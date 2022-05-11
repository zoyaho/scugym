<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,java.sql.*,java.io.*"%>  
<%
session.removeAttribute("user");
session.removeAttribute("pass");
session.removeAttribute("ADMIN");
session.removeAttribute("group");
session.removeAttribute("loginOK");
if(session!=null)
{
	session.invalidate();
}

out.print("OK");
%>
