<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String memid = (String)session.getAttribute("idKey");
String log = "";
if(memid == null){
	log = "<a href='login.jsp'>로그인</a>";
}else{
	log = "<a href='logout.jsp'>로그아웃</a>";
}
String mem = "";
if(memid == null){
	mem = "<a href='../member/register.jsp'>회원가입</a>";
}else{
	mem = "<a href='../member/memberUpdate.jsp'>회원수정</a>";
}
%>
<table style="width: 80%">
	<tr style="background-color: orange; text-align: center; font-weight: bold;">
		<td><%=log %></td>
		<td><%=mem %></td>
		<td><a href="productlist.jsp">상품목록</td>
		<td><a href="cartlist.jsp">장바구니</td>
		<td><a href="orderlist.jsp">구매목록</td>
		<td><a href="../board/boardlist.jsp">게시판</td>
	</tr>
</table>





