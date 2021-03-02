<%@page import="model.Staff"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<body>

	<%
		Staff user = (Staff) session.getAttribute("user");
		
	%>
	<!-- Header -->
	<!-- Login Modal -->

	<div id="loginModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">Đăng nhập</h4>
					
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<h5 class="text-danger" id="messageLogin" style="display:none"></h5>
					<form>
						<div class="form-group">
							<label for="username">Username</label> <input type="email"
								class="form-control" id="username" aria-describedby="emailHelp"
								placeholder="username">
						</div>
						<div class="form-group">
							<label for="password">Password</label> <input type="password"
								class="form-control" id="password" placeholder="password">
						</div>
						<a id="login" class="btn btn-success text-white">Đăng nhập</a>
					</form>
				</div>
				<div class="modal-footer">
					<button id="closeLoginModal" type="button" class="btn btn-info"
						data-dismiss="modal">Hủy bỏ</button>
				</div>
			</div>

		</div>
	</div>
	<div class="main-header">
		<div class="header-top">
			<div class="row clearfix">
				<!-- Logo -->
				<div class="col-2 logo">
					<a href="#"> <img
						src="<c:url value="/static/images/logo.png" />" alt="Logo">
					</a>
				</div>
				<div class="col-3"></div>
				<div class="col-5 header-top-infos ">
					<ul class="row clearfix">
						<li>
							<div class="clearfix">
								<img src="<c:url value="/static/images/header-phone.png" />"
									alt="image">
								<p>
									<b>Call Us Now</b> <br> +49 123 456 789
								</p>
							</div>
						</li>
						<li>
							<div class="clearfix">
								<img src="<c:url value="/static/images/header-timer.png" />"
									alt="image">
								<p>
									<b>Opening Hours</b> <br>Mon - Sat 9.00 - 19.00
								</p>
							</div>
						</li>

					</ul>
				</div>
				<div class="col-2" style="margin-top: 20px;">
					<ul class="row clearfix">

						<li>
							<button id="loginBtn" class="btn btn-info" data-toggle="modal"
								data-target="#loginModal">Đăng nhập</button>
						</li>

						<li id="userLogin" style="margin: 4px 15px 0 0"><i
							id="userIcon" class="fa fa-user" style="font-size: 25px;"></i> 
							<span id="usernameLogin" style="font-size: 20px;"> 
							<%
							 	if (user != null)
							 	out.print(user.getUsername());
							 %>
							 </span>
						</li>
						<li><a href="<c:url value="/staff/logout" />" id="logoutBtn"
							class="btn btn-info text-white">Đăng xuất</a></li>

					</ul>



				</div>
			</div>
		</div>
		<div class="main-menu">
			<nav class="navbar navbar-expand-lg">
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarNav" aria-controls="navbarNav"
					aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link" href="home.jsp">Trang
								chủ <span class="sr-only">(current)</span>
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="car_reception.jsp">Nhận xe</a></li>
						<li class="nav-item"><a class="nav-link" href="payment.jsp">Thanh
								toán</a></li>
						<li class="nav-item"><a class="nav-link" href="report.jsp">Thống
								kê</a></li>
					</ul>
				</div>
			</nav>

		</div>
	</div>
	<!-- End Header -->
	<div id="checkLogin">		
	</div>
	<script src="<c:url value="/static/js/login.js"/>"></script>
	<%		
			
		if (user == null) {%>			
			<script>
			console.log("staff not loged");
				$('#checkLogin p').remove();
				$('#checkLogin').append('<p id="loginStatus" style="display: none">0</p>');	
			</script>
		<% } else {%>
			<script>	
			console.log("staff loged");
				$('#checkLogin p').remove();
				$('#checkLogin').append('<p id="loginStatus" style="display: none">1</p>');			
			</script>
		<%}
	%>
	
	<%
		if (user == null) {
	%>
	<script>
		$("#loginBtn").show();
		$("#logoutBtn").hide();
		$("#userLogin").hide();
	</script>
	<%
		} else {
	%>
	<script>
		$("#loginBtn").hide();
		$("#logoutBtn").show();
		$("#userLogin").show();
	</script>
	<%
		}
	%>
</body>
</html>