<%@page import="java.io.*,java.util.*,wisoft.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
CaseData cst = new CaseData();
try
{
	String gid = request.getParameter("gid"); 
	cst.DelGroup(gid);

	out.print("OK");
	cst.closeall();
}catch(Exception e){
	//out.print(e);
	out.print("NO");
}finally{
	cst.closeall();
}

%>
