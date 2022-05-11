<%@page import="java.io.*,java.util.*,wisoft.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("loginOK") == "OK") {

		CaseData cst = new CaseData();
		ReserveData rst = new ReserveData();
		try {
			String sysid = request.getParameter("id");
			rst.getLibrarian(sysid);
			cst.DelLibrarian(sysid, rst.showData("tempid", 0));
			//String area = session.getAttribute("id").toString();  
			out.print("OK");
			cst.closeall();
		} catch (Exception e) {
			//out.print(e);
			out.print("NO");
		} finally {
			cst.closeall();
		}
	}
%>
