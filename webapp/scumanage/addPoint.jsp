<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.util.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {
		CaseData cst = new CaseData();
		ReserveData rst = new ReserveData();
		//email to the reader 

		SimpleSender smtp = new SimpleSender();
		String subj = "";
		String bodycont = "";
		String towho = "";
		String from = "";
		String booking_datetime = "";
		String result = "";
		String emailtype = "";
		try {

			String readerid = request.getParameter("rid");
			String readername = request.getParameter("rname");
			String loc = request.getParameter("loc");
			String room = request.getParameter("room");
			String reason = request.getParameter("reason");
			String pointtype = request.getParameter("ptype");
			String admin = request.getParameter("admin");
			String createdate = request.getParameter("cdate");
			String unit = request.getParameter("unit");
			String email = request.getParameter("email");
			String area = request.getParameter("area");
			String bookingsysid = request.getParameter("bookingsysid");
			cst.SavePoint(readerid, readername, loc, room, createdate, pointtype, reason, admin, unit, email,
					area, bookingsysid);
			//判斷是否符合停權條件,如果符合自動新增一筆停權並跳至停權功能
			String flag = rst.checkPoint(readerid, loc, pointtype, admin, email, readername, area);
			//out.print(flag);

			String rsflag[] = flag.split(":");
			String titlereason = "";
			String titlecreade = "";
			String point_reason = "";
			String rangdate = "";

			if (rsflag[0].equals("true")) {
				result = "VIOLATE";
			} else {
				result = "OK";

			}

			out.print(result);

		} catch (Exception e) {

		} finally {
			cst.closeall();
			rst.closeall();
		}
	}
%>
