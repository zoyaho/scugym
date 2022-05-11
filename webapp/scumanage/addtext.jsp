<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {
		CaseData cst = new CaseData();
try
{
		String sysid = request.getParameter("sysid");
		String html = request.getParameter("html");
		String subject = request.getParameter("subject");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");

		String rt = cst.SaveNews(sysid, subject, html, startdate, enddate);

		out.print(rt);
}catch(Exception e){}finally{
		cst.closeall();
}
	}
%>
