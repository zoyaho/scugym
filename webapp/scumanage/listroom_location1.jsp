<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>
<select id="gl" class="pop4font">
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
<script type="text/javascript">
	$("#gl").change(function() {
		//alert($(this).val());
		$("#gpoint").load("point.jsp?lid=" + $(this).val());

	});
</script>

<%
	rstarea.closeall();
		rst.closeall();
	}
%>
