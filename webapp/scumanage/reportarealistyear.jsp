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

Utility ul = new Utility();
ReserveData rst = new ReserveData();

String type = request.getParameter("type");
String location =  request.getParameter("loc");
String param = request.getParameter("param");
String url="";

url="type="+type+"&param="+param+"&loc="+location;

int monthofyear = 12;

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
int total=0;
String locname="";

String exportToExcel = request.getParameter("exportToExcel");
	
	    if (exportToExcel == null) {
	%>
	<a href="reportarealistyear1.jsp?<%=url%>&exportToExcel=YES&type1=excel">匯出Excel</a>
	<a href="reportarealistyear1.jsp?<%=url%>&exportToExcel=YES&type1=txt">匯出doc</a>
	<!-- 
	<a href="reportarealistyear2.jsp?<%=url%>&exportToExcel=YES&type1=excel" target="_blank">郵寄excel</a>
	<a href="reportarealistyear2.jsp?<%=url%>&exportToExcel=YES&type1=txt" target="_blank">郵寄doc</a>
	 -->
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
<h3><%=param %>年 <%=locname %>座位區域人次統計表</h3>
  <div class="table">
  	<div class="table-head">
            <div class="column" data-label="月份">月份</div>
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
     	while(i < monthofyear)
     	{
     		
     		
     		%>
     		 <div class="row">
            <div class="column"><% out.print(param+"/"+ (i+1)); %></div>
            
            <%
     		if(location.equals("20"))
             {	
     		%>
            <div class="column">
            <%
            	zone1 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "3","20");
            	out.print(zone1);
            	zone1_total += zone1; 
            %>
            </div>
            <div class="column"><%
            	zone2 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "4","20");
            	out.print(zone2);
            	zone2_total += zone2;
            %></div>
            <div class="column"><%
            	zone3 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "2","20");
            	out.print(zone3);
            	zone3_total += zone3;
            %></div>
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
            	zone4 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "3","52");
            	out.print(zone4);
            	zone4_total += zone4;
            %></div>
            <div class="column"><%
            	zone5 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "61","52");
            	out.print(zone5);
            	zone5_total += zone5;
            %></div>
            <div class="column"><%
            	zone6 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "62","52");
            	out.print(zone6);
            	zone6_total += zone6;
            %></div>
            <div class="column"><%
            	zone7 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "63","52");
            	out.print(zone7);
            	zone7_total += zone7;
            %></div>
            <div class="column"><%
            	zone8 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "70","52");
            	out.print(zone8);
            	zone8_total += zone8;
            %></div>
            <div class="column"><%
            	zone9 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "71","52");
            	out.print(zone9);
            	zone9_total += zone9;
            %></div>
            <div class="column"><% 
            		day_total = (zone4+zone5+zone6+zone7+zone8+zone9);
            	out.print(day_total);
            %></div>
            <div class="column"></div>
       		<%
     		 }
     		 else
     		 {
     			 %>
     			<div class="column">
                <%
                	zone1 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "3","20");
                	out.print(zone1);
                	zone1_total += zone1; 
                %>
                </div>
                <div class="column"><%
                	zone2 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "4","20");
                	out.print(zone2);
                	zone2_total += zone2;
                %></div>
                <div class="column"><%
                	zone3 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "2","20");
                	out.print(zone3);
                	zone3_total += zone3;
                %></div>
                <div class="column"><%
                		day_total = (zone1+zone2+zone3);
                		out.print(day_total);
                		%>
               	 	</div>
               <div class="column"><%
            	zone4 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "3","52");
            	out.print(zone4);
            	zone4_total += zone4;
            %></div>
            <div class="column"><%
            	zone5 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "61","52");
            	out.print(zone5);
            	zone5_total += zone5;
            %></div>
            <div class="column"><%
            	zone6 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "62","52");
            	out.print(zone6);
            	zone6_total += zone6;
            %></div>
            <div class="column"><%
            	zone7 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "63","52");
            	out.print(zone7);
            	zone7_total += zone7;
            %></div>
            <div class="column"><%
            	zone8 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "70","52");
            	out.print(zone8);
            	zone8_total += zone8;
            %></div>
            <div class="column"><%
            	zone9 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "71","52");
            	out.print(zone9);
            	zone9_total += zone9;
            %></div>
            <div class="column"><% 
            		day_total = (zone4+zone5+zone6+zone7+zone8+zone9);
            	out.print(day_total);
            %></div>	
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
rst.closeall();
ul.closeall();

}
%>

</body>
</html>
