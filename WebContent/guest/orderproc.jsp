<%@page import="shop.product.OrderBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cartMgr" class="shop.order.CartMgr" scope="session"/>
<jsp:useBean id="ordermgr" class="shop.order.OrderMgr"/>
<jsp:useBean id="productmgr" class="shop.product.ProductMgr"/>

<%
Hashtable hCart = cartMgr.getCartList();


Enumeration enu = hCart.keys();
if(hCart.size() == 0){
%>
		<script>
		alert("주문내역이없습니다");
		location.href="productlist.jsp";
		</script>
<%}else{
	while(enu.hasMoreElements()){
		OrderBean order = (OrderBean)hCart.get(enu.nextElement());
		ordermgr.insertOrder(order);//주문디비에 저장
		productmgr.reduceProduct(order);//주문수만큼 상품재고량 뺴기
		cartMgr.deleteCart(order);
	}
	%>
	<script>
		alert("주문처리완료 \n호갱님 감사합니다");
		location.href="orderlist.jsp";
		</script>
	<%
}
%>