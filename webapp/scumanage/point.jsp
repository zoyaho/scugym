<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>     
<%
if(session.getAttribute("loginOK")=="OK")
{

int i=0;
int up=0;
String lid = request.getParameter("lid");
if(request.getParameter("lid")==null)
{
	lid="";
}	
else
{
	lid = request.getParameter("lid");
}	
ReserveData rst = new ReserveData();
%>
<select id="gv">
    <option value='0'>請選擇</option>
    <%
    	i=0;
    	rst.getCodeTab2(17,lid);
		up = rst.showCount();
		while(i < up)
		{
						
		%>
		<option value="<%=rst.showData("seq", i) %>"><%=rst.showData("name_zh", i) %></option>
		<%
								
				i++;
		}	
    	%>
</select>

<%
rst.closeall();

}
%>