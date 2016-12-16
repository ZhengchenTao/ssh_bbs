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
		$('#left-nav-forum').addClass("active");
		$('.glyphicon-cog').click(function() {
			if (edit == 0) {
				var eid = $(this).attr('att');
				$('.show_' + eid + '').addClass('hidden');
				$('.edit_' + eid + '').removeClass('hidden');
				edit = 1;
			} else {
				$('#message-content').html(null);
				$('#message-content').append('请先完成当前编辑');
				$('#mes').modal('show');
			}
		});
		$('.glyphicon-trash').click(function() {
			var eid = $(this).attr('att');
			$('#message-content').html(null);
			$('#message-content').append('确认删除？');
			$('#mes').modal('show');
			$('#model-btn').click(function() {
				$('#mes').modal('hide');
				$.post("../admin/forumsDelete", {
					'forums.id' : eid
				}, function(data) {
					data = $.parseJSON(data);
					if (data.state == 'success') {
						$('#message-content2').html(null);
						$('#message-content2').append(data.message);
						$('#mes2').modal('show');
						$('#model-btn2').click(function() {
							top.location.reload();
						});
					} else {
						$('#message-content2').html(null);
						$('#message-content2').append(data.message);
						$('#mes2').modal('show');
					}
				});
			});
		});
		$('.glyphicon-ok').click(function() {
			var flag = 0;
			var eid = $(this).attr('att');
			var etitle = $('#forumstitle_' + eid + '').val();
			var ftitle = $('#ftitle_' + eid + '').html();
			if (etitle == ftitle) {
				$('#message-content').html(null);
				$('#message-content').append('未做任何修改');
				$('#mes').modal('show');
			} else {
				$.post("../admin/forumsUpdate", {
					'forums.id' : eid,
					'forums.title' : etitle
				}, function(data) {
					data = $.parseJSON(data);
					if (data.state == 'success') {
						$('#message-content2').html(null);
						$('#message-content2').append(data.message);
						$('#mes2').modal('show');
						$('#model-btn2').click(function() {
							top.location.reload();
						});
					} else {
						$('#message-content').html(null);
						$('#message-content').append(data.message);
						$('#mes').modal('show');
					}
				})
			}
		});
		$('.glyphicon-remove').click(function() {
			var eid = $(this).attr('att');
			$('.show_' + eid + '').removeClass('hidden');
			$('.edit_' + eid + '').addClass('hidden');
			edit = 0;
		});
		$('#addforum').click(function() {
			$('#message-content').html(null);
			$('#message-content').append('<input type="text" class="form-control" id="addforumname" placeholder="请输入板块名称">');
			$('#mes').modal('show');
			$('#model-btn').click(function() {
				var title = $('#addforumname').val();
				$.post("../admin/forumsAdd", {'forums.title' : title}, function(data) {
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
	});
</script>
<style>
.forums-table {
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
	<div class="forums-table">
		<button class="btn btn-primary pull-right" id="addforum">
			<span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;添加板块
		</button>
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th>ID</th>
					<th>板块名</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="#list" var="l">
					<tr>
						<td>${l.id }</td>
						<td><span class="show_${l.id }" id="ftitle_${l.id }">${l.title }</span>
							<input type="text"
							class="form-control hidden input-sm edit_${l.id }"
							id="forumstitle_${l.id }" value="${l.title }" /></td>
						<td>
							<div class="show_${l.id }">
								<a href="#"><span class="glyphicon glyphicon-cog"
									att="${l.id }"></span></a>&nbsp;&nbsp; <a href="#"><span
									class="glyphicon glyphicon-trash" att="${l.id }"></span></a>
							</div>
							<div class="hidden edit_${l.id }">
								<a href="#"><span class="glyphicon glyphicon-ok"
									att="${l.id }"></span></a>&nbsp;&nbsp; <a href="#"><span
									class="glyphicon glyphicon-remove" att="${l.id }"></span></a>
							</div>
						</td>
					</tr>
				</s:iterator>
			</tbody>
		</table>
		<div class="text-center">
			<nav>
			<ul class="pagination">
				<li><a href="../admin/forumsIndex?page=${page-1 }">&laquo;</a></li>

				<s:bean name="org.apache.struts2.util.Counter" var="Counter">
					<s:param name="first" value="1" />
					<s:param name="last" value="#cpage" />
					<s:iterator>
						<s:if test="current-1 == page">
							<li class="active"><a
								href="../admin/forumsIndex?page=${current-1 } ">${current-1 }</a></li>
						</s:if>
						<s:else>
							<li><a href="../admin/forumsIndex?page=${current-1 } ">${current-1 }</a></li>
						</s:else>
					</s:iterator>
				</s:bean>

				<li><a href="../admin/forumsIndex?page=${page+1 }">&raquo;</a></li>
			</ul>

			</nav>
		</div>
	</div>
	</div>
	</div>
	</div>
</body>
</html>
