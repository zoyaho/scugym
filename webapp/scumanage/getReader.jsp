<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {

		ReserveData rst = new ReserveData();
		try
		{
		String id = request.getParameter("id");
		String readername = "";
		rst.getReaderInfo3(id);
		readername =  rst.showData("name", 0);
		out.print(readername);
		}catch(Exception e){}finally{
		rst.closeall();
		}
	}
%>
