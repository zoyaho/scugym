<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
if(session.getAttribute("loginOK")=="OK")
{
	CaseData cst = new CaseData();
	try {
		String gid = request.getParameter("gid");
		String fcid = request.getParameter("fcid");
		String fid = request.getParameter("fid");

		String ck = cst.SaveGroupFunc(gid, fcid, fid);
		out.print(ck);
		cst.closeall();
	} catch (Exception e) {
		out.print("NO");
	} finally {
		cst.closeall();
	}
}
%>
