<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ page
	import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title></title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" type="text/css" href="style.css">
<script src="assets/plugins/jquery.loading.block.js"></script>
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
				funck_search = rst.AuthFunc(fid, fcid, gid, "");

			}

			if (funck_search) {
	%>

	<section id="content" class="column-center">
		<div id="search">
			<form class="pure-form">
				<fieldset>
					<legend>24小時申請人次統計表</legend>
					from: <input type="text" id="gf" value="" /> 
					to: <input type="text" id="gt" value="" /> 
					證號/姓名: <input type="text" id="gk" value="" /> <input
						type="button" name="send" id="send_search" class="formbutton btn"
						value="確定" />
				</fieldset>
			</form>
			<br>
			<hr>
			<br>
		</div>


	</section>
	<script type="text/javascript">
		$.datetimepicker.setLocale('zh-TW');
		$('#gf').datetimepicker({
			timepicker : false,
			format : 'Y-m-d'
		});

		$('#gt').datetimepicker({
			timepicker : false,
			format : 'Y-m-d'
		});

		$("#send_search").click(function(event) {
			$(function() {
				$.loadingBlockShow({
					imgPath : 'assets/img/default.svg',
					text : '統計資料處理中 Loading ...',
					style : {
						position : 'fixed',
						width : '100%',
						height : '100%',
						background : 'rgba(0, 0, 0, .8)',
						left : 0,
						top : 0,
						zIndex : 10000
					}
				});

			});
			event.preventDefault();
		
			var d = document.getElementById("gk").value;
				e = document.getElementById("gf").value;
			    f = document.getElementById("gt").value;
			
			$.post("reportlist24applybyday.jsp", {
				gs : e,
				ge : f,
				gk : d
			}).done(function(data) {
				//alert(data);
				setTimeout($.loadingBlockHide, 3000);
				$("#middle1").html(data);

			});

		});
	</script>
	<div id="middle1"></div>
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
	<div id="simpleConfirm" title="session timeout"></div>
</body>
</html>
