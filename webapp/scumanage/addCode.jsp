<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
if(session.getAttribute("loginOK")=="OK")
{
	CaseData cst = new CaseData();
	try {
		String ck = request.getParameter("ck");
		String cname = request.getParameter("code_name");
		String ccomment = request.getParameter("code_comment");

		String ck1 = cst.SaveCode(ck, cname, ccomment);
		out.print(ck1);
		cst.closeall();
	} catch (Exception e) {
		out.print("NO");
	} finally {
		cst.closeall();
	}
}
%>
