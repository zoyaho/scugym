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
String exportToExcel = request.getParameter("exportToExcel");
if (exportToExcel != null
        && exportToExcel.toString().equalsIgnoreCase("YES")) {
	
	String fileName = "24小時申請人次統計表"+sdate+"-"+edate;
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
		
		rs = rst.get24ApplyBySearchRange(keyword,sdate,edate);
		url = "gs="+sdate+"&ge="+edate+"&gk="+keyword;	
	}
	else
	{
		//rst.getBookingLogBySearchRange(keyword,sdate,edate,area,identify,status);	
		rs = rst.get24ApplyBySearch(keyword); 
		url = "gk="+keyword;	
		//out.print(url);
	}	
	
	up = rs.getRow();
    //out.print(up);
	
	 %>

<div id="srt">

<h3>總查詢筆數 : <%=up %>筆</h3>
    <table>
       	<tr>
        	<th class="column" data-label="序號">序號</th>
            <th class="column" data-label="讀者證">讀者證</th>
            <th class="column" data-label="單位">單位</th>
            <th class="column" data-label="姓名">姓名</th>
            <th class="column" data-label="申請日期時間">申請日期時間</th>
          
        </tr>
        <%
        rs.beforeFirst();
        
        while(rs.next())
        {
        	
        	String cardid = rs.getString("cardid");
        	//out.print(cardid);
        	String applydate =  rs.getString("create_datetime");
        	rst1.getReaderByCard(cardid);
        
          %>
       	<tr class="row">
        	<td class="column" data-label="序號"><%=i+1 %></td>
            <td class="column" data-label="讀者證"><%=rst1.showData("uid", 0) %></td>
            <td class="column" data-label="單位"><% 
            if(rst1.showData("deaprt_1", 0).equals(""))
            {
            	if(rst1.showData("type", 0).equals("9001"))
            	{
            		out.print("校友");
            	}	
            	else if( rst1.showData("type", 0).equals("9002")){
            		out.print("推廣");
            	}
            }	
            else
            {
            	 out.print(rst1.showData("deaprt_1", 0));
            }	
            %></td>
            <td class="column" data-label="姓名"><%= rst1.showData("name", 0) %></td>
            <td class="column" data-label="申請日期時間"><%= applydate %></td>
                  
          </tr>
       <%
	     	
        }
        
        rs.close();
    
       %>
          
    
 </table>
 



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