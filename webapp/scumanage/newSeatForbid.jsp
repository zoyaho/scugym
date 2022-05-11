<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>  

<%
if(session.getAttribute("loginOK")=="OK")
{

	String seq = request.getParameter("id");
	ReserveData rst = new ReserveData();
	ReserveData rst1 = new ReserveData();
	rst.getTempForbidById(seq);
	String fid = "";
	String fcid = "";
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();
%>
 	
<div id="popup4">
    <span class="cross4">X</span><br><br>
    <fieldset>
	<label>選擇身份別</label><br><br>
	<table>
	<tr>
	
	<%

	rst1.getCodeSub("13");
	int i =0;
	int up = rst1.showCount();
	String ck="";
	while(i<up)
	{	
		if(rst.showData("usertype", 0).indexOf(rst1.showData("name_zh", i)) != -1)
		{
			ck="checked";
		}	
		else
		{
			ck="";
		}	
	%>
	<td class="pop4width">
	<input type="checkbox" id="g1" name="g1" value="<%=rst1.showData("name_zh", i) %>" <%=ck %>/><%=rst1.showData("name_zh", i) %>
	</td>
	<%
		i++;
	}
	%>
	</tr>
	</table>
	<br><br>
	<table>
	<tr>
	<td>
	<label>開始日期時間</label><br>
	<input type="text" id="g2" class="pop4font" value="<%=rst.showData("start_date", 0) %>" />
	</td>
	<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td>
	<label>結束日期時間</label><br>
	<input type="text" id="g3" class="pop4font" value="<%=rst.showData("end_date", 0) %>" />
	</td>
	</tr>
	</table>
	<br>
	</fieldset><br><br>
   
    <span class="goquestion4" ><a href="#" class="btn" id='sure' onclick="add_edit('<%=seq%>','9');">確定</a></span>
    <span class="closebutton4"><a href="#" class="btn" >取消</a></span>
   
  
</div>
<script type='text/javascript'> // 網頁底端浮動視窗的js語法


$(function(){
	$("#popup4").draggable();
	$("#popup4").fadeIn('fast');
	
	$(".cross4").click(function(){
		
   		$("#popup4").fadeOut('fast');
   		
	})
	
	$(".closebutton4").click(function(){
   		$("#popup4").fadeOut('fast');
   		
   		
	})
	$(".goquestion4").click(function(){
   	    $("#popup4").fadeOut('fast');
   	 	
	})
});

</script>
<script type="text/javascript">
	$.datetimepicker.setLocale('zh-TW');
	$('#g2').datetimepicker({
		dayOfWeekStart : 1,
		step:10,
		timepickerScrollbar:false,
		closeOnDateSelect:true,
		format : 'Y-m-d H:i'
	});
	
	$('#g3').datetimepicker({
		dayOfWeekStart : 1,
		step:10,
		timepickerScrollbar:false,
		closeOnDateSelect:true,
		format : 'Y-m-d H:i'
		});
	
	
	$('#g3').change(function() {
        $('#sure').focus();
    });
</script>
<%

rst.closeall();
rst1.closeall();
}
%>