<%@page import="shop.product.ProductBean"%>
<%@page import="shop.product.OrderBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="orderMgr" class="shop.order.OrderMgr"/>
    <jsp:useBean id="productMgr" class="shop.product.ProductMgr"/>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문관리</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
*** 주문된 상품 처리***<p/>
<%@include file="admin_top.jsp" %>
<table style="width: 80%; text-align: center;">
	<tr style="background-color: orange">
		<th>주문번호</th><th>주문자</th><th>상품명</th><th>주문수</th><th>주문일</th>
		<th>주문상태</th><th>보기</th>
	</tr>
	<%
	ArrayList<OrderBean> list = orderMgr.getOrderAll();
	if(list.size() == 0){
	%>
	<tr><td colspan="7">주문내역잉없다<td></tr>
	<%
	}else{
		for(int i=0;i < list.size(); i++){
			OrderBean order = (OrderBean)list.get(i);
			ProductBean product = productMgr.getProduct(order.getProduct_no());
			%>
		<tr style="text-align: center;">
			<td><%=order.getNo() %></td>
			<td><%=order.getId() %></td>
			<td><%=product.getName() %></td>
			<td><%=order.getQuantify() %></td>
			<td><%=order.getSdate() %></td>
			<td>
			<%
			switch(order.getState()){
			case "1":out.println("접수"); break;
			case "2":out.println("입금확인"); break;
			case "3":out.println("배송준비"); break;
			case "4":out.println("배송중"); break;
			case "5":out.println("처리완료"); break;
			default:out.println("접수중"); break;
			}
			%>
			</td>
			<td><a href="javascript:orderDetail('<%=order.getNo() %>')">상세보기</td>
		</tr>
			<%
		}
	}
	%>
</table>
<%@include file="admin_bottom.jsp" %>
<form action="orderdetail.jsp" name="detailFrm" method="post">
	<input type="hidden" name="no">
</form>
</body>
</html>