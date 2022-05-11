<%@page import="java.io.*,java.util.*,wisoft.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("loginOK") == "OK") {

		CaseData cst = new CaseData();
		ReserveData rst = new ReserveData();
		ReserveData rst1 = new ReserveData();
		//getDoor gdr = new getDoor();

		try {
			String sysid = request.getParameter("sysid");
			rst.getReaderInfoById(sysid);
			cst.deleteReader(sysid,rst.showData("hexcardid", 0));
			
			out.print("OK");
			cst.closeall();
			rst.closeall();
			rst1.closeall();
			//gdr.closeall();

		} catch (Exception e) {
			//out.print(e);
			out.print("NO"+e);
		} finally {
			cst.closeall();
			rst.closeall();
			rst1.closeall();
			//gdr.closeall();

		}
	}
%>
