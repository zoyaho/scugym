<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*,wisoft.*"%>
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
ReserveData rdt1 = new ReserveData();
ReserveData rdtroom = new ReserveData();

try
{

	
	String kw = (String)request.getParameter("gk");
	String startdate = (String)request.getParameter("gs");
	String starttime = (String)request.getParameter("gstime");
	String enddate = (String)request.getParameter("ge");
	String endtime = (String)request.getParameter("getime");
	String location = (String)request.getParameter("gloc");
	String cno = "";
	
	String getreader = "";
	if(!request.getParameter("gk").equals("")){
		rdtreader.getReaderInfo4(kw);
		cno = rdtreader.showData("cardid", 0);
		
	}
	//out.print(cno);
	rdt.getStaff(cno,startdate,starttime,enddate,endtime,location);
	rdt.SetPageinfo(rdt.showCount(), 15);
	
	int prepi=0;//當前頁數
	
	if(request.getParameter("page")==null)
	{
		prepi = 1;
	}
	else
	{
		prepi = Integer.parseInt(request.getParameter("page"));
	}
	
	rdt.setPagenumber(prepi);
	rdt.gotoPage(prepi);
%>
<div id="content">
<article>
	<table class="t1" width="98%" border="0" cellpadding="0" cellspacing="0">
	<tr>
	<td class="t1" height="25" valign="top"><span class="style4">/ 體育場館 </span>
    	<% 
    	
    		if(request.getParameter("gk").equals(""))
    		{
    			%>
    	    	<span class="style2">/ 使用者紀錄管理/ALL) </span>
    	   		<%  
    	   			
    		}
    		else
    		{	
    	%>
    	<!-- <span class="style2">/ 使用者紀錄管理/<%=rdt.showData("reader_name", 0) %>(<%=rdt.showData("new_id", 0) %>) </span> -->
    	<span class="style2"> 使用紀錄管理 </span>
   		<%  
   			} 
    	String exportToExcel = request.getParameter("exportToExcel");
    	String url = "";
    	url="gk="+kw+"&gs="+startdate+"&gstime="+starttime+"&ge="+enddate+"&getime="+endtime+"&gloc="+location;
    	 String encodedURL = java.net.URLEncoder.encode(url, "UTF-8");

    	if (exportToExcel == null) {
    	%>
    	<a href="staff_p_list1.jsp?<%=url%>&exportToExcel=YES&type1=excel">匯出Excel</a>
    	<%
    	    }

   		%>
    </td>
  	</tr>
	</table>  
	<div class="table">
        <div class="table-head">
            <div class="column" data-label="序號">序號</div>
            <div class="column" data-label="卡號">卡號</div>
            <div class="column" data-label="日期時間">日期時間</div>
            <div class="column" data-label="進出狀態">進出狀態</div>
            <div class="column" data-label="進出狀態">刷卡狀態</div>
        </div>		
		
		<% 
		int i = 0 ;
		int up = rdt.showCount();
		int rs_row = 0;
	
		while (i < up){
			
			if(rs_row >= rdt.showPagebegin() && rs_row < rdt.showPageend())
	    	{
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
				String do_type = rdt.showData("do_type",i); 
			%>
			<div class="row"><td><%=i+1%></td>
				<div class="column" >(<%=locnm%> <%=roomname %>)<%=staff%>/<%=rdt.showData("do_card",i)%></div>
				<div class="column" ><%=rdt.showData("sysid",i)%></div>
				<div class="column" ><%=rdt.showData("do_inout",i)%></div>
				<div class="column" ><%=rdt.showData("do_type",i)%></div>
			</div>
			<%
			  
	    	}
			rs_row++;
				i++;
		}
		
		if (up == 0){
		%>
		<tr><td colspan="8">查無資料...</td></tr>
		<%
		}
		%>
		
	</div>
	</article>
</div>
<!--分頁程式開始  -->
<div class="page">
<a href="#" onclick="goPage1('staff_p_list.jsp?gk=<%=kw%>&gs=<%=startdate%>&gstime=<%=starttime%>&ge=<%=enddate%>&getime=<%=endtime%>&gloc=<%=location%>&page=1');">第一頁</a>

<%
int pi;
int current=0;
current = prepi;

	if(prepi > 1)
	{	
%>

<a href="#" onclick="goPage1('staff_p_list.jsp?gk=<%=kw%>&gs=<%=startdate%>&gstime=<%=starttime%>&ge=<%=enddate%>&getime=<%=endtime%>&gloc=<%=location%>&page=<%=current-1%>&pageC=p');">上一頁</a>
<%
	}
	
	
	if(prepi < 10)
	{
		prepi = 1;
	}
	else if(prepi >= (rdt.showTotalpage() -10))
	{
		
		prepi = prepi -9;
	}
	
	for(pi = prepi;pi < prepi+10; pi++)
	{
		
		if(pi <= rdt.showTotalpage())
		{	
		
%>


<a href="#" onclick="goPage1('staff_p_list.jsp?gk=<%=kw%>&gs=<%=startdate%>&gstime=<%=starttime%>&ge=<%=enddate%>&getime=<%=endtime%>&gloc=<%=location%>&page=<%=pi%>');">

<%if(pi==current){out.print("<font color=red>"+pi+"</font>");}else{out.print(pi);} %>

</a>
<%
		}
	}
	
	if(prepi < rdt.showTotalpage() )
	{	
%>
<a href="#" onclick="goPage1('staff_p_list.jsp?gk=<%=kw%>&gs=<%=startdate%>&gstime=<%=starttime%>&ge=<%=enddate%>&getime=<%=endtime%>&gloc=<%=location%>&page=<%=current+1%>&pageC=n');">下一頁</a>
<%
	}
%>
<a href="#" onclick="goPage1('staff_p_list.jsp?gk=<%=kw%>&gs=<%=startdate%>&gstime=<%=starttime%>&ge=<%=enddate%>&getime=<%=endtime%>&gloc=<%=location%>&page=<%=rdt.showTotalpage()%>');">最終頁</a>

</div>
<!--分頁程式結束  -->

<div id="jerry"></div>
<%	

}catch(Exception e){out.print(e);}finally{
rdt.closeall();
rdt1.closeall();
rdtreader.closeall();
rdtroom.closeall();
}
%>
</body>
</html>