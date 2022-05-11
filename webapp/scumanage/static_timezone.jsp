<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>群組管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" type="text/css" href="style.css">
 <script src="assets/plugins/jquery.loading.block.js"></script>
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
  
  <section id="content" class="column-center">
      			<div id="search">
      			<form  class="pure-form">
      			<fieldset>
      			<legend>體育場館時段人次統計表 </legend>  
      			<br>
      			<select id="gloc">
						<option value='0'>請選擇</option>
						<%
							int i1 = 0;
									rst.getCodeTab(8);
							int	up1 = rst.showCount();
									while (i1 < up1) {
						%>
						<option value="<%=rst.showData("seq", i1)%>"><%=rst.showData("name_zh", i1)%></option>
						<%
							i1++;
									}
						%>
					</select>
      			<div id="room" style="display:inline-block"></div>
      		
      			<input type="radio" id="g1" name="g1" value="hour" checked><label for="依時">依時(當日)</label>
      			<input type="radio" id="g1" name="g1" value="day" ><label for="依日">依日</label>
      			<input type="radio" id="g1" name="g1" value="month" ><label for="依月">依月</label>
	
      			from <input type="text" id="gf" value=""/>
      			to <input type="text" id="gt" value=""/>
				<input type="button" name="send" id="send_search" class="formbutton btn" value="確定" />
      			
      			
      			</fieldset>
				</form>
				<br><hr><br>
      			</div>
      			
				
		</section>
  <script type="text/javascript">
  $('input[type=radio][name=g1]').change(function() {
	    if (this.value == 'hour') {
	    	 
	    	  $.datetimepicker.setLocale('zh-TW');
	    	  $('#gf').datetimepicker({
	    		  timepicker:true,
	    		  format:'Y-m-d H:00'
	    	  });

	    	  $('#gt').datetimepicker({
	    		  timepicker:true,
	    	  	 format:'Y-m-d H:00'
	    	  });
	    	  
	    }
	    else if (this.value == 'day') {
	    	 
	    	  $.datetimepicker.setLocale('zh-TW');
	    	  $('#gf').datetimepicker({
	    		  timepicker:false,
	    		  format:'Y-m-d'
	    	  });

	    	  $('#gt').datetimepicker({
	    		  timepicker:false,
	    		  format:'Y-m-d'
	    	  });
	    	  
	    }
	    else if (this.value == 'month') {
	    	 $.datetimepicker.setLocale('zh-TW');
	    	  $('#gf').datetimepicker({
	    		  timepicker:false,
	    		  format:'Y-m-d'
	    	  });

	    	  $('#gt').datetimepicker({
	    		  timepicker:false,
	    		  format:'Y-m-d'
	    	  });
	    }
	});
  
  $.datetimepicker.setLocale('zh-TW');
  $('#gf').datetimepicker({
	  format:'Y-m-d H:00'
  });

  $('#gt').datetimepicker({
  	 format:'Y-m-d H:00'
  });
  
  $("#send_search").click(function(event){
	  $(function() {
	        $.loadingBlockShow({
	            imgPath: 'assets/img/default.svg',
				text: '統計資料處理中 Loading ...',
	            style: {
	                position: 'fixed',
	                width: '100%',
	                height: '100%',
	                background: 'rgba(0, 0, 0, .8)',
	                left: 0,
	                top: 0,
	                zIndex: 10000
	            }
	        });

	   
	    });
	   		 
		event.preventDefault();
		
		var g = $("#gloc").val();
		var b;var c;var d; var e; var f;
		b = $("#g3").val();//room
		c = $("#gf").val();//起
		d = $("#gt").val();//迄
	    f = $('input[name=g1]:checked').val()
		//alert(g);
		if(g != '0')
		{
			$.post( "reportlist.jsp",{loc:g,room:b,from:c,to:d,type:f})
			  .done(function( data ) {
				  setTimeout($.loadingBlockHide, 3000);
				  $("#middle1").html(data);
				  
			  });
		}
		else
		{
			alert("尚未點選校區");
			setTimeout($.loadingBlockHide, 100);
			return false;
		}	
		
	});

  
  $("#gloc").on('change', function() {
		
		var loc = $( '#gloc' ).val();
		//alert(loc);
		$( "#room" ).load("listroom1.jsp?loc="+loc);
	     	  
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
  	<div id="simpleConfirm" title="session timeout"></div>
</body>
</html>
