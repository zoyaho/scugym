<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,wisoft.*"%>  
<%
if(session.getAttribute("loginOK")=="OK")
{
CaseData cst = new CaseData();

String ck="0";
String area = "3"; 
String status = "10";
String floor = "B2";
String loc = "52";
String roomname ="";
for(int i=1 ; i <= 125 ; i++)
{
	if(i < 10)
	{
		roomname = "A00"+i;
	}	
	else if(i >= 100)
	{
		
		roomname = "A"+i;
	}	
	else
	{
		roomname = "A0"+i;
	}	
	String ip="";
	String rt = cst.SaveSeat(ck,area,status,roomname,floor,loc,ip); 
   out.println(rt);
}

cst.closeall();
}
%>