<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="/static/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/static/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/static/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="/static/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

<%--Bootstrap分页插件--%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery/bs_pagination/jquery.bs_pagination.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery/bs_pagination/en.js"></script>

<script type="text/javascript">

	$(function(){
	    pageList(1,5);

        //查询按钮
        $("#searchBtn").click(function () {

            $("#hidden-owner").val($.trim($("#search-owner").val()));
            $("#hidden-tranName").val($.trim($("#search-tranName").val()));
            $("#hidden-customerName").val($.trim($("#search-customerName").val()));
            $("#hidden-stage").val($.trim($("#search-stage").val()));
            $("#hidden-type").val($.trim($("#search-type").val()));
            $("#hidden-source").val($.trim($("#search-source").val()));
            $("#hidden-contact").val($.trim($("#search-contact").val()));

            pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
        });
	});

    function pageList(pageNo,pageSize){
        $("#selectAll").prop("checked",false);
        //查询前把隐藏域中的属性取出来,赋值给当前域
        $("#search-owner").val($.trim($("#hidden-owner").val()));
        $("#search-tranName").val($.trim($("#hidden-tranName").val()));
        $("#search-customerName").val($.trim($("#hidden-customerName").val()));
        $("#search-stage").val($.trim($("#hidden-stage").val()));
        $("#search-type").val($.trim($("#hidden-type").val()));
        $("#search-source").val($.trim($("#hidden-source").val()));
        $("#search-contact").val($.trim($("#hidden-contact").val()));
        $.ajax({
            url:"/Tran/pageList",
            type:"post",
            data:{
                "pageNo":pageNo,
                "pageSize":pageSize,
                "owner":$.trim($("#search-owner").val()),
                "tranName":$.trim($("#search-tranName").val()),
                "customerName":$.trim($("#search-customerName").val()),
                "stage":$.trim($("#search-stage").val()),
                "type":$.trim($("#search-type").val()),
                "source":$.trim($("#search-source").val()),
                "contact":$.trim($("#search-contact").val()),
            },
            success:function (data) {
                //需要一个list和数据的总数
                //{"total":100,"dataList":[{市场活动1},{2},{3}]}
                let dataList = data.dataList;
                let html="";
                $.each(dataList,function (index, element) {
                	html+='<tr>';
                    html+='<td><input type="checkbox" /></td>';
                    html+='<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'/Tran/detail?id='+element.id+'\';">'+element.name+'</a></td>';
                    html+='<td>'+element.customerId+'</td>';
                    html+='<td>'+element.stage+'</td>';
                    html+='<td>'+element.type+'</td>';
                    html+='<td>'+element.owner+'</td>';
                    html+='<td>'+element.source+'</td>';
                    html+='<td>'+element.contactsId+'</td>';
                    html+='</tr>';
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
        })}
	
</script>
</head>
<body>
		<input type="hidden" id="hidden-owner">
		<input type="hidden" id="hidden-tranName">
		<input type="hidden" id="hidden-customerName">
		<input type="hidden" id="hidden-stage">
		<input type="hidden" id="hidden-type">
		<input type="hidden" id="hidden-source">
		<input type="hidden" id="hidden-contact">
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>交易列表</h3>
			</div>
		</div>
	</div>

	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="search-tranName">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
				      <input class="form-control" type="text" id="search-customerName">
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">阶段</div>
					  <select class="form-control" id="search-stage">
					  	<option></option>
					  	<c:forEach items="${stageList}" var="item">
							<option value="${item.value}">${item.text}</option>
						</c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">类型</div>
					  <select class="form-control" id="search-type">
					  	<option></option>
					  	<option>已有业务</option>
					  	<option>新业务</option>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">来源</div>
				      <select class="form-control" id="search-source">
						  <option></option>
						  <c:forEach items="${sourceList}" var="item">
							  <option value="${item.value}">${item.text}</option>
						  </c:forEach>
						</select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">联系人名称</div>
				      <input class="form-control" type="text" id="search-contact">
				    </div>
				  </div>
				  
				  <button type="submit" class="btn btn-default" id="searchBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" onclick="window.location.href='/Tran/addPage';"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" onclick="window.location.href='edit.html';"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" /></td>
							<td>名称</td>
							<td>客户名称</td>
							<td>阶段</td>
							<td>类型</td>
							<td>所有者</td>
							<td>来源</td>
							<td>联系人名称</td>
						</tr>
					</thead>
					<tbody id="activityBody">
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