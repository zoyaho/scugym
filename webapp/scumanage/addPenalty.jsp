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
		String rangedate = "";
		String createdate = rst.todaytime();

		try {

			String loc = request.getParameter("loc");
			String startdate = request.getParameter("startdate");
			String enddate = request.getParameter("enddate");
			String rid = request.getParameter("rid");
			String rname = request.getParameter("rname");
			String admin = request.getParameter("admin");
			String reason = request.getParameter("reason");
			String unit = request.getParameter("unit");
			String email = request.getParameter("email");
			String area = request.getParameter("area");
			cst.SavePenalty1(loc, startdate, enddate, rid, rname, admin, reason, email, area);
			/*	
			rst.getBookingEmail(loc,"73");//停權
			subj = rst.showData("subject", 0);
			bodycont =  "讀者資料:"+rid+"("+rname+") <br>";
			rangedate = "<br>停權起訖日期:"+startdate +"~"+enddate+"<br><br>";
			
			bodycont += rangedate+"停權發生原因:"+reason+"<br>"+"停權發生時間:"+createdate+"<br>"+rst.showData("content", 0) ;
			from =  rst.showData("email_from_who", 0);
			towho = email;
			
			//郵件伺服器
			rst.getCodetabById("60");
			//smtp.Init_Auth(rst.showData("name_desc_zh", 0),rst.showData("name_en", 0),rst.showData("name_desc_en", 0));
			smtp.Init_Auth(rst.showData("name_desc_zh", 0));
			smtp.sendSender(rst.showData("name_en", 0));
			smtp.SendMail1(bodycont, from, towho, subj);
			*/
			out.print("OK");

		} catch (Exception e) {
			out.print("NO");

		} finally {
			cst.closeall();
			rst.closeall();
		}
	}
%>
