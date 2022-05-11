<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.util.*"%>
<%
if(session.getAttribute("loginOK")=="OK")
{
	CaseData cst = new CaseData();
	ReserveData rst = new ReserveData();
	//email to the reader 
	String room="";
	String loc="";
	String pointtype ="";
	String readerid="";
	String admin="";
	String email="";
	
	SimpleSender smtp = new SimpleSender();
	String subj = "";
	String bodycont = "";
	String towho ="";
	String from = "";
	String booking_datetime="";
	String result="";
	String emailtype="";
	String reason="";
	String createdate="";
	//try {

		String sysid = request.getParameter("id");
		//out.print(sysid);
		
		rst.getPointBySysid(sysid);
		room = rst.showData("point_room", 0);
		loc = rst.showData("point_loc", 0);
		pointtype = rst.showData("point_type", 0);
		readerid =  rst.showData("reader_id", 0);
		admin = rst.showData("creater", 0);
		email = rst.showData("email", 0);
		reason = rst.showData("reason", 0);
		createdate = rst.showData("createdate", 0);
		
		rst.getRoomSetById(room);
		//判斷是否符合取消停權條件
		String flag = rst.checkPointRelease(readerid,loc,pointtype,admin,sysid);
		String rsflag[] = flag.split(":");
		String titlereason="";
		String titlecreade="";
		String point_reason="";
		//out.print(flag); 
		if(rsflag[0].equals("true"))
		{
			result="REALEASE";	
			emailtype="74"; //解除停權
					//out.print("VIOLATE");
			titlereason = "停權原因:";
			titlecreade = "停權發生時間:";
			
			rst.getPointBypenaltyid(rsflag[1]);
			int i1 = 0;
			int up1 = rst.showCount();
			while(i1 < up1)
			{
				cst.DelPoint(rst.showData("sysid", i1));
				point_reason = "<br>違規原因:"+rst.showData("reason", i1)+"<br>"+"違規日期:"+rst.showData("createdate", i1)+"<br>";
				i1++;
			}
			
			bodycont =  "<br>"+titlereason+reason+"<br>"+titlecreade+createdate+point_reason ;
			
		}
		else
		{
			result="OK";
			cst.DelPoint(sysid);
			emailtype="46"; //解除違規
			//out.print("OK");
			titlereason = "違規原因:";
			titlecreade = "違規發生時間:";
			
			room = rst.showData("roomLoc_name", 0)+" "+rst.showData("room_name", 0)+"<br>";
			bodycont =  room+"<br>"+titlereason+reason+"<br>"+titlecreade+createdate ;
			
			
		}	
		/*
		rst.getBookingEmail(loc,emailtype);
		subj = rst.showData("subject", 0);
		bodycont +=  rst.showData("content", 0)+"<br>";
		from =  rst.showData("email_from_who", 0);
		towho = email;
		
		rst.getCodetabById("60");
		//smtp.Init_Auth(rst.showData("name_desc_zh", 0),rst.showData("name_en", 0),rst.showData("name_desc_en", 0));
		smtp.Init_Auth(rst.showData("name_desc_zh", 0));
		smtp.sendSender(rst.showData("name_en", 0));
		smtp.SendMail1(bodycont, from, towho, subj);
	*/
		out.print(result);
		
		
	//} catch (Exception e) {
        //out.print(e);
	//} finally {
		cst.closeall();
		rst.closeall();
	//}
	
}
%>
