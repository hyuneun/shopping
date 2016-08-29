<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="bean" class="shop.member.MemberBean" />
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="memberMgr" class="shop.member.MemberMgr" />
<%
String id = request.getParameter("id");
boolean b = memberMgr.saveMember(bean, id);

if(b){
	out.println("<b>회원정보가 변경되었습니다(관리자)</b><br>");
	out.println("<a href='membermanager.jsp'>로그인</a>");
}else{
	out.println("<b>변경실패(관리자)</b><br>");
	out.println("<a href='membermanager.jsp>다시해</a>");
}
%>