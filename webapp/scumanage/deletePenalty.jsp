<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.util.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {

		CaseData cst = new CaseData();
		ReserveData rst = new ReserveData();

		SimpleSender smtp = new SimpleSender();
		String subj = "";
		String bodycont = "";
		String towho = "";
		String from = "";
		String booking_datetime = "";
		String result = "";
		String loc = "";
		String email = "";
		String room = "";
		String reason = "";
		String createdate = "";
		String createby = "";
		String rangdate = "";
		String startdate = "";
		String enddate = "";
		String readerid = "";
		String readername = "";
		try {

			String penaltyid = request.getParameter("id");
			rst.getPenaltyById(penaltyid);

			email = rst.showData("email", 0);
			startdate = rst.showData("start_date", 0);
			enddate = rst.showData("end_date", 0);
			loc = rst.showData("penalty_location", 0);
			reason = rst.showData("reason", 0);
			createdate = rst.showData("create_datetime", 0);
			rangdate = "<br>停權起訖日期:" + startdate + "~" + enddate + "<br><br>";
			readerid = rst.showData("reader_id", 0);
			readername = rst.showData("reader_name", 0);
			//判斷是否符合解除停權條件
			cst.deletePenalty1(penaltyid);
			/*
				rst.getBookingEmail(loc,"74");//解除停權
				
				subj = rst.showData("subject", 0);
				bodycont =  "讀者資料:"+readerid+"("+readername+") <br>";
				from =  rst.showData("email_from_who", 0);
				towho = email;
				
				bodycont =  rangdate+"<br>停權原因:"+reason+"<br>停權發生時間:"+createdate+"<br>"+rst.showData("content", 0)  ;
					
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
