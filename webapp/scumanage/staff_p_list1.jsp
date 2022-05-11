<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*,wisoft.*,java.net.*"%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title></title>
<meta name="keywords" content="" />
<meta name="description" content="" />

</head>
<body>
<%	



	ReserveData rdt = new ReserveData();
	ReserveData rdtreader = new ReserveData();
	ReserveData rdtroom = new ReserveData();

	String kw = (String)request.getParameter("gk");
	String startdate = (String)request.getParameter("gs");
	String starttime = (String)request.getParameter("gstime");
	String enddate = (String)request.getParameter("ge");
	String endtime = (String)request.getParameter("getime");
	String location = (String)request.getParameter("gloc");
	//out.print(request.getParameter("exportToExcel"));
  String exportToExcel = request.getParameter("exportToExcel");
if (exportToExcel != null
        && exportToExcel.toString().equalsIgnoreCase("YES")) {
	
	//out.print(exportToExcel);
	String fileName = "卡號進出紀錄"+startdate+"~"+enddate;
	String e8 = URLEncoder.encode(fileName, "UTF8");
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition", "inline; filename="+e8+".xls");
	
}

String cno = "";

String getreader = "";
if(!kw.equals("")){
	rdtreader.getReaderInfo4(kw);
	cno = rdtreader.showData("cardid", 0);
	
}
//out.print(cno);
rdt.getStaff(cno,startdate,starttime,enddate,endtime,location);
	
%>
<div id="content">
	<table class="t1" width="98%" border="0" cellpadding="0" cellspacing="0">
	<tr>
	<td class="t1" height="25" valign="top"><span class="style4">/ 體育場館 </span>
    	<span class="style2"> 使用紀錄管理 </span>
    </td>
  	</tr>
	</table>  
	<table>
		<tr>
			<th>序號</th><th>卡號</th><th>日期時間</th><th>進出狀態</th><th>刷卡狀態</th>
		</tr>
		
		<% 
		int i = 0 ;
		int up = rdt.showCount();
		int rs_row = 0;
		ReserveData rdt1 = new ReserveData();
		ReserveData rdt2 = new ReserveData();
	
		while (i < up){
			rdt1.getReaderInfo4(rdt.showData("do_card",i));
			String staff="";
			try
			{
				staff = rdt1.showData("name", 0) ;
			}catch(Exception e){
				staff ="";
			}
			
			rdtroom.getRoomByIP(rdt.showData("do_ip",i));
			String loc= rdtroom.showData("room_type", 0);
			String roomname = rdtroom.showData("room_name", 0);
			rdtroom.getCodetabById(loc);
			String locnm = rdtroom.showData("name_zh", 0);
			
			
			%>
			<tr><td><%=i+1%></td>
				<td>(<%=locnm%> <%=roomname %>)<%=staff%>/<%=rdt.showData("do_card",i)%></td>
				<td><%="'"+rdt.showData("sysid",i).substring(0, 14)+"'" %></td>
				<td><%=rdt.showData("do_inout",i)%></td>
				<td><%=rdt.showData("do_type",i)%></td>
			</tr>
			<%
			
				i++;
		}
		rdt.closeall();
		rdt1.closeall();
		rdt2.closeall();
		rdtreader.closeall();
		rdtroom.closeall();
		if (up == 0){
		%>
		<tr><td colspan="8">查無資料...</td></tr>
		<%
		}
		%>
		
	</table>
</div>

</body>
</html>