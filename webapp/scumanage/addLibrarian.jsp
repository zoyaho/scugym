<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {
		CaseData cst = new CaseData();
		//try {
			String ck = request.getParameter("ck");
			String id = request.getParameter("id");
			String name = request.getParameter("desc");

			String fid = session.getAttribute("fid").toString();
			String fcid = session.getAttribute("fcid").toString();

			String realid = "";
		
			if (id.length() > 10 && cst.onlynumber(id)) {
				realid = cst.upsidedown_HEX(cst.decimal2Hex(Integer.parseInt(id))); //10轉16
			} else {
				if(id.length() < 10){ //16to10
					realid = Long.toString(cst.hex2Decimal(cst.upsidedown_HEX(id)));
					if(realid.length() < 10) {
					String addzeros = "0000000000";
					realid = addzeros.substring(0,10-realid.length())+realid;
					id=realid ;
					}
				}else{
					realid = id;
				}
			}

			
			String rt = cst.saveLibrarian(ck, id, name);

			out.print(rt + ":" + fid + ":" + fcid);
			cst.closeall();
		//catch (Exception e) {
		//	out.print("NO");
		//} finally {
			cst.closeall();
		//}
	}
%>
