<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.removeAttribute("idKey");
%>
<script>
alert("로그아웃성공");
location.href = "guest_index.jsp";
</script>