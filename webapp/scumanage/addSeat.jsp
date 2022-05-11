<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {

		CaseData cst = new CaseData();
		try {

			//0 insert 1:update
			//status(座位開放狀態) 10  
			String ck = request.getParameter("ck");
			String area = request.getParameter("area");
			String status = request.getParameter("status");
			String roomname = request.getParameter("room");
			String floor = request.getParameter("floor");
			String loc = request.getParameter("loc");
			String fid = session.getAttribute("fid").toString();
			String fcid = session.getAttribute("fcid").toString();
			String ip = request.getParameter("ip");
			String rt = cst.SaveSeat(ck, area, status, roomname, floor, loc,ip);
			out.print(rt + ":" + fid + ":" + fcid + ":" + area);
			cst.closeall();
		} catch (Exception e) {
			out.print("NO");
		} finally {
			cst.closeall();
		}
	}
%>
