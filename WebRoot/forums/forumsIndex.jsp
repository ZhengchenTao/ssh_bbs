<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String realPath = "http://"
			+ request.getServerName()
			+ ":"
			+ request.getServerPort()
			+ request.getContextPath()
			+ request.getServletPath().substring(0,
					request.getServletPath().lastIndexOf("/") + 1);
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
* {
	font-family: "微软雅黑";
}

body {
	background-color: #EEEEEE;
}

.navbar-right {
	margin-right: 5px;
}

.navbar-header a {
	font-size: 30px;
}

.modal-dialog {
	padding-top: 120px;
	width: 350px;
}

.modal-content {
	width: 350px;
}

.forums {
	font-family: "微软雅黑";
	padding-left: 150px;
	margin-top: 30px;
}

.forums-list {
	margin-top: 50px;
}

.forums-content {
	margin-top: 30px;
}

.forums-content a {
	margin-top: 15px;
}
</style>
<script>
        $(function () {
            $('#nav-log').click(function () {
                $('#Log').modal('show');
                $('#Log').on('shown.bs.modal');
            });
            $('#nav-logout').click(function () {
                $('#message-content').html(null);
                $('#message-content').append('确定退出？');
                $('#mes').modal('show');
                $('#model-btn').click(function () {
                    $.post("../login/logout", function (data) {
                    	data = $.parseJSON(data);
                        if (data.state == 'success') {
                            location.reload();
                        }
                    });
                });
            });
            $('#log-reg').click(function () {
                $('#Log').modal('hide');
                $('#Reg').modal('show');
                $('#Reg').on('shown.bs.modal');
            });
            $('#reg-log').click(function () {
                $('#Reg').modal('hide');
                $('#Log').modal('show');
            });
            $('#logsub').click(function () {
                var uname = $('#username').val().trim();
                var upass = $('#userpass').val().trim();
                var cbox = $('#remember').is(':checked');
                var logflag = 0;
                if (uname == "" || uname == null) {
                    $('#username-group').addClass('has-error');
                    $('#username-group label').removeClass('hidden');
                    logflag = 0;
                } else {
                    $('#username-group').removeClass('has-error');
                    $('#username-group label').addClass('hidden');
                    logflag++;
                }
                if (upass == "" || upass == null) {
                    $('#userpass-group').addClass('has-error');
                    $('#userpass-group label').removeClass('hidden');
                    logflag = 0;
                } else {
                    $('#userpass-group').removeClass('has-error');
                    $('#userpass-group label').addClass('hidden');
                    logflag++;
                }
                if (logflag == 2) {
                    $.post("../login/login", { 'users.username': uname, 'users.password': upass, remember: cbox }, function (data) {
                    	data = $.parseJSON(data);
                        if (data.state == 'success') {
                            $('#Log').modal('hide');
                            $('#message-content').html(null);
                            $('#message-content').append(data.message);
                            $('#mes').modal('show');
                            $('#mes').on('shown.bs.modal');
                            $('#model-btn').click(function () {
                                location.reload();
                            });
                        }
                    });
                }
            });
            $('#regsub').click(function () {
                var regflag = 0;
                var uname = $('#reg-username').val().trim();
                var upass = $('#reg-userpass').val().trim();
                var confirmpass = $('#reg-confirmpass').val().trim();
                if (uname.length < 3 || uname.length > 8) {
                    $('#reg-username-group').addClass('has-error');
                    $('#reg-username-group label').removeClass('hidden');
                    regflag = 0;
                } else {
                    $('#reg-username-group').removeClass('has-error');
                    $('#reg-username-group label').addClass('hidden');
                    regflag++;
                }
                if (upass.length < 3 || upass.length > 8) {
                    $('#reg-userpass-group').addClass('has-error');
                    $('#reg-userpass-group label').removeClass('hidden');
                } else {
                    $('#reg-userpass-group').removeClass('has-error');
                    $('#reg-userpass-group label').addClass('hidden');
                    regflag++;
                }
                if (upass != confirmpass) {
                    $('#reg-confirmpass-group').addClass('has-error');
                    $('#reg-confirmpass-group label').removeClass('hidden');
                    regflag = 0;
                } else {
                    $('#reg-confirmpass-group').removeClass('has-error');
                    $('#reg-confirmpass-group label').addClass('hidden');
                    regflag++;
                }
                if (regflag == 3) {
                    $.post("../login/register", { 'users.username': uname, 'users.password': upass, }, function (data) {
                    	data = $.parseJSON(data);
                    	if (data.state == 'succes') {
                            $('#Reg').modal('hide');
                            $('#reg-username').val(null);
                            $('#reg-userpass').val(null);
                            $('#reg-confirmpass').val(null);
                            $('#message-content').html(null);
                            $('#message-content').append(data.message);
                            $('#mes').modal('show');
                            $('#mes').on('shown.bs.modal');
                            $('#model-btn').click(function () {
                                $('#mes').modal('hide');
                                $('#Log').modal('show');
                            });
                        }
                        if (data.state == 'error') {
                            $('#Reg').modal('hide');
                            $('#message-content').html(null);
                            $('#message-content').append(data.message);
                            $('#mes').modal('show');
                            $('#mes').on('shown.bs.modal');
                            $('#model-btn').click(function () {
                                $('#mes').modal('hide');
                                $('#Log').modal('show');
                            });
                        };
                    });
                };
            });
        });
    </script>
</head>
<body>
	<nav class="navbar navbar-inverse  navbar-fixed-top">
		<div class="navbar-header">
			<a href="/Forums/Index" class="navbar-brand">青农论坛</a>
		</div>
		<div class="collapse navbar-collapse">
			<s:if test="#session.username==null">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#" id="nav-log">登录</a></li>
				</ul>
			</s:if>
			<s:else>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#">${session.username }</a></li>
					<li><a href="#" id="nav-logout">退出</a></li>
				</ul>
			</s:else>
		</div>
	</nav>
	<div class="container body-content">
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
		<!--登录框-->
		<div class="modal" id="Log" aria-hidden="true" data-backdrop="static"
			tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button class="close" data-dismiss="modal">
							<span>&times;</span>
						</button>
						<h4 class="modal-title">请先登录</h4>
					</div>
					<div class="modal-body">
						<form action="" method="post" class="tab-pane fade in active"
							name="log" id="log">
							<div class="form-group" id="username-group">
								<label class="control-label hidden" for="username">用户名不能为空</label>
								<input type="text" class="form-control" name="username"
									id="username" value="${cookie.username.value }"
									placeholder="用户名" />
							</div>
							<div class="form-group" id="userpass-group">
								<label class="control-label hidden" for="username">密码不能为空</label>
								<input type="password" class="form-control" name="userpass"
									id="userpass" value="${cookie.password.value }"
									placeholder="密码" />
							</div>
							<div class="checkbox">
								<label> <input type="checkbox" name="remember"
									id="remember" value="remember"> 记住我
								</label>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" id="log-reg">注册</button>
						<button class="btn btn-primary" id="logsub">登录</button>
					</div>
				</div>
			</div>
		</div>
		<!--登录框-->
		<!--注册框-->
		<div class="modal" id="Reg" aria-hidden="true" data-backdrop="static"
			tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button class="close" data-dismiss="modal">
							<span>&times;</span>
						</button>
						<h4 class="modal-title">注册</h4>
					</div>
					<div class="modal-body">
						<form action="" method="post" class="tab-pane fade in active"
							name="reg" id="reg">
							<div class="form-group" id="reg-username-group">
								<label class="control-label hidden" for="reg-username">用户名在3~8个字符之间</label>
								<input type="text" class="form-control" name="username"
									id="reg-username" value="" placeholder="用户名" />
							</div>
							<div class="form-group" id="reg-userpass-group">
								<label class="control-label hidden" for="reg-userpass">密码在3~8个字符之间</label>
								<input type="password" class="form-control" name="userpass"
									id="reg-userpass" value="" placeholder="密码" />
							</div>
							<div class="form-group" id="reg-confirmpass-group">
								<label class="control-label hidden" for="reg-confirmpass">两次密码不一致</label>
								<input type="password" class="form-control"
									name="reg-confirmpass" id="reg-confirmpass" value=""
									placeholder="密码" />
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" id="reg-log">返回登录</button>
						<button class="btn btn-primary" id="regsub">注册</button>
					</div>
				</div>
			</div>
		</div>
		<!--注册框-->
		<div class="row">
			<div class="forums-list">
				<s:iterator value="#list" var="l">
					<div class="col-md-6 forums">
						<h3 class="forums-title">${l.title}</h3>
						<div class="forums-content">
							<p>
								帖子数:<span>123</span>
							</p>
							<p>
								<span><a href="/Post/ShowPost?postid=@Model.Post.Id">@Model.Post.Title</a></span>
								<span><a href="">username</a></span> <br /> <span>Post.CreateTime</span>
								<!-- <span>@Model.Post.CreateTime</span> <br />
							 <span>暂无新帖</span>  -->
							</p>
							<a href="/PostList/Index?forumsid=@Model.Forums[i].Id"
								class=" btn btn-default enterforums">点击进入</a>
						</div>
					</div>
				</s:iterator>
			</div>
		</div>
</body>
</html>

