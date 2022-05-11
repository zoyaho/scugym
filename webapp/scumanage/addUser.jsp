<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {
		CaseData cst = new CaseData();
		Utility util = new Utility();
		try {
			String ck = request.getParameter("ck");
			String userid = request.getParameter("userid");
			String passwd = request.getParameter("passwd");
			String username = request.getParameter("username");
			String userright = request.getParameter("userright");
			String set_date = request.getParameter("set_date");
			String upd_date = request.getParameter("upd_date");
			String start_time = request.getParameter("start_time");
			String end_time = request.getParameter("end_time");
			String status = request.getParameter("status");
			String group = request.getParameter("group");

			String ck1 = cst.SaveUser(ck, userid, util.bin2hex(passwd), username, userright, set_date, upd_date,
					start_time, end_time, status, group);
			out.print(ck1);
			cst.closeall();
			util.closeall();
		} catch (Exception e) {
			//out.print(e);
			out.print("NO");
		} finally {
			cst.closeall();
			util.closeall();
		}
	}
%>
