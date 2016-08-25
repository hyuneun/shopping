<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/board.css">
<script type="text/javascript">
function check(){
	if(frm.id.value == "" || frm.pwd.value == ""){
		alert("자료를 넣으라고");
		return;
	}
	frm.submit();
}
</script>
</head>
<body>
<form action="adminlogin.jsp
" name="frm" method="post">
<table style="100%">
	<tr>
		<td>
		<%
		String sessionVal = (String)session.getAttribute("adminOk");
		if(sessionVal != null){
		%>
			이미로그인함<br><br>
			[<a href="adminlogout.jsp">로그아웃</a>]
			[<a href="javascript:window.close()">창닫기</a>]
		<%}else{%>
			<table style="width: 100%">
				<tr>
					<td>id : <input type="text" name="id" size="10"></td>
				</tr>
				<tr>
					<td>비번 : <input type="text" name="pwd" size="10"></td>
				</tr>
				<tr>
					<td>
						[<a href="#" onclick="check()">로그인</a>]
						[<a href="javascript:window.close()">창닫기</a>]
					</td>
				</tr>
			</table>
		<%}%>
		</td>
	</tr>
</table>
</form>
</body>
</html>