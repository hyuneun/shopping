<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="bean" class="shop.member.MemberBean" />
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="memberMgr" class="shop.member.MemberMgr" />
<%
boolean b = memberMgr.saveMember(bean);

if(b){
	out.println("<b>회원정보가 변경되었습니다</b><br>");
	out.println("<a href='../guest/guest_index.jsp'>로그인</a>");
}else{
	out.println("<b>변경실패</b><br>");
	out.println("<a href='../guest/guest_index.jsp'>다시해</a>");
}
%>