<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>群組管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
</head>
<body><%
if(session.getAttribute("loginOK")=="OK")
{

ReserveData rst = new ReserveData();

boolean funck_search  = false;
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
	


if(session.getAttribute("ADMIN")!=null)
{
	funck_search=true;
}

if(session.getAttribute("group")!=null)
{
	gid=session.getAttribute("group").toString();
	funck_search=rst.AuthFunc(fid, fcid, gid, "");
	
}

if(funck_search)
{
%>

<script>
		 
 		 $(function() {
   		 $( "#gs" ).datepicker({
   			dateFormat: 'yy-mm-dd',
   		   	changeMonth: true,
     		changeYear: true,
    	   	buttonText: "選擇日期"
         });
   		 
       });
 		 
 		 $(function() {
 	   		 $( "#ge" ).datepicker({
 	   			dateFormat: 'yy-mm-dd',
 	   		   	changeMonth: true,
	       		changeYear: true,
 	    	   	buttonText: "選擇日期"
 	         });
 	   		 
 	       });
 		 
  </script>
  
  <section id="content" class="column-center">
      			<div id="search">
      			<form  class="pure-form">
      			<fieldset>
      			<legend>查尋使用者紀錄 </legend>  <br>
					
						<label for="起始日期">開始日期:</label>
						<input type="text" name="sdate" id="gs" value=""/>	
						<label for="結束日期">結束日期:</label>
						<input type="text" name="edate" id="ge" value=""/>
						<label for="keyword">使用者:</label>	
						<input type="text" name="keyword" id="gk" value="" /><br><br>
						<input type="radio" id="by1" name="by1" value="99">全部
						<input type="radio" id="by1" name="by1" value="0">查詢
						<input type="radio" id="by1" name="by1" value="1">新增
						<input type="radio" id="by1" name="by1" value="2">修改
						<input type="radio" id="by1" name="by1" value="3">刪除<br><br>
						<input type="button" name="send" id="send_search" class="formbutton btn" value="搜尋" />
					
				</fieldset>
				</form>
				<br><hr><br>
      			</div>
      			
				
		</section>
  <script type="text/javascript">
  $("#send_search").click(function(event){
		
		event.preventDefault();
		var a = document.getElementById("gs").value;
		var b = document.getElementById("ge").value;
		var c = document.getElementById("gk").value;	
		var d = $("input[name=by1]:checked").val();  
		//alert(d);
		if(a == '' && b == '' && c== '')
		{
	 		alert("請輸入搜尋條件");
		}	
		
	 	if(a == '' && b == '' && c!='')
		{
			
	 		$("#middle1").load("search_result.jsp?gk="+c+"&by="+d);
		}	
		
	 	if(a != '' && b == '')
		{
			alert("起訖日期輸入錯誤");
		}
		
	 	if(a == '' && b != '')
		{
			alert("起訖日期輸入錯誤");
		}

		if(a != '' && b != '')
		{
			//alert("search_result.jsp?gs="+a+"&ge="+b+"&gk="+c+"&by="+d);
			$("#middle1").load("search_result.jsp?gs="+a+"&ge="+b+"&gk="+c+"&by="+d);
		}	

	});

  </script>
  <div id="middle1"></div>
<%
}
else
{
%>
<script>
$( function() {
    $( "#simpleConfirm" ).dialog({
      modal: true,
      buttons: {
        Ok: function() {
        	 var url = "enter";    
			  $(location).attr('href',url);
        }
      }
    });
  } );
</script>
<%	
}

rst.closeall();

}
%>  
  	<div id="simpleConfirm" title="無使用權限"></div>
</body>
</html>
