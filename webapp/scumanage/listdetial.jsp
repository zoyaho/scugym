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
	<div id="popup1">
		<span class="cross1">X</span><br>
		<br>
		<article>
		<div class="table">
				<div class="table-head">
					<div class="column" data-label="序號">序號</div>
					<div class="column" data-label="進出執行">進出執行</div>
					<div class="column" data-label="進出時間">進出時間</div>
					<div class="column" data-label="區域">區域</div>

				</div>
		<%
			//if (session.getAttribute("loginOK") == "OK") {

				ReserveData rst = new ReserveData();
				ReserveData rst1 = new ReserveData();
				getData gdt = new getData();
				getData gdt1 = new getData();
				String inout_status = "";
				
				String sysid = request.getParameter("id");
				gdt1.init("rev_booking");
				gdt1.queryMe("sysid = '"+sysid+"'");
				String loc = gdt1.showData("room_type", 0);
				String area = gdt1.showData("room_codeid", 0);
				rst.getCodetabById(loc);
				rst1.getCodetabById(area);
				
        	    gdt.init("door_record");
				gdt.queryMe("do_type = '4'  and sysid between '"+gdt1.showData("rev_datetime",0).replaceAll("-","").replaceAll(":","").replaceAll(" ","")+"000' and '"+gdt1.showData("rev_act_datetime",0).replaceAll("-","").replaceAll(":","").replaceAll(" ","")+"999' and left(queuesysid,6) = '"+gdt1.showData("card_id",0).substring(0,6)+"' and queuesysid not like '%_0803%' order by sysid desc");
				//out.print(gdt.showCount());
				int i =0;
				int up= 0;
				
				
				if(gdt.showCount()>0){
					while(i < gdt.showCount())
					{
						//out.print(gdt.showData("do_inout",i)+"/"+gdt.showData("do_station",i)+"/"+gdt.showData("queuesysid",i)+"/"+gdt.showData("sysid",i).substring(8,10)+":"+gdt.showData("sysid",i).substring(10,12)+":"+gdt.showData("sysid",i).substring(12,14)+"/"+gdt.showData("do_ip",i)+"<BR>");
						
						%>
						<div class="row">
						<div class="column" data-label="序號"><%=i + 1%></div>
					<div class="column" data-label="進出執行"><%
					String inout = gdt.showData("do_inout",i);
					switch(inout){
					case "IN" :
						out.print("刷入");
						break;
					case "OUT" :
						out.print("刷出");	
					    break;
					default:
						out.print("");
						break;
					}
					%></div>
					<div class="column" data-label="進出時間"><%=gdt.showData("sysid",i).substring(8,10)+":"+gdt.showData("sysid",i).substring(10,12)+":"+gdt.showData("sysid",i).substring(12,14)%></div>
					<div class="column" data-label="區域"><%=rst.showData("name_zh", 0) %>/ <%=rst1.showData("name_zh", 0)%></div>
						
						</div>
						<%
						i++;
					}
					
				}else{
					out.print("No Records");
				}
				//out.print(inout_status);
					
	     %>
		</div>	
</article>	
	</div>

	<%
			rst1.closeall();
			rst.closeall();
			gdt.closeall();
			gdt1.closeall();
		//}
	%>

	<script type='text/javascript'>
		// 網頁底端浮動視窗的js語法

		$(function() {
			$("#popup1").draggable();
			$("#popup1").fadeIn('fast');
			$(".cross1").click(function() {
				$("#popup1").fadeOut('fast');
			})

		});
	</script>
	</body>
</html>
