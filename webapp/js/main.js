jQuery(document).ready(function($){
	var gallery = $('.cd-gallery'),
		foldingPanel = $('.cd-folding-panel'),
		mainContent = $('.cd-main');
	/* open folding content */
	gallery.on('click', 'a', function(event){
		event.preventDefault();
		openItemInfo($(this).attr('href'));
	});

	/* close folding content */
	foldingPanel.on('click', '.cd-close', function(event){
		event.preventDefault();
		toggleContent('', false);
	});
	gallery.on('click', function(event){
		/* detect click on .cd-gallery::before when the .cd-folding-panel is open */
		if($(event.target).is('.cd-gallery') && $('.fold-is-open').length > 0 ) toggleContent('', false);
	})

	function openItemInfo(url) {
		var mq = viewportSize();
		if( gallery.offset().top > $(window).scrollTop() && mq != 'mobile') {
			/* if content is visible above the .cd-gallery - scroll before opening the folding panel */
			$('body,html').animate({
				'scrollTop': gallery.offset().top
			}, 100, function(){ 
	           	toggleContent(url, true);
	        }); 
	    } else if( gallery.offset().top + gallery.height() < $(window).scrollTop() + $(window).height()  && mq != 'mobile' ) {
			/* if content is visible below the .cd-gallery - scroll before opening the folding panel */
			$('body,html').animate({
				'scrollTop': gallery.offset().top + gallery.height() - $(window).height()
			}, 100, function(){ 
	           	toggleContent(url, true);
	        });
		} else {
			toggleContent(url, true);
		}
	}

	function toggleContent(url, bool) {
		if( bool ) {
			/* load and show new content */
			var foldingContent = foldingPanel.find('.cd-fold-content');
			foldingContent.load(url+' .cd-fold-content > *', function(event){
				setTimeout(function(){
					$('body').addClass('overflow-hidden');
					foldingPanel.addClass('is-open');
					mainContent.addClass('fold-is-open');
				}, 100);
				
			});
		} else {
			/* close the folding panel */
			var mq = viewportSize();
			foldingPanel.removeClass('is-open');
			mainContent.removeClass('fold-is-open');
			
			(mq == 'mobile' || $('.no-csstransitions').length > 0 ) 
				/* according to the mq, immediately remove the .overflow-hidden or wait for the end of the animation */
				? $('body').removeClass('overflow-hidden')
				
				: mainContent.find('.cd-item').eq(0).one('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function(){
					$('body').removeClass('overflow-hidden');
					mainContent.find('.cd-item').eq(0).off('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend');
				});
		}
		
	}

	function viewportSize() {
		/* retrieve the content value of .cd-main::before to check the actua mq */
		return window.getComputedStyle(document.querySelector('.cd-main'), '::before').getPropertyValue('content').replace(/"/g, "").replace(/'/g, "");
	}
});

function go_login(){
	
	var a = $('#account').val().trim();
	var b = $('#password').val().trim();
	//alert($('#login-btn').is('[disabled]'));
	if($('#login-btn').is('[disabled]')==false)
	{
		$.post( "login_ok.jsp", { account: a,password:b })
		  .done(function( data ) {
			  //alert(data);
			  if(data.trim() == 'true')
			  {
				  var url = "history.jsp";    
				  $(location).attr('href',url);
			  }
			  else
		      {
				 	  alert("帳號密碼輸入錯誤，或者帳號不允許登入!");
					  var url = "login.jsp";    
					  $(location).attr('href',url);
				 
		      }		  
			  
		  });
	}	
	else
	{
		alert("請畫出畫面上的圖型才能登入!");
		 
		  $.get( "login.jsp", { account: a,password:b } );
	}
}

function go_logout(){
	
	$.post( "logout_ok.jsp")
	  .done(function( data ) {
		  //alert(data);
		  if(data.trim() == 'OK')
		  {
			  var url = "login.jsp";    
			  $(location).attr('href',url);
		  }
		 	  
		  
	  });
}


function go_histroy(){
	$.post( "history.jsp")
	  .done(function( data ) {
		  var htmlString = data;
		  $("#middle1").html( htmlString );
	  });
}


function go_point(){
	$.post( "point.jsp")
	  .done(function( data ) {
		  var htmlString = data;
		  $("#middle1").text( htmlString );
	  });
}