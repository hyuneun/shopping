<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="memberMgr" class="shop.member.MemberMgr" />
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
boolean b = memberMgr.checkId(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>
</head>
<body>
<%=id %>

<%
if(b){
%>
는 이미 사용중<p/>
	<a href="#" onclick="opener.document.regForm.id.focus(); window.close()">닫기</a>
<%}else{%>
	는 사용가능<p/>
	 <a href="#" onclick="opener.document.regForm.passwd.focus(); window.close()">닫기</a>
<%	
}
%>
</body>
</html>