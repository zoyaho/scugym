<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ page
	import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>座位系統管理</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
</head>
<body>
	<%
		if (session.getAttribute("loginOK") == "OK") {

			ReserveData rst = new ReserveData();

			boolean funck_search = false;
			String admin = "";
			String gid = "";

			String fid = "";
			String fcid = "";

			if (request.getParameter("fid") != null && request.getParameter("fcid") != null) {
				fid = request.getParameter("fid");
				fcid = request.getParameter("fcid");

				session.setAttribute("fid", fid);
				session.setAttribute("fcid", fcid);
			} else {
				fid = session.getAttribute("fid").toString();
				fcid = session.getAttribute("fcid").toString();
			}

			if (session.getAttribute("ADMIN") != null) {
				funck_search = true;
			}

			if (session.getAttribute("group") != null) {
				gid = session.getAttribute("group").toString();
				funck_search = rst.AuthFunc(fid, fcid, gid, "1");

			}

			if (funck_search) {
	%>
	<div id="middle1">
		<jsp:include page="choselocation.jsp">
			<jsp:param name="fid" value="<%=fid%>" />
			<jsp:param name="fcid" value="<%=fcid%>" />
		</jsp:include>
	</div>
	<%
		} else {
	%>
	<script>
		$(function() {
			$("#simpleConfirm").dialog({
				modal : true,
				buttons : {
					Ok : function() {
						var url = "enter";
						$(location).attr('href', url);
					}
				}
			});
		});
	</script>
	<%
		}

			rst.closeall();

		}
	%>
	<div id="simpleConfirm" title="刪除座位"></div>
</body>
</html>
