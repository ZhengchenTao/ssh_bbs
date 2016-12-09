<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<link rel="stylesheet" href="../css/layout.css" />
<script src="../js/layout.js"></script>
<nav class="navbar navbar-inverse  navbar-fixed-top">
	<div class="navbar-header">
		<a href="../forums/index" class="navbar-brand">青农论坛</a>
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
								id="userpass" value="${cookie.password.value }" placeholder="密码" />
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