<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {
		CaseData cst = new CaseData();
		try {
			String ck = request.getParameter("ck");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			String start = request.getParameter("start");
			String end = request.getParameter("end");
			String rt = cst.SaveNews(ck, title, content, start, end);
			out.print(rt);
			cst.closeall();
		} catch (Exception e) {
			out.print("NO");
		} finally {
			cst.closeall();
		}
	}
%>
