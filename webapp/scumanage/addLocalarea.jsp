<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {
		CaseData cst = new CaseData();
		try {
			String ck = request.getParameter("ck");
			String location = request.getParameter("location");
			String area = request.getParameter("area");

			String fid = session.getAttribute("fid").toString();
			String fcid = session.getAttribute("fcid").toString();

			String rt = cst.SaveLocarea(ck, location, area);
			out.print(rt + ":" + fid + ":" + fcid);
			cst.closeall();
		} catch (Exception e) {
			out.print("NO");
		} finally {
			cst.closeall();
		}
	}
%>
