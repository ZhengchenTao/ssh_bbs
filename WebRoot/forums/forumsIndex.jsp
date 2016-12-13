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
.forums {
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
</head>
<body>
	<jsp:include page="../layout/clientLayout.jsp" />
	<div class="row">
		<div class="forums-list">
			<s:iterator value="#list" var="l">
				<div class="col-md-6 forums">
					<h3 class="forums-title">${l.title}</h3>
					<div class="forums-content">
						<p>
							帖子数:
							<s:iterator value="#count" var="key">
								<s:if test="key==#l.id">
									<span>${value }</span>
								</s:if>
							</s:iterator>
						</p>
						<a href="../posts/index?forumsId=${l.id }"
							class=" btn btn-default enterforums">点击进入</a>
					</div>
				</div>
			</s:iterator>
		</div>
	</div>
	</div>
</body>
</html>

