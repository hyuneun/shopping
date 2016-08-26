<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자로그인</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>
<script type="text/javascript">
window.onload = function(){
	document.getElementById("btnLogin").addEventListener("click", funcLogin, false);
	document.getElementById("btnNewMember").addEventListener("click", funcNew, false);
	document.getElementById("btnHome").addEventListener("click", funcHome, false);
	
}

function funcLogin(){
	if(loginfrm.id.value === ""){
		alert("id입력좀");
		loginfrm.id.focus();
	}else if(loginfrm.passwd.value === ""){
		alert("pwd입력좀");
		loginfrm.passwd.focus();
	}else{
		loginfrm.action = "loginproc.jsp";
		loginfrm.method = "post";
		loginfrm.submit();
	}
}

function funcNew(){
	location.href = "../member/register.jsp";
}

function funcHome(){
	location.href = "guest_index.jsp";
}
</script>
</head>
<body style="margin: 20px">
<%
String id = (String)session.getAttribute("idKey");
if(id != null){
%>
	<b><%=id%>님 환영합니다</b><br>
	<a href="logout.jsp">로그아웃</a>
<%}else{%>
<form name="loginfrm">
<table>
	<tr>
		<td colspan="2">** 로그인 **</td>
	</tr>
	<tr>
		<td>아이디 : </td>
		<td><input type="text" name="id" /> </td>
	</tr>
	<tr>
		<td>비번 : </td>
		<td><input type="text" name="passwd" /> </td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" value="로그인" id="btnLogin">
			<input type="button" value="회원가입" id="btnNewMember">
			<input type="button" value="홈페이지" id="btnHome">
		</td>
	</tr>
</table>
</form>


<%}%>
</body>
</html>