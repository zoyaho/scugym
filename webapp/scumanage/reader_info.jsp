<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ page
	import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>讀者資料檔管理</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
</head>
<body>
	<%
	
	if(session.getAttribute("loginOK")=="OK")
	{
		ReserveData rst = new ReserveData();
		ReserveData rst1 = new ReserveData();
		//ReserveData rstroom = new ReserveData();

		boolean funck_search = false;
		String admin = "";
		String gid = "";

		String fid = "";
		String fcid = "";

		int i = 0;
		int up = 0;

		if (request.getParameter("fid") != null && request.getParameter("fcid") != null) {
			fid = request.getParameter("fid");
			fcid = request.getParameter("fcid");

			session.setAttribute("fid", fid);
			session.setAttribute("fcid", fcid);
		} else {
			fid = session.getAttribute("fid").toString();
			fcid = session.getAttribute("fcid").toString();
		}

		boolean funck_new = false;
		boolean funck_edit = false;
		boolean funck_del = false;

		String location = "0";
		if (session.getAttribute("ADMIN") != null) {
			funck_search = true;
			location = "0";
		}

		if (session.getAttribute("group") != null) {
			gid = session.getAttribute("group").toString();
			funck_search = rst.AuthFunc(fid, fcid, gid, "1");
			//location = session.getAttribute("location").toString();
		}

		if (funck_search) {
	%>
	<script type="text/javascript">
$.datetimepicker.setLocale('zh-TW');


$('#gs').datetimepicker({
	closeOnDateSelect:true,
	 timepicker:false,
	 format:'Y-m-d'
});



$('#ge').datetimepicker({
	closeOnDateSelect:true,
	 timepicker:false,
	 format:'Y-m-d'
});
</script>

	<section id="content" class="column-center">
		<div id="search">
			<form class="pure-form">
				<fieldset>
					<legend>使用者資料檔</legend>
					<br> 
					<label for="開始日期">開始日期:</label> 
					<input type="text" name="sdate" id="gs" class="pop4font" value="" /> 
					<label for="結束日期">結束日期:</label> 
					<input type="text" name="edate" id="ge" class="pop4font" value="" /> 
					<label for="keyword">關鍵字:</label> 
					<input type="text" name="keyword" id="gk" value="" /><br>
					<br> 
					<input type="button" name="send" id="send_search" class="formbutton btn" value="搜尋" /> 
					<input type="button" class="btn" value="新增使用者" onclick="go_log('<%=fid%>','1');edit_news('1','newReader.jsp');">

				</fieldset>
			</form>
		</div>
	</section>
	<script type="text/javascript">
  $("#send_search").click(function(event){
	  go_log('<%=fid%>', '0');
					event.preventDefault();
					var a = $("#gs").val();
					var b = $("#ge").val();
					var c = $("#gk").val();
				

					if (a != '' && b == '') {
						alert("起訖日期輸入錯誤");
					} else if (a == '' && b != '') {
						alert("起訖日期輸入錯誤");
					} else if (a != '' && b != '') {
						//alert("listreader.jsp?gs=" + a + "&ge=" + b + "&gk="+ c);
						$("#middle1").load("listreader.jsp?gs=" + a + "&ge=" + b + "&gk="+ encodeURIComponent(c.trim()) );
					} else if (a == '' && b == '') {
						//alert("booking.jsp?gk="+c+"&gl="+d+"&gu="+e+"&gr="+f);
						$("#middle1").load(
								"listreader.jsp?gk=" + encodeURIComponent(c.trim()) );
					}

				});
	</script>
	<div id="middle1">
		<jsp:include page="listreader.jsp">
			<jsp:param name="fid" value="<%=fid%>" />
			<jsp:param name="fcid" value="<%=fcid%>" />
			<jsp:param name="gk" value="" />
		</jsp:include>
	</div>
	<%
		rst.closeall();
			rst1.closeall();
		}
		
	}
	%>
</body>
</html>
