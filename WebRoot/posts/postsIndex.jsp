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
</style>
<script type="text/javascript">
	$(function() {
		$('.forums-nav').hover(function() {
			$(this).addClass('active');
		}, function() {
			$(this).removeClass('active');
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
						<a href="../posts/addPost?forumsId=${forums.id }"
							class="btn btn-primary pull-right" style="font-size: 20px;">&nbsp;&nbsp;发帖&nbsp;&nbsp;</a>
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
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th style="width: 500px;">帖子标题</th>
							<th>作者</th>
							<th style="width: 100px;">查看/回复</th>
							<th>最后发表</th>
						</tr>
					</thead>
					<tbody>
						<s:iterator value="#polist" var="pl">
							<tr>
								<td><a href="../posts/checkPost?postId=${pl.id }">${pl.title }</a></td>
								<td><a href="">@post.Users.username</a></td>
								<td><span id="pcheck">${pl.clickNum }</span>/<span>@check</span></td>
								<!-- <td><a href=""><span id="pcheckname">@lastrep.Users.username</span></a>&nbsp;<span>@string.Format("{0:f}",
										lastrep.ReplyTime)</span></td>-->
								<td>暂无回复</td>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</div>
			<div class="text-center">
				<nav>
					<ul class="pagination">
						<li><a href="index?page=${page-1 }">&laquo;</a></li>

						<s:bean name="org.apache.struts2.util.Counter" var="Counter">
							<s:param name="first" value="1" />
							<s:param name="last" value="#cpage" />
							<s:iterator>
								<s:if test="current-1 == page">
									<li class="active"><a href="index?page=${current-1 } ">${current-1 }</a></li>
								</s:if>
								<s:else>
									<li><a href="index?page=${current-1 } ">${current-1 }</a></li>
								</s:else>
							</s:iterator>
						</s:bean>

						<li><a href="index?page=${page+1 }">&raquo;</a></li>
					</ul>

				</nav>
			</div>
		</div>
	</div>

	</div>
</body>
</html>

