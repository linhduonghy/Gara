<%@page import="model.Staff"%>
<%@page import="model.CustomerReport"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" type="text/css"
	href="//fonts.googleapis.com/css?family=Open+Sans" />
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="<c:url value = "/static/css/bootstrap.min.css" />">
<script src="https://use.fontawesome.com/369acbe04f.js"></script>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="<c:url value="/static/js/jquery-3.5.1.min.js"/>"></script>
<script src="<c:url value="/static/js/popper.min.js"/>"></script>
<script src="<c:url value="/static/js/bootstrap.min.js"/>"></script>
<!-- Custom CSS -->
<link rel="stylesheet" href="<c:url value = "/static/css/style.css" />">
<style>
body {
	background-color: #eee;
}

.report {
	padding: 5% 2%;
	background-color: #fff;
}
</style>
<title>Thống kê</title>
</head>

<body>
	<%
		List<CustomerReport> customerReports = (List<CustomerReport>) session.getAttribute("customerReports");
	Float total = (Float) session.getAttribute("total");
	%>
	<!-- Header -->
	<jsp:include page="header.jsp"></jsp:include>
	<!-- End Header -->


	<!-- Content -->
	<div class="container">
		<form action="/GaraMan/customer_report/get" method="get">
			<div class="report">
				<div class="dropdown">
					<div class="select">
						<span id="reportType">Chọn thống kê</span>
					</div>
					<ul id="report_box" class="dropdown-menu">
						<li>Thống kê khách hàng</li>

						<li>Thống kê dịch vụ, phụ tùng</li>

						<li>Thống kê nhà cung cấp</li>


					</ul>
				</div>

				<input type="hidden" id="report_type" name="report_type">

				<div class="row">
					<div class="col">
						<div class="row pt-4">
							<div class="col-md-4 col-sm-12">
								Từ ngày: <input type="date" name="startDate" value="2020-06-15">
							</div>
							<div class="col-md-8 col-sm-12">
								Đến ngày: <input type="date" name="endDate" value="2021-02-11">
								<button type="submit" id="btnReport"
									class="btn btn-primary ml-4">Thống kê</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row report-table">
				<div class="col-lg-12 col-md-6">
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">Thống kê khách hàng</h4>
						</div>
						<div class="card-body table-responsive">
							<table class="table table-hover">
								<thead class="">
									<tr>
										<th>Mã KH</th>
										<th>Họ Tên</th>
										<th>Doanh thu</th>
									</tr>
								</thead>
								<tbody>
									<%
										if (customerReports != null) {
										for (CustomerReport customerReport : customerReports) {
											int customer_id = customerReport.getCustomer().getId();
									%>
									<tr class="c-pointer"
										data-href="customer_report_detail.jsp
													?customer_id=<%=customer_id%>
													&startDate=<%=customerReport.getStartDate()%>
													&endDate=<%=customerReport.getEndDate()%>">
										<td><%=customer_id%></td>
										<td><%=customerReport.getCustomer().getName()%></td>
										<td><%=customerReport.getRevenue()%></td>
									</tr>
									<%
										}
									%>
									<tr>
										<td></td>
										<td></td>
										<td><strong>Tổng doanh thu: <%=total%>
										</strong></td>
									</tr>
									<%
										}
									%>


								</tbody>
							</table>
						</div>
					</div>

				</div>
			</div>
		</form>
	</div>


	<!-- End Content -->
	<%
		Staff staff = (Staff) session.getAttribute("user");
	
	if (staff != null && !staff.getRole().getTitle().equalsIgnoreCase("Nhân viên quản lý")) {
	%>
	<script>
		alert("Chức năng này thuộc quyền hạn của nhân viên quản lý");
		window.location.href = "/GaraMan/admin/home.jsp";
	</script>
	<%
		}
	%>
	<!-- Optional JavaScript -->
	<script>
		$('#btnReport').click(function() {
			if ($("#loginStatus").text() == 0) {
				alert("Bạn chưa đăng nhập. Vui lòng đăng nhập để tiếp tục!");
				$("#loginBtn").click();
				return false;
			}

			if ($("#reportType").text().trim().indexOf("khách hàng") == -1) {
				alert("Vui lòng chọn loại thống kê!");
				return false;
			}
			var st = $('#startDate').val();
			var en = $('#endDate').val();
			if (st > en) {
				alert("Vui lòng chọn ngày bắt đầu sau ngày kết thúc!");
				return false;
			}
			return true;
		})
		/*Dropdown Menu*/
		$('.dropdown').click(function() {
			$(this).attr('tabindex', 1).focus();
			$(this).toggleClass('active');
			$(this).find('.dropdown-menu').slideToggle(300);
		});
		$('.dropdown').focusout(function() {
			$(this).removeClass('active');
			$(this).find('.dropdown-menu').slideUp(300);
		});
		$('.dropdown .dropdown-menu li').click(
				function() {
					$(this).parents('.dropdown').find('span').text(
							$(this).text());
					$(this).parents('.dropdown').find('input').attr('value',
							$(this).attr('id'));
				});
		/*End Dropdown Menu*/

		// script link table tr 
		$('tr[data-href]').on("click", function() {
			document.location = $(this).data('href');
		});

		/* */

		$("#report_box li").click(function() {

			$("#report_type").val($(this).text());
		})
	</script>
	<script src="../static/js/custom.js"></script>

</body>

</html>