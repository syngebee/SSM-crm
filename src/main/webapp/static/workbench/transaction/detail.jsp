<%@ page import="com.itheima.crm.settings.pojo.DicValue" %>
<%@ page import="com.itheima.crm.workbench.pojo.Tran" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	//取出阶段列表
	List<DicValue> dvList = (List<DicValue>) application.getAttribute("stageList");
	//准备阶段可能性对应关系
	Map<String,String> pmap = (Map<String, String>) application.getAttribute("pMap");
	//遍历阶段列表,当可能性为0时即为分界点
	int point=0;
	for (int i = 0; i < dvList.size(); i++) {
		DicValue dicValue = dvList.get(i);
		String value = dicValue.getValue();
		String possibility = pmap.get(value);
		if ("0".equals(possibility)){
		    point=i;
		    break;
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />

<style type="text/css">
.mystage{
	font-size: 20px;
	vertical-align: middle;
	cursor: pointer;
}
.closingDate{
	font-size : 15px;
	cursor: pointer;
	vertical-align: middle;
}
</style>
	
<script type="text/javascript" src="/static/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){
        getHistoryList();

		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
		});
		
		$(".remarkDiv").mouseover(function(){
			$(this).children("div").children("div").show();
		});
		
		$(".remarkDiv").mouseout(function(){
			$(this).children("div").children("div").hide();
		});
		
		$(".myHref").mouseover(function(){
			$(this).children("span").css("color","red");
		});
		
		$(".myHref").mouseout(function(){
			$(this).children("span").css("color","#E6E6E6");
		});
		
		
		//阶段提示框
		$(".mystage").popover({
            trigger:'manual',
            placement : 'bottom',
            html: 'true',
            animation: false
        }).on("mouseenter", function () {
                    var _this = this;
                    $(this).popover("show");
                    $(this).siblings(".popover").on("mouseleave", function () {
                        $(_this).popover('hide');
                    });
                }).on("mouseleave", function () {
                    var _this = this;
                    setTimeout(function () {
                        if (!$(".popover:hover").length) {
                            $(_this).popover("hide")
                        }
                    }, 100);
                });
	});
	function getHistoryList() {
        $.ajax({
            url:"/Tran/getHistoryListByTranId",
            type:"get",
            data:{
                "tranId":"${tran.id}"
            },
            dataType:"json",
            success:function (data) {
                let html="";
                $.each(data,function (index, element) {
                    html+= '<tr>';
                    html+= '<td>'+element.stage+'</td>';
                    html+= '<td>'+element.money+'</td>';
                    html+= '<td>'+element.possibility+'</td>';
                    html+= '<td>'+element.expectedDate+'</td>';
                    html+= '<td>'+element.createTime+'</td>';
                    html+= '<td>'+element.createBy+'</td>';
                    html+= '</tr>';
                });
                $("#historyBody").html(html);
            },
            error:function () {}
        });
    }

	function changeStage(stage,i) {
        $.ajax({
            url:"/Tran/changeStage",
            type:"post",
            data:{
                "id":"${tran.id}",
                "stage":stage,
				"money":"${tran.money}",
				"expectedDate":"${tran.expectedDate}",
			},
            dataType:"json",
            success:function (data) {
				/*
					data
						{"success":true/false ,"tran":{交易}}
						editBy, editTime, possibility,stage
				*/
				if (data.success){
				    let editBy = data.tran.editBy;
				    let editTime = data.tran.editTime;
				    let possibilitiy = data.tran.possibility;
				    let stage = data.tran.stage;

				    //拿到数据后给修改人，修改时间，可能性，当前阶段 4 个值重新刷新
					$("#editby").html(editBy+"&nbsp;&nbsp;");
					$("#editTime").html(editTime+"&nbsp;&nbsp;");
					$("#possibilitiy").html(possibilitiy+"&nbsp;&nbsp;");
					$("#stage").html(stage+"&nbsp;&nbsp;");

					//更新会添加交易历史，重新刷新交易历史
                    getHistoryList();

                    //阶段的图标重新判断，重新赋予颜色与样式
					changeIcon(stage,i);
                }else{
				    alert("修改失败")
                }
            },
            error:function () {}
        });
    }
	
	function changeIcon(stage,i) {
	    //当前阶段
	    let currentStage = stage;
	    //当前阶段可能性
		let currentPossibility= $("#possibilitiy").text();
		//当前阶段的下标
		let index = i;
		//丢失交易的分界点
		let point = "<%=point%>";

/*		alert("当前阶段"+currentStage);
		alert("当前阶段可能性"+possibility);
		alert("当前阶段的下表"+index);
		alert("丢失交易的分界点"+point);*/
		//先判断当前阶段
        //如果当前阶段可能性为0, 分界点前都使用黑色的样式,后面的一个红叉,一个黑叉
		if (currentPossibility==0){
		    //遍历前7个
            for (let i = 0; i < point; i++){
                //黑圈
				let $1 = $("#"+i);
                //先要移除原有的样式
                $1.removeClass();
				//添加新的样式
                $1.addClass("glyphicon glyphicon-record mystage");
				//赋予新的颜色
				$1.css("color","#000000")
            }

            //后面的叉
            for (let i = point; i < <%=dvList.size()%>; i++){
				//当前阶段
                if (i == index){
                    //红叉
                    let $1 = $("#"+i);
                    //先要移除原有的样式
                    $1.removeClass();
                    //添加新的样式
                    $1.addClass("glyphicon glyphicon-remove mystage");
                    //赋予新的颜色
                    $1.css("color","#FF0000")

                //非当前阶段
				}else {
                    //黑叉
                    let $1 = $("#"+i);
                    //先要移除原有的样式
                    $1.removeClass();
                    //添加新的样式
                    $1.addClass("glyphicon glyphicon-remove mystage");
                    //赋予新的颜色
                    $1.css("color","#000000")
				}
            }

        //如果当前阶段可能性不为0,分界点前可能是绿圈和黑圈,后面两个一定是黑叉
		}
		else {
            for (let i = 0; i < point; i++){
                if (i>index){
                    //黑圈
                    let $1 = $("#"+i);
                    //先要移除原有的样式
                    $1.removeClass();
                    //添加新的样式
                    $1.addClass("glyphicon glyphicon-record mystage");
                    //赋予新的颜色
                    $1.css("color","#000000");
				}else if (i==index){
                    //绿标
                    let $1 = $("#"+i);
                    //先要移除原有的样式
                    $1.removeClass();
                    //添加新的样式
                    $1.addClass("glyphicon glyphicon-map-marker mystage");
                    //赋予新的颜色
                    $1.css("color","#90F790");

				} else{
                    //绿圈
                    let $1 = $("#"+i);
                    //先要移除原有的样式
                    $1.removeClass();
                    //添加新的样式
                    $1.addClass("glyphicon glyphicon-ok-circle mystage");
                    //赋予新的颜色
                    $1.css("color","#90F790");
				}
            }
            //后面的叉
            for (let i = point; i < <%=dvList.size()%>; i++){
                //黑叉
                let $1 = $("#"+i);
                //先要移除原有的样式
                $1.removeClass();
                //添加新的样式
                $1.addClass("glyphicon glyphicon-remove mystage");
                //赋予新的颜色
                $1.css("color","#000000");
            }

		}
    }
</script>

</head>
<body>
	
	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>${tran.name} <small>￥${tran.money}</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" onclick="window.location.href='edit.html';"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>

	<!-- 阶段状态 -->
	<div style="position: relative; left: 40px; top: -50px;">
		阶段&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%
			//准备当前阶段
			Tran tran = (Tran) request.getAttribute("tran");
			String currentStage = tran.getStage();
			//准备当前阶段的可能性
			String currentPossibility = tran.getPossibility();

			//先判断当前阶段
			//如果当前阶段可能性为0, 分界点前都使用黑色的样式,后面的一个红叉,一个黑叉
			if ("0".equals(currentPossibility)){
				for (int i = 0; i < dvList.size(); i++) {
				    //拿出每一个阶段
					DicValue dv = dvList.get(i);
					//取他的value
					String listStage = dv.getValue();
					//取他的可能性
					String  listPossibility = pmap.get(listStage);

					//可能性等于0则属于后两个,执行后两个的处理逻辑
					if ("0".equals(listPossibility)){
					    //当前阶段红叉
					    if (currentStage.equals(listStage)){
		%>
		<span id="<%=i%>" onclick="changeStage('<%=listStage%>','<%=i%>')"
			  class="glyphicon glyphicon-remove mystage"
			  data-toggle="popover" data-placement="bottom"
			  data-content="<%=dv.getText()%>" style="color: #FF0000;"></span>
		-----------
		<%
					    //非当前阶段黑叉
						}else {
		%>
		<span id="<%=i%>" onclick="changeStage('<%=listStage%>','<%=i%>')"
			  class="glyphicon glyphicon-remove mystage"
			  data-toggle="popover" data-placement="bottom"
			  data-content="<%=dv.getText()%>" style="color: #000000;"></span>
		-----------
		<%
						}
						//可能性不等于0则属于前七个,执行前七个的处理逻辑(黑圈)
					} else{
		%>
		<span id="<%=i%>" onclick="changeStage('<%=listStage%>','<%=i%>')"
			  class="glyphicon glyphicon-record mystage"
			  data-toggle="popover" data-placement="bottom"
			  data-content="<%=dv.getText()%>" style="color: #000000;"></span>
		-----------
		<%
					}

				}
			}
			//如果当前阶段可能性不为0,分界点前可能是绿圈和黑圈,后面两个一定是黑叉
			else {
			    int index=0;
				for (int i = 0; i < dvList.size(); i++) {
					DicValue dv = dvList.get(i);
					String listStage = dv.getValue();

					//当前阶段
					if (currentStage.equals(listStage)){
					    index=i;
					    break;
					}
				}

				for (int i = 0; i < dvList.size(); i++) {
					//拿出每一个阶段
					DicValue dv = dvList.get(i);
					//取他的value
					String listStage = dv.getValue();
					//取他的可能性
					String listPossibility = pmap.get(listStage);

					if ("0".equals(listPossibility)) {
						//一定黑叉,最后俩
		%>
		<span id="<%=i%>" onclick="changeStage('<%=listStage%>','<%=i%>')"
			  class="glyphicon glyphicon-remove mystage"
			  data-toggle="popover" data-placement="bottom"
			  data-content="<%=dv.getText()%>" style="color: #000000;"></span>
		-----------
		<%
					}else {
					    //大于当前的黑圈,小于当前的绿圈
						if(i<index){
						    //绿圈
		%>
		<span id="<%=i%>" onclick="changeStage('<%=listStage%>','<%=i%>')"
			  class="glyphicon glyphicon-ok-circle mystage"
			  data-toggle="popover" data-placement="bottom"
			  data-content="<%=dv.getText()%>" style="color: #90F790;"></span>
		-----------
		<%
						}else if(i==index){
						    //当前
		%>
		<span id="<%=i%>" onclick="changeStage('<%=listStage%>','<%=i%>')"
			  class="glyphicon glyphicon-map-marker mystage"
			  data-toggle="popover" data-placement="bottom"
			  data-content="<%=dv.getText()%>" style="color: #90F790;"></span>
		-----------
		<%
						}else{
						    //黑圈
		%>
		<span id="<%=i%>" onclick="changeStage('<%=listStage%>','<%=i%>')"
			  class="glyphicon glyphicon-record mystage"
			  data-toggle="popover" data-placement="bottom"
			  data-content="<%=dv.getText()%>" style="color: #000000;"></span>
		-----------
		<%
						}

					}

				}
			}


		%>

		<span class="closingDate">${tran.expectedDate}</span>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: 0px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.owner}&nbsp;&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">金额</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${tran.money}&nbsp;&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.name}&nbsp;&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">预计成交日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${tran.expectedDate}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">客户名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.customerId}&nbsp;&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">阶段</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="stage">${tran.stage}&nbsp;&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">类型</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.type}&nbsp;&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">可能性</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="possibilitiy">${tran.possibility}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">来源</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.source}&nbsp;&nbsp;</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">市场活动源</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${tran.activityId}&nbsp;&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">联系人名称</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${tran.contactsId}&nbsp;&nbsp;</b></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${tran.createBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${tran.createTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 70px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="editBy">${tran.editBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;" id="editTime">${tran.editTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 80px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${tran.description}&nbsp;&nbsp;
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 90px;">
			<div style="width: 300px; color: gray;">联系纪要</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${tran.contactSummary}&nbsp;&nbsp;
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 100px;">
			<div style="width: 300px; color: gray;">下次联系时间</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${tran.nextContactTime}&nbsp;&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- 备注 -->
	<div style="position: relative; top: 100px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>
		
		<!-- 备注1 -->
		<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="/static/image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5>哎呦！</h5>
				<font color="gray">交易</font> <font color="gray">-</font> <b>动力节点-交易01</b> <small style="color: gray;"> 2017-01-22 10:10:10 由zhangsan</small>
				<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
				</div>
			</div>
		</div>
		
		<!-- 备注2 -->
		<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="/static/image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5>呵呵！</h5>
				<font color="gray">交易</font> <font color="gray">-</font> <b>动力节点-交易01</b> <small style="color: gray;"> 2017-01-22 10:20:10 由zhangsan</small>
				<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
				</div>
			</div>
		</div>
		
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button type="button" class="btn btn-primary">保存</button>
				</p>
			</form>
		</div>
	</div>
	
	<!-- 阶段历史 -->
	<div>
		<div style="position: relative; top: 100px; left: 40px;">
			<div class="page-header">
				<h4>阶段历史</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>阶段</td>
							<td>金额</td>
							<td>可能性</td>
							<td>预计成交日期</td>
							<td>创建时间</td>
							<td>创建人</td>
						</tr>
					</thead>
					<tbody id="historyBody">
<%--						<tr>
							<td>资质审查</td>
							<td>5,000</td>
							<td>10</td>
							<td>2017-02-07</td>
							<td>2016-10-10 10:10:10</td>
							<td>zhangsan</td>
						</tr>--%>
<%--						<tr>
							<td>需求分析</td>
							<td>5,000</td>
							<td>20</td>
							<td>2017-02-07</td>
							<td>2016-10-20 10:10:10</td>
							<td>zhangsan</td>
						</tr>
						<tr>
							<td>谈判/复审</td>
							<td>5,000</td>
							<td>90</td>
							<td>2017-02-07</td>
							<td>2017-02-09 10:10:10</td>
							<td>zhangsan</td>
						</tr>--%>
					</tbody>
				</table>
			</div>
			
		</div>
	</div>
	
	<div style="height: 200px;"></div>
	
</body>
</html>