<%@ page language="java" import="java.sql.*,wisoft.*"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.*"%>
<%@ page import="java.io.FileNotFoundException"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>

	<%
	String fistsheet = "";
	String secondsheet = "";
		if (session.getAttribute("loginOK") == "OK") {

			CaseData cst = new CaseData();
			try {
				String file = request.getParameter("filename");
				String uploadPath = getServletContext().getInitParameter("recordpath");
				String fileName = uploadPath + file; //testExcel.xls Excel File name
				//Read an Excel File and Store in a ArrayList
				fistsheet = cst.readExcelFile(fileName, 0);
				secondsheet = cst.readExcelFile(fileName, 1);
				
				//String rs1[] = fistsheet.split("/");
				//String rs2[] = secondsheet.split("/");
				
			} catch (Exception e) {
			} finally {
				cst.closeall();
			}
			out.print("OK:" + fistsheet +":"+secondsheet);
		}
	%>
