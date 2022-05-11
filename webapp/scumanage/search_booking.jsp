<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*,java.net.*"%>
<%@ page import="wisoft.*"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>登入使用紀錄管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
</head>
<body><%
if(session.getAttribute("loginOK")=="OK")
{

ReserveData rst = new ReserveData();
ReserveData rst1 = new ReserveData();
ReserveData rst2 = new ReserveData(); 
ReserveData rst3 = new ReserveData();
String sessionnow = (String)session.getId();
ResultSet rs = null;
String fid = "";
String fcid = "";

	
if( request.getParameter("fid")!=null && request.getParameter("fcid")!=null)
{
	fid = request.getParameter("fid");
	fcid = request.getParameter("fcid");

	session.setAttribute("fid", fid);
	session.setAttribute("fcid", fcid);
}
else
{
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();
}	


String gid = "";
String keyword = "";
String sdate = "";
String edate = "";

String stime = "";
String etime = "";

String sdatetime = "";
String edatetime = "";

String area = "";
String identify = "";
String status = "";
String loc = "";

String identify1 = "";
String status1 = "";

String url="";

HashMap<String, String> map = new HashMap<String, String>();

map.put("0", "");
map.put("1", "選位");
map.put("3", "失敗");
map.put("5", "取消");
map.put("7", "入座");
map.put("8", "暫離");
map.put("9", "離館");
map.put("11", "逾時");
map.put("12", "暫離逾時");
map.put("14", "屆時清除");
map.put("13", "人工清除");
map.put("16", "換位");//換位後被清除的座位
map.put("17", "手機離館");

if(request.getParameter("gk")!=null){
	keyword = request.getParameter("gk");
}
else
{
	keyword="";
}	

boolean funck_new  = false;
boolean funck_edit = false;
boolean funck_del  = false;

if(session.getAttribute("ADMIN")!=null)
{
	funck_new=true;
	funck_edit=true;
	funck_del=true;
}

if(session.getAttribute("group")!=null)
{
	gid=session.getAttribute("group").toString();
	funck_new=rst2.AuthFunc(fid, fcid, gid, "4");
	funck_edit=rst2.AuthFunc(fid, fcid, gid, "2");
	funck_del=rst2.AuthFunc(fid, fcid, gid, "3");
}


int i=0;
int up=0;
//out.print("123");
try
{

	if((request.getParameter("gs") != null && request.getParameter("ge") != null) 
			&& !request.getParameter("ge").equals("") && !request.getParameter("gs").equals(""))
	{
		
		sdate = request.getParameter("gs");
		edate = request.getParameter("ge");
		
		stime = request.getParameter("gstime");
		etime = request.getParameter("getime");
		
		sdatetime = sdate+" "+stime;
		
		edatetime = edate+" "+etime;
		
		loc = request.getParameter("gl1");
		area = request.getParameter("gl");
		
		identify = request.getParameter("g2");
		status = request.getParameter("g3");
		
		rs = rst.getBookingLogBySearchRange(keyword,sdatetime,edatetime,area,identify,status,loc);	 
		url = "gs="+sdate+"&ge="+edate+"&gstime="+stime+"&getime="+etime+"&gk="+keyword+"&gl="
		      +area+"&gl1="+loc+"&g2="+identify+"&g3="+status+"";	
	}
	else
	{
		//rst.getBookingLogBySearchRange(keyword,sdate,edate,area,identify,status);	
		loc = request.getParameter("gl1");
		area = request.getParameter("gl");
		identify = request.getParameter("g2");
		status = request.getParameter("g3");
		rs = rst.getBookingLogBySearch(keyword,area,identify,status,loc); 
		url = "gk="+keyword+"&gl="+area+"&gl1="+loc+"&g2="+identify+"&g3="+status+"";	
		//out.print(url);
	}	
	
	up = rst.showCount();
    //out.print(up);
	int rs_row = 0;
	rst.SetPageinfo(up, 10);

	int prepi=0;//當前頁數

	if(request.getParameter("page")==null)
	{
		prepi = 1;
	}
	else
	{
		prepi = Integer.parseInt(request.getParameter("page"));
	}

	rst.setPagenumber(prepi);
	rst.gotoPage(prepi);
	
	String exportToExcel = request.getParameter("exportToExcel");
	
	 %>

<div id="srt">

	<a href="search_booking1.jsp?<%=url%>&exportToExcel=YES&type=excel">匯出Excel</a>
	<a href="search_booking1.jsp?<%=url%>&exportToExcel=YES&type=txt">匯出doc</a>
	 <!-- 
	 <a href="search_booking2.jsp?<%=url%>&exportToExcel=YES&type=excel" target="_blank">郵寄excel</a>
     <a href="search_booking2.jsp?<%=url%>&exportToExcel=YES&type=txt" target="_blank">郵寄doc</a>
     -->
<div>總查詢筆數 : <%=up %>筆</div>
    <div class="table">
        <div class="table-head">
        	<div class="column" data-label="序號">序號</div>
            <div class="column" data-label="讀者證">讀者證</div>
            <div class="column" data-label="姓名">姓名</div>
            <div class="column" data-label="身份">身份</div>
            <div class="column" data-label="座位">座位</div>
            <div class="column" data-label="異動狀態">異動狀態</div>
            <div class="column" data-label="異動時間">異動時間</div>
            <div class="column" data-label="異動時間">選位時間</div>
            <div class="column" data-label="出入細項">出入細項</div>
        </div>
        <%
        	rs.beforeFirst();
        while(rs.next())
        {
        	//rst1.getFunction(rst.showData("fid", i));
        	if(rs_row >= rst.showPagebegin() && rs_row < rst.showPageend())
	    	{
        %>
       	<div class="row">
        	<div class="column" data-label="序號"><%=i+1 %></div>
            <div class="column" data-label="讀者證"><%=rs.getString("reader_id") %></div>
            <div class="column" data-label="姓名"><%= rs.getString("reader_name") %></div>
            <div class="column" data-label="身份"><%=rs.getString("reader_kind") %></div>
            <div class="column" data-label="座位"><%
            String roomloczh ="";
			String roomlocen = "";
			try
			{
			rst1.getCodetabById(rs.getString("room_type"));
			roomloczh = rst1.showData("name_zh", 0);
			roomlocen = rst1.showData("name_en", 0);
			}catch(Exception e){} 
            //out.print(roomloczh+"("+roomlocen+")"+" "+ rs.getString("room_name"));
            out.print(roomloczh+" "+ rs.getString("room_name"));
            %></div>
            <div class="column" data-label="異動狀態"><%
            out.print(map.get(rs.getString("rev_status")));
             %></div>
            <div class="column" data-label="異動時間"><%=rs.getString("rev_act_datetime") %></div>
            <div class="column" data-label="選位時間"><%=rs.getString("rev_datetime") %></div>   
            <div class="column" data-label="出入細項">
            <input type="button" class="btn" value="出入細項" onclick="go_detial('<%=rs.getString("sysid") %>');">
            </div>         
          </div>
       <%
	    	}
        	rs_row++;
      	 	i++;
        }
    	rs.close();
       %>
          
       <div id="simpleConfirm" title="刪除暫停"></div>
       <div id="simpleedit"></div>
 </div>
 
 <!--分頁程式開始  -->
<div class="page">&nbsp;&nbsp;<a href="#" onclick="go_page('search_booking.jsp?page=1&gs=<%=sdate%>&ge=<%=edate%>&gstime=<%=stime %>&getime=<%=etime %>&gk=<%=URLEncoder.encode(keyword,"UTF-8")%>&g1=<%=area%>&g2=<%=identify%>&g3=<%=status%>&gl=<%=area%>&gl1=<%=loc%>');">第一頁</a>
	 <%
	 int pi;
	 int current=0;
	 current = prepi;	 
     if(prepi > 1 )
	 {
	%>
	&nbsp;&nbsp;<a href="#" onclick="go_page('search_booking.jsp?page=<%=prepi-1%>&gs=<%=sdate%>&ge=<%=edate%>&gstime=<%=stime %>&getime=<%=etime %>&gk=<%=URLEncoder.encode(keyword,"UTF-8")%>&g1=<%=area%>&g2=<%=identify%>&g3=<%=status%>&gl=<%=area%>&gl1=<%=loc%>');">上一頁</a>&nbsp;
	<%}%>
	&nbsp;&nbsp;&nbsp;
	<%
	

	int pi1=0;
	if(current >= 5)
	{
		pi1=current+5;
	}
	else
	{
		pi1=current+10;
	}	
	for (pi = ((current - 5) - 1); pi < pi1; pi++) 
	{
		if(pi >= 1 )
		{
			if(pi <= rst.showTotalpage())
			{
	%>
	<a href="#" onclick="go_page('search_booking.jsp?page=<%=pi%>&gs=<%=sdate%>&ge=<%=edate%>&gstime=<%=stime %>&getime=<%=etime %>&gk=<%=URLEncoder.encode(keyword,"UTF-8")%>&g1=<%=area%>&g2=<%=identify%>&g3=<%=status%>&gl=<%=area%>&gl1=<%=loc%>');"><font <%if(pi==current){out.print("color=gray size=5");} %>> <%=pi%></font></a>
	<%
    		}
		}
	}
    %>
    <%
    if(prepi < rst.showTotalpage()-1)
	{
%>
&nbsp;&nbsp;<a href="#" onclick="go_page('search_booking.jsp?page=<%=prepi+1%>&gs=<%=sdate%>&ge=<%=edate%>&gstime=<%=stime %>&getime=<%=etime %>&gk=<%=URLEncoder.encode(keyword,"UTF-8")%>&g1=<%=area%>&g2=<%=identify%>&g3=<%=status%>&gl=<%=area%>&gl1=<%=loc%>');">下一頁</a>
<%}%>
&nbsp;&nbsp;<a href="#" onclick="go_page('search_booking.jsp?page=<%=rst.showTotalpage()%>&gs=<%=sdate%>&gstime=<%=stime %>&getime=<%=etime %>&ge=<%=edate%>&gk=<%=URLEncoder.encode(keyword,"UTF-8")%>&g1=<%=area%>&g2=<%=identify%>&g3=<%=status%>&gl=<%=area%>&gl1=<%=loc%>');">最終頁</a>
</div>
<!--分頁程式結束  -->


<%
}catch(Exception e){
	//out.print(e);
}finally{
	rst.closeall();
	rst1.closeall();
	rst2.closeall();
	rst3.closeall();

}

}
%>
 </div>
</body>
</html>