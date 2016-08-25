<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="bean" class="shop.board.BoradBean" />
<jsp:setProperty property="*" name="bean" />
<jsp:useBean id="boardMgr" class="shop.board.BoardMgr" />

<%
String spage = request.getParameter("page");

boolean b = boardMgr.checkPass(bean.getNum(),bean.getPass());

	if(b){
	boardMgr.saveEdit(bean);
	response.sendRedirect("boardlist.jsp?page=" + spage);
		
	}else{
%>
	<script>
		alert("동작그만 밑장빼기냐?");
		history.back();
	</script>
	<%
	}

%>
