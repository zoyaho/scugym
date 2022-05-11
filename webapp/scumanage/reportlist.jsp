<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*,java.net.*"%>
<%@ page import="wisoft.*"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>登入使用紀錄管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

<%
if(session.getAttribute("loginOK")=="OK")
{


ReserveData rst = new ReserveData();
ReserveData rst1 = new ReserveData();
ReserveData rst2 = new ReserveData();
String type = request.getParameter("type");
String loc =  request.getParameter("loc");
String room =  "";
String from =  request.getParameter("from");
String to =  request.getParameter("to");

String url="";
ResultSet rs = null;
ArrayList<String> arrayip = new ArrayList<String>();
String do_ip = "";
String title="";
String locname="";
String roomname="";
if(!request.getParameter("room").equals("0"))
{
	room =  request.getParameter("room");
	rst.getOneRoom(room);
	do_ip = rst.showData("ip", 0);
	roomname = rst.showData("room_name",0);
}
else
{
	rst1.getRoomByLoc(loc);
	int i=0;
	int up = rst1.showCount();
	
	while(i < up)
	{
		arrayip.add(rst1.showData("ip", i));
		//roomname += rst1.showData("room_name",i);
		roomname ="ALL";
		i++;
	}
	
	do_ip = "0";
}	


url="type="+type+"&loc="+loc+"&from="+from+"&to="+to+"&room="+request.getParameter("room");

String exportToExcel = request.getParameter("exportToExcel");

if (exportToExcel == null) {
%>
<a href="reportlist1.jsp?<%=url%>&exportToExcel=YES&type1=excel">匯出Excel</a>
<a href="reportlist1.jsp?<%=url%>&exportToExcel=YES&type1=txt">匯出doc</a>
<%
}


if(type.equals("hour"))
{
	rs = rst.getHourRecord(from,to,do_ip,arrayip);
	
	title="<h3> 依小時"+from+"-"+to+"</h3>";
}
else if(type.equals("day"))
{
	rs = rst.getDayRecord(from,to,do_ip,arrayip);
	String fromdate[] = from.split(" ");
	String todate[] = to.split(" ");
	title="<h3> 依日期"+fromdate[0]+"-"+todate[0]+"'</h3>";
}	
else if(type.equals("month"))
{
	rs = rst.getMonthRecord(from,to,do_ip,arrayip);
	String frommonth = from.substring(0,7);
	String tomonth = to.substring(0,7);;
	title="<h3> 依月份"+frommonth+"-"+tomonth+"</h3>";
}

if(!loc.equals("0"))
{
	rst2.getTab(Integer.parseInt(loc));
	locname = rst2.showData("name_zh", 0);
}
	
		%>
        
        
         <%=locname%>/<%=roomname %> <%=title %>
       <div class="table">
      
        <div class="table-head">
            <%
            	if(type.equals("hour"))
            	{
            		
            	}
            	else if(type.equals("day"))
            	{
            		%>
            		<div class="column" data-label="Hour">日期</div>
            		<%
            	}
            	else if(type.equals("month"))
            	{
            		%>
            		<div class="column" data-label="Hour">月</div>
            		<%
            	}
            		
            %>
        	<div class="column" data-label="Hour">時段</div>
            <div class="column" data-label="IN">進(人次)</div>
            <div class="column" data-label="OUT">出(人次)</div>
        
        </div>
        <%
        int totalin= 0 ;
        int totalout= 0 ;
        rs.beforeFirst();
        
        while(rs.next())
        {
        	
        	
        	%>
<div class="row">        	
 <%
            	if(type.equals("hour"))
            	{
            		
            	}
            	else if(type.equals("day"))
            	{
            		%>
            		<div class="column" data-label="Day"><%=rs.getString("date") %></div>

            		<%
            	}
            	else if(type.equals("month"))
            	{
            		%>
            		<div class="column" data-label="Month"><%=rs.getString("month") %></div>

            		<%
            	}
            		
            %>
<div class="column" data-label="HOUR"><%=rs.getString("hourf") %>-<%=rs.getString("hourt") %></div>
<div class="column" data-label="IN"><%=rs.getInt("numin") %></div>
<div class="column" data-label="OUT"><%=rs.getInt("numout") %></div>
</div>
        	<%
        	totalin += rs.getInt("numin");
        	totalout += rs.getInt("numout");
        }
        
     
	%>
	<div class="row">        	
<div class="column" data-label="HOUR">總計</div>
<%

        if(!type.equals("hour"))
		{
%>
<div class="column" data-label="HOUR"></div>
		<%}%>
<div class="column" data-label="IN"><%=totalin %></div>
<div class="column" data-label="OUT"><%=totalout %></div>
</div>
	 </div>
	<%
	rs.close();

rst.closeall();
rst1.closeall();
rst2.closeall();
}
%></body>
</html>
