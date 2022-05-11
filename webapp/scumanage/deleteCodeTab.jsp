<%@page import="java.io.*,java.util.*,wisoft.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("loginOK") == "OK") {

		CaseData cst = new CaseData();
		try {
			String seq = request.getParameter("id");
			String ck = cst.DelCodeTab(seq);

			out.print(ck);
			cst.closeall();
		} catch (Exception e) {
			//out.print(e);
			out.print("NO");
		} finally {
			cst.closeall();
		}
	}
%>
