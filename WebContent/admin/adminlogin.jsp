<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자로그인</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js" ></script>
<script type="text/javascript">
window.onload = function(){
	document.getElementById("btnAdminlogin").onclick = funcAdminlogin;
	document.getElementById("btnHome").onclick = funcHome;
}

function funcAdminlogin(){
	if(adminlogin.adminid.value == ""){
		alert("id 입력")
		adminlogin.adminid.focus();
		return;
	}
	if(adminlogin.adminpasswd.value == ""){
		alert("pwd 입력")
		adminlogin.adminpasswd.focus();
		return;
	}
	adminlogin.submit();
}

function funcHome(){
	location.href = "../guest/guest_index.jsp";
}
</script>
</head>
<body>
<form action="adminloginproc.jsp" name="adminlogin" method="post">
<table style="">
	<tr>
		<td colspan="2" style="text-align: center;">
			관리자 로그인
		</td>
	</tr>
	<tr>
		<td>id : </td>
		<td><input type="text" name="adminid" /></td>
	</tr>
	<tr>
		<td>passwd : </td>
		<td><input type="text" name="adminpasswd" /></td>
	</tr>
	<tr>
		<td colspan="2" style="text-align: center;">
			<input type="button" value="관리자로그인" id="btnAdminlogin">
			<input type="button" value="메인" id="btnHome">
		</td>
	</tr>
</table>
</form>
</body>
</html>