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
String keyword = request.getParameter("gk");
String sdate = "";
String edate = "";
String by ="";
int i=0;
int up=0;
String arry[] = {"查詢","新增","修改","刪除"};
//out.print("123");
try
{
	if(request.getParameter("by").equals(""))
	{
		by="0";
	}	
	else 
	{
		by=request.getParameter("by");
	}	 
	
	//out.print(by);
	
	if((request.getParameter("gs") != null && request.getParameter("ge") != null) &&
			(!request.getParameter("gs").equals("") && !request.getParameter("ge").equals("")))
	{
		
		sdate = request.getParameter("gs");
		edate = request.getParameter("ge");
		rst.getUseBySearchRange(keyword,sdate,edate,by);	
	 		
	}
	else
	{
		rst.getUseBySearch(keyword,by);
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
<article>
    <div class="table">
        <div class="table-head">
            <div class="column" data-label="功能">功能</div>
            <div class="column" data-label="帳號">帳號</div>
            <div class="column" data-label="使用狀態">使用狀態</div>
            <div class="column" data-label="使用日期">使用日期</div>
        </div>
        <%
        	
        while(i<up)
        {
        	rst1.getFunction(rst.showData("fid", i));
        	if(rs_row >= rst.showPagebegin() && rs_row < rst.showPageend())
	    	{
        %>
        <div class="row">
            <div class="column" data-label="功能"><%=rst1.showData("func_name", 0) %></div>
            <div class="column" data-label="帳號"><%=rst.showData("user", i) %></div>
            <div class="column" data-label="使用狀態"><%=arry[Integer.parseInt(rst.showData("status", i))] %></div>
            <div class="column" data-label="使用日期"><%=rst.showData("create_date", i) %></div>
        </div>
       <%
	    	}
        	rs_row++;
      	 	i++;
        }
       %>
       
    </div>
</article>
<!--分頁程式開始  -->
<div class="page">

    &nbsp;&nbsp;<a href="#" onclick="go_page('search_result.jsp?page=1&gk=<%=keyword%>&gs=<%=sdate%>&ge=<%=edate%>&by=<%=by%>');">第一頁</a>
	 <%
		if(prepi > 1 )
		{
	%>
	&nbsp;&nbsp;<a href="#" onclick="go_page('search_result.jsp?page=<%=prepi-1%>&gk=<%=URLEncoder.encode(keyword,"UTF-8")%>&gs=<%=sdate%>&ge=<%=edate%>&by=<%=by%>');">上一頁</a>&nbsp;
	<%}%>
	&nbsp;&nbsp;&nbsp;
	<%
	int pi=0;

    while(pi<rst.showTotalpage())
    {


	%>
	<a href="#" onclick="go_page('search_result.jsp?page=<%=pi+1%>&gk=<%=URLEncoder.encode(keyword,"UTF-8")%>&gs=<%=sdate%>&ge=<%=edate%>&by=<%=by%>');"><font <%if(pi+1==prepi){out.print("color=gray size=5");} %>> <%=pi+1%></font></a>
	<%
		pi++;
	}
    %>
    <%
		if(prepi<rst.showTotalpage())
		{
	%>
	&nbsp;&nbsp;<a href="#" onclick="go_page('search_result.jsp?page=<%=prepi+1%>&gk=<%=URLEncoder.encode(keyword,"UTF-8")%>&gs=<%=sdate%>&ge=<%=edate%>&by=<%=by%>');">下一頁</a>
	<%}%>
	&nbsp;&nbsp;<a href="#" onclick="go_page('search_result.jsp?page=<%=rst.showTotalpage()%>&gk=<%=URLEncoder.encode(keyword,"UTF-8")%>&gs=<%=sdate%>&ge=<%=edate%>&by=<%=by%>');">最終頁</a>
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
