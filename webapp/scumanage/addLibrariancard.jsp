<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {
		CaseData cst = new CaseData();
		try {
			String id = request.getParameter("id");
			String rt = cst.saveLibrarian("0", id, "");

			cst.closeall();

		} catch (Exception e) {

		} finally {
			cst.closeall();
		}
	}
%>
