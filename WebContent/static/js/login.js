
$('#loginBtn').click( function() {
	$('#messageLogin').hide();
})
$("#login").click(() => {
	login();
})

$('#username').keyup(function(e) {
	if (e.keyCode == 13) {
		login();
	}
});

$('#password').keyup(function(e) {
	if (e.keyCode == 13) {
		login();
	}
});

var login = () => {

	var username = $("#username").val();
	var password = $("#password").val();

	// post data 
	$.ajax({
		url: 'http://localhost:8080/GaraMan/staff/login',
		type: 'POST',
		data: {  username: username, password: password },
		dataType: 'json',
		success: function(user) {
			if (user == null) {
				$('#messageLogin').show();
				$('#messageLogin').html('Sai thông tin đăng nhập!');
				return;
			} else {
				$('#loginStatus').html(1);
				$("#closeLoginModal").click();
				$("#loginBtn").hide();
				$("#logoutBtn").show();
				$("#userLogin").show();
				$("#usernameLogin").html(user.username);
			}


		},
		error: function() {
		}
	})
}