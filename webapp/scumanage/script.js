$(document).ready(function() {
		$menuLeft = $('.pushmenu-left');
		$nav_list = $('#nav_list');
		
		$nav_list.click(function() {
			$(this).toggleClass('active');
			$('.pushmenu-push').toggleClass('pushmenu-push-toright');
			$menuLeft.toggleClass('pushmenu-open');
		});
		
		
		if($( window ).width() > 768)
		{
			$(this).toggleClass('active');
			$('.pushmenu-push').toggleClass('pushmenu-push-toright');
			$menuLeft.toggleClass('pushmenu-open');
		}
		else
		{
			$menuLeft = $('.pushmenu-left');
			$nav_list = $('#nav_list');
			
			
		}	
	});