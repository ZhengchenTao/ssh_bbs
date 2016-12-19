<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My JSP 'usersIndex.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" href="../css/bootstrap.min.css" />
<script src="../js/jquery-1.10.2.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script>
	$(function() {
		var edit = 0;
		$('.glyphicon-trash').click(function() {
			var eid = $(this).attr('att');
			$('#message-content').html(null);
			$('#message-content').append('确认删除？');
			$('#mes').modal('show');
			$('#model-btn').click(function() {
				$('#mes').modal('hide');
				$.post("../admin/postsDelete", {
					'posts.id' : eid,
				}, function(data) {
					data = $.parseJSON(data);
					$('#message-content2').html(null);
					$('#message-content2').append(data.message);
					$('#mes2').modal('show');
					$('#model-btn2').click(function() {
						top.location.reload();
					});
				});
			});
		});
		$('.glyphicon-remove').click(function() {
			var eid = $(this).attr('att');
			$('.show_' + eid + '').removeClass('hidden');
			$('.edit_' + eid + '').addClass('hidden');
			edit = 0;
		});
	});
</script>
<style>
.user-table {
	width: 80%;
	margin-left: 100px;
}

.input-sm {
	width: 100px;
}
</style>
</head>

<body>
	<jsp:include page="../layout/adminLayout.jsp" />
	<div class="user-table">
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th>ID</th>
					<th>标题</th>
					<th>内容</th>
					<th>作者</th>
					<th>所属板块</th>
					<th>注册时间</th>
					<th>浏览量</th>
					<th>回复量</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#list" var="l">
					<tr>
						<td>${l.id}</td>
						<td><span class="show_${l.id}" id="ptitle_${l.id}">${l.title }</span>
							<input type="text"
							class="form-control hidden input-sm edit_${l.id}"
							id="etitle_${l.id}" value="@item.Title" /></td>
						<td><span class="show_${l.id}" id="pcontent_${l.id}">${l.content }</span>
							<input type="text"
							class="form-control hidden input-sm edit_${l.id}"
							id="econtent_${l.id}" value="@item.Content" /></td>
						<td><s:iterator value="#uslist" var="ul">
								<s:if test="#ul.id==#l.users_id">
									<s:property value="#ul.username" />
								</s:if>
							</s:iterator></td>
						<td><s:iterator value="#folist" var="fl">
								<s:if test="#fl.id==#l.forums_id">
									<s:property value="#fl.title" />
								</s:if>
							</s:iterator></td>
						<td>${l.createTime }</td>
						<td>${l.clickNum }</td>
						<td><s:iterator value="#replist" var="key">
								<s:if test="key==#l.id">
									<span><s:property value="value" /></span>
								</s:if>
							</s:iterator></td>
						<td>
							<div class="show_${l.id}">
								</a>&nbsp;&nbsp; <a href="#"><span
									class="glyphicon glyphicon-trash" att="${l.id}"></span></a>
							</div>
						</td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
		<div class="text-center">
			<nav>
			<ul class="pagination">
				<li><a href="../admin/postsIndex?page=${page-1 }">&laquo;</a></li>

				<s:bean name="org.apache.struts2.util.Counter" var="Counter">
					<s:param name="first" value="1" />
					<s:param name="last" value="#cpage" />
					<s:iterator>
						<s:if test="current-1 == page">
							<li class="active"><a
								href="../admin/postsIndex?page=${current-1 } ">${current-1 }</a></li>
						</s:if>
						<s:else>
							<li><a href="../admin/postsIndex?page=${current-1 } ">${current-1 }</a></li>
						</s:else>
					</s:iterator>
				</s:bean>

				<li><a href="../admin/postsIndex?page=${page+1 }">&raquo;</a></li>
			</ul>

			</nav>
		</div>
	</div>
	</div>
	</div>
	</div>
</body>
</html>
