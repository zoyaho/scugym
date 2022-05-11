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

Utility ul = new Utility();
ReserveData rst = new ReserveData();
String type = request.getParameter("type");
String location =  request.getParameter("loc");
String param ="";
String param1 ="";
String from ="";
String to = "";
final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
LocalDate firstDate = null;
LocalDate secondDate = null;
int dayofmonth = 0;

	from = request.getParameter("from");
	to = request.getParameter("to");
	firstDate = LocalDate.parse(from, formatter);
    secondDate = LocalDate.parse(to, formatter);
	final long days = ChronoUnit.DAYS.between(firstDate, secondDate);
	
int i=0;
//out.print(dayofmonth);
int zone0=0;
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
int zone12=0;
int zone13=0;
int zone14=0;
int zone15=0;
int zone16=0;
int zone17=0;
int zone18=0;
int zone19=0;
int zone20=0;
int zone21=0;
int zone22=0;
int zone23=0;
int day_total=0;

int zone0_total=0;
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
int zone12_total=0;
int zone13_total=0;
int zone14_total=0;
int zone15_total=0;
int zone16_total=0;
int zone17_total=0;
int zone18_total=0;
int zone19_total=0;
int zone20_total=0;
int zone21_total=0;
int zone22_total=0;
int zone23_total=0;

int total=0;
String locname="";
String exportToExcel = request.getParameter("exportToExcel");
if (exportToExcel != null
        && exportToExcel.toString().equalsIgnoreCase("YES")) {
	
	String fileName = "閱覽室時段人次統計表"+param+"-"+param1+"日報" + from +"~"+to;
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
 <h3> <%=from %> ~ <%=to %>日 <%=locname %>時段人次統計表</h3>
  <table>
  	<tr>
            <th class="column" data-label="日期">日期</th>
            <th class="column" data-label="星期">星期</th>
            <th class="column" data-label="(0-1)">(0-1)</th>
            <th class="column" data-label="(1-2)">(1-2)</th>
            <th class="column" data-label="(2-3)">(2-3)</th>
            <th class="column" data-label="(3-4)">(3-4)</th>
            <th class="column" data-label="(4-5)">(4-5)</th>
            <th class="column" data-label="(5-6)">(5-6)</th>
            <th class="column" data-label="(6-7)">(6-7)</th>
            <th class="column" data-label="(7-8)">(7-8)</th>
            <th class="column" data-label="(8-9)">(8-9)</th>
            <th class="column" data-label="(9-10)">(9-10)</th>
            <th class="column" data-label="(10-11)">(10-11)</th>
            <th class="column" data-label="(11-12)">(11-12)</th>
            <th class="column" data-label="(12-13)">(12-13)</th>
            <th class="column" data-label="(13-14)">(13-14)</th>
            <th class="column" data-label="(14-15)">(14-15)</th>
            <th class="column" data-label="(15-16)">(15-16)</th>
            <th class="column" data-label="(16-17)">(16-17)</th>
            <th class="column" data-label="(17-18)">(17-18)</th>
            <th class="column" data-label="(18-19)">(18-19)</th>
            <th class="column" data-label="(19-20)">(19-20)</th>
            <th class="column" data-label="(20-21)">(20-21)</th>
            <th class="column" data-label="(21-22)">(21-22)</th>
            <th class="column" data-label="(22-23)">(22-23)</th>
            <th class="column" data-label="(23-24)">(23-24)</th>
            <th class="column" data-label="合計">合計</th>
            <th class="column" data-label="備註">備註</th>
     </tr>
     <%
     for (LocalDate date = firstDate; date.isBefore(secondDate); date = date.plusDays(1)) {
    	 String datesplit[] =  date.toString().split("-");
         String y = datesplit[0];
         String m = datesplit[1];
         int day = Integer.parseInt(datesplit[2]);
     	int dayweek = ul.getDayOfWeek(Integer.parseInt(y),Integer.parseInt(m),day);
     	
     		%>
     		 <tr>
            <td><% out.print(m+"/"+ (datesplit[2])); %></td>
            <td><%
            	out.print(ul.weekDay(dayweek,"zh")); %>
            </td>
            <td>
            <%
            	zone0 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day, "00:00-01:00",location);
            	out.print(zone0);
            	zone0_total += zone0;
            %>
            </td>
            <td>
            <%
            	zone1 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day, "01:00-02:00",location);
            	out.print(zone1);
            	zone1_total += zone1;
            %>
            </td>
            <td>
            <%
            	zone2 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day, "02:00-03:00",location);
            	out.print(zone2);
            	zone2_total += zone2;
            %>
            </td>
            <td>
            <%
            	zone3 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day, "03:00-04:00",location);
            	out.print(zone3);
            	zone3_total += zone3;
            %>
            </td>
            <td>
            <%
            	zone4 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day, "04:00-05:00",location);
            	out.print(zone4);
            	zone4_total += zone4;
            %>
            </td>
            <td><%
            	//zone2 = rst.countlogin(ul.getYear(), param,(i+1), "10:00-12:00");
            	zone5 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day, "05:00-06:00",location);
            	out.print(zone5);
            	zone5_total += zone5;
            %></td>
            <td><%
            	zone6 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day,  "06:00-07:00",location);
            	out.print(zone6);
            	zone6_total += zone6;
            	
            %></td>
            <td class="column"><%
            	zone7 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day,  "07:00-08:00",location);
            	out.print(zone7);
            	zone7_total += zone7;
            %></td>
            <td class="column"><%
            	zone8 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day,  "08:00-09:00",location);
            	out.print(zone8);
            	zone8_total += zone8;
            %></td>
            <td class="column"><%
            	zone9 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day, "09:00-10:00",location);
            	out.print(zone9);
            	zone9_total += zone9;
            %></td>
            <td class="column"><%
            	zone10 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day,  "10:00-11:00",location);
            	out.print(zone10);
            	zone10_total += zone10;
            %></td>
            <td class="column"><%
            	zone11 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day,  "11:00-12:00",location);
            	out.print(zone11);
            	zone11_total += zone11;
            %></td>
            <td class="column"><%
            	zone12 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day,  "12:00-13:00",location);
            	out.print(zone12);
            	zone12_total += zone12;
            %></td>
            <td class="column"><%
            	zone13 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day,  "13:00-14:00",location);
            	out.print(zone13);
            	zone13_total += zone13;
            %></td>
            <td class="column"><%
            	zone14 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day, "14:00-15:00",location);
            	out.print(zone14);
            	zone14_total += zone14;
            %></td>
            <td class="column"><%
            	zone15 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day, "15:00-16:00",location);
            	out.print(zone15);
            	zone15_total += zone15;
            %></td>
            <td class="column"><%
            	zone16 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day, "16:00-17:00",location);
            	out.print(zone16);
            	zone16_total += zone16;
            %></td>
            <td class="column"><%
            	zone17 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day,  "17:00-18:00",location);
            	out.print(zone17);
            	zone17_total += zone17;
            %></td>
            <td class="column"><%
            	zone18 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day,  "18:00-19:00",location);
            	out.print(zone18);
            	zone18_total += zone18;
            %></td>
            <td class="column"><%
            	zone19 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day,  "19:00-20:00",location);
            	out.print(zone19);
            	zone19_total += zone19;
            %></td>
            <td class="column"><%
            	zone20 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day,  "20:00-21:00",location);
            	out.print(zone20);
            	zone20_total += zone20;
            %></td>
            <td class="column"><%
            	zone21 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day,  "21:00-22:00",location);
            	out.print(zone21);
            	zone21_total += zone21;
            %></td>
            <td class="column"><%
            	zone22 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day,  "22:00-23:00",location);
            	out.print(zone22);
            	zone22_total += zone22;
            %></td>
            <td class="column"><%
            	zone23 = rst.countlogin(Integer.parseInt(datesplit[0]), datesplit[1],day, "23:00-24:00",location);
            	out.print(zone23);
            	zone23_total += zone23;
            %></td>
            
            <td class="column"><% 
            		day_total = (zone0+zone1+zone2+zone3+zone4+zone5+
            				zone6+zone7+zone8+zone9+zone10+zone11+zone12+zone13+zone14+zone15+zone16+
            				zone17+zone18+zone19+zone20+zone21+zone22+zone23);
            	out.print(day_total);
            %></td>
            <td class="column"></td>
       		 </tr>
     		<%
     		
     		i++;
     		 zone0=0;
     		 zone1=0;
     		 zone2=0;
     		 zone3=0;
     		 zone4=0;
     		 zone5=0;
     		 zone6=0;
     		 zone7=0;
     		 zone8=0;
     		 zone9=0;
     		 zone10=0;
     		 zone11=0;
     		 zone12=0;
     		 zone13=0;
     		 zone14=0;
     		 zone15=0;
     		 zone16=0;
     		 zone17=0;
     		 zone18=0;
     		 zone19=0;
     		 zone20=0;
     		 zone21=0;
     		 zone22=0;
     		 zone23=0;
     		
     	}	
     
     %>
      <tr class="row">
      <td class="column">總計</td>
      <td class="column"></td>
      <td class="column"><%=zone0_total %></td>
      <td class="column"><%=zone1_total %></td>
      <td class="column"><%=zone2_total %></td>
      <td class="column"><%=zone3_total %></td>
      <td class="column"><%=zone4_total %></td>
      <td class="column"><%=zone5_total %></td>
      <td class="column"><%=zone6_total %></td>
      <td class="column"><%=zone7_total %></td>
      <td class="column"><%=zone8_total %></td>
      <td class="column"><%=zone9_total %></td>
      <td class="column"><%=zone10_total %></td>
      <td class="column"><%=zone11_total %></td>
      <td class="column"><%=zone12_total %></td>
      <td class="column"><%=zone13_total %></td>
      <td class="column"><%=zone14_total %></td>
      <td class="column"><%=zone15_total %></td>
      <td class="column"><%=zone16_total %></td>
      <td class="column"><%=zone17_total %></td>
      <td class="column"><%=zone18_total %></td>
      <td class="column"><%=zone19_total %></td>
      <td class="column"><%=zone20_total %></td>
      <td class="column"><%=zone21_total %></td>
      <td class="column"><%=zone22_total %></td>
      <td class="column"><%=zone23_total %></td>
      
      
      <td class="column"><% total = zone0_total+zone1_total+zone2_total+zone3_total+
      zone4_total+zone5_total+zone6_total+zone7_total+zone8_total+
      zone9_total+zone10_total+zone11_total+zone12_total+zone13_total+
      zone14_total+zone15_total+zone16_total+zone17_total+zone18_total+
      zone19_total+zone20_total+zone21_total+zone22_total+zone23_total;
      out.print(total);
      	%></td>
      </tr>
  </table>
<%
rst.closeall();
ul.closeall();
}
%>

</body>
</html>
