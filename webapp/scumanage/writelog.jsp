<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<jsp:useBean id="cst" scope="request" class="wisoft.CaseData" />
<%
	if (session.getAttribute("loginOK") == "OK") {
		try {
			String user = session.getAttribute("user").toString();
			String fid = request.getParameter("fid");
			String status = request.getParameter("status");

			cst.SaveLog(fid, user, status);
			out.print("OK");
			cst.closeall();
		} catch (Exception e) {
			out.print("NO");
		} finally {
			cst.closeall();
		}
	}
%>
