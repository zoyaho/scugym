<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*,wisoft.*"%>    
<!DOCTYPE html>
<html lang="zh-Hant-TW">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
  <link rel="icon" href="images/favicon.ico" type="image/x-icon" />
  <meta property="fb:app_id" content="" />
  <meta property="og:title" content="東吳大學討論室" />
  <meta property="og:type" content="activity" />
  <meta property="og:url" content="" />
  <meta property="og:description" content="" />

  <meta property="og:image" content="/images/1200x628.jpg" />
  <meta property="og:image:type" content="image/jpeg">
  <meta property="og:image:width" content="1200">
  <meta property="og:image:height" content="628">

  <title>東吳大學討論室</title>

 
  <link href="https://fonts.googleapis.com/css?family=Nunito+Sans" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+TC:400, 500,300,700&display=swap" rel="stylesheet">

  <!-- JS
  <script src="assets/js/jquery-2.0.0.min.js"></script>
   -->  
  <!-- CSS -->
  <link rel="stylesheet" href="css/reset.css"> 
  <link rel="stylesheet" href="css/layout.css"> 
  <link rel="stylesheet" href="css/login.css"> 
    <link rel="stylesheet" href="css/jquery-confirm.css"> 
    <style type="text/css">
	.ui-state-default,
	.ui-widget-content .ui-state-default,
	.ui-widget-header .ui-state-default {
		font-size: 24px;
	
	}
	.ui-dialog-content{
	background:#81ddc8; 
	font-size: 24px;
	text-align:center;
	padding-top:20px;
	}
	.ui-dialog .ui-dialog-titlebar, 
	.ui-dialog-buttonset {
      background:#F3CBAB;
      border-color:rgb(157,213,58); 
}

	</style>
 </head>
<%
if(session.getAttribute("account") == null){
%>
<script>
  location.replace("login.jsp");
</script>
<%	
}	
ReserveData rdt = new ReserveData();
ReserveData rdtreader = new ReserveData();
ReserveData rdt1 = new ReserveData();
ReserveData rdtroom = new ReserveData();

try
{
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
	//kw="";
	String getreader = "";
	if(!kw.equals("")){
		rdtreader.getReaderInfo4(kw);
		cno = rdtreader.showData("cardid", 0);
		
	}
	//out.print(cno);
	rdt.getStaff(cno,startdate,starttime,enddate,endtime,location);
%>
<body id="login">
  <div id="ham" class="mb-only-b" >
    <span></span>
    <span></span>
    <span></span>
  </div>
  <div id="ham-content" class="mb-only-b">
    <ul>
     
      <li class="ham-icon3">
        <a href="#"  onclick="go_logout();">          
          <svg id="hamicon3"  xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120">
            <rect class="cls-1" x="-11.5" y="-5.17" width="137.51" height="133"/>
            <rect class="cls-2" x="1.5" y="1.5" width="117" height="117"/>
            <path class="cls-3" d="M37,36.88a23.72,23.72,0,1,1-.34,9.94"/>
            <polyline class="cls-3" points="76 42 45 42 52.07 49.07"/>
            <line class="cls-3" x1="45" y1="42" x2="52.07" y2="34.93"/>
            <text class="cls-4" transform="matrix(1, 0, 0, 1, 44.36, 90.13)">登出
            </text>
            <text class="cls-5" transform="matrix(1, 0, 0, 1, 42.29, 104.64)">L
            <tspan class="cls-6" x="4.71" y="0">OGOUT
            </tspan>
            </text>
          </svg>
        </a>
      </li>
    </ul>
  </div>
  <nav id="nav">
      <div id="nav-logo">
        <span class="img logo1"></span>
      </div>
      <ul id="nav-icons-wrap"  class="pc-only">
       
        <li class="nav-icons icon8">
          <a href="#" onclick="go_logout();">          
            <svg id="hamicon3"  xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120">
              <rect class="cls-1" x="-11.5" y="-5.17" width="137.51" height="133"/>
              <rect class="cls-2" x="1.5" y="1.5" width="117" height="117"/>
              <path class="cls-3" d="M37,36.88a23.72,23.72,0,1,1-.34,9.94"/>
              <polyline class="cls-3" points="76 42 45 42 52.07 49.07"/>
              <line class="cls-3" x1="45" y1="42" x2="52.07" y2="34.93"/>
              <text class="cls-4" transform="matrix(1, 0, 0, 1, 44.36, 90.13)">登出
              </text>
              <text class="cls-5" transform="matrix(1, 0, 0, 1, 42.29, 104.64)">L
              <tspan class="cls-6" x="4.71" y="0">OGOUT
              </tspan>
              </text>
            </svg>
          </a>
        </li>
      </ul>
  </nav>
  
  <article id="wrap">
     <section class="c-container fired" id="c-content">
	 <table>
        <thead>        
          <tr>
            <th>日期/場地 <span>Date/Room</span></th>
            <th>使用狀態 <span>Status</span></th>
          </tr>
        </thead>
        <tbody>
		<% 
		int i = 0 ;
		int up = rdt.showCount();
		int rs_row = 0;
	
		while (i < up){
			
				rdt1.getReaderInfo4(rdt.showData("do_card",i));
				String staff="";
				try
				{
					staff = rdt1.showData("name", 0) ;
				}catch(Exception e){
					staff ="";
				}
				String show_Date = rdt.showData("sysid",i);
				String show_DateName = show_Date.substring(0,4)+"-"+show_Date.substring(4,6)+"-"+show_Date.substring(6,8);
				rdtroom.getRoomByIP(rdt.showData("do_ip",i));
				String loc= rdtroom.showData("room_type", 0);
				String roomname = rdtroom.showData("room_name", 0);
				rdtroom.getCodetabById(loc);
				String locnm = rdtroom.showData("name_zh", 0);
				String do_type = rdt.showData("do_type",i);
				String IN_OUT = rdt.showData("do_inout",i);
				String IN_OUT_NAME="";
				String IN_OUT_TYPE = rdt.showData("do_type",i);
				String IN_OUT_TYPE_NAME = "";
				if(IN_OUT.equals("IN")){
					IN_OUT_NAME="入館";
					if(IN_OUT_TYPE.equals("OK")) IN_OUT_TYPE_NAME="已入館";
				}
				if(IN_OUT.equals("OUT")){
					IN_OUT_NAME="出館";
					if(IN_OUT_TYPE.equals("OK")) IN_OUT_TYPE_NAME="已出館";
				}
				IN_OUT_NAME += "("+show_Date.substring(8,10)+":"+show_Date.substring(10,12)+":"+show_Date.substring(12,14)+")";
				if(IN_OUT_TYPE.equals("ROOM FULL")) IN_OUT_TYPE_NAME="人數已滿,無法入館";
				if(IN_OUT_TYPE.equals("FAIL IN")) IN_OUT_TYPE_NAME="無效卡,入館失敗";
				if(IN_OUT_TYPE.equals("INUSED")) IN_OUT_TYPE_NAME="已使用其他場地,入館失敗";
				if(IN_OUT_TYPE.equals("CARD OUT")) IN_OUT_TYPE_NAME="僅出館";
				if(IN_OUT_TYPE.equals("FAIL OUT")) IN_OUT_TYPE_NAME="無效卡,出館失敗";
			%>
			<tr><td>
				<ul>              
                  <li class="t"><%=show_DateName%> </li>  
                  <li class="r"><%=locnm%> <%=roomname %>
                    <!--<span class="pc-only-ib"><%=locnm%></span>
                    <span class="mb-only-ib"><%=roomname %></span>-->
                  </li>
				  <!--
				  <li class="e">
                      <span class="mb-only-b"><%=locnm%></span>
                      <span class="pc-only-ib"><%=roomname %></span>
                  </li>-->
                </ul>
				</td>
				<td>
				<ul>              
                  <li class="t"><%=IN_OUT_NAME%> </li>  
                  <li class="r"><%=IN_OUT_TYPE_NAME%>
                   <!-- <span class="pc-only-ib"><%=rdt.showData("do_type",i)%></span>
                    <span class="mb-only-ib"><%=rdt.showData("do_type",i)%></span>-->
                  </li>
				  <!--
				  <li class="e">
                      <span class="mb-only-b"><%=rdt.showData("do_type",i)%></span>
                      <span class="pc-only-ib"><%=rdt.showData("do_type",i)%></span>
                  </li>-->
                </ul></td>
			</tr>
			<%
			  
	  
				i++;
		}
		
		if (up == 0){
		%>
		<tr><td colspan="8">查無資料...</td></tr>
		<%
		}
		%>
		
	</table>
    </section>
    
  </article>
 
<div id="jerry"></div>
<%	

}catch(Exception e){out.print(e);}finally{
rdt.closeall();
rdt1.closeall();
rdtreader.closeall();
rdtroom.closeall();
}
%>   
 <script src="js/jquery-3.1.1.min.js"></script>
		<script src="js/jquery-ui.min.js"></script>
		<script src="js/jquery-confirm.js"></script>
		<script src="js/jquery.motionCaptcha.0.2.js"></script>
  <script src="js/login.js"></script>
 <script src="js/main.js"></script>
 
</body>
</html>

