<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,javax.naming.*,javax.sql.*"%>
<%@ page import="wisoft.*"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>群組管理</title>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="style.css" type="text/css" media="all">
  <script src="ckeditor/ckeditor.js"></script>
  
</head>
<body>

<%
if(session.getAttribute("loginOK")=="OK")
{

ReserveData rst = new ReserveData();


String sysid = request.getParameter("id");
rst.getNews("1",sysid);

String fid = "";
String fcid = "";
try
{
fid = session.getAttribute("fid").toString();
fcid = session.getAttribute("fcid").toString();


%>
<article>
 <div class="editor">
    <form class="pure-form pure-form-stacked">
    <fieldset>
    <input type="hidden" id="g5" value="<%=sysid%>">
        <label>上架日期:</label><input type="text" id="g6" class="pop4font" placeholder="上架日期" value="<%=rst.showData("start_date", 0) %>"><br>
    <label>下架日期 :</label><input type="text" id="g7" class="pop4font" placeholder="下架日期" value="<%=rst.showData("end_date", 0) %>"><br>
        
        <label>主旨:</label><input type="text" id="g1" class="pop4font" placeholder="主旨" size="150" value="<%=rst.showData("title", 0) %>"><br>
        <label>內容</label>
       <textarea name="g2" id="g2" rows="10" cols="80" class="pop4font">
               <%=rst.showData("content", 0) %>
            </textarea>
            <script>
            var editor2 ;
            (function () {
    			var changesCount = 0;
    			editor2 = CKEDITOR.replace( 'g2', {
    				removeDialogTabs : 'link:target;link:advanced;image:Link;image:advanced'
    				
    			});
    			editor2.on( 'change', function ( ev ) {
    				//alert('123');
    			});
    			editor2.config.removeButtons = 'Save'; 
    		})();
            
            $.datetimepicker.setLocale('zh-TW');
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
            
        		 function saveedit(){
        				
        				var a = document.getElementById('g5').value;
        				var b = editor2.getData();
        				var c = document.getElementById('g1').value;
        				var d = document.getElementById('g6').value;
        				var e = document.getElementById('g7').value;
        				
        				$.post( "addtext.jsp", { sysid: a,html:b,subject:c,startdate:d,enddate:e })
        				  .done(function( data ) {
        					  //alert(data);
        					  if(data.trim() == 'OK')
        					  {
        						 	alert("新增完成");
        						  	var url = "search_news.jsp?fid=<%=fid%>&fcid=<%=fcid%>"; 
        							$( "#middle1" ).load(url);
        						  //$(location).attr('href',url);
        					  }
        					  else if(data.trim() == 'MODY')
        					  {
        						  alert("修改完成");
        						  	var url = "search_news.jsp?fid=<%=fid%>&fcid=<%=fcid%>"; 
        							$( "#middle1" ).load(url);
        					  }
        					  else 
        				      {
        							alert("失敗");
        							var url = "search_news.jsp?fid=<%=fid%>&fcid=<%=fcid%>"; 
        							$( "#middle1" ).load(url);
        				      }		  
        					  
        				  });
        				
        			}
        		 
            </script> 
		<br><br>
        <button type="button" class="btn" onclick="saveedit();">確定</button>
    </fieldset>
	</form>
  </div>            
</article>
<%
}catch(Exception e){}finally{
	rst.closeall();
}

}
%>
</body>
</html>
