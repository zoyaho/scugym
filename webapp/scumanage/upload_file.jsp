<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/dropzone.css" />
<script src="js/dropzone.js"></script>
</head>
<body> 
<%
if(session.getAttribute("loginOK")=="OK")
{
%>
<div class="dropz">
      <form method="post" action="upload.jsp" class="dropzone" enctype="multipart/form-data"></form>
        </div>   
        <div id="media-upload-previews"></div>
		<script type="text/javascript">
		var fil ;
		Dropzone.autoDiscover = false;
		var myDropZone = new Dropzone(".dropzone",{
			url: "upload.jsp",
	    	uploadMultiple: true,
	    	clickable : true,
	   		dictDefaultMessage:"請將您的檔案移至此處...",
	    	addRemoveLinks: true,
	    	dictRemoveFile:"按此可移除檔案",
	   	 	parallelUploads: 30,
	    	maxFiles: 1,//最多允許上傳圖片數
	    	maxFilesize: 15,
	    	dictFileTooBig: '檔案大小超過15M',
	    	dictInvalidFileType: '只允許上傳EXCEL',
	    	acceptedFiles: ".xlsx",
	    	init: function() {
	    	
	    	 this.on("complete", function (file) {
	    		 if (this.getUploadingFiles().length === 0 && this.getQueuedFiles().length === 0) {
	    			 //alert("上傳"); 	
	    			 fil = file.name;
	    		 }
	    		 else
	    		 {
	    			 //alert("上傳失敗");
	    		 }	 
	    	 });
	    	 this.on("removedfile",function(file){
	    		 $.post( "deletefile.jsp", {  file_to_be_deleted: file.name })
	    		  .done(function( data ) {
	    			  //alert(data);
	    			  if(data.trim() == 'OK')
	    			  {
	    				//alert('檔案已刪除!');
	    				
	    			  } 
	    			  
	    			 
	    		  });
	    		 
			});
	    	 
 
		/*
		$(".dropzone").dropzone({
		
    		
    	 });*/
    	 
	 
    }
});
		

		function import_excel(){
			//alert(fil);
			$.post( "importExcel.jsp", {  filename:fil  })
			.done(function( data ) {
				var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
				 var myArray = str1.split(':');
				var successfirst = myArray[1].split("/");
				var successsecond = myArray[2].split("/");
				
				
				 if(myArray[0] == 'OK')
					{
					   alert("執行完畢");
					   
					   $("#importresult1").html (  "Excel 工作頁1 = 成功筆數:"+successfirst[0]+"  "+"失敗筆數位置: "+successfirst[1] );
					   $("#importresult2").html (  "Excel 工作頁2 = 成功筆數:"+successsecond[0]+"  "+"失敗筆數位置: "+successsecond[1]  );
					}
				
			});
		}
		
</script>

<button onclick="import_excel();">執行匯入</button>
<%
}
%>
<div id="importresult1"></div>
<div id="importresult2"></div>
</body>
</html>