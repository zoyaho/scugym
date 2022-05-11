<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*,wisoft.*"%>

<%
	if (session.getAttribute("loginOK") == "OK") {

		try {
%>

<div>
	<input type="text" id="g1" name="g1" value="F:\\scugym_sql_file_backup"
		disabled size="50px"><br>
	<br> <a href="#" onclick="go_backup();" class="btn">開始資料庫備份</a> <a
		href="#" onclick="go_backup1();" class="btn">開始系統備份</a>
</div>

<div id="s_backup"></div>

<%
	} catch (Exception e) {
		} finally {

		}
	}
%>