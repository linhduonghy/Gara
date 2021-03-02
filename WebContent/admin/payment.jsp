<%@page import="java.text.SimpleDateFormat"%>
<%@page import="model.Customer"%>
<%@page import="java.sql.Date"%>
<%@page import="model.CarReception"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
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
<title>Thanh toán</title>
</head>

<body>
	<%-- <%
		List<CarReception> carReceptions = null;
	boolean[] paids = null;
	Customer customer = null;
	if (session.getAttribute("crs") != null) {
		carReceptions = (List<CarReception>) session.getAttribute("crs");
		customer = carReceptions.get(0).getCustomer();
	}
	if (session.getAttribute("paids") != null) {
		paids = (boolean[]) session.getAttribute("paids");
	} 
	%> --%>
	<!-- Header -->
	<jsp:include page="header.jsp"></jsp:include>
	<!-- End Header -->

	<!-- Content -->
	<div class="content">
		<div class="container">

			<div class="customer-search">
				<input type="text" id="customer_input" class="form-control"
					placeholder="tìm kiếm khách hàng">
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

									<div class="form-group">
										<h4 class="form-text" id="c_name">
											<%-- <%
												if (customer != null)
												out.print(customer.getName());
											%> --%>
											<i class="fa fa-check"></i>
										</h4>
									</div>
									<div class="form-group">
										<cite title="San Francisco, USA" id="c_address"> <%-- <%
 	if (customer != null)
 	out.print(customer.getAddress());
 %> --%></cite> <i class="fa fa-map-marker ml-1"> </i>
									</div>
									<div class="form-group">
										<i class="fa fa-envelope"></i> <label class="cus-info"
											id="c_email"> <%-- <%
 	if (customer != null)
 	out.print(customer.getEmail());
 %> --%></label>
									</div>
									<div class="form-group">
										<i class="fa fa-phone"></i> <span class="cus-info"
											style="margin-left: 7px;" id="c_phone"> <%-- <%
 	if (customer != null)
 	out.print(customer.getPhone());
 %> --%></span>
									</div>
									<div class="form-group">
										<i class="fa fa-credit-card"></i> <span class="cus-info"
											id="c_card_number"> <%-- <%
 	if (customer != null)
 	out.print(customer.getCardNumber());
 %> --%></span>
									</div>
									<div class="form-group" style="margin-bottom: 0;">
										<i class="fa fa-calendar"></i> <span class="cus-info"
											id="c_dob"> <%-- <%
										 	if (customer != null)
										 	out.print(customer.getDob());
										 %> --%></span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="list-service-part pt-3">
				<div class="card">
					<div class="card-header">
						<h4 class="card-title mb-0">Danh sách các lần nhận xe khách
							hàng</h4>
					</div>
				</div>
				<div id="listSP" class="card-body table-responsive">
					<table id="tableSP" class="table table-hover pt-5">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">Ngày nhận xe</th>
								<th scope="col">Nhân viên nhận xe</th>
								<th scope="col">Tình trạng</th>
								<th scope="col"></th>
							</tr>
						</thead>
						<tbody>

							<%-- <%
								if (carReceptions != null) {
								for (int i = 0; i < carReceptions.size(); ++i) {
									CarReception carReception = carReceptions.get(i);
									boolean paid = paids[i];
									Date createdDate = carReception.getCreatedDate();
									SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
									
									String p_ttr = (paid == true) ? "Đã thanh toán" : "Chưa thanh toán";
									// payment button forward payment_bill.jsp
									String p_btn = String.format("<td><a href='payment_bill.jsp?id=%d' class='btn btn-success'>Thanh toán</a></td>", carReception.getId());
									if (paid == true) p_btn = "";
							%>
							<tr>
								<th scope="row"><%=carReception.getId()%></th>
								<td><%=sdf.format(createdDate)%></td>
								<td><%= carReception.getSaleStaff().getName() %></td>
								<td><%=p_ttr%></td>
								<%=p_btn%>
							</tr>
							<%
								}
							}
							%> --%>
						</tbody>
					</table>
				</div>

			</div>
		</div>
	</div>
	<!-- End Content -->

	<!-- Optional JavaScript -->
	<script>
		
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
								addCustomerInfo(customer);
								addListServicePart(customer);
							});
						});
					}
	
				},
				error: (e) => {
					console.log(e);
				}
			})
		})
		
		var addCustomerInfo = (customer) => {					
			$("#customerInfo").show();
			$("#customer_id").val(customer.id);
			$("#c_name").html(customer.name);
			$("#c_address").html(customer.address);
			$("#c_email").html(customer.email);
			$("#c_card_number").html(customer.cardNumber);			
			$("#c_dob").html(customer.dob);
			$("#c_phone").html(customer.phone);
		}
		var addListServicePart = (customer) => {
			console.log(customer);
			$("#listSP .alert").remove();
			$("#tableSP thead").hide();
			$("#tableSP tbody tr").remove();
			$.getJSON(`http://localhost:8080/GaraMan/carReception/get?customer_id=\${customer.id}`, (data) => {				
				var car_receptions = data[0];
				var paids = data[1];
				// no car reception from customer
				if (car_receptions.length == 0) {
					$("#listSP").append(`<div id=""class="alert alert-warning" role="alert">Không tìm thấy thông tin nhận xe của khách hàng</div>`);
					return;
				}
				
				$("#tableSP thead").show();
				for (var i = 0; i < car_receptions.length; ++i) {				
					var car_reception = car_receptions[i];						
					var createdDate = new Date(Date.parse(car_reception.createdDate));
					var p = paids[i] ? "Đã thanh toán" : "Chưa thanh toán";
					// payment button forward payment_bill.jsp
					var p_btn = paids[i] ? `<td><a href="payment_bill.jsp?id=\${car_reception.id}" class="btn btn-success">In hóa đơn</a></td>`
							: `<td><a href="payment_bill.jsp?id=\${car_reception.id}" class="btn btn-primary">Thanh toán</a></td>`; 
					console.log(car_reception);
					$("#tableSP tbody").append(
						`<tr>`+
							`<th scope="row">\${car_reception.id}</th>`+
							`<td>\${createdDate.toLocaleDateString("en-US")}</td>`+
							`<td>\${car_reception.saleStaff.name}</td>`+
							`<td>\${p}</td>`+
							p_btn + 
						`</tr>`			
					);
				}						
			})
		}
		
	</script>

</body>

</html>