$(function() {
	$('#nav-log').click(function() {
		$('#Log').modal('show');
		$('#Log').on('shown.bs.modal');
	});
	$('#nav-logout').click(function() {
		$('#message-content').html(null);
		$('#message-content').append('确定退出？');
		$('#mes').modal('show');
		$('#model-btn').click(function() {
			$.post("../login/logout", function(data) {
				data = $.parseJSON(data);
				if (data.state == 'success') {
					location.reload();
				}
			});
		});
	});
	$('#log-reg').click(function() {
		$('#Log').modal('hide');
		$('#Reg').modal('show');
		$('#Reg').on('shown.bs.modal');
	});
	$('#reg-log').click(function() {
		$('#Reg').modal('hide');
		$('#Log').modal('show');
	});
	$('#logsub').click(function() {
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
			$.post("../login/login", {
				'users.username' : uname,
				'users.password' : upass,
				remember : cbox
			}, function(data) {
				data = $.parseJSON(data);
				if (data.state == 'success') {
					$('#Log').modal('hide');
					$('#message-content').html(null);
					$('#message-content').append(data.message);
					$('#mes').modal('show');
					$('#mes').on('shown.bs.modal');
					$('#model-btn').click(function() {
						location.reload();
					});
				}
			});
		}
	});
	$('#regsub').click(function() {
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
			$.post("../login/register", {
				'users.username' : uname,
				'users.password' : upass,
			}, function(data) {
				data = $.parseJSON(data);
				if (data.state == 'success') {
					$('#Reg').modal('hide');
					$('#reg-username').val(null);
					$('#reg-userpass').val(null);
					$('#reg-confirmpass').val(null);
					$('#message-content').html(null);
					$('#message-content').append(data.message);
					$('#mes').modal('show');
					$('#mes').on('shown.bs.modal');
					$('#model-btn').click(function() {
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
					$('#model-btn').click(function() {
						$('#mes').modal('hide');
						$('#Log').modal('show');
					});
				}
				;
			});
		}
		;
	});
});