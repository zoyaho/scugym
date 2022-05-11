
function go_login(){
	
	var a = document.getElementById('username').value;
	var b = document.getElementById('password').value;
	
	$.post( "login_ok.jsp", { username: a,password:b })
	  .done(function( data ) {
		  //alert(data);
		  if(data.trim() == 'OK')
		  {
			  var url = "main";    
			  $(location).attr('href',url);
		  }
		  else
	      {
			  if(data.trim() == 'NOIP')
			  {
				  alert("您目前所在IP位置，尚未開放使用本系統!");
				  var url = "enter";    
				  $(location).attr('href',url);
			  }
			  else
			  {
				  alert("帳號密碼輸入錯誤，或者帳號不允許登入!");
				  var url = "enter";    
				  $(location).attr('href',url);
			  }
			 
	      }		  
		  
	  });
}

function go_logout(){
	
	$.post( "logout_ok.jsp")
	  .done(function( data ) {
		  //alert(data);
		  if(data.trim() == 'OK')
		  {
			  var url = "enter";    
			  $(location).attr('href',url);
		  }
		 	  
		  
	  });
}

function goback(xxx,y1,roomtype){
	
	$( "#middle1" ).load('listarea.jsp?fid='+xxx+"&fcid="+y1+"&roomtype="+roomtype);
}

function go_tab(urlk,y1,y2){
	//alert(y1+":"+y2);
	
	if(y1==20  || y1==28 || y1==12)
	{
		$(this).toggleClass('active');
		$('.pushmenu-push').toggleClass('pushmenu-push-toright');
		$menuLeft.toggleClass('pushmenu-open');
	}
	
	$( "#cont" ).load(urlk+"?fid="+y1+"&fcid="+y2);
}

function edit_news(xxx,urlk){
	$( "#middle1" ).load(urlk+"?id="+xxx);
}

function go_edit(xxx,urlk,roomtype){
	
	$( "#simpleedit" ).load(urlk+"?id="+xxx+"&roomtype="+roomtype);
}

function go_edit2(xxx,urlk,y1){
	//alert("page"+y1);
	$( "#simpleedit" ).load(urlk+"?id="+xxx+"&page="+y1);
}

function go_edit1(xxx,urlk){
	
	var a = document.getElementById("s2").value;
	$( "#simpleedit" ).load(urlk+"?id="+xxx+"&cid="+a);
}

function add_edit(xxx,y1){
	
	if(y1==1)
	{
		var a = document.getElementById("g1").value;
		var b = document.getElementById("g2").value;
		var c = document.getElementById("g3").value;
		
		$.post( "addGroup.jsp", { ck:xxx,gid:a,gname:b,gdesc:c })
		  .done(function( data ) {
			  if(data.trim() == 'OK')
			  {
					alert("儲存成功!");
				  $( "#cont" ).load('group_contr.jsp');
			  } 
			  else if(data.trim()=='EXIST')
			  {
					alert('該群組已存在!');
					$( "#simpleedit" ).load('newgroup.jsp?id='+xxx);
		      } 
			  else if(data.trim() == 'NO')
			  {
				  alert("儲存失敗!");
				  $( "#cont" ).load('group_contr.jsp');
			  } 
			 
		  });
	}
	else if(y1==2)
	{
		var a = document.getElementById("g1").value;
		var b = document.getElementById("g2").value;
		var c = document.getElementById("g3").value;
		var d = document.getElementById("g4").value;
		var e = document.getElementById("g5").value;
		var f = document.getElementById("g6").value;
		var g = document.getElementById("g7").value;
		var h = document.getElementById("g8").value;
		var i = getRadioValue("g9");
		var j = getRadioValue("g10");
		
		if(a=='' && b=='' && c=='' && d=='' && e=='' && f=='' && g=='' && h=='')
		{
			alert('欄位填寫空白!');
			$( "#simpleedit" ).load('newuser.jsp?id='+xxx);
		}
		else
		{
			$.post( "addUser.jsp", { ck:xxx,userid:a,passwd:b,
				 username:c,userright:d,
				 set_date:e,upd_date:f,
				 start_time:g,end_time:h,
				 status:i,group:j })
				 .done(function( data ) {
			 	//alert(data);

					 if(data.trim() == 'OK')
					 {
						 alert("儲存成功!");
						 $( "#cont" ).load('user_contr.jsp');
					 } 
					 else if(data.trim()=='EXIST')
					 {
						 alert('該使用者已存在!');
						 $( "#simpleedit" ).load('newuser.jsp?id='+xxx);
					 } 
					 else if(data.trim() == 'NO')
					 {
						 alert("儲存失敗!");
						 $( "#cont" ).load('user_contr.jsp');
					 } 

				 });
		}	
		
		
	}	
	else if(y1==3)
	{
		var a = document.getElementById("g1").value;
		var b = document.getElementById("g2").value;
		var c = document.getElementById("g3").value;
		var d = document.getElementById("g4").value;
		$.post( "addIP.jsp", { ck:xxx,ip:a,ipdesc:b,start:c,end:d})
		  .done(function( data ) {
			  if(data.trim() == 'OK')
			  {
					alert("儲存成功!");
				  $( "#cont" ).load('ip_contr.jsp');
			  } 
			  else if(data.trim()=='EXIST')
			  {
					alert('該IP已存在!');
					$( "#simpleedit" ).load('newIP.jsp?id='+xxx);
		      } 
			  else if(data.trim() == 'NO')
			  {
				  alert("儲存失敗!");
				  $( "#cont" ).load('ip_contr.jsp');
			  } 
			 
		  });
	}	
	else if(y1==4)
	{
		var a = document.getElementById("g1").value;
		var b = document.getElementById("g2").value;
	
		
		$.post( "addCode.jsp", { ck:xxx,code_name:a,code_comment:b})
		  .done(function( data ) {
			  if(data.trim() == 'OK')
			  {
					alert("儲存成功!");
				  $( "#cont" ).load('code_contr.jsp');
			  } 
			  else if(data.trim()=='EXIST')
			  {
					alert('該代碼已存在!');
					$( "#simpleedit" ).load('newCode.jsp?id='+xxx);
		      } 
			  else if(data.trim() == 'NO')
			  {
				  alert("儲存失敗!");
				  $( "#cont" ).load('code_contr.jsp');
			  } 
			 
		  });
	}		
	else if(y1==5)
	{
		var a = document.getElementById("g1").value;
		var b = document.getElementById("g2").value;
		var c = document.getElementById("g3").value;
		var d = document.getElementById("g4").value;
		var e = document.getElementById("g5").value;
		
		$.post( "addSubCode.jsp", { ck:xxx,name_zh:a,desc_zh:b,name_en:c,desc_en:d,cid:e})
		  
		.done(function( data ) {
			 var myArray = data.split(':');
			 //alert(data);
			if(myArray[0].trim() == 'OK')
			  {
					alert("儲存成功!");
				  $( "#simpleedit" ).load('CodeSubSet.jsp?id='+myArray[1]);
			  } 
			  else if(myArray[0].trim()=='EXIST')
			  {
					alert('該代碼已存在!');
					if(!myArray[1]=='11' && !myArray[1]=='12')
						$( "#simpleedit" ).load('newSubCode.jsp?id='+xxx+"&cid="+myArray[1]);
					else if(!myArray[1]=='15')
						$( "#simpleedit" ).load('newSubCodeByMail.jsp?id='+xxx+"&cid="+myArray[1]);
					else 
						$( "#simpleedit" ).load('newSubCodeByTime.jsp?id='+xxx+"&cid="+myArray[1]);	
		      } 
			  else if(myArray[0].trim() == 'NO')
			  {
				  alert("儲存失敗!");
				  $( "#simpleedit" ).load('CodeSubSet.jsp?id='+myArray[1]);
			  } 
			 
		  });
	}
	else if(y1==6){
		var a = $('#g1').val();
		var b = $('#g2').text();
		
		$.post( "addNews.jsp", { ck:xxx,title:a,content:b})
		  
		.done(function( data ) {
			
			 //alert(data);
			if(data == 'OK')
			{
					alert("儲存成功!");
				  $( "#middle1" ).load('search_news.jsp');
			} 
			else if(data.trim() == 'MODY')
			{
				  alert("修改成功!");
				  $( "#middle1" ).load('search_news.jsp');
			} 
			else if(data.trim() == 'NO')
			{
				  alert("儲存失敗!");
				  $( "#middle1" ).load('search_news.jsp');
			} 
			 
		  });
		
	}
	else if(y1==7){
		var a = getRadioValue("g1");
		var b = getRadioValue("g2");
		var c = $('#g3').val();
		var d = getRadioValue("g4");
		var e = getRadioValue("g5");
		var f = $('#g6').val();
		$.post( "addSeat.jsp", { ck:xxx,area:e,status:b,room:c,floor:d,loc:a,ip:f})
		  
		.done(function( data ) {
			 //alert(data);
			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			 var myArray = str1.split(':');
			
			if(myArray[0] == 'OK')
			{
					alert("儲存成功!");
					//$( "#middle1" ).load('listallseat.jsp?fid='+myArray[1]+"&fcid="+myArray[2]+"&id="+myArray[3]);
			} 
			else if(myArray[0]=='MODY')
			{
					alert("修改成功!");
					//$( "#middle1" ).load('listallseat.jsp?fid='+myArray[1]+"&fcid="+myArray[2]+"&id="+myArray[3]);
			}
			else if(myArray[0]=='EXIST'){
				alert("資料已存在!");
				//$( "#middle1" ).load('listallseat.jsp?fid='+myArray[1]+"&fcid="+myArray[2]+"&id="+myArray[3]);
			}
			else if(myArray[0].trim() == 'NO')
			{
				  alert("儲存失敗!");
				 
			} 
			 $( "#middle1" ).load('listallseat.jsp?fid='+myArray[1]+"&fcid="+myArray[2]+"&id="+myArray[3]+"&roomtype="+a);
		  });
	}
	else if(y1==8){
		var a = getRadioValue("g1");
		var b = getRadioValue("g2");
		$.post( "addLocalarea.jsp", { ck:xxx,location:a,area:b})
		  
		.done(function( data ) {
			 //alert(data);
			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			 var myArray = str1.split(':');
			
			if(myArray[0] == 'OK')
			{
					alert("儲存成功!");
					$( "#middle1" ).load('listlocation.jsp?fid='+myArray[1]+"&fcid="+myArray[2]);
			} 
			else if(myArray[0]=='EXIST')
			{
				alert("該筆資料已存在!");
				$( "#middle1" ).load('listlocation.jsp?fid='+myArray[1]+"&fcid="+myArray[2]);
			}	
			else if(myArray[0]=='MODY')
			{
					alert("修改成功!");
					$( "#middle1" ).load('listlocation.jsp?fid='+myArray[1]+"&fcid="+myArray[2]);
			}
			else if(myArray[0].trim() == 'NO')
			{
				  alert("儲存失敗!");
				  $( "#middle1" ).load('listallseat.jsp?fid='+myArray[1]+"&fcid="+myArray[2]);
			} 
			 
		  });
	}
	else if(y1==9){
		var a = GetCheckedValue("g1");
		var b = $('#g2').val();
		var c = $('#g3').val();
		
		//alert(a);
		$.post( "addSeatForbid.jsp", { ck:xxx,usertype:a,start:b,end:c})
		  
		.done(function( data ) {
			 //alert(data);
			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			 var myArray = str1.split(':');
			
			if(myArray[0] == 'OK')
			{
					alert("儲存成功!");
					$( "#middle1" ).load('listtempforbid.jsp?fid='+myArray[1]+"&fcid="+myArray[2]);
			} 
			else if(myArray[0]=='MODY')
			{
					alert("修改成功!");
					$( "#middle1" ).load('listtempforbid.jsp?fid='+myArray[1]+"&fcid="+myArray[2]);
			}
			else if(myArray[0].trim() == 'NO')
			{
				  alert("儲存失敗!");
				   $( "#middle1" ).load('listtempforbid.jsp?fid='+myArray[1]+"&fcid="+myArray[2]);
			} 
			 
		  });
	}
	else if(y1==10){
		var a = $('#g1').val();
		var b = $('#g2').val();
		var c = $('#g3').val();
		var d = $('#g4').val();
		var e = $('#g5').val();
		var f = $('#g6').val();
		var g = $('#g7').val();
		
		//alert(a);
		$.post( "addForbid.jsp", { ck:xxx,id:a,name:b,usertype:c,start:d,end:e,reason:f,note:g})
		  
		.done(function( data ) {
			 //alert(data);
			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			 var myArray = str1.split(':');
			
			if(myArray[0] == 'OK')
			{
					alert("儲存成功!");
					$( "#middle1" ).load('search_forbid.jsp?fid='+myArray[1]+"&fcid="+myArray[2]);
			} 
			else if(myArray[0]=='MODY')
			{
					alert("修改成功!");
					$( "#middle1" ).load('search_forbid.jsp?fid='+myArray[1]+"&fcid="+myArray[2]);
			}
			else if(myArray[0].trim() == 'NO')
			{
				  alert("儲存失敗!");
				   $( "#middle1" ).load('search_forbid.jsp?fid='+myArray[1]+"&fcid="+myArray[2]);
			} 
			 
		  });
	}
	else if(y1==11){
		var a = $('#g1').val();
		var b = $('#g2').val();
		var c = $('#g3').val();
		//alert(c);
		if(a=='')
		{
			alert('卡號不得為空白!');
			return false;
		}
		$.post( "addLibrarian.jsp", { ck:xxx,id:a,desc:b})
		  
		.done(function( data ) {
			 //alert(data);
			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			 var myArray = str1.split(':');
			
			if(myArray[0] == 'OK')
			{
					//alert("儲存成功!");
					$( "#middle1" ).load('listlibrarian.jsp?fid='+myArray[1]+"&fcid="+myArray[2]+"&page="+c);
			} 
			else if(myArray[0]=='MODY')
			{
					//alert("修改成功!");
					$( "#middle1" ).load('listlibrarian.jsp?fid='+myArray[1]+"&fcid="+myArray[2]+"&page="+c);
			}
			else if(myArray[0].trim() == 'NO')
			{
				  //alert("儲存失敗!");
				   $( "#middle1" ).load('listlibrarian.jsp?fid='+myArray[1]+"&fcid="+myArray[2]+"&page="+c);
			} 
			 
		  });
	}
	else if(y1==12){
		var a = document.getElementById("g1").value;
		var b = document.getElementById("g2").value;
		var c = document.getElementById("g3").value;
		var d = document.getElementById("g4").value;
		var e = document.getElementById("g5").value;
		var f = GetCheckedValue("g6");
		//alert(f);
		var g = document.getElementById("g7").value;
		
		if(a=='' || b=='' || c=='' || d=='' || e=='')
		{
			alert("指定欄位未填寫完成!");
			$( "#simpleedit1" ).load('newSubCodeByPenalty.jsp');
		}
		else
		{
			$.post( "addSubCode1.jsp", { ck:xxx,name_zh:a,desc_zh:b,name_ch:c,desc_ch:d,name_en:e,desc_en:f,cid:g})
			
			  
			.done(function( data ) {
				
				var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
				myArray = str1.split(':');
				if(myArray[0].trim() == 'OK')
				{
					alert("儲存成功!");
					$( "#simpleedit" ).load('CodeSubSet.jsp?id='+myArray[1].trim());
				} 
				else if(myArray[0].trim() == 'Mody')
				{
					  alert("修改成功!");
					  $( "#simpleedit" ).load('CodeSubSet.jsp?id='+myArray[1].trim());
				} 
				else if(myArray[0].trim()=='EXIST')
				{
					alert('該代碼已存在!');
					 $( "#simpleedit" ).load('CodeSubSet.jsp?id='+myArray[1].trim());
				}	
				else if(myArray[0].trim() == 'NO')
				{
					  alert("儲存失敗!");
					  $( "#simpleedit" ).load('CodeSubSet.jsp?id='+myArray[1].trim());
				} 
				 
			  });
		}	
	}
	else if(y1==13){
		var a = document.getElementById("g1").value;
		var b = document.getElementById("g2").value;
		var c = document.getElementById("g3").value;
		var d = document.getElementById("g4").value;
		var e = document.getElementById("g5").value;
		
		$.post( "addSubCode1.jsp", { ck:xxx,name_zh:a,desc_zh:b,name_en:c,desc_en:d,cid:e})
		  
		.done(function( data ) {
			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			myArray = str1.split(':');
			if(myArray[0].trim() == 'OK')
			{
				alert("儲存成功!");
				$( "#simpleedit" ).load('CodeSubSet.jsp?id='+myArray[1].trim());
			} 
			else if(myArray[0].trim() == 'Mody')
			{
				  alert("修改成功!");
				  $( "#simpleedit" ).load('CodeSubSet.jsp?id='+myArray[1].trim());
			} 
			else if(myArray[0].trim()=='EXIST')
			{
				alert('該代碼已存在!');
				 $( "#simpleedit" ).load('CodeSubSet.jsp?id='+myArray[1].trim());
			}	
			else if(myArray[0].trim() == 'NO')
			{
				  alert("儲存失敗!");
				  $( "#simpleedit" ).load('CodeSubSet.jsp?id='+myArray[1].trim());
			} 
			 
		  });
	}
	else if(y1==14){
		var a = document.getElementById("g1").value;
		var b = document.getElementById("g2").value;
		var c = document.getElementById("g3").value;
		var d = document.getElementById("g4").value;
		var e = document.getElementById("g5").value;
		
		$.post( "addSubCode1.jsp", { ck:xxx,name_zh:a,desc_zh:b,name_en:c,desc_en:d,cid:e})
		  
		.done(function( data ) {
			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			myArray = str1.split(':');
			if(myArray[0].trim() == 'OK')
			{
				alert("儲存成功!");
				$( "#simpleedit" ).load('CodeSubSet.jsp?id='+myArray[1].trim());
			} 
			else if(myArray[0].trim() == 'Mody')
			{
				  alert("修改成功!");
				  $( "#simpleedit" ).load('CodeSubSet.jsp?id='+myArray[1].trim());
			} 
			else if(myArray[0].trim()=='EXIST')
			{
				alert('該代碼已存在!');
				 $( "#simpleedit" ).load('CodeSubSet.jsp?id='+myArray[1].trim());
			}	
			else if(myArray[0].trim() == 'NO')
			{
				  alert("儲存失敗!");
				  $( "#simpleedit" ).load('CodeSubSet.jsp?id='+myArray[1].trim());
			} 
			 
		  });
	}
}


function del_group(xxx,y1)
{
	
	if(y1==1)
	{
		  $(function() {
			    $( "#simpleConfirm" ).dialog({
			    	closeIcon: true,
			    	resizable: false,
			    	height:140,
			    	modal: true,
			    	buttons: {
			        "確定?": function() {
			        	
			        	 $( this ).dialog( "close" );
			        		$.post( "deleteGroup.jsp", {  gid: xxx  })
			        		.done(function( data ) {
			        			//alert(data);
			        			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			        			if(str1=='OK') 
			        			{
			        				alert('刪除完成'); 
			        				$( "#cont" ).load('group_contr.jsp');
			        			}
			        			else
			        			{
			        				alert('刪除失敗');
			        				  $( "#cont" ).load('group_contr.jsp');
			        			} 
			        		});
			       	 
			        	},
			        	 '取消': function() {
			        		$( this ).dialog( "close" );
			        	}
			        	
			      }
			    });
			  });
	}	
	else if(y1==2){
		 $(function() {
			    $( "#simpleConfirm" ).dialog({
			    	closeIcon: true,
			    	resizable: false,
			    	height:140,
			    	modal: true,
			    	buttons: {
			        "確定?": function() {
			        	
			        	 $( this ).dialog( "close" );
			        		$.post( "deleteIP.jsp", {  sysid: xxx  })
			        		.done(function( data ) {
			        			//alert(data);
			        			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			        			if(str1=='OK') 
			        			{
			        				alert('刪除完成'); 
			        				$( "#cont" ).load('ip_contr.jsp');
			        			}
			        			else
			        			{
			        				alert('刪除失敗');
			        				  $( "#cont" ).load('ip_contr.jsp');
			        			} 
			        		});
			       	 
			        	},
			        	 '取消': function() {
			        		$( this ).dialog( "close" );
			        	}
			        	
			      }
			    });
			  });
		
	}
	else if(y1==3){
		 $(function() {
			    $( "#simpleConfirm" ).dialog({
			    	closeIcon: true,
			    	resizable: false,
			    	height:140,
			    	modal: true,
			    	buttons: {
			        "確定?": function() {
			        	
			        	 $( this ).dialog( "close" );
			        		$.post( "deleteCode.jsp", {  id: xxx  })
			        		.done(function( data ) {
			        			//alert(data);
			        			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			        			if(str1=='OK') 
			        			{
			        				alert('刪除完成'); 
			        				$( "#cont" ).load('code_contr.jsp');
			        			}
			        			else if(str1=='EXIST'){
			        				alert('此代碼尚有小類存在,無法直接刪除!'); 
			        				$( "#cont" ).load('code_contr.jsp');
			        			}
			        			else
			        			{
			        				alert('刪除失敗');
			        				  $( "#cont" ).load('code_contr.jsp');
			        			} 
			        		});
			       	 
			        	},
			        	 '取消': function() {
			        		$( this ).dialog( "close" );
			        	}
			        	
			      }
			    });
			  });
		
	}
	else if(y1==4){
		 $(function() {
			    $( "#simpleConfirm" ).dialog({
			    	closeIcon: true,
			    	resizable: false,
			    	height:140,
			    	modal: true,
			    	buttons: {
			        "確定?": function() {
			        	
			        	 $( this ).dialog( "close" );
			        		$.post( "deleteCodeTab.jsp", {  id: xxx  })
			        		.done(function( data ) {
			        			//alert(data);
			        			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			        			if(str1=='OK') 
			        			{
			        				alert('刪除完成'); 
			        				$( "#simpleedit" ).load('CodeSubSet.jsp');
			        			}
			        			else if(str1=='EXIST')
			        			{
			        				alert('尚存小類'); 
			        				$( "#simpleedit" ).load('CodeSubSet.jsp');
			        			}	
			        			else
			        			{
			        				alert('刪除失敗');
			        				  $( "#simpleedit" ).load('CodeSubSet.jsp');
			        			} 
			        		});
			       	 
			        	},
			        	 '取消': function() {
			        		$( this ).dialog( "close" );
			        	}
			        	
			      }
			    });
			  });
		
	}
	else if(y1==5){
		 $(function() {
			    $( "#simpleConfirm" ).dialog({
			    	closeIcon: true,
			    	resizable: false,
			    	height:140,
			    	modal: true,
			    	buttons: {
			        "確定?": function() {
			        	
			        	 $( this ).dialog( "close" );
			        		$.post( "deleteNews.jsp", {  id: xxx  })
			        		.done(function( data ) {
			        			//alert(data);
			        			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			        			if(str1=='OK') 
			        			{
			        				alert('刪除完成'); 
			        				$( "#middle1" ).load('search_news.jsp');
			        			}
			        			else
			        			{
			        				alert('刪除失敗');
			        				  $( "#middle1" ).load('search_news.jsp');
			        			} 
			        		});
			       	 
			        	},
			        	 '取消': function() {
			        		$( this ).dialog( "close" );
			        	}
			        	
			      }
			    });
			  });
	}
	else if(y1==6){
		 $(function() {
			    $( "#simpleConfirm" ).dialog({
			    	closeIcon: true,
			    	resizable: false,
			    	height:140,
			    	modal: true,
			    	buttons: {
			        "確定?": function() {
			        	
			        	 $( this ).dialog( "close" );
			        		$.post( "deleteLocarea.jsp", {  id: xxx  })
			        		.done(function( data ) {
			        			//alert(data);
			        			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			        			if(str1=='OK') 
			        			{
			        				alert('刪除完成'); 
			        				$( "#simpleedit" ).load('LocArea.jsp');
			        			}
			        			else if(str1=='EXIST')
			        			{
			        				alert('刪除失敗,該區域尚有指定座位!');
			        				 $( "#simpleedit" ).load('LocArea.jsp');
			        			}	
			        			else
			        			{
			        				alert('刪除失敗');
			        				  $( "#simpleedit" ).load('LocArea.jsp');
			        			} 
			        		});
			       	 
			        	},
			        	 '取消': function() {
			        		$( this ).dialog( "close" );
			        	}
			        	
			      }
			    });
			  });
	}
	else if(y1==7){
		 $(function() {
			    $( "#simpleConfirm" ).dialog({
			    	closeIcon: true,
			    	resizable: false,
			    	height:140,
			    	modal: true,
			    	buttons: {
			        "確定?": function() {
			        	
			        	 $( this ).dialog( "close" );
			        		$.post( "deleteSeat.jsp", {  id: xxx  })
			        		.done(function( data ) {
			        			//alert(data);
			        			
			        			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			        			 var myArray = str1.split(':');
			        			if(myArray[0]=='OK') 
			        			{
			        				alert('刪除完成'); 
			        			
			        			}
			        			else if(str1=='EXIST')
			        			{
			        				alert('刪除失敗,該區域尚有指定座位!');
			        				// $( "#simpleedit" ).load('LocArea.jsp');
			        			}	
			        			else
			        			{
			        				alert('刪除失敗');
			        				//  $( "#simpleedit" ).load('LocArea.jsp');
			        			} 
			        			
			        			$( "#middle1" ).load('listallseat.jsp?id='+myArray[1]);
			        		});
			       	 
			        	},
			        	 '取消': function() {
			        		$( this ).dialog( "close" );
			        	}
			        	
			      }
			    });
			  });
	}
	else if(y1==8){
		 $(function() {
			    $( "#simpleConfirm" ).dialog({
			    	closeIcon: true,
			    	resizable: false,
			    	height:140,
			    	modal: true,
			    	buttons: {
			        "確定?": function() {
			        	
			        	 $( this ).dialog( "close" );
			        		$.post( "deleteTempForbid.jsp", {  id: xxx  })
			        		.done(function( data ) {
			        			//alert(data);
			        			
			        			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			        			//var myArray = str1.split(':');
			        			if(str1=='OK') 
			        			{
			        				alert('刪除完成'); 
			        			
			        			}
			        			else if(str1=='EXIST')
			        			{
			        				alert('刪除失敗,該區域尚有指定座位!');
			        				// $( "#simpleedit" ).load('LocArea.jsp');
			        			}	
			        			else
			        			{
			        				alert('刪除失敗');
			        				//  $( "#simpleedit" ).load('LocArea.jsp');
			        			} 
			        			
			        			$( "#middle1" ).load('listtempforbid.jsp');
			        		});
			       	 
			        	},
			        	 '取消': function() {
			        		$( this ).dialog( "close" );
			        	}
			        	
			      }
			    });
			  });
	}
	else if(y1==9){
		 $(function() {
			    $( "#simpleConfirm" ).dialog({
			    	closeIcon: true,
			    	resizable: false,
			    	height:140,
			    	modal: true,
			    	buttons: {
			        "確定?": function() {
			        	
			        	 $( this ).dialog( "close" );
			        		$.post( "deleteForbid.jsp", {  id: xxx  })
			        		.done(function( data ) {
			        			//alert(data);
			        			
			        			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			        			 //var myArray = str1.split(':');
			        			if(str1=='OK') 
			        			{
			        				alert('刪除完成'); 
			        			
			        			}
			        			else if(str1=='EXIST')
			        			{
			        				alert('刪除失敗,該區域尚有指定座位!');
			        				// $( "#simpleedit" ).load('LocArea.jsp');
			        			}	
			        			else
			        			{
			        				alert('刪除失敗');
			        				//  $( "#simpleedit" ).load('LocArea.jsp');
			        			} 
			        			
			        			$( "#middle1" ).load('search_forbid.jsp');
			        		});
			       	 
			        	},
			        	 '取消': function() {
			        		$( this ).dialog( "close" );
			        	}
			        	
			      }
			    });
			  });
	}
	else if(y1==10){
		 $(function() {
			    $( "#simpleConfirm" ).dialog({
			    	closeIcon: true,
			    	resizable: false,
			    	height:140,
			    	modal: true,
			    	buttons: {
			        "確定?": function() {
			        	
			        	 $( this ).dialog( "close" );
			        		$.post( "deleteForbid.jsp", {  id: xxx  })
			        		.done(function( data ) {
			        			//alert(data);
			        			
			        			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			        			 //var myArray = str1.split(':');
			        			if(str1=='OK') 
			        			{
			        				alert('刪除完成'); 
			        			
			        			}
			        			else if(str1=='EXIST')
			        			{
			        				alert('刪除失敗,該區域尚有指定座位!');
			        				// $( "#simpleedit" ).load('LocArea.jsp');
			        			}	
			        			else
			        			{
			        				alert('刪除失敗');
			        				//  $( "#simpleedit" ).load('LocArea.jsp');
			        			} 
			        			
			        			$( "#middle1" ).load('forbid.jsp');
			        		});
			       	 
			        	},
			        	 '取消': function() {
			        		$( this ).dialog( "close" );
			        	}
			        	
			      }
			    });
			  });
	}
	else if(y1==11){
		 $(function() {
			    $( "#simpleConfirm" ).dialog({
			    	closeIcon: true,
			    	resizable: false,
			    	height:140,
			    	modal: true,
			    	buttons: {
			        "確定?": function() {
			        	
			        	 $( this ).dialog( "close" );
			        		$.post( "deleteUser.jsp", {  id: xxx  })
			        		.done(function( data ) {
			        			//alert(data);
			        			
			        			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			        			 //var myArray = str1.split(':');
			        			if(str1=='OK') 
			        			{
			        				alert('刪除完成'); 
			        				$( "#cont" ).load('user_contr.jsp');
			        			}
			        			else
			        			{
			        				alert('刪除失敗');
			        				//  $( "#simpleedit" ).load('LocArea.jsp');
			        				$( "#cont" ).load('user_contr.jsp');
			        			} 
			        			
			        			
			        		});
			       	 
			        	},
			        	 '取消': function() {
			        		$( this ).dialog( "close" );
			        	}
			        	
			      }
			    });
			  });
	}
	else if(y1==12){
		 $(function() {
			    $( "#simpleConfirm" ).dialog({
			    	closeIcon: true,
			    	resizable: false,
			    	height:140,
			    	modal: true,
			    	buttons: {
			        "確定?": function() {
			        	
			        	 $( this ).dialog( "close" );
			        		$.post( "deleteLibrarian.jsp", {  id: xxx  })
			        		.done(function( data ) {
			        			//alert(data);
			        			
			        			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			        			 //var myArray = str1.split(':');
			        			if(str1=='OK') 
			        			{
			        				//alert('刪除完成'); 
			        				$( "#middle1" ).load('listlibrarian.jsp');
			        			}
			        			else
			        			{
			        				//alert('刪除失敗');
			        				//  $( "#simpleedit" ).load('LocArea.jsp');
			        				$( "#middle1" ).load('listlibrarian.jsp');
			        			} 
			        			
			        			
			        		});
			       	 
			        	},
			        	 '取消': function() {
			        		$( this ).dialog( "close" );
			        	}
			        	
			      }
			    });
			  });
	}
}

function go_detial(xxx)
{
	$('#simpleedit').load('listdetial.jsp?id='+xxx);
}

function go_list(xxx,roomtype,y1,y2,y3)
{
	if(y3==1)
	{
		$( "#middle1" ).load('listallseat.jsp?id='+xxx+"&fid="+y1+"&fcid="+y2+"&roomtype="+roomtype);
	}	
	else if(y3==2)
	{
		$( "#middle1" ).load('LocArea.jsp?id='+xxx+"&fid="+y1+"&fcid="+y2+"&roomtype="+roomtype);
	}	
}

function listseat(loc)
{
	var a = getRadioValue("g5");
	$( "#seat" ).load('listseat.jsp?area='+a+"&loc="+loc);
}

function goPage(url)
{
	//alert(url);
	//getChange(url,"","middle1");
	$( "#middle1" ).load(url);
}

function goPage1(url)
{
	//alert(url);
	//getChange(url,"","middle1");
	$( "#jerry" ).load(url);
}

function clearseat(xxx,y1,y2,y3){
	
	//$( "#simpleedit" ).load('clearseat.jsp?room_name='+xxx+'&area='+a);
	$( "#simpleConfirm"+y3 ).show();
	$(function() {
		$( "#simpleConfirm"+y3 ).dialog({
			resizable: false,
			height:250,
    		modal: true,
    		buttons: {
    		"是": function() {
    			$( this ).dialog( "close" );
    				$.post( "clearseat.jsp", { room_name:xxx,area:y1,loc:y2})
    				.done(function( data ) {
    					//alert(data);
    					var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
    					//alert(str1);
    					var myArray = str1.split(':');
    					if(str1=='OK') 
    					{
    						$("#seat").load("listseat.jsp?area="+y1+"&loc="+y2);
    					}	
    					if(str1=='NO')
    					{
    						$("#seat").load("listseat.jsp?area="+y1+"&loc="+y2, function () {
    							//alert('Load was performed.');
    						});
    				
    					}	
    					
    				
        				 
    			});
        	},
        	 '否': function() {
        		$( this ).dialog( "close" );
        	}
        	
    		}
		}).prev(".ui-dialog-titlebar").css("background","#FF9800");
	});
}

function go_news_page(urlToLoad)
{
	//alert(urlToLoad);
	
	 $('#middle1').load(urlToLoad, function () {
	       //alert('Load was performed.');
	 });
}

function getRadioValue(RadioName)
{
  var allNodes=document.getElementsByName(RadioName);
  for(var i=0; i<allNodes.length; i++)if(allNodes[i].checked)return(allNodes[i].value);
  return(null);
}

function checkbox(xxx,y1,y2){
	//alert($("input[name='g"+xxx+"']:checked"));
	if ( $( "input[name='g"+y2+"']" ).is( ":checked" ) == true){
	    //do something
		$.post( "addgfunc.jsp", {  gid: xxx,fcid:y1,fid:y2  })
		.done(function( data ) {
			//alert(data);
			//var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			//alert(GetCheckedValue("Item"+y2));
			//console.log(GetCheckedValue("Item"+y2));
		});
		   $("#fsel"+y2).show();
	}
	else
	{
		//delete group  
		$.post( "deleteGFunc.jsp", {  gid: xxx,fcid:y1,fid:y2  })
		.done(function( data ) {
			//alert(data);
			//var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			//alert(GetCheckedValue("Item"+y2));
			//console.log(GetCheckedValue("Item"+y2));
		});
		
		$("#fsel"+y2).hide();
	}	
	
	
	
	// $("#fsel"+this.value).show();
	

}

function addfunc(xxx,y1,y2,y3){
	
	
	if ( $( "input[name='I"+y3+y2+"']" ).is( ":checked" ) == true){
		$.post( "addgfunck.jsp", {  gid:xxx,fcid:y1,fid:y2,fck:y3  })
		.done(function( data ) {
			//alert(data);
		});
		
		if(y3==0)
		{
			$("input[name='I1"+y2+"']").attr('checked', false);
			$("input[name='I2"+y2+"']").attr('checked', false);
			$("input[name='I3"+y2+"']").attr('checked', false);
			$("input[name='I4"+y2+"']").attr('checked', false);
		}
		else
		{
			$("input[name='I0"+y2+"']").attr('checked', false);
		}	
	}
	else
	{
		$.post( "deleteGFunck.jsp", {  gid:xxx,fcid:y1,fid:y2,fck:y3  })
		.done(function( data ) {
			//alert(data);
		});
		
		
	}	
	
	
}

function goreal(loc,fid,fcid){
	$( "#middle1" ).load('real_status.jsp?loc='+loc+"&fid="+fid+"&fcid="+fcid);
}

function golistarea(roomtype){
	$( "#middle1" ).load('listarea.jsp?roomtype='+roomtype);
}

function go_log(xxx,y1){
	//alert(xxx);
	$.post( "writelog.jsp", {  fid:xxx,status:y1 })
	.done(function( data ) {
		//alert(data);
	});
}

function go_backup()
{
	var a = document.getElementById("g1").value;
	$("#s_backup").load("start_backup.jsp");
}

function go_backup1()
{
	var a = document.getElementById("g1").value;
	$("#s_backup").load("start_backup1.jsp");
}

function go_page(xxx){
	 $( "#srt" ).load(xxx);
}

function checkTime(i) {
    if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
    return i;
}


function GetCheckedValue(checkBoxName)
{
	return $('input:checkbox:checked[name='+checkBoxName+']').map(function() { return $(this).val(); }).get().join(',');
}
function isValidDate(dateString) {
	  var regEx = /^\d{4}-\d{2}-\d{2}$/;
	  if(!dateString.match(regEx))
	    return false;  // Invalid format
	  var d;
	  if(!((d = new Date(dateString))|0))
	    return false; // Invalid date (or this could be epoch)
	  return d.toISOString().slice(0,10) == dateString;
	}
