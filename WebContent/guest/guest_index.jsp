<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
<table style="width: 80%">
	<tr>
		<td style="font-size: 30px">전문쇼핑몰</td>
	</tr>
</table>
<%@ include file="guest_top.jsp" %>
<table style="width: 80%">
<% if(memid != null){ %>
<tr	style="text-align: center;">
	<td style="font-size: 20px;">
		<%=memid %>님 방문을환영합니다
		<img title="꺼져" src="../image/pic2.gif;">
	</td>
</tr>
<%}else{%>
	<tr	style="text-align: center;">
		<td style="background-image: url(../image/pic.jpg); background-size:100%; color: red;font-weight: bold;">
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			고객님어서오세요
			<br>로그인하세요
		</td>
	</tr>
<%} %>
</table>
<%@ include file="guest_bottom.jsp" %>
</body>
</html>