<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ page
	import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>暫停使用名單維護管理</title>
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
try{
			fid = request.getParameter("fid");
			fcid = request.getParameter("fcid");

			session.setAttribute("fid", fid);
			session.setAttribute("fcid", fcid);

			boolean funck_new = false;
			boolean funck_edit = false;
			boolean funck_del = false;

			if (session.getAttribute("ADMIN") != null) {
				funck_search = true;

			}

			if (session.getAttribute("group") != null) {
				gid = session.getAttribute("group").toString();
				funck_search = rst.AuthFunc(fid, fcid, gid, "1");

			}

			if (funck_search) {
	%>

	<script>
		 
$.datetimepicker.setLocale('zh-TW');
$('#gs').datetimepicker({
	 timepicker:false,
	 format:'Y-m-d'
});

$('#ge').datetimepicker({
	 timepicker:false,
	 format:'Y-m-d'
});
 		 
 		
 		 
  </script>

	<section id="content" class="column-center">
		<div id="search">
			<form class="pure-form">
				<fieldset>
					<legend>查尋停用使用者紀錄 </legend>
					<br> <label for="起始日期">開始日期:</label> <input type="text"
						name="sdate" id="gs" value="" /> <label for="結束日期">結束日期:</label> <input
						type="text" name="edate" id="ge" value="" /> <label for="keyword">關鍵字:</label>
					<input type="text" name="keyword" id="gk" value="" /><br>
					<br> <input type="button" name="send" id="send_search"
						class="formbutton btn" value="搜尋" /> <input type="button"
						class="btn" value="新增停用"
						onclick="go_log('<%=fid%>','1');edit_news('0','newForbid.jsp');">


				</fieldset>
			</form>
			<br>
			<hr>
			<br>
		</div>


	</section>
	<script type="text/javascript">
  $("#send_search").click(function(event){
	    go_log('<%=fid%>', '0');
							event.preventDefault();
							var a = document.getElementById("gs").value;
							var b = document.getElementById("ge").value;
							var c = encodeURIComponent(document
									.getElementById("gk").value);
							//alert(c);
							if (a == '' && b == '' && c == '') {
								alert("請輸入搜尋條件");
							}

							if (a == '' && b == '' && c != '') {

								$("#middle1").load("search_forbid.jsp?gk=" + c);
							}

							if (a != '' && b == '') {
								alert("起訖日期輸入錯誤");
							}

							if (a == '' && b != '') {
								alert("起訖日期輸入錯誤");
							}

							if (a != '' && b != '') {
								$("#middle1").load(
										"search_forbid.jsp?gs=" + a + "&ge="
												+ b + "&gk=" + c);
							}

						});
	</script>
	<div id="middle1">
		<jsp:include page="search_forbid.jsp">
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
}catch(Exception e){}finally{
			rst.closeall();
}
		}
	%>
	<div id="simpleConfirm" title="無使用權限"></div>
</body>
</html>
