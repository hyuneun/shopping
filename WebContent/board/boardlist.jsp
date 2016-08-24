<%@page import="shop.board.BoardDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="boardMgr" class="shop.board.BoardMgr"/>
    <jsp:useBean id="dto" class="shop.board.BoardDto"/>
<%
int spage = 1;
int pageSu = 1;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/board.css">
<script type="text/javascript">
window.onload = function(){
	   document.getElementById("btnSearch").onclick = function(){
	      if(frm.sword.value == ""){
	         frm.sword.focus();
	         alert("검색어를 입력하시오.");
	         return;
	      }
	      frm.submit();
	   }
	}

</script>
</head>
<body>
<table>
	<tr>
		<td>
			[<a href="../index.jsp">메인으로</a>]&nbsp;
			[<a href="boardlist.jsp?page=1">최신목록</a>]&nbsp;
			[<a href="boardwrite.jsp">새글작성</a>]&nbsp;
			[<a href="#" onclick="window.open('admin.jsp','','width=300,height=150,top=200,left=300')">관리자용</a>]&nbsp;
			<br><br>
			<table style="width: 100%">
				<tr style="background-color: silver;">
					<th>번호</th><th>제목</th><th>작성자</th><th>작성일</th><th>번호</th>
				</tr>
			<%
			request.setCharacterEncoding("utf-8");
			try{//페이지를 눌렀을때 page=? 으로 페이지가 넘어온다
				spage = Integer.parseInt(request.getParameter("page"));//받는다
			}catch(Exception e){//페이지가  없을때 or 1일때 1을준다
				spage = 1;
			}
			if(spage <= 0) spage = 1;
			
			//검색이 있는경우
			String stype = request.getParameter("stype");
			String sword = request.getParameter("sword");
			
			boardMgr.totalList();//테이블자료 갯수구하기
			pageSu = boardMgr.getPageSu();	//몇페이지 찍어야되는지 얻기
													//값을넘김┐
			ArrayList<BoardDto> list = boardMgr.getDataAll(spage,stype,sword);
			for(int i=0; i < list.size(); i++){
				dto = (BoardDto)list.get(i);
				%>
				<tr>
					<td><%=dto.getNum() %></td>
					<td>
						<a href="boardcontent.jsp?num=<%=dto.getNum() %>&page=<%=spage %>"><%=dto.getTitle() %></a>
					</td>
					<td><%=dto.getName() %></td>
					<td><%=dto.getBdate() %></td>
					<td><%=dto.getReadcnt() %></td>
				</tr>
				
				<%
			}
			%>
			</table>
      <br/>
      <table style="width: 100%">
		<tr>
			<td style="text-align: center;">
				<%
				for(int i=1; i <= pageSu; i++){
					if(i == spage){//현재페이지면 링크x
					out.print("<b style='font-size:50pt;color:red;'" + "'>" + i + "</b>" + " ");
					}else{
					out.print("<a href='boardlist.jsp?page=" + i + "'>[" + i + "]</a>" + " ");
					}
				}
				%>
				<br><br>
				<form action="boradlist.jsp" name="frm" method="post">
					<select name="stype">
						<option value="title" selected="selected">글제목</option>
						<option value="name">작성자</option>
					</select>
					<input type="text" name="sword">
					<input type="button" value="검색" id="btnSearch">		
				</form>
			</td>
		</tr>
	</table>
</body>
</html>