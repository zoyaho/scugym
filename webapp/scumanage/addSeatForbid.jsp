<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {

		CaseData cst = new CaseData();
		try {
			String ck = request.getParameter("ck");
			String usertype = request.getParameter("usertype");
			String start = request.getParameter("start");
			String end = request.getParameter("end");
			String fid = session.getAttribute("fid").toString();
			String fcid = session.getAttribute("fcid").toString();

			String rt = cst.SaveSeatForbid(ck, usertype, start, end);
			out.print(rt + ":" + fid + ":" + fcid);
			cst.closeall();
		} catch (Exception e) {
			out.print("NO");
		} finally {
			cst.closeall();
		}
	}
%>
