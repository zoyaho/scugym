<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>  
<%
if(session.getAttribute("loginOK")=="OK")
{
	String uid = request.getParameter("id");
	String fid = "";
	String fcid = "";
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();

	ReserveData rst = new ReserveData();
	ReserveData rst1 = new ReserveData();
	Utility util = new Utility();
	rst.getUserByID(uid);

	int i=0;
	int up=0;

try
{
%>
 	
<div id="popup3">
    <span class="cross3">X</span><br><br>
    <fieldset>
	<label>帳號	:&nbsp;</label>
	<input type="text" id="g1" class="pop4font" value="<%=rst.showData("userid", 0) %>" /><br>
	<label>密碼       :&nbsp;</label>
	<input type="password" id="g2" class="pop4font" value="<%=util.hex2bin(rst.showData("passwd", 0) )%>" /><br>
	<label>姓名	:&nbsp;</label>
	<input type="text" id="g3" class="pop4font" value="<%=rst.showData("username", 0) %>" /><br>
	<label>身份名稱:</label>
	<input type="text" id="g4" class="pop4font" value="<%=rst.showData("userright", 0) %>" /><br>
	<label>建立日期:</label>
	<input type="text" id="g5" class="pop4font" value="<%=rst.showData("set_date", 0) %>" /><br>
	<label>修正日期:</label>
	<input type="text" id="g6" class="pop4font" value="<%=rst.showData("upd_date", 0) %>" /><br>
	<label>有效開始日期:</label>
	<input type="text" id="g7" class="pop4font" value="<%=rst.showData("start_time", 0) %>" /><br>
	<label>有效結束日期:</label>
	<input type="text" id="g8" class="pop4font" value="<%=rst.showData("end_time", 0) %>" /><br>
	<label>狀態	:&nbsp;</label>
	<%
	String ck_0 = "";
	String ck_1 = "";
	if(rst.showData("status", 0).equals("1"))
	{
		ck_0="";
		ck_1="checked";
	}	
	else if(rst.showData("status", 0).equals("0"))
	{
		ck_0="checked";
		ck_1="";
	}	
	%>
	
	<input type="radio" id="g9" name="g9" class="pop4font" value="1" <%=ck_1 %> />
	有效
	<input type="radio" id="g9" name="g9" class="pop4font" value="0" <%=ck_0 %> />
	停用
	
	<br><br>
	
	</fieldset>
	<label>所屬群組:</label><br><br>
	<%
		rst1.getGroup(0,"");
		up = rst1.showCount();
		String radiock="";
		while(i <up)
		{
			if(rst.showData("gid", 0).equals(rst1.showData("gid", i)))
			{
				radiock="checked";
			}
			else
			{
				radiock="";
			}	
	%>
	<input type="radio" id="g10" name="g10" value="<%=rst1.showData("gid", i)%>" <%=radiock %>/><%=rst1.showData("gname", i) %>
	<%
			i++;
		}	
	%>
	
	<br><br>
   
    <span class="goquestion3" >
    <a href="#" class="btn" onclick="add_edit('<%=uid%>','2');">確定</a></span>
    <span class="closebutton3"><a href="#" class="btn" >取消</a></span>
   
  
</div>
<script type='text/javascript'> // 網頁底端浮動視窗的js語法


$(function(){
	 $( "#popup3" ).draggable();
	$("#popup3").fadeIn('fast');
	
	$(".cross3").click(function(){
		
   		$("#popup3").fadeOut('fast');
   		go_tab('user_contr.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	
	$(".closebutton3").click(function(){
   		$("#popup3").fadeOut('fast');
   		go_tab('user_contr.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	$(".goquestion3").click(function(){
		
   	$("#popup3").fadeOut('fast')
	})
});

</script>
<script type="text/javascript">
	$.datetimepicker.setLocale('zh-TW');
	
	$('#g5').datetimepicker({
		
		 timepicker:false,
		 format:'Y-m-d',
			closeOnDateSelect:true
	});
	
	$('#g6').datetimepicker({
		 timepicker:false,
		 format:'Y-m-d',
			closeOnDateSelect:true

		});
	$('#g7').datetimepicker({
		 timepicker:false,
		 format:'Y-m-d',
			closeOnDateSelect:true
		});
	$('#g8').datetimepicker({
		 timepicker:false,
		 format:'Y-m-d',
			closeOnDateSelect:true
		});
	
	
</script>

<%
}catch(Exception e){}finally{
	
	rst.closeall();
	rst1.closeall();
	util.closeall();
}

}
%>