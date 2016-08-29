<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<%
String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

if(id.equals("admin") && pwd.equals("111")){
	session.setAttribute("adminOk", id);
	out.println("로기인 성공");
}else{
	out.println("응 아니야");
}
%>
<br><br>
[<a href="javascript:window.close()">창닫기</a>]
</body>
</html>