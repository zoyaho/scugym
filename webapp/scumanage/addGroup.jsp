<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
if(session.getAttribute("loginOK")=="OK")
{
	CaseData cst = new CaseData();
	try {
		String ck = request.getParameter("ck");
		String gid = request.getParameter("gid");
		String gname = request.getParameter("gname");
		String gdesc = request.getParameter("gdesc");

		String ck1 = cst.SaveGroup(ck, gid, gname, gdesc);
		out.print(ck1);
		cst.closeall();
	} catch (Exception e) {
		out.print("NO");
	} finally {
		cst.closeall();
	}
}
%>
