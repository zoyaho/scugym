<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*"%>
<%
	if (session.getAttribute("loginOK") == "OK") {
		CaseData cst = new CaseData();
		String rt = "";
		try {
			String id = request.getParameter("id");
			rt = cst.saveLibrarian("0", id, "");

			cst.closeall();
		} catch (Exception e) {

		} finally {
			cst.closeall();
		}

		if (rt.equals("OK")) {
%>
<script>
	alert("新增完成");
	window.location.replace('index.jsp');
</script>
<%
	} else {
%>
<script>
	alert("已經卡號已存在");
	window.location.replace('index.jsp');
</script>
<%
	}
	}
%>