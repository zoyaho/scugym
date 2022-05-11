<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-Hant-TW">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
  <link rel="icon" href="images/favicon.ico" type="image/x-icon" />
  <meta property="fb:app_id" content="" />
  <meta property="og:title" content="東吳大學討論室" />
  <meta property="og:type" content="activity" />
  <meta property="og:url" content="" />
  <meta property="og:description" content="" />

  <meta property="og:image" content="/images/1200x628.jpg" />
  <meta property="og:image:type" content="image/jpeg">
  <meta property="og:image:width" content="1200">
  <meta property="og:image:height" content="628">

  <title>東吳大學自修室</title>

  
  <link href="https://fonts.googleapis.com/css?family=Nunito+Sans" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+TC:400, 500,300,700&display=swap" rel="stylesheet">

  <!-- JS -->  
  <script src="assets/js/jquery-2.0.0.min.js"></script>
  <!-- CSS -->
  <link rel="stylesheet" href="css/reset.css"> 
  <link rel="stylesheet" href="css/layout.css"> 
  <link rel="stylesheet" href="css/login.css"> 
    <link rel="stylesheet" href="css/jquery.motionCaptcha.0.2.css?ez_orig=1" />
 </head>
<%
	String account="";
	String pass="";
	
	if(request.getParameter("account")!=null)
	{
		account = request.getParameter("account");
	}	
	
	if(request.getParameter("password")!=null)
	{
		pass = request.getParameter("password");
	}	
	

%>
<body id="login">
<!--
  <div id="ham" class="mb-only-b" >
    <span></span>
    <span></span>
    <span></span>
  </div>
  <div id="ham-content" class="mb-only-b">
    <ul>
      <li class="ham-icon1">
        <a href="#">      	
      	    <svg id="hamicon1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120">
      	      <rect class="cls-1" x="-7.5" y="-7.17" width="137.51" height="133"/>
      	      <rect class="cls-2" x="1.5" y="1.5" width="117" height="117"/>
      	      <polyline class="cls-3" points="56.77 28.3 70.14 28.3 70.14 67.1 37.07 67.1 37.07 28.3 48.24 28.3"/>
      	      <polyline class="cls-3" points="48.53 27.97 48.53 19.21 79.7 19.21 79.7 57.99 70.52 57.99"/>
      	      <line class="cls-4" x1="46.03" y1="38.14" x2="46.03" y2="38.14"/>
      	      <line class="cls-4" x1="46.72" y1="38.14" x2="46.72" y2="38.14"/>
      	      <line class="cls-4" x1="54.15" y1="38.07" x2="62.35" y2="38.07"/>
      	      <line class="cls-4" x1="46.03" y1="47.25" x2="46.03" y2="47.25"/>
      	      <line class="cls-4" x1="46.72" y1="47.25" x2="46.72" y2="47.25"/>
      	      <line class="cls-4" x1="54.15" y1="47.18" x2="62.35" y2="47.18"/>
      	      <text class="cls-5" transform="matrix(1, 0, 0, 1, 26.76, 90.14)">
      	      借用紀錄</text>
      	      <text class="cls-6" transform="matrix(1, 0, 0, 1, 41.12, 104.64)">
      	      A<tspan class="cls-7" x="5.43" y="0">
      	      C</tspan>
      	      <tspan class="cls-8" x="10.96" y="0">
      	      TIVI</tspan>
      	      <tspan class="cls-9" x="27.78" y="0">
      	      T</tspan>
      	      <tspan class="cls-8" x="33.03" y="0">
      	      Y</tspan>
      	      </text>
      	      </svg>            
        </a>
      </li>
      <li class="ham-icon2">
        <a href="#">
            <svg id="hamicon2" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120">
              <rect class="cls-1" x="-7.5" y="-7.17" width="137.51" height="133"/>
              <rect class="cls-2" x="1.5" y="1.5" width="117" height="117"/>
              <polyline class="cls-3" points="47.95 38.75 40.3 38.75 40.3 20.54 58.51 20.54 58.51 38.75 48.88 29.13"/>
              <rect class="cls-3" x="65.9" y="20.54" width="18.21" height="18.21"/>
              <rect class="cls-3" x="40.3" y="45.66" width="18.21" height="18.21"/>
              <polyline class="cls-3" points="76.46 45.53 84.11 45.53 84.11 63.74 65.9 63.74 65.9 45.53 75.64 55.28"/>
              <text class="cls-4" transform="matrix(1, 0, 0, 1, 26.76, 90.14)">即時座位
              </text>
              <text class="cls-5" transform="matrix(1, 0, 0, 1, 47.5, 104.64)">MENU
              </text>
            </svg>
        </a>
      </li>
      <li class="ham-icon3">
        <a href="#">          
          <svg id="hamicon3"  xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120">
            <rect class="cls-1" x="-11.5" y="-5.17" width="137.51" height="133"/>
            <rect class="cls-2" x="1.5" y="1.5" width="117" height="117"/>
            <path class="cls-3" d="M37,36.88a23.72,23.72,0,1,1-.34,9.94"/>
            <polyline class="cls-3" points="76 42 45 42 52.07 49.07"/>
            <line class="cls-3" x1="45" y1="42" x2="52.07" y2="34.93"/>
            <text class="cls-4" transform="matrix(1, 0, 0, 1, 44.36, 90.13)">登出
            </text>
            <text class="cls-5" transform="matrix(1, 0, 0, 1, 42.29, 104.64)">L
            <tspan class="cls-6" x="4.71" y="0">OGOUT
            </tspan>
            </text>
          </svg>
        </a>
      </li>
    </ul>
  </div>
  -->
  <aside id="aside"> until a full-grown man </aside>
    <nav id="nav">
        <div id="nav-logo">
          <span class="img logo1"></span>
        </div>
        <div id="time-wrap">
          <span id="time">09:30 a.m.</span> , <span id="date">May 22</span> , <span id="day">Thu</span>
        </div>
    </nav>
  

    <article class="login-wrap">
      <form class="login mc-active" id="mc-form">
          <div id="login-title">使用者登入<span>Login</span></div>
          <ul id="login-inputs">
              <li>
                  <span class="img icon account-icon"></span>
                  <label for="account">帳號 account</label>
                  <input type="text" id="account" value="<%=account %>" >
              </li>
              <li>
                  <span class="img icon password-icon"></span>
                  <label for="password">密碼 password</label>
                  <input type="password" id="password" value="<%=pass %>">
              </li>
              <li>
                   
                  <div class="text">
                  <span class="img icon verifycode-icon"></span>
                  <label>驗證碼 verification code </label> 
							<a onclick="reload();" href="javascript: void(0)" title="產生新圖案">產生新圖案</a>
				  </div>
                  <div id="code">
                  <div class='input' style="z-index:99;">
							<canvas id="mc-canvas" style="margin-left:-0px">></canvas>
 							</div>
 							
 			      </div>
                  <a href="#" class="img icon" id="login-btn" disabled   onclick="go_login();">
                      <svg id="loginbtn" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 120 120">
                      <rect class="cls-1" x="1.5" y="1.5" width="117" height="117"/>
                      <text class="cls-2" transform="matrix(1, 0, 0, 1, 44.36, 90.13)">登入
                      </text>
                      <polyline class="cls-3" points="45.5 42.61 76.5 42.61 69.42 35.54"/>
                      <path class="cls-3" d="M79.56,28.55A23.69,23.69,0,1,1,72.08,22"/>
                      <line class="cls-3" x1="76.5" y1="42.61" x2="69.43" y2="35.54"/>
                      <line class="cls-3" x1="76.5" y1="42.61" x2="69.43" y2="49.68"/>
                      <text class="cls-4" transform="matrix(1, 0, 0, 1, 46.74, 104.64)">L
                      <tspan class="cls-5" x="4.71" y="0">OGIN
                      </tspan>
                      </text>
                      </svg>
                  </a>
              </li>
          </ul>
      </form>
  </article>

    
  <div id="position">
    <footer >
        <span class="mb-only img" id="corner-animate"></span>
      <span class="pc-only-ib img " id="corner-animation"></span>
    </footer>
  </div>
  

 <script src="js/jquery-3.1.1.min.js"></script>
		<script src="js/jquery-ui.min.js"></script>
		<script src="js/jquery.motionCaptcha.0.2.js"></script>
		<script src="js/main.js"></script>
  <script src="js/common.js"></script>
  <script src="js/login.js"></script>
 
		<script type="text/javascript">
		// Do the biznizz:
		$('#mc-form').motionCaptcha();
		
		function reload(){
			//alert('1');
			var a = $("#account").val();
			var b = $("#password").val();
			$( "#login" ).load( "login1.jsp", { account:a, password:b,v:new Date().getTime()} );
			
		}
	
		
		  $("#password").keypress(function (e) {
	            if (e.which == 13) {
	            	go_login();
	                return false;
	            }
	        });
		  
		
		</script>
  <script>
  </script>
</body>


</html>
    
    
    
