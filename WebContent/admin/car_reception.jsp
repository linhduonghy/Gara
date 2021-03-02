<%@page import="model.Staff"%>
<%@page import="java.util.List"%>
<%@page import="dao.StaffDAO"%>
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
#addCustomer form label {
	margin-bottom: 0;
}

#addCustomer form input {
	margin-bottom: 0.5rem;
}

.service-part-item {
	display: none;
}
</style>
<title>Nhận xe</title>
</head>

<body>

	<!-- Header -->
	<jsp:include page="header.jsp" />

	<!-- Content -->
	<div class="content">
		<!-- Add Customer Modal -->
		<!-- Modal -->
		<div id="addCustomer" class="modal fade" role="dialog">
			<div class="modal-dialog" style="max-width: 600px;">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title font-weight-bold">Thêm mới khách hàng</h4>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<form action="/GaraMan/customer/insert" method="post">
							<div class="form-group mb-0">
								<label for="name">Họ Tên</label> <input type="text"
									class="form-control" name="name" required>
							</div>
							<div class="form-group mb-0">
								<label for="email">Email</label> <input type="email"
									class="form-control" name="email" required>
							</div>
							<div class="form-group mb-0">
								<label for="address">Địa chỉ</label> <input type="text"
									class="form-control" name="address" required>
							</div>
							<div class="form-group mb-0">
								<label for="phone">Số điện thoại</label> <input type="text"
									class="form-control" name="phone" required>
							</div>
							<div class="form-group mb-0">
								<label for="dob">Ngày sinh</label> <input type="date"
									class="form-control" name="dob" required>
							</div>
							<div class="form-group mb-0">
								<label for="cardNumber">Số CMND</label> <input type="text"
									class="form-control" name="cardNumber" required>
							</div>
							<button type="submit" class="btn btn-primary">Xác nhận</button>
						</form>
					</div>
				</div>

			</div>
		</div>

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
			<div class="customer-search">
				<input type="text" id="customer_input" class="form-control"
					placeholder="tìm kiếm khách hàng"> <a
					class="btn btn-primary text-white" style="margin-top: -5px;"
					data-toggle="modal" data-target="#addCustomer" id="addCustomerBtn">Thêm
					khách hàng</a>
				<div id="customer_search_list" style="display: none">
					<table id="table_customer" class="table table-hover">
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
			<form id="car_reception_form"
				action="<c:url value="/carReception/insert" />" method="post">
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

									<div id="customerInfo">


										<input type="hidden" name="customer_id" id="customer_id"
											value='${c_added.id}'>
										<div class="form-group">
											<h4 class="form-text">
												<span id="c_name" class="mr-2">${c_added.name} </span><i
													class="fa fa-check"></i>
											</h4>
										</div>
										<div class="form-group">
											<cite title="San Francisco, USA" id="c_address">
												${c_added.address} </cite> <i class="fa fa-map-marker ml-1"> </i>
										</div>
										<div class="form-group">
											<i class="fa fa-envelope"></i> <span class="cus-info"
												id="c_email">${c_added.email}</span>
										</div>
										<div class="form-group">
											<i class="fa fa-phone"></i> <span class="cus-info"
												style="margin-left: 7px;" id="c_phone">${c_added.phone}</span>
										</div>
										<div class="form-group">
											<i class="fa fa-credit-card"></i> <span class="cus-info"
												id="c_card_number">${c_added.cardNumber}</span>
										</div>
										<div class="form-group" style="margin-bottom: 0;">
											<i class="fa fa-calendar"></i> <span class="cus-info"
												id="c_dob">${c_added.dob}</span>
										</div>
										<%
											session.removeAttribute("c_added");
										%>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-1"></div>
						<!-- car info -->
						<div class="col-sm-6">
							<div class="card " style="margin-left: -20px">
								<div class="card-header text-center"
									style="background-color: #33b5e5; color: #fff;">
									<h4 class="card-title">Thông tin xe</h4>
								</div>
								<div class="card-body" style="padding-bottom: 1rem;">

									<div class="form-group">
										<label for="infoCar">Thông tin chung</label> <input
											type="text" class="form-control" name="modelCar"
											id="modelCar" required> <small
											class="form-text text-muted">Thông tin về hãng xe,
											mẫu xe, số km đã đi</small>
									</div>
									<div class="form-group">
										<label for="statusCar">Tình trạng</label> <input type="text"
											class="form-control" name="statusCar" id="statusCar" required>
										<small class="form-text text-muted">Thông tin về tình
											trạng xe</small>
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="service-part">
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
									style="width: 60px; height: 30px;" type="text" id="spQuantity"
									value="1" /> <a id="confirmSP"
									class="btn btn-primary text-white" style="margin-left: 160px;">
									Xác nhận</a>
							</div>
							<label id="spType" style="display: none;"></label>
						</div>

					</div>

				</div>

				<div class="list-service-part pt-3">
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">Danh sách các dịch vụ phụ tùng</h4>
						</div>
						<div class="card-body table-responsive">
							<table id="sp_list" class="table table-hover">
								<thead>
									<tr>
										<th>ID</th>
										<th>Tên</th>
										<th>Mô tả</th>
										<th>Giá</th>
										<th>Số lượng</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>#</td>
										<td>#</td>
										<td>#</td>
										<td>#</td>
										<td>#</td>
									</tr>
									<tr>
										<td>#</td>
										<td>#</td>
										<td>#</td>
										<td>#</td>
										<td>#</td>
									</tr>
									<tr>
										<td>#</td>
										<td>#</td>
										<td>#</td>
										<td>#</td>
										<td>#</td>
									</tr>
									<tr>
										<td>#</td>
										<td>#</td>
										<td>#</td>
										<td>#</td>
										<td>#</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>

				</div>

				<!-- Technical Staff -->
				<%
					StaffDAO staffDAO = new StaffDAO();
				List<Staff> tech_staffs = staffDAO.getAllTechnicalStaff();
				%>
				<div class="technical-staff mt-3">
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">Chọn nhân viên kỹ thuật</h4>
						</div>
						<div class="card-body table-responsive">
							<table class="table table-hover">
								<thead class="">
									<tr>
										<th>ID</th>
										<th>Họ Tên</th>
										<th>Bậc chuyên môn</th>
										<th>#</th>
									</tr>
								</thead>
								<tbody>
									<%
										for (Staff staff : tech_staffs) {
									%>
									<tr>
										<td><%=staff.getId()%></td>
										<td><%=staff.getName()%></td>
										<td><%=staff.getLevel()%></td>
										<td>
											<div class="radio">
												<label><input type="radio" value=<%=staff.getId()%>
													name="technical_staff_id"></label>

											</div>
										</td>
									</tr>
									<%
										}
									%>

								</tbody>
							</table>
						</div>
					</div>
				</div>
				<input type="submit" class="btn btn-primary float-right m-3"
					value="Xác nhận">
			</form>
		</div>
	</div>
	<!-- End Content -->



	<!-- Optional JavaScript -->

	<script>	
		
		// handle before submit form car_reception
		$('#car_reception_form').submit( function() {			
			if ($("#loginStatus").text() == 0) {
				alert("Bạn chưa đăng nhập. Vui lòng đăng nhập để tiếp tục!");
				$("#loginBtn").click();
				return false;
			}
			if ($('#customer_id').val() == '') {
				alert("Nhập thông tin khách hàng");
				return false;
			} 			
			if ($('input[name="sp"]').length == 0) {
				alert("Chưa chọn dịch vụ, phụ tùng sử dụng");
				return false;
			}
			if ($('input[name=technical_staff_id]:checked').length == 0) {
			    alert("Chưa chọn nhân viên kỹ thuật");
			    return false;
			}	
			return true;			
		})
		
		// event add Customer
		$("#addCustomerBtn").click( function() {
			console.log("add cus");
			if ($("#loginStatus").text() == 0) {
				alert("Bạn chưa đăng nhập. Vui lòng đăng nhập để tiếp tục!");
				$("#loginBtn").click();
				return false;
			}
			return true;
		})
		
		// search customer
		var customer_search_listHeight = $('#customer_search_list').height();
		$("#customer_input").keyup( () =>  {			
			var customerName = $("#customer_input").val().toUpperCase();			
			var customer_search_list = $("#customer_search_list");			
			if (customerName === "") {
				$('#customer_search_list').hide();
				return;
			}
			$('#customer_search_list').height(customer_search_listHeight);
			// remove table
			$('#table_customer tbody tr').remove();
			// remove alert "không tìm thấy KH"
			$('#customer_search_list .alert').remove();
			
			$('#customer_search_list').show();
			// get customer by name
			$.ajax({				
				url: `http://localhost:8080/GaraMan/customer/get?name=\${customerName}`,
				type: 'get',
				dataType: 'json',
				success: (data) => {	
					// list customer is empty
					if (data.length === 0) {
						$('#customer_search_list').height("100px");
						$("#customer_search_list").append(`<div class="alert alert-warning" role="alert">Không tìm thấy thông tin khách khách hàng</div>`);						
					}
					else {
						data.forEach((customer) => {
							//console.log(customer);
							$("#table_customer tbody").append(`<tr id="customer_\${customer.id}" style="cursor: pointer;"><td>\${customer.name}</td><td>\${customer.address}</td><td>\${customer.phone}</td></tr>`);
							$("#customer_" + customer.id).click(() => {
								$("#customer_input").val('');
								$('#customer_search_list').hide();
								displayCustomerInfo(customer);								
							});
						});
					}

				},
				error: (e) => {
					console.log(e);
				}
			});
		});
		// display customer information
		var displayCustomerInfo = (customer) => {			
			$("#customerInfo").show();
			$("#customer_id").val(customer.id);
			$("#c_name").html(customer.name);
			$("#c_address").html(customer.address);
			$("#c_email").html(customer.email);
			$("#c_card_number").html(customer.cardNumber);			
			$("#c_dob").html(customer.dob);
			$("#c_phone").html(customer.phone);
		};
		
		
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
						displaySP(service, "service");
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
						displaySP(part, "part");
					})			
				})
			})
			
		})
					
		// display service part information
		var displaySP = (sp, t) => {
			$('.service-part-item').show();
			$('#spType').html(t);
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
		// event confirm add service part to list
		$("#sp_list tbody tr").remove();
		$("#confirmSP").click( () => {		
			if ($('#spName').text() == '') {
				alert("Chưa chọn dịch vụ, phụ tùng!");
				return;	
			}
			var quantityInStock = parseInt($('#spQuantityInStock').html());
			var quantityUse = parseInt($('#spQuantity').val());
			if (isNaN(quantityUse)) {
				alert("Nhập số lượng là số!");
				return;
			}
			console.log(quantityInStock);
			console.log(quantityUse);
			if (quantityUse > quantityInStock && !isNaN(quantityInStock)) {
				alert("Số lượng phụ tùng này trong kho không còn đủ");
				return;
			}
			var sp = {id: $('#spId').text(), name:$('#spName').text(), des: $('#spDescription').text(),
						price: $('#spPrice').text(), quantity: $('#spQuantity').val(), type: $("#spType").text()};					
			var isNew = true;
			var isModify = false;
			var change = false;
			for (var s of listSP) {
				if (s.id == sp.id && s.name == sp.name) {
					if (s.quantity != sp.quantity) {
						change = true;
						isNew = false;
						isModify = true;
						s.quantity = sp.quantity;
					} else {
						// not change
						change = false;
						isNew = false;
						isModify = false;
					}										
				} 
				/* else {
					change = true;
					isNew = true;
					isModify = false;
				} */
			}
			if (isNew)
				listSP.push(sp);	
			console.log(listSP);
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
		

	</script>
</body>
</html>