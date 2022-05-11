<%@page import="java.io.*,java.util.*,wisoft.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("loginOK") == "OK") {

		BookingData1 bkd1 = new BookingData1();
		BookingData1 bkd2 = new BookingData1();
		BookingData1 bkd3 = new BookingData1();
		BookingData1 bkd4 = new BookingData1();
		ReserveData rdt = new ReserveData();
		getDoor gdr = new getDoor();
		String get_day = bkd1.today();
		String seat_sysid = "";
		try {
			String room_name = request.getParameter("room_name");
			String area = request.getParameter("area");
			String loc = request.getParameter("loc");
			bkd2.CheckReserveSeat(area, room_name, loc);
			seat_sysid = bkd2.showDataSingle("sysid", 0);
			bkd3.CheckOthersReserveSeatAll(get_day, seat_sysid);

			//gdr.deleteCard(bkd3.showDataSingle("card_id", 0));
            bkd1.getRoom1(seat_sysid);
			rdt.getTabByName(bkd1.showData("room_floor", 0)); 
			gdr.deleteCard(bkd3.showDataSingle("room_type", 0),bkd1.showData("room_floor", 0),bkd3.showDataSingle("room_codeid", 0),rdt.showData("name_en", 0) ,bkd3.showDataSingle("card_id", 0)); 	 	
				
			bkd4.ClearSeat(bkd3.showDataSingle("sysid", 0));

			out.print("OK");
			bkd1.closeall();
			bkd2.closeall();
			bkd3.closeall();
			bkd4.closeall();
			rdt.closeall();
			gdr.closeall();

		} catch (Exception e) {
		//	out.print(e);
			out.print("NO");
		} finally {
			bkd1.closeall();
			bkd2.closeall();
			bkd3.closeall();
			bkd4.closeall();
			rdt.closeall();
			gdr.closeall();

		}
	}
%>
