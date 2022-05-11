<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>  
<%
if(session.getAttribute("loginOK")=="OK")
{
	String seq = request.getParameter("id");
	String cid = request.getParameter("cid");
	ReserveData rst = new ReserveData();
	ReserveData rst_tab = new ReserveData();
	//out.print(seq);
	rst.getCodetabById(seq);
	String fid = "";
	String fcid = "";
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();
	
	//out.print(cid);
%>
 	
<div id="popup3">
    <span class="cross3">X</span><br><br>
    <fieldset>
           違規名稱<input type="text" id="g1" class="pop4font" value="<%=rst.showData("name_zh", 0) %>" /><br><br>
	違規說明<input type="text" id="g2" class="pop4font" value="<%=rst.showData("name_desc_zh", 0) %>" /><br><br>
	違規次數<input type="text" id="g3" class="pop4font" value="<%=rst.showData("name_ch", 0) %>" /><br><br>
	間隔天數<br><input type="text" id="g4" class="pop4font" value="<%=rst.showData("name_desc_ch", 0) %>" /><br><br>
	停權(日)<br><input type="text" id="g5" class="pop4font" value="<%=rst.showData("name_en", 0) %>" /><br><br>
	所屬場地:
	<%
    	rst_tab.getCodeTab(3);
    	int i=0;
    	int up = rst_tab.showCount();
    	String ck_loc="";
    	while(i < up)
    	{	
    		if(rst.showData("name_desc_en", 0).indexOf(rst_tab.showData("seq", i))!=-1)
    		{
    			if(rst.showData("name_desc_en", 0).equals("10") && rst_tab.showData("seq", i).equals("1"))
    			{
    				ck_loc="";
    			}	
    			else
    			{
    				ck_loc="checked";
    			}	
    			
    		}	
    		else
    		{
    			ck_loc="";
    		}	
   			%>
			<input type="checkbox" id="g6" name="g6" value="<%=rst_tab.showData("seq",i) %>" <%=ck_loc %>><%=rst_tab.showData("name_zh", i) %>
			<%
    		i++;
    	}
	%>
	</fieldset><br><br>
   
    <span class="goquestion3" >
    <input type="hidden" id="g7" value="<%=cid%>">
    <a href="#" class="btn" onclick="add_edit('<%=seq%>','12');">確定</a></span>
    <span class="closebutton3"><a href="#" class="btn" >取消</a></span>
   
  
</div>

<script type='text/javascript'> // 網頁底端浮動視窗的js語法


$(function(){
	$( "#popup3" ).draggable();
	$( "#popup3" ).fadeIn('fast');
	
	$(".cross3").click(function(){
		
   		$("#popup3").fadeOut('fast');
   		//go_tab('code_contr.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
   		//go_tab('CodeSubSet.jsp?cid=<%=cid%>');
	})
	
	$(".closebutton3").click(function(){
   		$("#popup3").fadeOut('fast');
   		//go_tab('code_contr.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
   		//go_tab('CodeSubSet.jsp?cid=<%=cid%>');
	})
	
	$(".goquestion3").click(function(){
   		$("#popup3").fadeOut('fast')
	})
});

</script>
<%
rst.closeall();
rst_tab.closeall();

}
%>