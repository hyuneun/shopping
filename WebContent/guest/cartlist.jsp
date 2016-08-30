<%@page import="shop.product.ProductBean"%>
<%@page import="shop.product.OrderBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cartMgr" class="shop.order.CartMgr" scope="session"/>
<<jsp:useBean id="productMgr" class="shop.product.ProductMgr" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카트</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
** 장바구니 목록 **
<%@include file="guest_top.jsp" %>

<table style="width: 80%">
	<tr style="background-color: silver;">
		<th>주문상품</th><th>가격</th><th>수량</th><th>수정/삭제</th><th>보기</th>
	</tr>
<%
int totalprice = 0;
Hashtable hCart = cartMgr.getCartList();
if(hCart.size() == 0){
%>
	<tr><td>장바구니에 상품이 없습니다</td></tr>
<%
}else{
	//System.out.print("asd");
	Enumeration enu = hCart.keys();//키벨류형식의 값을 읽을때 사용하는 클래스
	while(enu.hasMoreElements()){
		//System.out.print("asd");
		OrderBean order = (OrderBean)hCart.get(enu.nextElement());
		ProductBean product = productMgr.getProduct(order.getProduct_no());
		//System.out.print("___" + product.getPrice() + "__");
		//System.out.print(order.getQuantify() + "____");
		int price = Integer.parseInt(product.getPrice());
		int quantity = Integer.parseInt(order.getQuantify());
		int subTotal = price * quantity;//소계
		totalprice += subTotal; //총계
		

%>
<form action="cartproc.jsp" method="post">
	<input type="hidden" name="flag" />
	<input type="hidden" name="product_no" value="<%=product.getNo() %>" />
	<tr style="text-align: center;">
		<td><%=product.getName() %></td>
		<td><%=subTotal %></td>
		<td>
			<input style="text-align: center;" type="text" name="quantify" size="5" value="<%=quantity%>">
		</td>
		<td>
			<input type="button" style="background-color: aqua;" value="수정" onclick="cartUpdate(this.form)" />
			<input type="button" style="background-color: aqua;" value="삭제" onclick="cartDelete(this.form)" />
		</td>															        <!--form에 name을 안주고 할수있슴-->
		<td>
			<a href="javascript:productDetail('<%=product.getNo()%>')">상세보기</a>
		</td>
	</tr>
</form>
<%
	}
%>
	<tr>
		<td colspan="5">
		<br>
		<b>총결재금액 : <%=totalprice%>원 &nbsp;&nbsp;&nbsp;&nbsp;</b>
		<a href="orderproc.jsp">[주문]</a>
	</tr>
<%
}
%>
</table>

<%@include file="guest_bottom.jsp" %>

<form action="productdetail_g.jsp" name="detailFrm">
	<input type="hidden" name="no">
</form>
</body>
</html>

