<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<style type="text/css">
* {
	font-family: "微软雅黑";
}

body {
	background-color: #EEEEEE;
}

.navbar-header a {
	font-size: 30px;
}

.navbar-default {
	height: 70px;
}

.container-fluid {
	margin-top: 7px;
}

.left-nav {
	background-color: #F9F9F9;
	max-width: 225px;
	min-width: 225px;
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
		$('#logout').click(function() {
			$('#message-content').html(null);
			$('#message-content').append('确认退出？');
			$('#mes').modal('show');
			$('#model-btn').click(function() {
				$.post("/Admin/AdminLogout", function(data) {
					$('#message-content2').html(null);
					$('#message-content2').append(data.message);
					$('#mes2').modal('show');
					$('#model-btn2').click(function() {
						location.href = '/Home/Index';
					});
				});
			});
		});
	});
</script>
<!--提示框-->
<div class="modal fade" aria-hidden="true" data-backdrop="static"
	id="mes">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="message-title">提示</h4>
			</div>
			<div class="modal-body">
				<p id="message-content"></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal"
					id="model-btn">确定</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!--提示框-->
<!--提示框2-->
<div class="modal fade" aria-hidden="true" data-backdrop="static"
	id="mes2">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="message-title2">提示</h4>
			</div>
			<div class="modal-body">
				<p id="message-content2"></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal"
					id="model-btn2">确定</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!--提示框-->
<!--导航开始-->
<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">青农论坛后台管理</a>
		</div>
		<ul class="nav navbar-nav navbar-right">
			<li>
				<p class="navbar-text">
					你好,管理员<span>@Session["admin"]</span>
				</p>
			</li>
			<li><a href="#" id="logout">退出系统</a></li>
		</ul>
	</div>
</nav>
<!--导航结束-->
<div class="container-fluid">
	<div class="row">
		<div class="col-md-2">
			<!--左侧导航开始-->
			<div class="left-nav">
				<ul class="nav nav-pills nav-stacked">
					<li role="presentation" id="left-nav-home"><a
						href="/Admin/Index"><span class="glyphicon glyphicon-home"></span>&nbsp;&nbsp;首页</a>
					</li>
					<li role="presentation" id="left-nav-user"><a
						href="/Admin/UserManage"><span
							class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;用户管理</a></li>
					<li role="presentation" id="left-nav-forum"><a
						href="/Admin/ForumManage"><span
							class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;板块管理</a></li>
					<li role="presentation" id="left-nav-post"><a
						href="/Admin/PostManage"><span
							class="glyphicon glyphicon-file"></span>&nbsp;&nbsp;帖子管理</a></li>
				</ul>
			</div>
			<!--左侧导航结束-->
		</div>
		<div class="col-md-10">