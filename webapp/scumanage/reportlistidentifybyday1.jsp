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
<body>

<%
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
int dayofmonth = 0;
final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
LocalDate firstDate = null;
LocalDate secondDate = null;
try
{
	


	from = request.getParameter("from");
	to = request.getParameter("to");
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
if (exportToExcel != null
        && exportToExcel.toString().equalsIgnoreCase("YES")) {
	
	String fileName = "閱覽室身份別人次統計表"+param+"~"+param1+"月報" +from+"~"+to;
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
<h3><%=from %> ~<%=to %>日 <%=locname %>身份別人次統計表</h3>
  <table class="table">
  	<tr class="table-head">
            <th class="column" data-label="日期">日期</th>
            <th class="column" data-label="星期">星期</th>
           <%
           		rst1.getCodeTab(13);
           		int i2=0;
           		int up2 = rst1.showCount();
           		while(i2 < up2)
           		{	
           			
           %>
            <th class="column" data-label="<%=rst1.showData("name_zh", i2) %>"><%=rst1.showData("name_zh", i2) %></div>
           <%
           			i2++;
           		}	
           %>
            <th class="column" data-label="合計">合計</th>
            <th class="column" data-label="備註">備註</th>
     </tr>
      <%
     	i=0;
      for (LocalDate date = firstDate; date.isBefore(secondDate); date = date.plusDays(1)) {
     	  String datesplit[] =  date.toString().split("-");
          String y = datesplit[0];
          String m = datesplit[1];
          int day = Integer.parseInt(datesplit[2]);
      	  int dayweek = ul.getDayOfWeek(Integer.parseInt(y),Integer.parseInt(m),day);
     		%>
     		<tr class="row">
            <td class="column"><% out.print(m+"/"+ (datesplit[2])); %></td>
            <td class="column"><%
                out.print(ul.weekDay(dayweek,"zh")); %>
            </td>
            <%
            
            for(i1=0 ;i1 < map.size();i1++)
       		{
            	
       		%><td class="column"><%
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
            </td>
            <%
         		zone1=0;
       		}
            %><td class="column"><%= zone1_total %></td><td class="column"></td>
            </tr>
     		<%
     	
     		day_total += zone1;
     		zone1_total=0;
     		i++;
         
     	}	
     %>
      <tr class="row">
      <td class="column">總計</td>
       <td class="column"></td>
       <%
       for(int i3=0 ;i3 < map.size();i3++)
  		{		
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
        		     day_total = rst2.countMonthTotalByDay(yy1, Integer.toString(mm1),map.get(i3) ,from,yesterday,location); 
        		     rst2.closeall();
                }catch(Exception e){
                	day_total=0;
                }
       			total += day_total;
       	%>		
      <td class="column"><%= day_total%></td>
      <%
        	}
      %>
      <td class="column"><%=total %></td>
      </tr>
    </table>
<%
}catch(Exception e){}finally{
	ul.closeall();
	rst1.closeall();
	   rst.closeall();
	//rst.closeall();
}

}
%>

</body>
</html>
