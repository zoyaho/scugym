var xmlHttp;
	

function CurentTime(){
    const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    const weekNames = ["Sun", "Mon", "Tue", "Wed","Thu", "Fri", "Sat"];
    var today = new Date();
    var h = today.getHours();
    var m = today.getMinutes();
    var d = today.getDate();
    var mmn = monthNames[today.getMonth()];
    var mm = today.getMonth()+1;    
    var w = weekNames[today.getDay()];
    var ampm = h >= 12 ? 'pm' : 'am';
    h = checkTime(h);
    m = checkTime(m);
    mm = checkTime(mm);
    d = checkTime(d);
   
    document.getElementById('time').innerText = h + "：" + m + " " + ampm ;
    document.getElementById('date').innerText =mmn + " " + d ;
    document.getElementById('day').innerText = w ;
    //goreload();
    var t = setTimeout(CurentTime, 1000);
}

function checkTime(i) {
    if (i < 10) {i = "0" + i};
    return i;
}



window.onload=CurentTime();