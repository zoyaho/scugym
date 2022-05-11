<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
if(session.getAttribute("loginOK")=="OK")
{
	CaseData cst = new CaseData();
	try {
		String ck = request.getParameter("ck");
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String usertype = request.getParameter("usertype");
		String start = request.getParameter("start");
		String end = request.getParameter("end");
		String reason = request.getParameter("reason");
		String note = request.getParameter("note");

		String fid = session.getAttribute("fid").toString();
		String fcid = session.getAttribute("fcid").toString();

		String rt = cst.SaveForbid(ck, id, name, usertype, start, end, reason, note);
		out.print(rt + ":" + fid + ":" + fcid);
		cst.closeall();
	} catch (Exception e) {
		out.print("NO");
	} finally {
		cst.closeall();
	}
}
%>
