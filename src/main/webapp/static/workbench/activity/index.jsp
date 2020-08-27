<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String bathPath=request.getScheme()+"://"+request.getServerName()+":"+
request.getServerPort()+request.getContextPath()+"/";
%>
<html>
<head>
	<base href="<%=bathPath%>"/>
<meta charset="UTF-8">

<link href="${pageContext.request.contextPath}/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/static/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

	<%--Bootstrap分页插件--%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery/bs_pagination/jquery.bs_pagination.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/bs_pagination/en.js"></script>

<script type="text/javascript">

	$(function(){
	    // pageList(1,5);
	    //点打开创建活动页面
		$("#addBtn").click(function () {
		    //添加时间控件
            $(".time").datetimepicker({
                minView: "month",
                language:  'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "bottom-left"
            });
		    //打开之前查一下user表，为下拉框填充选项
		    $.ajax({
				url:"/Activity/getUserList",
				type:"get",
				data:"",
				//应为json数组
				success:function (result) {
                    $("#create-owner").empty();
				    $.each(result,function (index, element) {
						$("#create-owner").append("<option value='"+element.id+"'>"+element.name+"</option>");
                    });
					let id = "${user.id}";
					// alert(id);
					$("#create-owner").val(id);
                },
				error:function () {},
				dataType:"json"
			});
			$("#createActivityModal").modal("show");
        });

		//创建窗口-保存按钮
		$("#saveBtn").click(function () {
			$.ajax({
				url:"/Activity/save",
				type:"post",
				data:{
                    "owner": $.trim($("#create-owner").val()),
                    "name": $.trim($("#create-name").val()),
                    "startDate": $.trim($("#create-startDate").val()),
                    "endDate": $.trim($("#create-endDate").val()),
                    "cost": $.trim($("#create-cost").val()),
                    "description": $.trim($("#create-description").val())
				},
				//{"success":true/false}
                dataType:"json",
				success:function (data) {
				    if (data){
                        pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                        //添加成功后，刷新活动列表（ajax局部刷新）
                        $("#create-form")[0].reset();
                        //关闭模态窗口
						$("#createActivityModal").modal("hide")

					} else{
				        alert("添加活动失败");
					}
                },
				error:function () {}
			})
        });

		//打开修改活动页面
		$("#editBtn").click(function () {
		    var $xz = $("input[name=xz]:checked");
		    if ($xz.length==0){
		        alert("请选择要修改的数据");
			} else if($xz.length>1){
		        alert("只能选择一项进行修改");
			} else{
                //时间插件
                $(".time").datetimepicker({
                    minView: "month",
                    language:  'zh-CN',
                    format: 'yyyy-mm-dd',
                    autoclose: true,
                    todayBtn: true,
                    pickerPosition: "bottom-left"
                });
		        //用户信息回调, 填充下拉框
                let id = $xz.val();
                //异步请求
                $.ajax({
                    url:"/Activity/getUserListAndActivity",
                    type:"get",
                    data:{
                        "id":id
					},
                    //用户信息回调
					//接收: 用户列表 和 单条用户信息 {"userList":[{用户1},{用户2},{用户3}],"a":{市场活动}}
                    success:function (map) {
                        let $edit = $("#edit-owner");
                        $edit.empty();
                        $.each(map.userList,function (index,element) {
                            $edit.append("<option value='"+element.id+"'>"+element.name+"</option>")
                        });

                        //填充值,隐藏id 为更新按钮做铺垫
						$("#edit-id").val(map.a.id);
						$("#edit-name").val(map.a.name);
                        $edit.val(map.a.owner);
						$("#edit-startDate").val(map.a.startDate);
						$("#edit-endDate").val(map.a.endDate);
						$("#edit-cost").val(map.a.cost);
						$("#edit-description").val(map.a.description);
                    },
                    error:function () {},
                    dataType:"json"
                });


                $("#editActivityModal").modal("show");
			}

        });

		//更新按钮
		$("#updateBtn").click(function () {
		    if(confirm("是否确认更新?")){
                $.ajax({
                    url:"/Activity/update",
                    type:"post",
                    data:{
                        "id":$("#edit-id").val(),
                        "owner": $.trim($("#edit-owner").val()),
                        "name": $.trim($("#edit-name").val()),
                        "startDate": $.trim($("#edit-startDate").val()),
                        "endDate": $.trim($("#edit-endDate").val()),
                        "cost": $.trim($("#edit-cost").val()),
                        "description": $.trim($("#edit-description").val()),
						"editBy":"${user.name}"
                    },
                    //{"success":true/false}
                    dataType:"json",
                    success:function (data) {
                        if (data){
                            pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
                                ,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                            //关闭模态窗口
                            $("#editActivityModal").modal("hide")

                        } else{
                            alert("修改活动失败");
                        }
                    },
                    error:function () {}
                })
			}

        });

		//删除按钮
		$("#deleteBtn").click(function () {
			let deleteBoxes =$("input[name=xz]:checked");
			if (deleteBoxes.length == 0) {
			    alert("请选中要删除的数据");
			}else {
				if(confirm("确定删除选中的数据吗?")){
                    let param = "";
                    $.each(deleteBoxes,function (index,element) {
                        param+="id="+$(element).val();
                        if (index < deleteBoxes.length - 1){
                            param+="&";
                        }
                    });
                    $.ajax({
                        url:"/Activity/delete",
                        type:"post",
                        data:param,
                        dataType:"json",
                        success:function (data) {
                            //{"success":true/false}
                            if (data){
                                pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
                            }else{
                                alert("删除市场活动失败")
                            }
                        },
                        error:function () {}
                    });
				}
				$("#editActivityModal").modal("hide")
			}

        });

		//页面加载完毕后 展现列表 pageList(pageNo,pageSize)
		pageList(1,5);

		//查询按钮
		$("#searchBtn").click(function () {
            $("#hidden-name").val($.trim($("#search-name").val()));
            $("#hidden-owner").val($.trim($("#search-owner").val()));
            $("#hidden-startDate").val($.trim($("#search-startDate").val()));
            $("#hidden-endDate").val($.trim($("#search-endDate").val()));
            pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
        });

		//全选按钮
		$("#selectAll").click(function () {
		    $('input[type=checkbox]').prop("checked",this.checked);
        });

		//反向全选勾,子全选->全选按钮勾选, 子非全选->全选按钮消失
		let xz = $("input[name=xz]");
		$("#activityBody").on('click',xz,function () {
			$("#selectAll").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length);
        });

        $(".time").datetimepicker({
            minView: "month",
            language:  'zh-CN',
            format: 'yyyy-mm-dd',
            autoclose: true,
            todayBtn: true,
            pickerPosition: "bottom-left"
        });

	});

	//查询分页功能
    function pageList(pageNo,pageSize){
        $("#selectAll").prop("checked",false);
        //查询前把隐藏域中的属性取出来,赋值给当前域
        $("#search-name").val($.trim($("#hidden-name").val()));
        $("#search-owner").val($.trim($("#hidden-owner").val()));
        $("#search-startDate").val($.trim($("#hidden-startDate").val()));
        $("#search-endDate").val($.trim($("#hidden-endDate").val()));
		$.ajax({
				   url:"/Activity/pageList",
				   type:"post",
				   data:{
				       "pageNo":pageNo,
					   "pageSize":pageSize,
					   "name":$.trim($("#search-name").val()),
					   "owner":$.trim($("#search-owner").val()),
					   "startDate":$.trim($("#search-startDate").val()),
					   "endDate":$.trim($("#search-endDate").val())
				   },
				   success:function (data) {
				       //需要一个list和数据的总数
					   //{"total":100,"dataList":[{市场活动1},{2},{3}]}
					   let dataList = data.dataList;
					   let html="";
				       $.each(dataList,function (index, element) {
						   html+='<tr class="active">';
                           html+='<td><input type="checkbox" value="'+element.id+'" name="xz"/></td>';
                           html+='<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'/Activity/detail?id='+element.id+'\';">'+element.name+'</a></td>';
                           html+='<td>'+element.owner+'</td>';
                           html+='<td>'+element.startDate+'</td>';
                           html+='<td>'+element.endDate+'</td>'
                       });
					   $("#activityBody").html(html);
					   let totalPages = data.total % pageSize==0 ? data.total/pageSize : parseInt(data.total/pageSize)+1;

                       $("#activityPage").bs_pagination({
                           currentPage: pageNo, // 页码
                           rowsPerPage: pageSize, // 每页显示的记录条数
                           maxRowsPerPage: 20, // 每页最多显示的记录条数
                           totalPages: totalPages, // 总页数
                           totalRows: data.total, // 总记录条数

                           visiblePageLinks: 3, // 显示几个卡片

                           showGoToPage: true,
                           showRowsPerPage: true,
                           showRowsInfo: true,
                           showRowsDefaultInfo: true,

                           //回调函数,点击分页组件触发
                           onChangePage : function(event, data){
                               pageList(data.currentPage , data.rowsPerPage);
                           }
                       });
				   },
				   error:function () {},
				   dataType:"json"
				})
    }
	
</script>
</head>
<body>
	<input type="hidden" id="hidden-name">
	<input type="hidden" id="hidden-owner">
	<input type="hidden" id="hidden-startDate">
	<input type="hidden" id="hidden-endDate">
	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="create-form">
					
						<div class="form-group">
							<label for="create-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-owner">
								</select>
							</div>
                            <label for="create-name" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-name">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startDate" class="col-sm-2 control-label time">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-startDate">
							</div>
							<label for="create-endDate" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-endDate">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="edit-form">
						<input type="hidden" id="edit-id">
						<div class="form-group">
							<label for="edit-owner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-owner">
								</select>
							</div>
                            <label for="edit-name" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-name">
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startDate" class="col-sm-2 control-label time">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-startDate">
							</div>
							<label for="edit-endDate" class="col-sm-2 control-label time">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-endDate">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-description"></textarea>
							</div>
						</div>
						
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="search-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
				    </div>
				  </div>

				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control time" type="text" id="search-startTime" />
				    </div>
				  </div>

				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control time" type="text" id="search-endTime">
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="searchBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="selectAll"/></td>
							<td>名称</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody  id="activityBody">
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">
				<div id="activityPage"></div>
			</div>
			
		</div>
	</div>
</body>
</html>