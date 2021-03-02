<%@page import="com.google.gson.Gson"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Customer"%>
<%@page import="java.util.List"%>
<%@page import="dao.CarReceptionBillDAO"%>
<%@page import="model.CarReceptionBill"%>
<%@page import="java.sql.Date"%>
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
</style>
</head>

<body>
	<%
		int customer_id = Integer.parseInt(request.getParameter("customer_id"));
	Date startDate = Date.valueOf(request.getParameter("startDate"));
	Date endDate = Date.valueOf(request.getParameter("endDate"));

	CarReceptionBillDAO billDAO = new CarReceptionBillDAO();
	List<CarReceptionBill> bills = billDAO.getBillByCustomerAndCreadtedDateBetween(customer_id, startDate, endDate);
	System.out.print(bills);

	if (bills == null) {
		response.sendRedirect(request.getContextPath() + "/admin/report.jsp");
		return;
	}
	Customer customer = bills.get(0).getCustomer();

	String billsJson = new Gson().toJson(bills);
	%>

	<!-- Header -->
	<jsp:include page="header.jsp"></jsp:include>
	<!-- End Header -->

	<!-- Content -->
	<div class="content">
		<div class="container">
			<!-- Bill Modal-->
			<div id="billModal" class="modal fade" role="dialog">
				<div class="modal-dialog" style="max-width: 750px;">
					<!-- Modal content-->

					<div class="modal-content">
						<div>
							<button type="button" style="font-size: 30px; padding: 8px 8px;"
								class="close float-right" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body" style="padding-top: 0;">
							<div class="invoice-box">
								<div class="row">
									<div class="col">
										<img src="../static/images/logo.png"
											style="width: 100%; max-width: 200px;">
									</div>
									<div class="col text-right">
										<span id="bill_id">#1102</span><br> <span id="bill_date">October
											19, 2020</span><br>
									</div>
								</div>
								<div class="row pt-4">
									<div class="col">
										<h4>Khách hàng</h4>
										<span class="form-text" id=customerName>Dương Văn Linh
										</span> <cite title="San Francisco, USA" id="customerAddress">Vĩnh
											Phúc </cite> <i class="fa fa-map-marker ml-1"> </i> <br>

									</div>
									<div class="col text-right">
										<h4>Nhân viên thanh toán</h4>
										<span class="form-text" id="paymentStaffName">Hoàng Hà
											Lam </span>

									</div>
								</div>
								<div class="list-service-part pt-3" id="listServicePart">
									<div class="card">
										<div class="card-header">
											<h4 class="card-title mb-0">
												<span class="font-weight-bold">Danh sách các dịch vụ
													phụ tùng</span>
											</h4>
										</div>
										<div class="card-body table-responsive">
											<table id="list_sp" class="table table-hover">
												<thead class="">
													<tr>
														<th>#</th>
														<th>Tên</th>
														<th>Giá</th>
														<th>Số lượng</th>
													</tr>
												</thead>
												<tbody>
													
												</tbody>
											</table>
											<div class="float-right font-weight-bold mr-4"
												id="totalPrice">Tổng tiền: ##.##</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="customer-car-info">
				<div class="row">
					<!-- customer info -->
					<div class="col-sm-5">
						<div class="card">
							<div class="card-header text-center"
								style="background-color: #33b5e5; color: #fff;">
								<h4 class="card-title">Thông tin khách hàng</h4>
							</div>
							<div class="card-body" style="padding: 1rem">
								<div id="customerInfo" style="display: block;">
									<div class="form-group">
										<h4 class="form-text" id="customerName"><%=customer.getName()%>
											<i class="fa fa-check"></i>
										</h4>
									</div>
									<div class="form-group">
										<cite title="San Francisco, USA" id="address"><%=customer.getAddress()%>
										</cite> <i class="fa fa-map-marker ml-1"> </i>
									</div>
									<div class="form-group">
										<i class="fa fa-envelope"></i> <span class="cus-info"
											id="email"><%=customer.getEmail()%></span>
									</div>
									<div class="form-group">
										<i class="fa fa-phone"></i> <span class="cus-info"
											style="margin-left: 7px;" id="phone"><%=customer.getPhone()%></span>
									</div>
									<div class="form-group">
										<i class="fa fa-credit-card"></i> <span class="cus-info"
											id="cardNumber"><%=customer.getCardNumber()%></span>
									</div>
									<div class="form-group" style="margin-bottom: 0;">
										<i class="fa fa-calendar"></i> <span class="cus-info" id="dob">
											<%=new SimpleDateFormat("dd/MM/yyyy").format(customer.getDob())%></span>
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="list-service-part pt-3">
				<div class="card">
					<div class="card-header pb-0">
						<h4 class="card-title font-weight-bold">Danh sách các lần
							nhận xe</h4>
					</div>
				</div>
				<div class="card-body table-responsive">
					<table id="car_receptions" class="table table-hover">
						<thead>
							<tr>
								<th>#</th>
								<th>Ngày nhận xe</th>
								<th>Ngày thanh toán</th>
								<th>Nhân viên thanh toán</th>
								<th>Tổng tiền</th>

							</tr>
						</thead>
						<tbody>
							<%
								for (CarReceptionBill bill : bills) {
							%>
							<tr class="c-pointer" data-toggle="modal"
								data-target="#billModal">
								<th scope="row"><%=bill.getId()%></th>
								<td><%=new SimpleDateFormat("dd/MM/yyyy").format(bill.getCreatedDate())%></td>
								<td><%=new SimpleDateFormat("dd/MM/yyyy").format(bill.getCreatedDateBill())%></td>
								<td><%=bill.getCustomer().getName()%></td>
								<td><%=bill.getTotalPrice()%></td>
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
	<!-- End Content -->
	
	<!-- Optional JavaScript -->
	<script src="<c:url value="/static/js/login.js"/>"></script>
	<script>
		// set a data in your js code from jsp but not reverse (js <- jsp not jsp <- js) :v
		var bills = <%=billsJson%>	// ? :v
		console.log(bills);
		
    	// event click show bill detail
    	$('#car_receptions tr').click(function(){
    		var index = $(this).index();    		
    		// get bill 
    		var bill = bills[index];
    		// get total price
    		var totalPrice = $(this).find("td").eq(3).text();
    		
    		$("#bill_id").html("#" + bill.id);
    		$("#bill_date").html(bill.createdDateBill);
    		$("#customerName").html(bill.customer.name);
    		$("#customerAddress").html(bill.customer.address);
    		$("#paymentStaffName").html(bill.paymentStaff.name);    		
    		$("#totalPrice").html("Tổng tiền: " + totalPrice);
    		
    		// remove all service, part
    		$("#list_sp tbody tr").remove();
    		
    		// add services to table
    		if (bill.services != null) {
    			for (var crService of bill.services) {
        			var service = crService.service;
        			var quantity = crService.quantity;
        			$("#list_sp tbody").append(
        					`<tr>`+
        						`<th>\${service.id}</th>`+
        						`<td>\${service.name}</td>`+
        						`<td>\${service.price}</td>`+
        						`<td>\${quantity}</td>`+
        					`</tr>`);
        		}
    		}    		
    		// add part to table
    		if (bill.parts != null) {
    			for (var crPart of bill.parts) {
        			var part = crPart.part;
        			var quantity = crPart.quantity;
        			$("#list_sp tbody").append(
        					`<tr>`+
        						`<th>\${part.id}</th>`+
        						`<td>\${part.name}</td>`+
        						`<td>\${part.price}</td>`+
        						`<td>\${quantity}</td>`+
        					`</tr>`);
        		}
    		}
    		
    	});
    </script>
</body>

</html>