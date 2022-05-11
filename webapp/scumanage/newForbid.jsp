<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>  

<%
if(session.getAttribute("loginOK")=="OK")
{
	String seq = request.getParameter("id");
	ReserveData rst = new ReserveData();
	ReserveData rst1 = new ReserveData();
	rst.getForbidByID(seq);
	String fid = "";
	String fcid = "";
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();
%>
 	
<div id="popup4">
    <span class="cross4">X</span><br><br>
    <fieldset>
	<label>讀者證號</label>
	<input type="text" id="g1" class="pop4font" value="<%=rst.showData("reader_id", 0) %>" /><br><br>
	<label>讀者姓名</label>
	<input type="text" id="g2" class="pop4font" value="<%=rst.showData("name", 0) %>" /><br><br>
	<label>讀者身份</label>
	<select id="g3" class="pop4font">
	<%
	rst1.getCodeSub("13");
	int i =0;
	int up = rst1.showCount();
	String ck="";
	while(i < up){
		if(rst.showData("usertype", 0).indexOf(rst1.showData("name_zh", i)) != -1)
		{
			ck="checked";
		}	
		else
		{
			ck="";
		}	
	%>
	<option value="<%=rst1.showData("name_zh", i) %>" <%=ck %>><%=rst1.showData("name_zh", i) %></option>
	<%	
		i++;
	}
	%>
	</select>
	<br><br>
	<table>
	<tr>
	<td>
	<label>開始日期時間</label><br>
	<input type="text" id="g4" class="pop4font" value="<%=rst.showData("start_date", 0) %>" />
	</td>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td>
	<label>結束日期時間</label><br>
	<input type="text" id="g5" class="pop4font" value="<%=rst.showData("end_date", 0) %>" />
	</td>
	</tr>
	</table>
	<br>
	<label>註記</label>
	<input type="text" id="g6" class="pop4font" value="<%=rst.showData("reason", 0) %>" /><br><br>
	<label>備註</label>
	<textarea id="g7" class="pop4font"><%=rst.showData("note", 0) %></textarea><br><br>
	
	</fieldset><br><br>
   
    <span class="goquestion4" ><a href="#" class="btn" onclick="add_edit('<%=seq%>','10');">確定</a></span>
    <span class="closebutton4"><a href="#" class="btn" >取消</a></span>
   
  
</div>
<script type='text/javascript'> // 網頁底端浮動視窗的js語法


$(function(){
	$("#popup4").draggable();
	$("#popup4").fadeIn('fast');
	
	$(".cross4").click(function(){
		
   		$("#popup4").fadeOut('fast');
   		go_tab('forbid.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	
	$(".closebutton4").click(function(){
   		$("#popup4").fadeOut('fast');
   		
   		go_tab('forbid.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	$(".goquestion4").click(function(){
   	    $("#popup4").fadeOut('fast');
   	
	})
});

</script>
<script type="text/javascript">
	/*
	var dt = new Date();
	var y = dt.getFullYear();
	var Month = dt.getMonth();
	var date = dt.getDate();
	Month =checkTime(Month+1);
	var h = dt.getHours();
	var m = dt.getMinutes();
	var s = dt.getSeconds();
	m = checkTime(m);
	s = checkTime(s);

	var today = y+"-"+Month+"-"+date+" "+h+":"+m;*/
	
	//alert(today);
	$('#g4').datetimepicker({
		dayOfWeekStart : 1,
		lang:'zh-TW',
		timepickerScrollbar:false,
		closeOnDateSelect:true
	});
	$('#g4').datetimepicker({step:10});
	
	$('#g5').datetimepicker({
		dayOfWeekStart : 1,
		lang:'',
		timepickerScrollbar:false,
		closeOnDateSelect:true
		});
	$('#g5').datetimepicker({step:10});
</script>
<%
rst.closeall();
rst1.closeall();

}
%>