<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>  
<%
if(session.getAttribute("loginOK")=="OK")
{
	String seq = request.getParameter("id");
	String cid = request.getParameter("cid");
	ReserveData rst = new ReserveData();
	rst.getCodetabById(seq);
	String fid = "";
	String fcid = "";
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();
%>
 	
<div id="popup3">
    <span class="cross3">X</span><br><br>
    <fieldset>
    <%
    if(!cid.equals("14"))
    {
    %>
	<label>時間(以分鐘為單位):</label><br>
	<%
    }
    else
    {
    %>
    <label>時間(以小時為單位):</label><br>
    <%	
    }	
	%>
	
	<input type="text" id="g1" class="pop4font" value="<%=rst.showData("name_zh", 0) %>" /><br><br>
	<label>說明</label><br>
	<textarea id="g2" class="pop4font"><%=rst.showData("name_desc_zh", 0) %></textarea><br>
	</fieldset><br><br>
   
    <span class="goquestion3" >
    <input type="hidden" id="g3" value="">
    <input type="hidden" id="g4" value="">
    <input type="hidden" id="g5" value="<%=cid%>">
    <a href="#" class="btn" onclick="add_edit('<%=seq%>','5');">確定</a></span>
    <span class="closebutton3"><a href="#" class="btn" >取消</a></span>
   
  
</div>
<script type='text/javascript'> // 網頁底端浮動視窗的js語法


$(function(){
	 $( "#popup3" ).draggable();
	$("#popup3").fadeIn('fast');
	
	$(".cross3").click(function(){
		
   		$("#popup3").fadeOut('fast');
   		go_tab('code_contr.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
   		go_tab('CodeSubSet.jsp?cid=<%=cid%>');
	})
	
	$(".closebutton3").click(function(){
   		$("#popup3").fadeOut('fast');
   		go_tab('code_contr.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
   		go_tab('CodeSubSet.jsp?cid=<%=cid%>');
	})
	$(".goquestion3").click(function(){
   	$("#popup3").fadeOut('fast')
	})
});

</script>
<%
rst.closeall();
}
%>