<%@ page contentType="text/html; charset=UTF-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ page
	import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>群組管理</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
</head>
<body>
	<%
		if (session.getAttribute("loginOK") == "OK") {

			ReserveData rst = new ReserveData();
			ReserveData rst1 = new ReserveData();
			ReserveData rst2 = new ReserveData();

			String fid = "";
			String fcid = "";

			fid = request.getParameter("fid");
			fcid = request.getParameter("fcid");

			session.setAttribute("fid", fid);
			session.setAttribute("fcid", fcid);

			String admin = "";
			String gid = "";

			boolean funck_new = false;
			boolean funck_edit = false;
			boolean funck_del = false;
			boolean funck_search = false;

			if (session.getAttribute("ADMIN") != null) {
				funck_new = true;
				funck_edit = true;
				funck_del = true;
				funck_search = true;
			}

			if (session.getAttribute("group") != null) {
				gid = session.getAttribute("group").toString();
				funck_new = rst2.AuthFunc(fid, fcid, gid, "4");
				funck_edit = rst2.AuthFunc(fid, fcid, gid, "2");
				funck_del = rst2.AuthFunc(fid, fcid, gid, "3");
				funck_search = true;
			}

			int i = 0;
			int up = 0;

			if (funck_search) {
	%>

	<script>
		 
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
					<legend>查尋違規紀錄 </legend>
					<br> <label for="起始日期">違規日期(起):</label> 
					<input type="text" name="sdate" id="gs" class="pop4font" value="" /> 
					<label for="結束日期">違規日期(迄):</label> 
					<input type="text" name="edate" id="ge" class="pop4font" value="" /> 
					<select id="gl1">
						<option value='0'>請選擇</option>
						<%
							i = 0;
									rst.getCodeTab(8);
									up = rst.showCount();
									while (i < up) {
						%>
						<option value="<%=rst.showData("seq", i)%>"><%=rst.showData("name_zh", i)%></option>
						<%
							i++;
									}
						%>
					</select>
					<div id="selroom1" style="display: inline;"></div>

					<div id="gpoint" style="display: inline;"></div>
                    <label for="keyword">關鍵字:</label>
					<input type="text" name="keyword" id="gk" value="" />
					<input type="button" name="send" id="send_search"
						class="formbutton btn" value="搜尋" />
					<%
						if (funck_new) {
					%>
					<input type="button" class="btn" value="新增違規"
						onclick="go_log('<%=fid%>','1');edit_news('0','newPoint.jsp');">
					<%
						}
					%>
				</fieldset>
			</form>
			<br>
			<hr>
			<br>
		</div>
	</section>
	<div id="middle1">
		<jsp:include page="list_point.jsp"></jsp:include>
	</div>
	<script type="text/javascript">

  var point;
  

  $('#gl1').on('change', function() { 

  	b = this.value;
  	$("#selroom1").show();
  	$( "#selroom1" ).load("listroom_location1.jsp?loc="+b);
  });

  
  $("#send_search").click(function(event){
	    go_log('<%=fid%>', '0');
					event.preventDefault();
					var a = document.getElementById("gs").value;
					var b = document.getElementById("ge").value;
					var c = document.getElementById("gk").value;
					var d = "0";
					var e = "0";
					var f = "0";

					//alert(d);
					if (a == '' && b == '' && c == '') {
						alert("請輸入搜尋條件");
					}
                    
					if (a == '' && b == '' && c != '') {
						//alert("list_point.jsp?gk="+c+"&gv="+d+"&gl="+e);
						
					 try{
							 e = document.getElementById("gl").value;
							 f = document.getElementById("gl1").value;
							  d = document.getElementById("gv").value;
								 
					 }catch(e){}
						$("#middle1").load("list_point.jsp?gk="
												+ encodeURIComponent(c)
												+ "&gv=" + d + "&gl=" + e
												+ "&gl1=" + f);
					}

					if (a != '' && b != '') {
						try {
							 
							 d = document.getElementById("gv").value;
							 e = document.getElementById("gl").value;
							 f = document.getElementById("gl1").value;

						
						} catch (e) {
						}
						$("#middle1").load("list_point.jsp?gs=" + a + "&ge=" + b
								+ "&gk=" + encodeURIComponent(c)
								+ "&gv=" + d + "&gl=" + e + "&gl1="
								+ f);
					}

				});
	</script>



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
			rst2.closeall();
			rst1.closeall();
			rst.closeall();

		}
	%>
	<div id="simpleConfirm" title="session time out"></div>

</body>
</html>
