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
<title>Trang chủ</title>
</head>

<body>

	<!-- Header -->
	<jsp:include page="header.jsp" />

	<!-- Optional JavaScript -->

	<script src="<c:url value="/static/js/login.js"/>"></script>
</body>
</html>