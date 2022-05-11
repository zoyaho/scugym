<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {
		CaseData cst = new CaseData();
		try {
			String ck = request.getParameter("ck");
			String ip = request.getParameter("ip");
			String ipdesc = request.getParameter("ipdesc");
			String start = request.getParameter("start");
			String end = request.getParameter("end");

			String ck1 = cst.SaveIP(ck, ip, ipdesc, start, end);
			out.print(ck1);
			cst.closeall();
		} catch (Exception e) {
			out.print("NO");
		} finally {
			cst.closeall();
		}
	}
%>
