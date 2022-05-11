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
if (exportToExcel != null
        && exportToExcel.toString().equalsIgnoreCase("YES")) {
	
	String fileName = "閱覽室座位區域人次統計表"+param+"年報";
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

	 if(!location.equals("0"))
	    {
	    	rst.getTab(Integer.parseInt(location));
	    	locname = rst.showData("name_zh", 0);
	    }
	    else
	    {
	    	locname="閱覽室";
	    }	
}
%>
<h3><%=param %>年 <%=locname %>座位區域人次統計表</h3>
  <table class="table">
  	<tr class="table-head">
            <td class="column" data-label="月份">月份</td>
           <%
            if(location.equals("20"))
            {	
            %>
            <td class="column" data-label="">第一閱覽室/區域A</td>
            <td class="column" data-label="">第一閱覽室/區域B</td>
            <td class="column" data-label="">第一閱覽室/區域C</td>
            <td class="column" data-label="合計">合計</td>
     
            <%
            }
            else if(location.equals("52"))
            {
            	%>
              <td class="column" data-label="第二閱讀區/區域A">第二閱/區域A</td>
            <td class="column" data-label="第二閱讀區/區域B1">第二閱/區域B1</td>
            <td class="column" data-label="第二閱讀區/區域B2">第二閱/區域B2</td>
            <td class="column" data-label="第二閱讀區/區域B3">第二閱/區域B3</td>
            <td class="column" data-label="第二閱讀區/區域B4">第二閱/區域B4</td>
            <td class="column" data-label="第二閱讀區/區域C">第二閱/區域C</td>
             <td class="column" data-label="合計">合計</td>
            	<%
            }
            else
            {
            	%>
             <td class="column" data-label="">第一閱覽室/區域A</td>
            <td class="column" data-label="">第一閱覽室/區域B</td>
            <td class="column" data-label="">第一閱覽室/區域C</td>
            <td class="column" data-label="合計">合計</td>
              <td class="column" data-label="第二閱讀區/區域A">第二閱/區域A</td>
            <td class="column" data-label="第二閱讀區/區域B1">第二閱/區域B1</td>
            <td class="column" data-label="第二閱讀區/區域B2">第二閱/區域B2</td>
            <td class="column" data-label="第二閱讀區/區域B3">第二閱/區域B3</td>
            <td class="column" data-label="第二閱讀區/區域B4">第二閱/區域B4</td>
            <td class="column" data-label="第二閱讀區/區域C">第二閱/區域C</td>
             <td class="column" data-label="合計">合計</td>
            	<%
            }	
            %>            
            <td class="column" data-label="備註">備註</td>
     </tr>
     <%
     	while(i < monthofyear)
     	{
     		
     		%>
     		 <tr class="row">
            <td class="column"><% out.print(param+"/"+ (i+1)); %></td>
            
            <%
     		if(location.equals("20"))
             {	
     		%>
            <td class="column">
            <%
            	zone1 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "3","20");
            	out.print(zone1);
            	zone1_total += zone1; 
            %>
            </td>
            <td class="column"><%
            	zone2 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "4","20");
            	out.print(zone2);
            	zone2_total += zone2;
            %></td>
            <td class="column"><%
            	zone3 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "2","20");
            	out.print(zone3);
            	zone3_total += zone3;
            %></td>
            <td class="column"><%
            		day_total = (zone1+zone2+zone3);
            		out.print(day_total);
            		%>
           	 	</td>
           	 <%
             }
     		 else if(location.equals("52"))
     		 { 
           	 %>	
            <td class="column"><%
            	zone4 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "3","52");
            	out.print(zone4);
            	zone4_total += zone4;
            %></td>
            <td class="column"><%
            	zone5 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "61","52");
            	out.print(zone5);
            	zone5_total += zone5;
            %></td>
            <td class="column"><%
            	zone6 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "62","52");
            	out.print(zone6);
            	zone6_total += zone6;
            %></td>
            <td class="column"><%
            	zone7 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "63","52");
            	out.print(zone7);
            	zone7_total += zone7;
            %></td>
            <td class="column"><%
            	zone8 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "70","52");
            	out.print(zone8);
            	zone8_total += zone8;
            %></td>
            <td class="column"><%
            	zone9 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "71","52");
            	out.print(zone9);
            	zone9_total += zone9;
            %></td>
            <td class="column"><% 
            		day_total = (zone4+zone5+zone6+zone7+zone8+zone9);
            	out.print(day_total);
            %></td>
            <td class="column"></td>
       		<%
     		 }
     		 else
     		 {
     			 %>
     			<td class="column">
                <%
                	zone1 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "3","20");
                	out.print(zone1);
                	zone1_total += zone1; 
                %>
                </td>
                <td class="column"><%
                	zone2 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "4","20");
                	out.print(zone2);
                	zone2_total += zone2;
                %></td>
                <td class="column"><%
                	zone3 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "2","20");
                	out.print(zone3);
                	zone3_total += zone3;
                %></td>
                <td class="column"><%
                		day_total = (zone1+zone2+zone3);
                		out.print(day_total);
                		%>
               	 	</td>
               <td class="column"><%
            	zone4 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "3","52");
            	out.print(zone4);
            	zone4_total += zone4;
            %></td>
            <td class="column"><%
            	zone5 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "61","52");
            	out.print(zone5);
            	zone5_total += zone5;
            %></td>
            <td class="column"><%
            	zone6 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "62","52");
            	out.print(zone6);
            	zone6_total += zone6;
            %></td>
            <td class="column"><%
            	zone7 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "63","52");
            	out.print(zone7);
            	zone7_total += zone7;
            %></td>
            <td class="column"><%
            	zone8 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "70","52");
            	out.print(zone8);
            	zone8_total += zone8;
            %></td>
            <td class="column"><%
            	zone9 = rst.countarealoginYear(Integer.parseInt(param), Integer.toString(i+1), "71","52");
            	out.print(zone9);
            	zone9_total += zone9;
            %></td>
            <td class="column"><% 
            		day_total = (zone4+zone5+zone6+zone7+zone8+zone9);
            	out.print(day_total);
            %></td>	
            <td class="column"></td>
               	 	<%
     		 }
            %>
       		 </tr>
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
     <tr>
      <td> 總計 </td>
       <%
       if(location.equals("20"))
       {
    	   %>
    	      <td class="column"><%=zone1_total %></td>
    	      <td class="column"><%=zone2_total %></td>
    	      <td class="column"><%=zone3_total %></td>
    	      <td class="column"><% total = zone1_total+zone2_total+zone3_total; out.print(total); %></td>
    	     <%
       } 
       else if(location.equals("52")){
    	   %>
    	   <td class="column"><%=zone4_total %></td>
           <td class="column"><%=zone5_total %></td>
             <td class="column"><%=zone6_total %></td>
              <td class="column"><%=zone7_total %></td>
               <td class="column"><%=zone8_total %></td>
                <td class="column"><%=zone9_total %></td>
                
         <td class="column"><% total = zone4_total+zone5_total+zone6_total+zone7_total+zone8_total+zone9_total;
         out.print(total);
         	%></td>
         	
        <%
       }
       else
       { 
       %>
      <td class="column"><%=zone1_total %></td>
      <td class="column"><%=zone2_total %></td>
      <td class="column"><%=zone3_total %></td>
      <td class="column">小計 : <% total = zone1_total+zone2_total+zone3_total; out.print(total); %></td>
       <td class="column"><%=zone4_total %></td>
        <td class="column"><%=zone5_total %></td>
          <td class="column"><%=zone6_total %></td>
           <td class="column"><%=zone7_total %></td>
            <td class="column"><%=zone8_total %></td>
             <td class="column"><%=zone9_total %></td>
             
      <td class="column"> 小計 :<% total = zone4_total+zone5_total+zone6_total+zone7_total+zone8_total+zone9_total;
      out.print(total);
      	%></td>
      	 <td class="column"><% int totalall = zone1_total+zone2_total+zone3_total+zone4_total
      	 +zone5_total+zone6_total+zone7_total+zone8_total+zone9_total;
      out.print(totalall);
      	%></td>
      	<%
       }
      	%>
      </tr>
  </table>
<%
rst.closeall();
ul.closeall();

}
%>

</body>
</html>
