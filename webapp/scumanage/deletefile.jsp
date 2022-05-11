<%@page import="java.io.*,java.util.*,wisoft.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("loginOK") == "OK") {

		String returnResult = "";
		String sourceFilePath = getServletContext().getInitParameter("recordpath");

		String newFileName = "";
		String sysid = "";

		//System.out.print(request.getParameter("file_to_be_deleted"));
		if (request.getParameter("file_to_be_deleted") == null) {
			newFileName = (String) session.getAttribute("filename");
		} else {
			newFileName = request.getParameter("file_to_be_deleted");
		}

		//System.out.print(sysid+"\\"+newFileName);
		String delfilepath = "";
		Utility util = new Utility();
		CaseData cst = new CaseData();

		try {
			//System.out.print("newFileName="+ sourceFilePath +sysid+"\\"+ newFileName);
			delfilepath = sourceFilePath + sysid + "\\" + newFileName;
			File file = new File(delfilepath);
			File file1 = new File(sourceFilePath + sysid);
			if (file.delete()) {
				//returnResult += "ok";
			} else {
				//System.out.println("Delete operation is failed.");
			}

			if (file1.isDirectory()) {
				String[] children = file1.list();
				for (int i = 0; i < children.length; i++) {
					util.deleteDir(new File(file1, children[i]));

				}
			}

			file1.delete();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			returnResult += "OK";
			cst.closeall();
			util.closeall();
		}

		//returnResult += "tmpfile="+ sourceFilePath + newFileName;

		out.clearBuffer();
		out.print(returnResult);

	}
%>