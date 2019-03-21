<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>变量列表管理</title>
<link rel="stylesheet" href="${basePath}css/mail/table.css" />
<link rel="stylesheet" href="${basePath}css/table-td.css" />
<script type="text/javascript" src="${basePath}jQuery/2.1.4/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="${basePath}bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${basePath}bootstrap/3.3.7/css/bootstrap-datepicker3.min.css">
<script type="text/javascript" src="${basePath}bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
function clean() {
	$("#VarName").val("");
}
function del(case_id){
	var id=case_id;
	var r=confirm("是否刪除?");
	if(r==true){
		$.ajax({
			  type: "POST",
			  url: "del/"+id,
			  success : function(result) {  	    	        
	                  alert("数据已成功删除！");
	                  window.location.reload();
		        } 
			});
	}
}
</script>
</head>
<body>
	<div class="all">
		<form action="${ctx}/Var/list" method="post">
			<div class="whole">
				<div class="littletitle">变量列表</div>
				变量名：<input type="text" placeholder="变量名" value="${VarName}" name="VarName" id="VarName" style="width: 190px; height: 30px"> 				
				<button type="submit" class="btn btn-primary">查询</button>
				<button type="button" class="btn btn-default" onclick="clean();">重置</button>
				<a class="btn btn-success" href="${ctx}/Var/addVar" >新增</a>
			</div>
			<div class="main">
				<table id="cs_table" class="data-table" style="table-layout:fixed;" border="1">
					<thead>
						<tr class="head">
							<td style="width:5%;">编号</td>
							<td style="width:20%;">变量名</td>
							<td style="width:20%;">变量值</td>							
							<td style="width:15%;">操作</td>
						</tr>
					</thead>
					<tbody id="group_one">
					<c:if   test="${fn:length(VarList.list) <= 0}">
							<tr>								
									<td colspan="4">无</td>									
							</tr>
					</c:if>	
						<c:forEach items="${VarList.list}" var="e2" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td title="${e2.varName}">${e2.varName}</td>
								<td title="${e2.varValue}">${e2.varValue}</td>																							
								<td>
									<a class="btn btn-info" href="editVar/${e2.id}" >编辑</a>
									<button  class="btn btn-danger" type="button"  onclick="del(${e2.id});" >删除</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
				<hr>
			</div>
		</form>
				<div align='right'>
			<!-- 分页文字信息 ：拿到控制器处理请求时封装在pageInfo里面的分页信息-->
			<div class="col-md-6">
				当前${VarList.pageNum}页,共${VarList.pages }页,总${VarList.total }条记录
			</div>
			<!-- 分页码 -->
			<div class="col-md-6">

				<ul class="pagination">
					<!-- 
                        1.pageContext.request.contextPath表示当前项目路径，采用的是绝对路径表达方式。一般为http:localhost:8080/项目名 。
                        2.首页，末页的逻辑：pn=1访问第一次，pn=${pageInfo.pages}访问最后一页
                      -->
					<li><a
						href="${pageContext.request.contextPath}/Var/list?VarName=${VarName}&pagenum=1">首页</a>
					</li>
					<!-- 如果还有前页就访问当前页码-1的页面， -->
					<c:if test="${VarList.hasPreviousPage}">
						<li><a
							href="${pageContext.request.contextPath}/Var/list?VarName=${VarName}&pagenum=${VarList.pageNum-1}">
								<span>上一页</span>
						</a></li>
					</c:if>
					<li>
						<!--遍历所有导航页码，如果遍历的页码页当前页码相等就高亮显示，如果相等就普通显示  --> <c:forEach
							items="${VarList.navigatepageNums }" var="page_Nums">
							<c:if test="${page_Nums==VarList.pageNum }">
								<li class="active"><a href="#">${page_Nums}</a></li>
							</c:if>
							<c:if test="${page_Nums!=VarList.pageNum }">
								<li><a
									href="${pageContext.request.contextPath}/Var/list?VarName=${VarName}&pagenum=${page_Nums}">${page_Nums}</a></li>
							</c:if>
						</c:forEach>
					</li>
					<!-- 如果还有后页就访问当前页码+1的页面， -->
					<c:if test="${VarList.hasNextPage}">
						<li><a
							href="${pageContext.request.contextPath}/Var/list?VarName=${VarName}&pagenum=${VarList.pageNum+1}">
								<span>下一页</span>
						</a></li>
					</c:if>
					<li><a
						href="${pageContext.request.contextPath}/Var/list?VarName=${VarName}&pagenum=${VarList.pages}">末页</a></li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>

