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
<body><%
if(session.getAttribute("loginOK")=="OK")
{


ReserveData rst1 = new ReserveData();
ReserveData rst = new ReserveData();
Utility ul = new Utility();
String type = request.getParameter("type");
String location =  request.getParameter("loc");
String param = request.getParameter("param");

try
{
int monthofyear = 12;
String url="";
url="type="+type+"&param="+param+"&loc="+location;
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
	
	String fileName = "身份別人次統計表"+param+"年報";
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
	<h3><%=param %>年 <%=locname %>身份別人次統計表</h3>
  <table class="table">
  	<tr class="table-head">
           <td class="column" data-label="月份">月份</td>
         <%
           		rst1.getCodeTab(13);
           		int i2=0;
           		int up2 = rst1.showCount();
           		while(i2 < up2)
           		{	
           			
           %>
            <td class="column" data-label="<%=rst1.showData("name_zh", i2) %>"><%=rst1.showData("name_zh", i2) %></td>
           <%
           			i2++;
           		}	
           %>
            <td class="column" data-label="合計">合計</td>
            <td class="column" data-label="備註">備註</td>
     </tr>
     <%
     	while(i < monthofyear)
     	{
     		
     		
     		%>
     		<tr class="row">
            <td class="column"><% out.print(param+"/"+ (i+1)); %></td>
            <%
            for(i1=0 ;i1 < map.size();i1++)
       		{	
       			
            %>
           <td class="column">
            <%
            try
            {
            	
            	zone1 = rst.countMonthTotal(Integer.parseInt(param),Integer.toString(i+1), map.get(i1),location );
              
            }catch(Exception e){
            	zone1 = 0;
            }	
            	out.print(zone1);
            	zone1_total += zone1;
            %>
            </td>
            <%
       		
            	zone1=0;
       		}
            %>
           
            <td class="column"><%=zone1_total %></td>
            <td class="column"></td>
       		 </tr>
     		<%
     		zone1_total=0;
     		i++;

		
     		
     	}	
     
     %>
      <tr class="row">
      <td class="column">總計</td>
     <%
     for(int i3=0 ;i3 < map.size();i3++)
		{		
       			try
                {
       				ReserveData rst2 = new ReserveData();
       			day_total = rst2.countYearTotal(Integer.parseInt(param), map.get(i3),location);
       			rst2.closeall();
                }catch(Exception e){
                	day_total = 0;
                }
       			
       			total += day_total;
       	%>		
      <td class="column"><%= day_total%></td>
      <%
      	
       		}
      %>
      <td class="column"><%=total%></td>
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
