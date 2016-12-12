<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>青农论坛</title>
<link rel="stylesheet" href="../css/bootstrap.min.css" />
<script src="../js/jquery-1.10.2.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<style>
.container {
	margin-top: 40px;
}

.posting {
	width: 570px;
}

.modal-dialog {
	padding-top: 120px;
	width: 350px;
}

.modal-content {
	width: 350px;
}
</style>
<script>
	$(function() {
		var flag = 0;
		$('.forums-nav').hover(function() {
			$(this).addClass('active');
		}, function() {
			$(this).removeClass('active');
		});
		$('#postsub').click(
				function() {
					var title = $('#Title').val().trim();
					var content = $('#Content').val().trim();
					if (title == null || title == "") {
						$('#message-content').append('请输入帖子标题');
						$('#mes').modal('show');
						flag = 0;
					} else {
						flag++;
						if (content.length < 10) {
							$('#message-content').append('帖子内容大于10个字符');
							$('#mes').modal('show');
							flag = 0;
						} else {
							flag++;
						}
					}
					if (flag > 2) {
						$.post("../posts/doAdd", {
							'posts.forums_id' : ${forums.id},
							'posts.title' : title,
							'posts.content' : content
						}, function(data) {
							data = $.parseJSON(data);
							alert(data.state);
							if (data.state == 'success') {
								location.href = '../posts/checkPost?postId='
										+ data.pid;
							}
							if (data.state == 'error') {
								$('#Log').modal('show');
								$('#Log').on('shown.bs.modal');
							}
						});
					}
				});
	});
</script>
</head>
<body>

	<jsp:include page="../layout/clientLayout.jsp" />
	<div class="container">
		<div class="row">
			<div class="col-md-2 col-sm-2 col-xs-2 forums-nav">
				<h4>板块导航</h4>
				<hr style="width: 100%;opacity:0.7;" />
				<ul class="nav nav-pills nav-stacked">
					<s:iterator value="#folist" var="l">
						<li role="presentation" class="forums-nav"><a
							href="../posts/index?forumsId=${l.id }">${l.title }</a></li>
					</s:iterator>
				</ul>
			</div>
			<div class="col-md-10 col-sm-10 col-xs-10">
				<div class="forums-info">
					<h3 class="forums-title">${forums.title }</h3>
					<div class="forums-content">
						<p>
							帖子数量：<span>@Model.CurrentForums[0].Post.Count</span>
						</p>
						<p>
							版主：<span>XXX</span>
						</p>
					</div>
				</div>
			</div>
			<div class="col-md-10 col-sm-10 col-xs-10">
				<div class="posting">
					<form action="/Post/AddPost" id="postform" method="post">
						<div class="form-group">
							<label for="posttitle">发表新贴</label> <input type="text"
								class="form-control" name="Title" id="Title" placeholder="请填写标题"
								value="" />
						</div>
						<div class="form-group">
							<textarea class="form-control" id="Content" name="Content"
								style="height: 200px;resize: none;"></textarea>
						</div>
						<div class="post-btn pull-right">
							<input type="button" id="postsub" value="发贴"
								class="btn btn-primary" /> <a href="#"
								onClick="javascript :history.go(-1);" class="btn btn-default">返回</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>

