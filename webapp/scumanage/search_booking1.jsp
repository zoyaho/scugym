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
try
{
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
String url="";

HashMap<String, String> map = new HashMap<String, String>();


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
map.put("16", "換位");
map.put("17", "手機離館");
if(request.getParameter("gk")!=null){
	keyword = request.getParameter("gk");
}
else
{
	keyword="";
}	



int i=0;
int up=0;


	//out.print(request.getParameter("gs"));
	//out.print(request.getParameter("gstime"));
	//out.print(request.getParameter("ge"));
	//out.print(request.getParameter("getime"));
	
	
	if((request.getParameter("gs") != null && request.getParameter("ge") != null))
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
			
	}
	else
	{
		//rst.getBookingLogBySearchRange(keyword,sdate,edate,area,identify,status);	
		loc = request.getParameter("gl1");
		area = request.getParameter("gl");
		identify = request.getParameter("g2");
		status = request.getParameter("g3");
		rs = rst.getBookingLogBySearch(keyword,area,identify,status,loc); 
		
	}	
	
	up = rst.showCount();
	String exportToExcel = request.getParameter("exportToExcel");
	if (exportToExcel != null
	        && exportToExcel.toString().equalsIgnoreCase("YES")) {
		
		String fileName = "讀者使用紀錄";
		String e8 = URLEncoder.encode(fileName, "UTF8");
		if(request.getParameter("type").equals("excel"))
		{
			response.setContentType("application/vnd.ms-excel");
		    response.setHeader("Content-Disposition", "inline; filename="+e8+".xls");
		}	
		else if(request.getParameter("type").equals("txt"))
		{
		    response.setContentType("application/msword" );
		    response.setHeader("Content-Disposition", "attachment;filename="+e8+".doc" );
	      
		}	
		
	}
	
	%>

<div id="srt">

    <table>
        	<tr>
        	<th class="column" data-label="序號">序號</th>
            <th class="column" data-label="讀者證">讀者證</th>
            <th class="column" data-label="姓名">姓名</th>
            <th class="column" data-label="身份">身份</th>
            <th class="column" data-label="座位">座位</th>
            <th class="column" data-label="異動狀態">異動狀態</th>
            <th class="column" data-label="異動時間">異動時間</th>
            <th class="column" data-label="選位時間">選位時間</th>
            </tr>
        <%
        rs.beforeFirst();
        while(rs.next())
        {
        	//rst1.getFunction(rst.showData("fid", i));
        	
        %>
       	<tr>
        	<td class="column" data-label="序號"><%=i+1 %></td>
            <td class="column" data-label="讀者證"><%=rs.getString("reader_id")  %></td>
            <td class="column" data-label="姓名"><%= rs.getString("reader_name") %></td>
            <td class="column" data-label="身份"><%=rs.getString("reader_kind") %></td>
            <td class="column" data-label="座位"><%
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
            %></td>
            <td class="column" data-label="異動狀態"><%
            out.print(map.get(rs.getString("rev_status")));
             %></td>
            <td class="column" data-label="異動時間"><%=rs.getString("rev_act_datetime") %></td>
            <td class="column" data-label="選位時間"><%=rs.getString("rev_datetime")%></td>            
        </tr>
       <%
	    	
        	
      	 	i++;
        }
        rs.close();
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
          
      
 </table>



 </div>
</body>
</html>