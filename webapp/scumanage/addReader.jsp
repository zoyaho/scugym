<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {

		CaseData cst = new CaseData();
		Utility util = new Utility();
		String rt = "";
		//try {
			String ck = request.getParameter("ck");
			String readerstatus = request.getParameter("readerstatus");
			String uid = request.getParameter("uid");
			String name = request.getParameter("name");
			String type = request.getParameter("type");
			String cardid = request.getParameter("cardid");
			String startdate = request.getParameter("startdate");
			String enddate = request.getParameter("enddate");
			String password = request.getParameter("password");
			String note = request.getParameter("note");
			String decimalid = "";
			String hexid = "";
			//需確認是卡號是內碼還是16進位
			
			if(cardid.length() >= 10 && util.onlynumber(cardid))
            {	
              	 Long val1=Long.parseLong(cardid);
                 if (val1>Integer.MAX_VALUE){
                    	 hexid = util.upsidedown_HEX(util.decimal2Hex(Long.parseLong(cardid))); //10轉16
                    	 decimalid = cardid;
                 }else {
                      
                     if(util.onlynumber(cardid))
                    	   hexid = util.upsidedown_HEX(util.decimal2Hex(Integer.parseInt(cardid))); //10轉16
                           decimalid = cardid;
                     } 
            }
            else
            {
              	 decimalid = Long.toString(util.hex2Decimal(util.upsidedown_HEX(cardid)));
				 if(decimalid.length() < 10) {
					String addzeros = "0000000000";
					decimalid = addzeros.substring(0,10-decimalid.length())+decimalid;
				 }
				 //decimalid = Long.toString(util.hex2Decimal(cardid));
     			 hexid = cardid;
            }	
			
			rt = cst.SaveReader(ck, readerstatus, "", uid, name, type, "", "", "", decimalid,
					util.bin2hex(password), startdate, enddate, note, hexid);

			String fid = session.getAttribute("fid").toString();
			String fcid = session.getAttribute("fcid").toString();

			out.print(rt + ":" + fid + ":" + fcid);

			cst.closeall();
		//} catch (Exception e) {
		//	out.print("NO" + e);
		//} finally {
			util.closeall();
			cst.closeall();
		//}
	}
%>
