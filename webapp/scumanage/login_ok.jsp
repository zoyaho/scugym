<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,java.sql.*,java.io.*,wisoft.*"%>  
<%
ReserveData rst = new ReserveData();
Utility util = new Utility();

String ip=request.getHeader("X-Forwarded-For");
//out.println(ip);
if (ip == null || ip.length() == 0)
{
	ip=request.getHeader("Proxy-Client-IP");
}
if (ip == null || ip.length() == 0)
{
	ip=request.getHeader("WL-Proxy-Client-IP");
}
if (ip == null || ip.length() == 0)
{
	ip=request.getRemoteAddr();
}
//out.println(ip);

try
{    
	IP_Util uip = new IP_Util();
	boolean true_ip = uip.getLeagle_ip(ip);
	//out.println(true_ip);
	if(true_ip==false)
	{

		String username = request.getParameter("username");
		String pass = request.getParameter("password");

		//out.print(uip.getLeagle_ip(ip));


		//check the legal user
		
			boolean flag = rst.checkuser(username,util.bin2hex(pass));
		    rst.getUser(username, util.bin2hex(pass));
		    
			if(flag)
			{	
				session.setAttribute("user", username);
				session.setAttribute("pass", util.bin2hex(pass));
				
				if(username.equals("admin"))
				{	
					session.setAttribute("ADMIN", "admin");
				}
				else
				{
					session.setAttribute("group", rst.showData("gid", 0));
				}	
				session.setAttribute("loginOK", "OK");
				out.print("OK");
			}
			else
			{
				out.print("NO");
			}	
		
	}
	else
	{
		out.print("NOIP");
	}	
}catch(Exception e){
	
}finally{
	rst.closeall();
	util.closeall();
}

%>

