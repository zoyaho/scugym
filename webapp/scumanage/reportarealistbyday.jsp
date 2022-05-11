<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*,java.net.*"%>
<%@ page import="java.time.temporal.*,java.time.*,java.time.format.DateTimeFormatter" %>
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
Utility ul = new Utility();
String type = request.getParameter("type");
String location =  request.getParameter("loc");
String param ="";
String param1 ="";
String from ="";
String to = "";
String url="";
final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
LocalDate firstDate = null;
LocalDate secondDate = null;
try
{

int dayofmonth = 0;

	from = request.getParameter("from");
	to = request.getParameter("to");
	
	url="type="+type+"&from="+from+"&to="+to+"&loc="+location;
	firstDate = LocalDate.parse(from, formatter);
	secondDate = LocalDate.parse(to, formatter);
	final long days = ChronoUnit.DAYS.between(firstDate, secondDate); 
	//dayofmonth = ul.getDayofMonth( Integer.parseInt(param),Integer.parseInt(param1)-1);

int i=0;
//out.print(dayofmonth);
int zone1=0;
int zone2=0;
int zone3=0;
int zone4=0;
int zone5=0;
int zone6=0;
int zone7=0;
int zone8=0;
int zone9=0;
int zone10=0;
int zone11=0;

int day_total=0;
int zone1_total=0;
int zone2_total=0;
int zone3_total=0;
int zone4_total=0;
int zone5_total=0;
int zone6_total=0;
int zone7_total=0;
int zone8_total=0;
int zone9_total=0;
int zone10_total=0;
int zone11_total=0;
int total=0;

String locname="";

String exportToExcel = request.getParameter("exportToExcel");
	
	    if (exportToExcel == null) {
	%>
	<a href="reportarealistbyday1.jsp?<%=url%>&exportToExcel=YES&type1=excel">匯出Excel</a>
	<a href="reportarealistbyday1.jsp?<%=url%>&exportToExcel=YES&type1=txt">匯出doc</a>
	<!-- <a href="reportarealist2.jsp?<%=url%>&exportToExcel=YES&type1=excel" target="_blank">郵寄excel</a>
	<a href="reportarealist2.jsp?<%=url%>&exportToExcel=YES&type1=txt" target="_blank">郵寄doc</a> -->
	<%
	    }
	    
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

<h3><%=from %>～<%=to %>日 <%=locname %>座位區域人次統計表</h3>
  <div class="table">
  	<div class="table-head">
            <div class="column" data-label="日期">日期</div>
            <div class="column" data-label="星期">星期</div>
            <%
            if(location.equals("20"))
            {	
            %>
            <div class="column" data-label="">第一閱覽室/區域A</div>
            <div class="column" data-label="">第一閱覽室/區域B</div>
            <div class="column" data-label="">第一閱覽室/區域C</div>
            <div class="column" data-label="合計">合計</div>
     
            <%
            }
            else if(location.equals("52"))
            {
            	%>
              <div class="column" data-label="第二閱讀區/區域A">第二閱/區域A</div>
            <div class="column" data-label="第二閱讀區/區域B1">第二閱/區域B1</div>
            <div class="column" data-label="第二閱讀區/區域B2">第二閱/區域B2</div>
            <div class="column" data-label="第二閱讀區/區域B3">第二閱/區域B3</div>
            <div class="column" data-label="第二閱讀區/區域B4">第二閱/區域B4</div>
            <div class="column" data-label="第二閱讀區/區域C">第二閱/區域C</div>
             <div class="column" data-label="合計">合計</div>
            	<%
            }
            else
            {
            	%>
             <div class="column" data-label="">第一閱覽室/區域A</div>
            <div class="column" data-label="">第一閱覽室/區域B</div>
            <div class="column" data-label="">第一閱覽室/區域C</div>
            <div class="column" data-label="合計">合計</div>
              <div class="column" data-label="第二閱讀區/區域A">第二閱/區域A</div>
            <div class="column" data-label="第二閱讀區/區域B1">第二閱/區域B1</div>
            <div class="column" data-label="第二閱讀區/區域B2">第二閱/區域B2</div>
            <div class="column" data-label="第二閱讀區/區域B3">第二閱/區域B3</div>
            <div class="column" data-label="第二閱讀區/區域B4">第二閱/區域B4</div>
            <div class="column" data-label="第二閱讀區/區域C">第二閱/區域C</div>
             <div class="column" data-label="合計">合計</div>
            	<%
            }	
            %>            
            
            <div class="column" data-label="備註">備註</div>
     </div>
     <%
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
     		if(location.equals("20"))
             {	
     		%>
     			<div class="column">
           		<%
            		zone1 = rst.countarealogin(Integer.parseInt(y), m,(day),"3","20");//A區
            		out.print(zone1);
            		zone1_total += zone1;
            	%>
            	</div>
            	<div class="column"><%
            		zone2 = rst.countarealogin(Integer.parseInt(y), m,(day),"4","20");//B區
            		out.print(zone2);
            		zone2_total += zone2;
            	%>
            	</div>
           	 	<div class="column"><%
            		zone3 = rst.countarealogin(Integer.parseInt(y), m,(day),"2","20");//C區
            		out.print(zone3);
            		zone3_total += zone3;
            	%>
            	</div>
            	
            	<div class="column"><%
            		day_total = (zone1+zone2+zone3);
            		out.print(day_total);
            		%>
           	 	</div>
           	 
           	 	<%
             }
     		 else if(location.equals("52"))
     		 { 
           	 	%>
           	 	<div class="column"><%
            		zone4 = rst.countarealogin(Integer.parseInt(y), m,(day),"3","52");//A
            		out.print(zone4);
            		zone4_total += zone4;
            	%>
            	</div>
            	<div class="column"><%
            		zone5 = rst.countarealogin(Integer.parseInt(y), m,(day),"61","52");//B1
            		out.print(zone5);
            		zone5_total += zone5;
            	%>
            	</div>
            	<div class="column"><%
            		zone6 = rst.countarealogin(Integer.parseInt(y), m,(day),"62","52");//B2
            		out.print(zone6);
            		zone6_total += zone6;
            	%>
            	</div>
            	<div class="column"><%
            		zone7 = rst.countarealogin(Integer.parseInt(y), m,(day),"63","52");//B3
            		out.print(zone7);
            		zone7_total += zone7;
            	%>
            	</div>
            	<div class="column"><%
            		zone8 = rst.countarealogin(Integer.parseInt(y), m,(day),"70","52");//B4
            		out.print(zone8);
            		zone8_total += zone8;
            	%>
            	</div>
            	<div class="column"><%
            		zone9 = rst.countarealogin(Integer.parseInt(y), m,(day),"71","52");//C
            		out.print(zone9);
            		zone9_total += zone9;
            	%>
            	</div>
            	<div class="column"><%
            		day_total = (zone4+zone5+zone6+zone7+zone8+zone9);
            		out.print(day_total);
            		%>
           	 	</div>
            	<div class="column"></div>
      
     		<%
     		 }
     		 else
     		 {
     			%>
     			<div class="column">
           		<%
            		zone1 = rst.countarealogin(Integer.parseInt(y), m,(day),"3","20");//A區
            		out.print(zone1);
            		zone1_total += zone1;
            	%>
            	</div>
            	<div class="column"><%
            		zone2 = rst.countarealogin(Integer.parseInt(y), m,(day),"4","20");//B區
            		out.print(zone2);
            		zone2_total += zone2;
            	%>
            	</div>
           	 	<div class="column"><%
            		zone3 = rst.countarealogin(Integer.parseInt(y), m,(day),"2","20");//C區
            		out.print(zone3);
            		zone3_total += zone3;
            	%>
            	</div>
            	
            	<div class="column"><%
            		day_total = (zone1+zone2+zone3);
            		out.print(day_total);
            		%>
           	 	</div>
           	 	<div class="column"><%
            		zone4 = rst.countarealogin(Integer.parseInt(y), m,(day),"3","52");//A
            		out.print(zone4);
            		zone4_total += zone4;
            	%>
            	</div>
            	<div class="column"><%
            		zone5 = rst.countarealogin(Integer.parseInt(y), m,(day),"61","52");//B1
            		out.print(zone5);
            		zone5_total += zone5;
            	%>
            	</div>
            	<div class="column"><%
            		zone6 = rst.countarealogin(Integer.parseInt(y), m,(day),"62","52");//B2
            		out.print(zone6);
            		zone6_total += zone6;
            	%>
            	</div>
            	<div class="column"><%
            		zone7 = rst.countarealogin(Integer.parseInt(y), m,(day),"63","52");//B3
            		out.print(zone7);
            		zone7_total += zone7;
            	%>
            	</div>
            	<div class="column"><%
            		zone8 = rst.countarealogin(Integer.parseInt(y), m,(day),"70","52");//B4
            		out.print(zone8);
            		zone8_total += zone8;
            	%>
            	</div>
            	<div class="column"><%
            		zone9 = rst.countarealogin(Integer.parseInt(y), m,(day),"71","52");//C
            		out.print(zone9);
            		zone9_total += zone9;
            	%>
            	</div>
            	
            	<div class="column"><%
            		day_total = (zone4+zone5+zone6+zone7+zone8+zone9);
            		out.print(day_total);
            		%>
           	 	</div>
            	<div class="column"></div>
          
     			<% 
     		 }	 
     		 %>
     		 </div>
     		 <%
     	
     		i++;
     		
     		 zone1=0;
     		 zone2=0;
     		 zone3=0;
     		zone4=0;
     		zone5=0;
     		zone6=0;
     		zone7=0;
     		zone8=0;
     		zone9=0;
     	
     		
     	}	
     
     %>
      <div class="row">
      <div class="column">總計 </div>
       <div class="column"></div>
       <%
       if(location.equals("20"))
       {
    	   %>
    	      <div class="column"><%=zone1_total %></div>
    	      <div class="column"><%=zone2_total %></div>
    	      <div class="column"><%=zone3_total %></div>
    	      <div class="column"><% total = zone1_total+zone2_total+zone3_total; out.print(total); %></div>
    	     <%
       } 
       else if(location.equals("52")){
    	   %>
    	   <div class="column"><%=zone4_total %></div>
           <div class="column"><%=zone5_total %></div>
             <div class="column"><%=zone6_total %></div>
              <div class="column"><%=zone7_total %></div>
               <div class="column"><%=zone8_total %></div>
                <div class="column"><%=zone9_total %></div>
                
         <div class="column"><% total = zone4_total+zone5_total+zone6_total+zone7_total+zone8_total+zone9_total;
         out.print(total);
         	%></div>
         	
        <%
       }
       else
       { 
       %>
      <div class="column"><%=zone1_total %></div>
      <div class="column"><%=zone2_total %></div>
      <div class="column"><%=zone3_total %></div>
      <div class="column">小計 : <% total = zone1_total+zone2_total+zone3_total; out.print(total); %></div>
       <div class="column"><%=zone4_total %></div>
        <div class="column"><%=zone5_total %></div>
          <div class="column"><%=zone6_total %></div>
           <div class="column"><%=zone7_total %></div>
            <div class="column"><%=zone8_total %></div>
             <div class="column"><%=zone9_total %></div>
             
      <div class="column"> 小計 :<% total = zone4_total+zone5_total+zone6_total+zone7_total+zone8_total+zone9_total;
      out.print(total);
      	%></div>
      	 <div class="column"><% int totalall = zone1_total+zone2_total+zone3_total+zone4_total
      	 +zone5_total+zone6_total+zone7_total+zone8_total+zone9_total;
      out.print(totalall);
      	%></div>
      	<%
       }
      	%>
      </div>
  </div>
<%
}catch(Exception e){}finally{
	ul.closeall();
	rst.closeall();
}

}
%>

</body>
</html>
