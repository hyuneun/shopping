<%@page import="shop.product.ProductBean"%>
<%@page import="shop.product.OrderBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="orderMgr" class="shop.order.OrderMgr"/>
    <jsp:useBean id="productMgr" class="shop.product.ProductMgr"/>
<%
OrderBean order = orderMgr.getOrderDetail(request.getParameter("no"));
ProductBean product = productMgr.getProduct(order.getProduct_no());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문관리</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
** 주문 상세보기 **<p/>
<%@include file="admin_top.jsp" %>
<form action="orderproc_admin.jsp" name="detailFrm" method="post">
<table style="width: 80%">
	<tr>
	<td>고 객 아 이 디 : <%=order.getId() %></td>
	<td>주 문 번 호 : <%=order.getNo() %></td>
	<td>상 품 번 호 : <%=product.getNo() %></td>
	<td>상 품 명 : <%=product.getName() %></td>
	</tr>
	<tr>
		<td>상 품 가 격 : <%=product.getPrice() %></td>
		<td>주 문 수 량 : <%=order.getQuantify() %></td>
		<td>재 고 수 : <%=product.getStock() %></td>
		<td>주 문 일 : <%=product.getSdate() %></td>
	</tr>
	<tr>
		<td colspan="4">총결제금액 :
			<%=Integer.parseInt(order.getQuantify()) * Integer.parseInt(product.getPrice()) %> 원
	</tr>
	<tr>
		<td colspan="4" style="text-align: center;">
		주문상태 :
		<select name="state">
			<option value="1">접수</option>
			<option value="2">입금확인</option>
			<option value="3">배송준비</option>
			<option value="4">배송중</option>
			<option value="5">처리완료</option>
			<%-- <script>
			document.detailFrm.state.value = <%=order.getState()%>
			</script> --%>
		</select>
	</tr>
	<tr style="text-align: center;">
		<td colspan="4">
			<input type="button" value="수 정" onclick="orderUpdate(this.form)"> //
			<input type="button" value="삭 제" onclick="orderDelete(this.form)">
			<input type="hidden" name="no" value="<%=order.getNo()%>">
			<input type="hidden" name="flag">
		</td>
	</tr>
</table>
</form>
<%@include file="admin_bottom.jsp" %>
</body>
</html>