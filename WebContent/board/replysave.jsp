<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="bean" class="shop.board.BoradBean"/>
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="boardMgr" class="shop.board.BoardMgr" />
<%
String spage = request.getParameter("page");
int num = bean.getNum();
int gnum = bean.getGnum();
int onum = bean.getOnum() + 1;
int nested = bean.getNested() + 1;//들여쓰기

//같은 그룹 내에서 새로운 댓글의 onum보다 크거나 같은 값을 댓글 입력전에
//먼저 수정하기. 작으면 수정하지 않음

boardMgr.updateOnum(gnum,onum);//onum 갱신처리
//댓글저장작업
bean.setOnum(onum);
bean.setNested(nested);
bean.setBip(request.getRemoteAddr());
bean.setBdate();
bean.setNum(boardMgr.currentGetNum() + 1);//새글번호

boardMgr.saveReply(bean);
response.sendRedirect("boardlist.jsp?page=" + spage);

%>








