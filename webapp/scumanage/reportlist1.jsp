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



if(type.equals("hour"))
{
	rs = rst.getHourRecord(from,to,do_ip,arrayip);
	title="<h3> 依小時"+from+"-"+to+"</h3>";
}
else if(type.equals("day"))
{
	rs = rst.getDayRecord(from,to,do_ip,arrayip);
	title="<h3> 依日期"+from+"-"+to+"'</h3>";
}	
else if(type.equals("month"))
{
	rs = rst.getMonthRecord(from,to,do_ip,arrayip);
	title="<h3> 依月份"+from+"-"+to+"</h3>";
}

String exportToExcel = request.getParameter("exportToExcel");
if (exportToExcel != null
        && exportToExcel.toString().equalsIgnoreCase("YES")) {
	
	String fileName = "進出人次統計表_"+rst1.todaytime();
	String e8 = URLEncoder.encode(fileName, "UTF8");
	if(request.getParameter("type1").equals("excel"))
	{
		response.setContentType("application/vnd.ms-excel");
	    response.setHeader("Content-Disposition", "inline; filename="+e8+".xls");
	}	
	else if(request.getParameter("type1").equals("txt"))
	{
	    response.setContentType("application/msword" );
	    response.setHeader("Content-Disposition", "attachment;filename="+e8+".doc" );
      
	}	
	
	if(!loc.equals("0"))
	{
		rst2.getTab(Integer.parseInt(loc));
		locname = rst2.showData("name_zh", 0);
	}
	
	
}

	
        %>
         <%=locname%>/<%=roomname %> <%=title %>
       <table>
      
        <tr>
         <%
            	if(type.equals("hour"))
            	{
            		
            	}
            	else if(type.equals("day"))
            	{
            		%>
            		<th class="column">日期</th>
            		<%
            	}
            	else if(type.equals("month"))
            	{
            		%>
            		<th class="column">月</th>
            		<%
            	}
            		
            %>
        	<th class="column" data-label="Hour">時段</th>
            <th class="column" data-label="IN">進(人次)</th>
            <th class="column" data-label="OUT">出(人次)</th>
        
        </tr>
        <%
        int totalin= 0 ;
        int totalout= 0 ;
    	rs.beforeFirst();
        while(rs.next())
        {
        	
        	totalin += rs.getInt("numin");
        	totalout += rs.getInt("numout");
        	%>
<tr>   
<%
            	if(type.equals("hour"))
            	{
            		
            	}
            	else if(type.equals("day"))
            	{
            		%>
            		<td class="column" ><%=rs.getString("date") %></td>

            		<%
            	}
            	else if(type.equals("month"))
            	{
            		%>
            		<td class="column" ><%=rs.getString("month") %></td>

            		<%
            	}
            		
            %>
 	
<td><%=rs.getString("hourf") %>-<%=rs.getString("hourt") %></td>
<td><%=rs.getInt("numin") %></td>
<td><%=rs.getInt("numout") %></td>
</tr>
        	<%
        	
        }
        rs.close();
     
        
	%>
	<tr>        	
<td colspan="2">總計</td>
<td><%=totalin %></td>
<td><%=totalout %></td>
</tr>
	 </table>
	<%


rst.closeall();
rst1.closeall();
rst2.closeall();
}
%></body>
</html>
