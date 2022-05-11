<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>  
<%
if(session.getAttribute("loginOK")=="OK")
{


String id = request.getParameter("id");
String roomtype = request.getParameter("roomtype");
String fid = "";
String fcid = "";
fid = session.getAttribute("fid").toString();
fcid = session.getAttribute("fcid").toString();

	ReserveData rst = new ReserveData();
	ReserveData rstseat = new ReserveData();
	rstseat.getSeatById(id,roomtype);
	int up=0;
	int i=0;
	String ck="";
%>
 	
<div id="popup3">
    <span class="cross3">X</span><br><br>
    <fieldset>
    <label>場址:</label>
    <%
	rst.getCodeSub("8");
	up = rst.showCount();
	  while(i<up)
      {
		  if(rst.showData("seq", i).equals(roomtype)){
			  ck="checked";
			  %>
				<input type="radio" id="g1" name="g1"  value="<%=rst.showData("seq", i) %>" <%=ck %>><%=rst.showData("name_zh", i) %>
				<% 
		  }
			i++;
      }
	  
	 
	%>
    
    <br><br>
    
	<%
    	String area = rstseat.showData("area",0);
		//out.print(area);
		//out.print(loc);
	%>
	<div id="area">
	<jsp:include page="listareaByloc.jsp">
	<jsp:param value="<%=roomtype%>" name="loc"/>
	<jsp:param value="<%=area%>" name="area"/>
	<jsp:param value="<%=id%>" name="id"/>
	</jsp:include>
	</div>
	<label>教室狀態:</label>
	<br>
	<%
	i=0;
	 ck="";
	rst.getCodeSub("6");
	up = rst.showCount();
	String br ="";
	  while(i<up)
      {
		  br="";
		  if(i%2==0 && i !=0)
	     {
	    	 br="<br>";
	     }	
	     else
	     {
	    	 br="";
	     }	 
		  
		  if(rstseat.showData("on_off", 0).equals(rst.showData("seq", i))){
			  ck="checked";
		  }
		  else
		  {
				if(id.equals("0"))
				{
					if(rst.showData("seq", i).equals("10"))
					{
						ck="checked";
					}
					else
					{
						ck="";
					}	
				}
				else
				{
					ck="";
				}	
					
		  } 
	%>
	<input type="radio" id="g2" name="g2" value="<%=rst.showData("seq", i) %>" <%=ck %> /><%=rst.showData("name_zh", i) %><%=br %>
	<%
		i++;
      }
	%>
	<br><br>
	<label>教室編號:</label><input type="text" id="g3" class="pop4font" value="<%=rstseat.showData("room_name", 0) %>" >
	<br><br>
	<label>限制人數:</label>
	<%
		i=0;
	 	ck="checked";
		rst.getCodeSub("9");
		up = rst.showCount();
	    while(i < up)
	    {
	    	if(rstseat.showData("room_floor", 0).equals(rst.showData("name_zh", i))){
				  ck="checked";
			  }
			  else
			  {
					  ck="";
			  } 
	    	
	    %>
	    <input type="radio" name="g4" id="g4" value="<%=rst.showData("name_zh", i) %>" <%=ck %>><%=rst.showData("name_zh", i) %>
	    <%	
	    	i++;
	    }	
	%>
		<br><br>
	<label>IP:</label>
	<input type="text" name="g6" id="g6"  class="pop4font" value="<%=rstseat.showData("ip", 0) %>"></input>
	</fieldset>
	<br><br>
   
    <span class="goquestion3" >
    <input type="hidden" id="roomtype" value="<%=roomtype%>">
    <a href="#" class="btn" id="btn" onclick="add_edit('<%=id%>','7');">確定</a></span>
    <span class="closebutton3"><a href="#" class="btn" >取消</a></span>
   
  <%
  rst.closeall();
  
  %>
</div>
<script type='text/javascript'> // 網頁底端浮動視窗的js語法



$(function(){
	
	$( "#popup3" ).draggable();
	$("#popup3").fadeIn('fast');
	
	$(".cross3").click(function(){
		
   		$("#popup3").fadeOut('fast');
   		go_tab('system_seat.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	
	$(".closebutton3").click(function(){
   		$("#popup3").fadeOut('fast');
   		go_tab('system_seat.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	$(".goquestion3").click(function(){
   	$("#popup3").fadeOut('fast')
	})
});

$("#g3").keydown(function(e){
	  code = (e.keyCode ? e.keyCode : e.which);
	  if (code == 13)
	  {
		  $("#popup3").fadeOut('fast');
		  add_edit('<%=id%>','7');
	  }
	});
	
	$("#g3").focus();

</script>
<%

rst.closeall();
rstseat.closeall();
}
%>