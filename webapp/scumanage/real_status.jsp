<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>即時座位管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge;chrome=1" />
<script type="text/javascript">
 	//js get servertime
 	 	function startTime() {
 	   	
 	    var today = new Date();
 		var year = today.getFullYear();
 	   	var month = ("0" + (today.getMonth() + 1)).slice(-2);
 	   	var date = ("0" + (today.getDate() )).slice(-2);
 	   	
 	    var h = today.getHours();
 	    var m = today.getMinutes();
 	    var s = today.getSeconds();
 	    m = checkTime(m);
 	    s = checkTime(s);
 	    //alert(h);
 	   //document.getElementById('txt').innerHTML= h + ":" + m + ":" + s;
 	   	var str = year+"-"+month+"-"+date+" "+ h + ":" + m ;
		$( "#txt" ).html( str );
 	   	//setInterval(startTime, 1000);
 	}

 	function checkTime(i) {
 	    if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
 	    return i;
 	}

 	$(document).ready(function () {
 		startTime();
    });
    setInterval(startTime,10000);
 	
 	</script>
  	
</head>
<body>
<%
if(session.getAttribute("loginOK")=="OK")
{


String fid = "";
String fcid = "";

	
fid = request.getParameter("fid");
fcid = request.getParameter("fcid");
	
session.setAttribute("fid", fid);
session.setAttribute("fcid", fcid);

ReserveData rdt = new ReserveData();
ReserveData rst = new ReserveData();
ReserveData rst1 = new ReserveData();

BookingData1 bkd = new BookingData1();
BookingData1 bkd1 = new BookingData1();
Utility ul = new Utility();
String loc = request.getParameter("loc");
bkd.SeatALLByArea(0,loc);
int all_seat = bkd.showCount();

bkd.SeatRevNumber(0,loc);
int all_revseat = bkd.showCount();

bkd.SeatInUseNumber(0,loc);
int all_inseat = bkd.showCount();

bkd.SeatLeaveNumber(0,loc);
int all_leaveseat = bkd.showCount();

int emptyseat = bkd.emptyseat(all_seat,all_revseat,all_inseat,all_leaveseat);
String area = "";


%>
<div>
<div id="top">
<h1><span id='txt'></span></h1>
<h1 style="font-size:25px;">全區座位:<%=all_seat %> <span class="grey">空位:<%=emptyseat %></span> <span class="orange">已選位:<%=all_revseat %></span> <span class="red">入座:<%=all_inseat %></span> <span class="purple">暫離:<%=all_leaveseat %></span></h1> 
<div id="area" style="padding-top:10px;">
<%

rst.getLocarea(loc);

int i = 0;
int up = rst.showCount();
String ck="";
String defaultarea="";

while(i < up)
{
	rst1.getCodetabById(rst.showData("area", i));
	
	
	if(loc.equals("20"))
	{
		if(rst.showData("area", i).equals("2") )
		{
			ck="checked";
			defaultarea="2";
		}
		else
		{
			ck="";
		}	
	
	}
	else if(loc.equals("52"))
	{
		if(rst.showData("area", i).equals("3"))
		{
			ck="checked";
			defaultarea="3";
		}
		else
		{
			ck="";
		}	
	}	
	else
	{
		ck="";
	}	
%>
	<input type="radio" id="g5" name="g5" value="<%=rst.showData("area", i) %>" onclick="listseat('<%=loc %>');" <%=ck %>><%=rst1.showData("name_zh", 0) %>

<%
	i++;
}


%>

	
</div>
</div>
<div id="seat">
<jsp:include page="listseat.jsp">
<jsp:param value="<%=defaultarea %>" name="area"/>
<jsp:param value="<%=loc %>" name="loc"/>
</jsp:include>
</div>

</div>
<%
rst.closeall();
rdt.closeall();
rst1.closeall();
bkd.closeall();
bkd1.closeall();
ul.closeall();

}
%>

</body>
</html>