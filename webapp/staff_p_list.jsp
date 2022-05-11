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
<!--
init("readerinfo");
		//System.out.println("uid = '"+st+"' and password='"+this.bin2hex(st1)+"' and ('"+this.today()+"' between start_date and end_date )");
		queryMe("uid = '"+st+"' and password='"+this.bin2hex(st1)+"' and ('"+this.today()+"' between start_date and end_date )");

CREATE TABLE `readerinfo` (
  `sysid` varchar(50) NOT NULL,
  `reader_status` varchar(45) NOT NULL,
  `msg` varchar(500) DEFAULT NULL,
  `uid` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL COMMENT '職員為E,學生為S,推廣部研修生9002,校友9001',
  `deaprt_1` varchar(200) DEFAULT NULL,
  `deaprt_2` varchar(200) DEFAULT NULL,
  `year` varchar(500) DEFAULT NULL,
  `cardid` varchar(500) NOT NULL,
  `password` varchar(250) DEFAULT NULL,
  `start_date` varchar(45) DEFAULT NULL,
  `end_date` varchar(45) DEFAULT NULL,
  `note` text,
  `createdate` varchar(45) DEFAULT NULL,
  `hexcardid` varchar(45) DEFAULT NULL,
  `del_mark` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`sysid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-->	


<%	
ReserveData rdt = new ReserveData();
ReserveData rdtreader = new ReserveData();
ReserveData rdt1 = new ReserveData();
ReserveData rdtroom = new ReserveData();

try
{

	out.print(session.getAttribute("account"));
	out.print(session.getAttribute("password"));
	String account = (String)session.getAttribute("account");
	String password = (String)session.getAttribute("password");
	
	String kw = "";
	String startdate = rdt.today(-7);
	String starttime = "00:00";
	String enddate = rdt.today();
	String endtime = "24:00";
	//String location = (String)request.getParameter("gloc");
	String location = "20";
	String cno = "";

	rdt.init("readerinfo");
	rdt.queryMe("uid = '"+account+"' and password='"+rdt.bin2hex(password)+"' and del_mark is null");
	if(rdt.showCount() > 0){
		kw = rdt.showData("uid",0);
	}
	out.print(kw);
	String getreader = "";
	if(!kw.equals("")){
		rdtreader.getReaderInfo4(kw);
		cno = rdtreader.showData("cardid", 0);
		
	}
	//out.print(cno);
	rdt.getStaff(cno,startdate,starttime,enddate,endtime,location);
	rdt.SetPageinfo(rdt.showCount(), rdt.showCount());
	
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
  <article id="wrap">
    
 
    
  </article>
<article>
   <section class="c-container fired" id="c-content">

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
	      
    </section>
	</article>
</div>

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