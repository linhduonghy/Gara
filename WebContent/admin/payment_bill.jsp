<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.CarReceptionBill"%>
<%@page import="dao.CarReceptionBillDAO"%>
<%@page import="model.CarReceptionPart"%>
<%@page import="model.CarReceptionService"%>
<%@page import="model.CarReception"%>
<%@page import="dao.CarReceptionDAO"%>
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
<title>Nhận xe</title>
</head>
<body>

	<%
		// get car_reception_id  request
	int car_reception_id = Integer.parseInt(request.getParameter("id"));
	// get car_reception by id
	CarReceptionDAO carReceptionDAO = new CarReceptionDAO();
	CarReception carReception = carReceptionDAO.getCarReception(car_reception_id);
	// get bill by car_reception_id
	CarReceptionBillDAO billDAO = new CarReceptionBillDAO();
	CarReceptionBill bill = billDAO.get(car_reception_id);
	System.out.println(carReception);
	if (carReception == null) {
		response.sendRedirect(request.getContextPath() + "/admin/payment.jsp");
		return;
	}
	%>
	<!-- Header -->
	<jsp:include page="header.jsp"></jsp:include>
	<!-- End Header -->

	<!-- Content -->
	<!-- Bill Modal -->
	<%
		if (bill != null) {
	%>
	<div id="billModal" class="modal fade" role="dialog">
		<div class="modal-dialog" style="max-width: 750px;">
			<!-- Modal content-->

			<div class="modal-content">
				<div>
					<button id="closeBillDetail" type="button"
						style="font-size: 30px; padding: 8px 8px;"
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
								#<%=bill.getId()%><br>
								<%=new SimpleDateFormat("MM/dd/yyyy").format(bill.getCreatedDateBill())%><br>
							</div>
						</div>
						<div class="row pt-4">
							<div class="col">
								<h4>Khách hàng</h4>
								<span class="form-text" id="customerName"><%=bill.getCustomer().getName()%></span>
								<cite title="San Francisco, USA" id="address"><%=bill.getCustomer().getAddress()%></cite>
								<i class="fa fa-map-marker ml-1"> </i> <br>

							</div>
							<div class="col text-right">
								<h4>Nhân viên thanh toán</h4>
								<span class="form-text" id="customerName"><%=bill.getPaymentStaff().getName()%>
								</span>

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
									<table class="table table-hover">
										<thead class="">
											<tr>
												<th>ID</th>
												<th>Tên</th>
												<th>Giá</th>
												<th>Số lượng</th>
											</tr>
										</thead>
										<tbody>
											<%
												if (bill.getServices() != null) {
												for (CarReceptionService crs : bill.getServices()) {
											%>
											<tr class="service">
												<td><%=crs.getService().getId()%></td>
												<td><%=crs.getService().getName()%></td>
												<td><%=crs.getService().getDescription()%></td>
												<td><%=crs.getService().getPrice()%></td>
												<td><%=crs.getQuantity()%></td>
											</tr>
											<%
												}
											}
											%>
											<%
												if (bill.getParts() != null) {
												for (CarReceptionPart crp : bill.getParts()) {
											%>
											<tr class="part">
												<td><%=crp.getPart().getId()%></td>
												<td><%=crp.getPart().getName()%></td>
												<td><%=crp.getPart().getDescription()%></td>
												<td><%=crp.getPart().getPrice()%></td>
												<td><%=crp.getQuantity()%></td>
											</tr>
											<%
												}
											}
											%>
										</tbody>
									</table>
									<div class="float-right font-weight-bold mr-4">
										Tổng tiền:
										<%=bill.getTotalPrice()%></div>
								</div>
							</div>
						</div>
						<button id="printBill" class="btn btn-success float-right mt-3">In
							hóa đơn</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%
		}
	%>
	<!-- Add service part Modal -->
	<div id="AddServicePartModal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title float-left">Bổ sung dịch vụ, phụ tùng</h4>
					<button id="closeModalSP" type="button" class="close"
						data-dismiss="modal">&times;</button>
				</div>
				<div class="modal-body">
					<div class="service-part" style="margin-top: 0px;">
						<div class="service-part-search">
							<input class="form-control" id="sp_input" type="text"
								placeholder="tìm kiếm dịch vụ, phụ tùng">
							<div id="sp_search_list" style="display: none">
								<table id="table_sp" class="table table-hover">
									<tbody>
										<tr style="cursor: pointer;">
											<td>Dương Văn Linh</td>
											<td>Vĩnh Phúc</td>
											<td>0396156993</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="service-part-detail card mt-2"
							style="max-width: 445px;">
							<div class="card-header"
								style="background-color: #33b5e5; color: #fff;">
								<h5 style="margin-bottom: 0;" class="card-title">Thông tin
									dịch vụ, phụ tùng</h5>
							</div>
							<div class="card-body" id="spDetail" style="padding: 0.75rem;">
								<span id="spId" style="display: none;"></span>
								<div class="service-part-item">
									Tên dịch vụ, phụ tùng: <span id="spName" class="sp-search-item"></span>
								</div>
								<div class="service-part-item">
									Mô tả: <span id="spDescription" class="sp-search-item"></span>
								</div>
								<div class="service-part-item">
									Giá:<span id="spPrice" class="sp-search-item"></span>
								</div>

								<div class="service-part-item" id="quantityInStock">
									Còn lại trong kho:<span id="spQuantityInStock"
										class="sp-search-item"></span>
								</div>
								<div class="service-part-item">
									<label for="name">Số lượng: </label> <input
										style="width: 40px; height: 30px;" type="number"
										id="spQuantity" value="1" /> <a id="confirmSP"
										class="btn btn-primary text-white" style="margin-left: 200px;">
										Xác nhận</a>
								</div>
								<label id="spType" style="display: none;"></label>
							</div>

						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="content">
		<div class="container">
			<%
				String msg = (String) session.getAttribute("msg");
			if (msg != null) {
			%>
			<h3 style="color: #ff0000; background: #ecffe6; margin-top: -20px;">
				<%=msg%>
			</h3>
			<%
				session.removeAttribute("msg");
			}
			%>
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
										<h4 class="form-text" id="customerName"><%=carReception.getCustomer().getName()%>
											<i class="fa fa-check"></i>
										</h4>
									</div>
									<div class="form-group">
										<cite title="San Francisco, USA" id="address"><%=carReception.getCustomer().getAddress()%>
										</cite> <i class="fa fa-map-marker ml-1"> </i>
									</div>
									<div class="form-group">
										<i class="fa fa-envelope"></i> <span class="cus-info"
											id="email"><%=carReception.getCustomer().getEmail()%></span>
									</div>
									<div class="form-group">
										<i class="fa fa-phone"></i> <span class="cus-info"
											style="margin-left: 7px;" id="phone"><%=carReception.getCustomer().getPhone()%></span>
									</div>
									<div class="form-group">
										<i class="fa fa-credit-card"></i> <span class="cus-info"
											id="cardNumber"><%=carReception.getCustomer().getCardNumber()%></span>
									</div>
									<div class="form-group" style="margin-bottom: 0;">
										<i class="fa fa-calendar"></i> <span class="cus-info" id="dob"><%=carReception.getCustomer().getDob()%></span>
									</div>

								</div>
							</div>
						</div>
					</div>

					<div class="col-sm-1"></div>
					<!-- car reception info -->
					<div class="col-sm-6">
						<div class="card " style="margin-left: -20px">
							<div class="card-header text-center"
								style="background-color: #33b5e5; color: #fff;">
								<h4 class="card-title">Thông tin nhận xe</h4>
							</div>
							<div class="card-body" style="padding-bottom: 1rem;">
								<div class="form-group">
									<label class="form-text">Ngày nhận xe: <span
										class="font-italic font-weight-bold"><%=new SimpleDateFormat("MM/dd/yyyy").format(carReception.getUpdatedDate())%></span></label>
								</div>
								<div class="form-group">
									<label class="form-text">Nhân viên nhận xe: <span
										class="font-italic font-weight-bold"><%=carReception.getSaleStaff().getName()%></span></label>
								</div>
								<div class="form-group">
									<label class="form-text">Nhân viên kỹ thuật: <span
										class="font-italic font-weight-bold"><%=carReception.getTechnicalStaff().getName()%></span></label>
								</div>

							</div>
						</div>
					</div>
				</div>
			</div>

			<form action="/GaraMan/CarReceptionBill/insert" method="post">
				<div class="list-service-part pt-3" id="listServicePart">
					<div class="card">
						<div class="card-header">
							<h4 class="card-title mb-0">
								<span class="font-weight-bold">Danh sách các dịch vụ phụ
									tùng</span>
								<%
									if (bill == null) {
								%>
								<a id="btnAdd" class="btn btn-primary text-white"
									style="margin-left: 5%;" data-toggle="modal"
									data-target="#AddServicePartModal">Bổ sung</a>
								<%
									}
								%>
							</h4>
						</div>
						<div class="card-body table-responsive">
							<table id="sp_list" class="table table-hover">
								<thead>
									<tr>
										<th>ID</th>
										<th>Tên</th>
										<th>Mô tả</th>
										<th>Đơn giá</th>
										<th>Số lượng</th>
									</tr>
								</thead>
								<tbody>

									<%
										if (carReception.getServices() != null) {
										for (CarReceptionService crs : carReception.getServices()) {
									%>
									<tr class="service">
										<td><%=crs.getService().getId()%></td>
										<td><%=crs.getService().getName()%></td>
										<td><%=crs.getService().getDescription()%></td>
										<td><%=crs.getService().getPrice()%></td>
										<td><%=crs.getQuantity()%></td>
									</tr>
									<%
										}
									}
									%>
									<%
										if (carReception.getParts() != null) {
										for (CarReceptionPart crp : carReception.getParts()) {
									%>
									<tr class="part">
										<td><%=crp.getPart().getId()%></td>
										<td><%=crp.getPart().getName()%></td>
										<td><%=crp.getPart().getDescription()%></td>
										<td><%=crp.getPart().getPrice()%></td>
										<td><%=crp.getQuantity()%></td>
									</tr>
									<%
										}
									}
									%>

								</tbody>
							</table>
							<%
								if (bill != null) {
							%>
							<div class="float-right font-weight-bold mr-4">
								Tổng tiền:
								<%=bill.getTotalPrice()%></div>
							<%
								}
							%>
						</div>
					</div>
				</div>
				<input type="hidden" name="car_reception_id"
					value=<%=car_reception_id%>> <input type="hidden"
					id="changed" name="changed" value="false">
				<%
					if (bill == null) {
				%>
				<input id="confirmBill" type="submit"
					class="btn btn-primary m-3 float-right" value="Xác nhận hóa đơn">
				<%
					} else {
				%>
				<a class="btn btn-success text-white m-3 float-right"
					data-toggle="modal" data-target="#billModal">In hóa đơn</a>
				<%
					}
				%>
			</form>
		</div>
	</div>
	<!-- End Content -->

	<!-- Optional JavaScript -->
	<script src="<c:url value="/static/js/login.js"/>"></script>
	<script>    
		/* add service part */	
		// search SP
		$("#sp_search_list").hide();
		var listSPHeight = $('#sp_search_list').height();
		$("#sp_input").keyup( () => {		
			// check service is empty
			var isEmpty = true;
			var input = $("#sp_input").val();
			if (input == "") {
				$('#sp_search_list').hide();
				return;
			}
			// remove table
			$('#table_sp tbody tr').remove();
			// remove alert 
			$('#sp_search_list .alert').remove();
			
			$("#sp_search_list").height(listSPHeight);
			$('#sp_search_list').show();
			// get service
			$.getJSON(`http://localhost:8080/GaraMan/service/get?name=\${input}`, (data) => {
				if (data.length != 0) {					
					isEmpty = false;					
					$("#table_sp tbody").append(`<tr>`+
							`<th> Tên dịch vụ</th>`+
							`<th>Mô tả</th>`+
							`<th>Giá</th>`+											
						`</tr>`);
				}
				data.forEach( (service) => {					
					$("#table_sp tbody").append(
							`<tr id="service_\${service.id}" style="cursor: pointer;">`+
								`<td >\${service.name}</td>`+
								`<td >\${service.description}</td>`+
								`<td >\${service.price}</td>`+
							`</tr>`);
					$("#service_"+service.id).click( () => {
						$("#sp_input").val('');
						$("#sp_search_list").hide();
						addSP(service, "service");
					})					
				})
			})
			// get part
			$.getJSON(`http://localhost:8080/GaraMan/part/get?name=\${input}`, (data) => {
				if (data.length != 0) {
					isEmpty = false;
					$("#table_sp tbody").append(`<tr>`+
							`<th>Tên phụ tùng</th>`+
							`<th>Mô tả</th>`+
							`<th>Giá</th>`+
						`</tr>`);
				} else {										
					// service empty and part empty
					if (isEmpty) {
						$("#sp_search_list").height("100px");
						$("#sp_search_list").append(`<div class="alert alert-warning" role="alert">Không tìm thấy thông tin dịch vu, phụ tùng</div>`);
					}
				}
				data.forEach( (part) => {		
					// add service to table service part search
					$("#table_sp tbody").append(
							`<tr id="part_\${part.id}" style="cursor: pointer;">`+
								`<td>\${part.name}</td>`+
								`<td>\${part.description}</td>`+
								`<td>\${part.price}</td>`+
							`</tr>`);
					// event click a service
					$("#part_"+part.id).click( () => {
						$("#sp_input").val('');
						$("#sp_search_list").hide();
						addSP(part, "part");
					})			
				})
			})
			
		})		
		
		var addSP = (sp, t) => {
			$("#spType").html(t);		
			$('#spId').html(sp.id);
			$('#spName').html(sp.name);
			$('#spDescription').html(sp.description);
			$('#spPrice').html(sp.price);
			if ('quantityInStock' in sp) {
				$('#spDetail #quantityInStock').show();
				$('#spQuantityInStock').html(sp.quantityInStock);
			} else {
				$('#spDetail #quantityInStock').hide();
			}
		}
		// list service part
		var listSP = [];
		$("#sp_list tbody tr.service").each(function() {			
			var tds = $(this).find("td");
			var sp = {id: tds.eq(0).text(), name: tds.eq(1).text(), des: tds.eq(2).text(),
					price: tds.eq(3).text(), quantity: tds.eq(4).text(), type:"service"};	
			listSP.push(sp);
		});
		
		$("#sp_list tbody tr.part").each(function() {			
			var tds = $(this).find("td");
			var sp = {id: tds.eq(0).text(), name: tds.eq(1).text(), des: tds.eq(2).text(),
					price: tds.eq(3).text(), quantity: tds.eq(4).text(), type:"part"};	
			listSP.push(sp);
		});
		
		console.log(listSP);
		// event confirm add service part to list	
		
		$("#confirmSP").click( () => {		
			$("#closeModalSP").click();
			var sp = {id: $('#spId').text(), name:$('#spName').text(), des: $('#spDescription').text(),
						price: $('#spPrice').text(), quantity: $('#spQuantity').val(), type: $('#spType').text()};			
			console.log(sp);
			var isNew = true;
			var isModify = false;
			
			for (var s of listSP) {
				if (s.id == sp.id && s.name == sp.name) {
					console.log(s);
					if (s.quantity != sp.quantity) {
						console.log("change quantity");
						changed = true;
						isNew = false;
						isModify = true;
						s.quantity = sp.quantity;
					} else {
						console.log("not change");
						// not change
						changed = false;
						isNew = false;
						isModify = false;
					}										
				} 
				/* else {		
					console.log("new");
					change = true;
					isNew = true;
					isModify = false;
				} */
			}
			if (changed) {
				$('#changed').val('true');
			}
			if (isNew) 
				listSP.push(sp);	
			$("#sp_list tbody tr").remove();
			for (var s of listSP) {				
				$("#sp_list tbody").append(
					`<tr>`+
						`<td>`+s.id+`</td>`+
						/* add hidden input form: sp_id */
						`<input type='hidden' name="sp" class="sp" value=\${s.id}>`+
						`<td>`+s.name+`</td>`+
						`<td>`+s.des+`</td>`+
						`<td>`+s.price+`</td>`+						
						`<td>`+s.quantity+`</td>`+
						/* add hidden input form: sp_quantity */
						`<input type='hidden' name="sp_quantity" value=\${s.quantity}>`+
						`<input type='hidden' name="sp_type" value=\${s.type}>`+
					`</tr>` );
			}
		})		
		
		/* end add service part */
		
		// event print bill 
		$("#printBill").click( () => {
			$("#closeBillDetail").click();
			alert("In hóa đơn thành công"); // hard code			
		}) 
    </script>
</body>

</html>