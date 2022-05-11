<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.naming.*,javax.sql.*,wisoft.*,java.sql.*,java.io.*"%>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title></title>
</head>
<body><%
if(session.getAttribute("loginOK")=="OK")
{


ReserveData rst = new ReserveData();
ReserveData rst1 = new ReserveData();
String cid = request.getParameter("id");
//out.print(cid);
rst.getLocarea(cid);
int i=0;
int up = rst.showCount();
String admin = "";
String gid = "";

String fid = "";
String fcid = "";

if( request.getParameter("fid")!=null && request.getParameter("fcid")!=null)
{
	fid = request.getParameter("fid");
	fcid = request.getParameter("fcid");

	session.setAttribute("fid", fid);
	session.setAttribute("fcid", fcid);
}
else
{
	fid = session.getAttribute("fid").toString();
	fcid = session.getAttribute("fcid").toString();
}	

boolean funck=false;

if(session.getAttribute("loginOK")=="OK")
{

if(session.getAttribute("ADMIN")!=null)
{
	funck=true;
}

if(session.getAttribute("group")!=null)
{
	gid=session.getAttribute("group").toString();
}

%>
<div id="popup1">
<span class="cross1">X</span><br><br>
 <div class="table">
        <div class="table-head">
            <div class="column" data-label="區域">區域</div>
            <div class="column" data-label="區域說明">區域說明</div>
           <div class="column" data-label="新增館址區域">
           <input type="button" value="新增館址區域" class="btn" onclick="go_log('<%=fid %>','1');go_edit1('0','newLocarea.jsp');">
		</div>
        </div>
        <%
        	
        while(i<up)
        {
        	rst1.getCodetabById(rst.showData("area", i));
        	
        %>
        <div class="row">
            <div class="column" data-label="區域"><%=rst1.showData("name_zh", 0) %></div>
            <div class="column" data-label="區域說明"><%=rst1.showData("name_desc_zh", 0) %></div>
            <div class="column" data-label="編輯館址區域">
            <script type="text/javascript">
            if($( window ).width() <= 768)
    		{
    			$("#s1").show();
    		}
            else
            {
            	$("#s1").hide();
            }	
            </script>
            <input type="button"  value="刪除區域" class="btn" onclick="go_log('<%=fid %>','3');del_group('<%=rst.showData("sysid", i) %>','6');">
			<div id="simpleConfirm" title="刪除區域"></div>
			
			</div>
       </div>
       <%
      	 	i++;
        }
       %>
       <input type="hidden" id="s2" value="<%=cid%>">
    </div>
</div>
<%
	rst1.closeall();
	rst.closeall();
}
%>
<script type='text/javascript'> // 網頁底端浮動視窗的js語法
$(function(){
	 $( "#popup1" ).draggable();
	$("#popup1").fadeIn('fast');
	
	$(".cross1").click(function(){
		
   		$("#popup1").fadeOut('fast');
   		go_tab('system_location.jsp?fid=<%=fid%>&fcid=<%=fcid%>');
	})
	
	
});

</script>

<%
}
%>
</body>
</html>