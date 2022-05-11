/**
 * 
 */

function golink(xxx){
	if(xxx=1)
	{
		window.location.href="./tb1/index.jsp";	
	}	
	else if(xxx=2)
	{
		window.location.href="./tb2/index.jsp";	
	}	
	
}

function bookseat(xxx,y1,y2){
	//alert(xxx+"/"+y1);
	
	//$( "#book" ).load('step3_save.jsp?sysid='+xxx+'&area='+y1);
	
	if(y2=='0')
	{
		$.post( "step3_save.jsp", { sysid:xxx,area:y1})
		
		.done(function( data ) {
			//alert(data);
			var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			//alert(str1);
			var myArray = str1.split(':');
			if(myArray[0]=='success') 
			{
				$("#book").load("success.jsp?id="+myArray[1]);
			}	
			if(myArray[0]=='fail')
			{
				$("#book").load("faile.jsp", function () {
		        //alert('Load was performed.');
				});
			
			}	
			if(myArray[0]=='exist')
			{
			
				$(function() {
					$( "#simpleConfirm" ).dialog({
						closeIcon: true,
						resizable: false,
						height:250,
			    		modal: true,
			    		buttons: {
			    		"是": function() {
			        	
			    				$( this ).dialog( "close" );
			    				//window.location.href = "step3_change.jsp?rid="+myArray[1]+"&area="+y1;
			    				$.post( "step3_change.jsp", { sysid:xxx,area:y1})
			    				.done(function( data ) {
			    					//alert(data);
			    					var str1 = data.replace(/(^\s*)|(\s*$)/g, "");
			    					//alert(str1);
			    					var myArray = str1.split(':');
			    					if(myArray[0]=='success') 
			    					{
			    						$("#book").load("success.jsp?id="+myArray[1]);
			    					}	
			    					if(myArray[0]=='fail')
			    					{
			    						$("#book").load("faile.jsp", function () {
			    							//alert('Load was performed.');
			    						});
			    				
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
			if(myArray[0]=='inused')
			{
				window.location.replace('step2.jsp');
			}
			 
		});
		
	}
	
	
}

function goSelect()
{
	window.location.href = "change.jsp";
}

function goTempout()
{
	window.location.href = "tmpout.jsp";
}