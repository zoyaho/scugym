<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>
<label>違規區域</label>
<br>
<br>
<select id="g9" class="pop4font">
	<option value='0'>請選擇</option>
	<%
		if (session.getAttribute("loginOK") == "OK") {

			ReserveData rst = new ReserveData();
			ReserveData rstarea = new ReserveData();
			String loc = request.getParameter("loc");
		
			rst.getLocarea(loc);

			int i = 0;
			int up = rst.showCount();
			i = 0;
			while (i < up) {
				rstarea.getCodetabById(rst.showData("area", i));
	%>
	<option value="<%=rstarea.showData("seq", 0)%>"><%=rstarea.showData("name_zh", 0)%></option>
	<%
		i++;

			}
	%>
</select>
<br>
<br>
<script type="text/javascript">
<!--
	$("#g9").on('change', function() {

		a = $("#g1").val();
		b = this.value;
		//alert(a);
		$("#selroom").show();
		$("#selroom").load("listroom_point.jsp?loc=" + a + "&area=" + b);

	});
//-->
</script>
<%
	rstarea.closeall();
		rst.closeall();
	}
%>
