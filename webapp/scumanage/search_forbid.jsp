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

String sessionnow = (String)session.getId();

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
String keyword="";
keyword = request.getParameter("gk");
String sdate = "";
String edate = "";
String by ="";
int i=0;
int up=0;
//out.print("123");
try
{
	if((request.getParameter("gs") != null && request.getParameter("ge") != null) &&
			(!request.getParameter("gs").equals("") && !request.getParameter("ge").equals("")))
	{
		
		sdate = request.getParameter("gs");
		edate = request.getParameter("ge");
		rst.getForbidBySearchRange(keyword,sdate,edate);	
	 		
	}
	else
	{
		if(request.getParameter("gk")==null || request.getParameter("gk").equals(""))
		{
			rst.getForbid("0", "");
		}
		else
		{
			rst.getForbidBySearch(keyword);
		}	
		
	}	
	
	up = rst.showCount();

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
	
	
%>
<div id="srt">

    <div class="table">
        <div class="table-head">
        	<div class="column" data-label="序號">序號</div>
            <div class="column" data-label="讀者證">讀者證</div>
            <div class="column" data-label="姓名">姓名</div>
            <div class="column" data-label="身份">身份</div>
            <div class="column" data-label="起迄日期">起迄日期</div>
            <div class="column" data-label="註記">註記</div>
            <div class="column" data-label="備註">備註</div>
            <div class="column" data-label=""></div>
            
        </div>
        <%
        	
        while(i<up)
        {
        	rst1.getFunction(rst.showData("fid", i));
        	if(rs_row >= rst.showPagebegin() && rs_row < rst.showPageend())
	    	{
        %>
        <div class="row">
        	<div class="column" data-label="序號"><%=i+1 %></div>
            <div class="column" data-label="讀者證"><%=rst.showData("reader_id", i) %></div>
            <div class="column" data-label="姓名"><%= rst.showData("name", i) %></div>
            <div class="column" data-label="身份"><%=rst.showData("usertype", i) %></div>
            <div class="column" data-label="起迄日期"><%=rst.showData("start_date", i) %>~<%=rst.showData("end_date", i) %></div>
            <div class="column" data-label="註記"><%=rst.showData("reason", i) %></div>
            <div class="column" data-label="備註"><%=rst.showData("note", i) %></div>
           <%
       	if(funck_edit)
    	{
           %>
            <input type="button"  value="修改停用" class="btn" onclick="go_log('<%=fid %>','2');edit_news('<%=rst.showData("sysid", i) %>','newForbid.jsp');">
		<%
    	}
		%>
		   <%
       	if(funck_del)
    	{
           %>
			<input type="button"  value="刪除停用" class="btn" onclick="go_log('<%=fid %>','3');del_group('<%=rst.showData("sysid", i) %>','9');">
		    <%
    	}
		    %>
		    </div>
     
       <%
	    	}
        	rs_row++;
      	 	i++;
        }
       %>
          </div>
       <div id="simpleConfirm" title="刪除停用"></div>
  
 
<!--分頁程式開始  -->
<div class="page">

    &nbsp;&nbsp;<a href="#" onclick="go_page('search_forbid.jsp?page=1&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>');">第一頁</a>
	 <%
		if(prepi > 1 )
		{
	%>
	&nbsp;&nbsp;<a href="#" onclick="go_page('search_forbid.jsp?page=<%=prepi-1%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>');">上一頁</a>&nbsp;
	<%}%>
	&nbsp;&nbsp;&nbsp;
	<%
	int pi=0;

    while(pi<rst.showTotalpage())
    {


	%>
	<a href="#" onclick="go_page('search_forbid.jsp?page=<%=pi+1%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>');"><font <%if(pi+1==prepi){out.print("color=gray size=5");} %>> <%=pi+1%></font></a>
	<%
		pi++;
	}
    %>
    <%
		if(prepi<rst.showTotalpage())
		{
	%>
	&nbsp;&nbsp;<a href="#" onclick="go_page('search_forbid.jsp?page=<%=prepi+1%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>');">下一頁</a>
	<%}%>
	&nbsp;&nbsp;<a href="#" onclick="go_page('search_forbid.jsp?page=<%=rst.showTotalpage()%>&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>');">最終頁</a>
</div>
<!--分頁程式結束  -->

<%
}catch(Exception e){
	//out.print(e);
}finally{
	rst.closeall();
	rst1.closeall();
	rst2.closeall();
}

}
%>
 </div>
</body>
</html>
