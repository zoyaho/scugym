<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*,wisoft.*"%>
	<%
	ReserveData rst = new ReserveData();
		try {
		
				String account = request.getParameter("account");
				String password = request.getParameter("password");
				session.setAttribute("account", account);
				session.setAttribute("password", password);
				SCUAuthenticate scuauthenticate = new SCUAuthenticate();
				//String result = scuauthenticate.checkSOAPAuth("http://163.14.3.116/portal/webservice/SsoService.asmx", account, password);
				String result = scuauthenticate.checkSOAPAuth("http://www.ecampus.scu.edu.tw/portal/webservice/SsoService.asmx", account, password);
				
				//result = "true";
				System.out.println("sso="+result);
				if(result.equals("false") || result.trim().equals(""))
				{
					String rs = rst.getReaderByAcctPw(account,password); 
					out.print(rs);
					
				}	
				else
				{
					out.print(result);
				}	
			
       
			
		} catch (Exception e) {

		} finally {
		rst.closeall();
		}
	%>
