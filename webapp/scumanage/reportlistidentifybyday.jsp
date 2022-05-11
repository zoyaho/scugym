<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*,java.net.*"%>
<%@ page import="java.time.temporal.*,java.time.*,java.time.format.DateTimeFormatter,java.text.*" %>
<%@ page import="wisoft.*"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>登入使用紀錄管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body><%
if(session.getAttribute("loginOK")=="OK")
{

ReserveData rst1 = new ReserveData();

ReserveData rst = new ReserveData();
Utility ul = new Utility();
String type = request.getParameter("type");
String location =  request.getParameter("loc");
String param ="";
String param1 ="";
String from ="";
String to = "";
String url="";
int dayofmonth = 0;
final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
LocalDate firstDate = null;
LocalDate secondDate = null;
try{


	from = request.getParameter("from");
	to = request.getParameter("to");
	
	url="type="+type+"&from="+from+"&to="+to+"&loc="+location;
	firstDate = LocalDate.parse(from, formatter);
	secondDate = LocalDate.parse(to, formatter);
	final long days = ChronoUnit.DAYS.between(firstDate, secondDate); 
	//dayofmonth = ul.getDayofMonth( Integer.parseInt(param),Integer.parseInt(param1)-1);

int i=0;
int up=0;
//out.print(dayofmonth);
int zone1=0;
int zone2=0;
int zone3=0;
int zone4=0;
int zone5=0;
int zone6=0;
int zone7=0;
int zone8=0;
int day_total=0;
int zone1_total=0;
int zone2_total=0;
int zone3_total=0;
int zone4_total=0;
int zone5_total=0;
int zone6_total=0;
int zone7_total=0;
int zone8_total=0;
int total=0;
String locname="";

HashMap<Integer, String> map = new HashMap<Integer, String>();

rst1.getCodeTab(13);
	int i1=0;
	int up1 = rst1.showCount();
	 while(i1 < up1)
		{
		 map.put(i1, rst1.showData("name_desc_zh", i1));
		 i1++;
		}

	String exportToExcel = request.getParameter("exportToExcel");
	    if (exportToExcel == null) {%>
	<a href="reportlistidentifybyday1.jsp?<%=url%>&exportToExcel=YES&type1=excel">匯出Excel</a>
	<a href="reportlistidentifybyday1.jsp?<%=url%>&exportToExcel=YES&type1=txt">匯出doc</a>
	<!-- 
	<a href="reportlistidentify2.jsp?<%=url%>&exportToExcel=YES&type1=excel" target="_blank">郵寄excel</a>
	<a href="reportlistidentify2.jsp.jsp?<%=url%>&exportToExcel=YES&type1=txt" target="_blank">郵寄doc</a>
	 -->
	<%}
	    if(!location.equals("0"))
	    {
	    	rst.getTab(Integer.parseInt(location));
	    	locname = rst.showData("name_zh", 0);
	    }
	    else
	    {
	    	locname="閱覽室";
	    }
	
	%>
	<h3><%=from %> ~<%=to %>日 <%=locname %>身份別人次統計表</h3>
  <div class="table">
  	<div class="table-head">
            <div class="column" data-label="日期">日期</div>
            <div class="column" data-label="星期">星期</div>
           <%
           		rst1.getCodeTab(13);
           		int i2=0;
           		int up2 = rst1.showCount();
           		while(i2 < up2){%>
            <div class="column" data-label="<%=rst1.showData("name_zh", i2) %>"><%=rst1.showData("name_zh", i2) %></div>
           <%i2++;}%>
            <div class="column" data-label="合計">合計</div>
            <div class="column" data-label="備註">備註</div>
     </div>
     <%
     	i=0;
     for (LocalDate date = firstDate; date.isBefore(secondDate); date = date.plusDays(1)) {
    	 String datesplit[] =  date.toString().split("-");
         String y = datesplit[0];
         String m = datesplit[1];
         int day = Integer.parseInt(datesplit[2]);
     	 int dayweek = ul.getDayOfWeek(Integer.parseInt(y),Integer.parseInt(m),day);
     		%>
     		<div class="row">
            <div class="column"><% out.print(m+"/"+ (datesplit[2])); %></div>
            <div class="column"><%
            	out.print(ul.weekDay(dayweek,"zh")); %>
            </div>
            <%
            
            for(i1=0 ;i1 < map.size();i1++)
       		{
            	
       		%><div class="column"><%
            try
            {
            	
            	zone1 = rst.countIdentifylogin(Integer.parseInt(y), m,(day), map.get(i1),location );
           
            }catch(Exception e){
            	//out.print(e);
            	zone1 = 0;
            }
        	out.print(zone1);
        	zone1_total += zone1;
            %>
            </div>
            <%
         		zone1=0;
       		}
            %><div class="column"><%= zone1_total %></div><div class="column"></div>
            </div>
     		<%
     		
     		day_total += zone1;
     		zone1_total=0;
     		i++;
         
     	}	
     %>
      <div class="row">
      <div class="column">總計</div>
       <div class="column"></div>
       <%
   	    for(int i3=0 ;i3 < map.size();i3++)
  		{	
        	day_total = 0;
        	try
             {
       			 ReserveData rst2 = new ReserveData();
       			 String datesplit1[] =  to.split("-");
       	         int yy1 = Integer.parseInt(datesplit1[0]);
       	         int mm1 = Integer.parseInt(datesplit1[1]);
       	         int d1 = Integer.parseInt(datesplit1[2]);
       			 
       	         Calendar cal = Calendar.getInstance();
       			 cal.set(yy1, mm1-1, d1);
       		     cal.add(Calendar.DATE, -1);
       		     String yesterday = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
       		     //System.out.println(yesterday);
     		     day_total = rst2.countMonthTotalByDay(yy1,Integer.toString(mm1),map.get(i3) ,from,yesterday,location); 
     		     rst2.closeall();
     		 }
       		 catch(Exception e){
       			day_total = 0;
       		 }
       	     total += day_total;
       	   %>		
           <div class="column"><%= day_total%></div>
           <%
           
            
         		}%>
      <div class="column"><%=total %></div>
      </div>
    </div><%

}catch(Exception e){
	out.print(e);
}finally{
	ul.closeall();
	rst1.closeall();
	 rst.closeall();
	//rst.closeall();
}

}
%>
</body>
</html>
