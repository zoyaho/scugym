<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*"  %>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*,wisoft.*"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<%
int have_thisyear = 0;
int i = 0 ;
%>
<body>	
<table>
<tr>
<td>請選擇查詢姓名/卡號: </td>
<td>
	<input type="text" id="gk" name="gk" ></input>
	<%
		ReserveData rst = new ReserveData();
		rst.getCodeTab(8);
		int up = rst.showCount();
		
	%>
	<select id="gloc" name="gloc">
		<option value="0">請選擇區域</option>
		<%
		while(i < up){
			%>
			<option value="<%=rst.showData("seq", i) %>"><%=rst.showData("name_zh", i) %></option>
			<% 
			i++;
		}
		rst.closeall();
		%>
	</select>
	開始日期:
	<input type="text" id="gs"></input>
	結束日期:
	<input type="text" id="ge"></input>	
<input type="button" name="send" id="send_search" class="formbutton btn" value="搜尋" />
</td>
</tr>

</table>
<div id="jerry"></div>
<script>
$.datetimepicker.setLocale('zh-TW');
$('#gs').datetimepicker({
	dayOfWeekStart : 1,
	defaultTime:'00:00',
	format:'Y-m-d H:i',
	timepickerScrollbar:true
});


$('#ge').datetimepicker({
	dayOfWeekStart : 1,
	defaultTime:'00:00',
	format:'Y-m-d H:i',
	timepickerScrollbar:true
	});

	

$("#send_search").click(function(event){
	event.preventDefault();
	var a = document.getElementById("gs").value;
	var b = document.getElementById("ge").value;
	var c = document.getElementById("gloc").value;
	var url;
	var f = "";
	//alert(a);
					
					if (a != '' && b == '') {
						alert("起訖日期輸入錯誤");
					}

					if (a == '' && b != '') {
						alert("起訖日期輸入錯誤");
					}
					
					if( c=='0')
					{
						alert("請選擇場域");
					}
					
					if (a != '' && b != '' && c !='0') {
						var a1 = a.split(" ");
						var b1 = b.split(" ");
						
							f = encodeURIComponent(document.getElementById("gk").value);
							url = "staff_p_list.jsp?gs=" + a1[0] + "&gstime="
									+ a1[1] + "&ge=" + b1[0] + "&getime="
									+ b1[1] + "&gk=" + f.trim()+"&gloc="+c;
							 //alert(url);
						
					}
					else
					{
							f = encodeURIComponent(document.getElementById("gk").value);
						
							url = "staff_p_list.jsp?gs=&gstime=&ge=&getime="+ "&gk=" + f.trim()+"&gloc="+c;
	                        //alert(url);
					}	
					
					$("#jerry").load(url, function() {

					});



				});
	</script>



</body>

</html>

