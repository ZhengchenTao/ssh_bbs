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
<style>
.container {
	padding-right: 150px;
	padding-left: 150px;
	margin-right: auto;
	margin-left: auto;
	margin-top: 50px;
}

tbody tr {
	height: 230px;
}

.modal-dialog {
	padding-top: 120px;
	width: 350px;
}

.modal-content {
	width: 350px;
}

.rtop {
	position: fixed;
	z-index: 50;
	top: 500px;
	right: 160px;
}
</style>
<script>
	$(function() {
		$('#rep').click(function() {
			$.post("../posts/addReply", {
				'replies.post_id' : ${post.id},
				'replies.content' : $('#rcontent').val()
			}, function(data) {
				data = $.parseJSON(data);
				if (data.state == 'success') {
					location.reload();
				}
				if (data.state == 'error') {
					$('#Log').modal('show');
					$('#Log').on('shown.bs.modal');
				}
			});
		});
		$('#back').click(function() {
			self.location=document.referrer;
		});
	});
</script>
</head>
<body>

	<jsp:include page="../layout/clientLayout.jsp" />
	<div class="row">
		<div class="rtop btn-group-vertical">
			<a href="#" class="btn btn-default btn-lg"> <span
				class="glyphicon glyphicon-chevron-up"></span>
			</a> <a href="#reform" class="btn btn-default btn-lg"> <span
				class="glyphicon glyphicon-comment"></span>
			</a>
		</div>
		<h3>${forums.title }</h3>
		<button class="btn btn-primary pull-right" id="back"
			style="margin-bottom:5px;font-size:18px">返回</button>
		<table class="table table-bordered">
			<thead>
				<tr>
					<td class="col-md-2 info">查看：<span style="color:red;">${post.clickNum }</span>
						回复：<span style="color:red;">${reCount }</span></td>
					<td class="col-md-10 info">${post.title }</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>${user.username }</td>
					<td>
						<p>${post.content }</p>
						<p class="pull-right text-muted" style="margin-top: 160px;">${post.createTime }</p>
					</td>
				</tr>
				<s:iterator value="#replies" var="re">
					<tr>
						<td>123</td>
						<td>
							<p>${re.content }</p>
							<p class="pull-right text-muted" style="margin-top: 160px;">${re.replyTime }</p>
						</td>
					</tr>
				</s:iterator>
				<tr>
					<td></td>
					<td>
						<form id="reform" action="/Post/AddReply" method="post">
							<textarea class="form-control" name="rcontent" id="rcontent"
								style="width: 570px;height: 200px;resize: none;"></textarea>
							<input type="button" id="rep" value="发表回复"
								class="btn btn-primary" />
						</form>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	</div>
</body>
</html>

