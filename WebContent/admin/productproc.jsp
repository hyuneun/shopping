<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productmgr" class="shop.product.ProductMgr"/>
<%
String flag = request.getParameter("flag");
boolean result = false;

if(flag.equals("insert")){
	result = productmgr.insertProduct(request);
}else if(flag.equals("update")){
	//result = productmgr.updateProduct(request);
}else if(flag.equals("delete")){
	response.sendRedirect("productmanager.jsp");
}

if(result){
%>
	<script>
	alert("정상입니다");
	location.href = "productmanager.jsp";
	</script>
<%}else{%>
	<script>
	alert("실패입니다");
	location.href = "productmanager.jsp";
	</script>
<%	
}
%>




