<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>     
<!-- for查詢使用的下拉房間 -->
<select id="g3" class="pop4font">
<option value="0">請選擇</option>
<%

ReserveData rst = new ReserveData();

try
{
String loc = request.getParameter("loc");

	rst.getRoomByLoc(loc);	
	
int i=0;
int up = rst.showCount();
while(i < up)
{

%>
<option value="<%=rst.showData("sysid", i) %>"><%=rst.showData("room_name", i) %></option>
<%	
	i++;	
}
}catch(Exception e){}
rst.closeall();
%>
</select>

