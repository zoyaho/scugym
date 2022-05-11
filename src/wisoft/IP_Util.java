package wisoft;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.StringTokenizer;

public class IP_Util extends getData {
  int i = 0;
  
  int up = 0;
  
  public boolean getLeagle_ip(String rip) throws SQLException, IOException {
    boolean ip_flag = false;
    String chk_ip = "";
    init("ip_admin");
    queryMe("CURDATE() between starttime and endtime");
    this.i = 0;
    this.up = showCount();
    while (this.i < this.up) {
      chk_ip = showData("ip", this.i);
      if (!chk_ip.equals("*.*.*.*")) {
        if (chk_ip.indexOf(";") != -1) {
          String[] tmp_ip = chk_ip.split(";");
          for (int i = 0; i < tmp_ip.length; i++) {
            ip_flag = checkip(rip, tmp_ip[i]);
            if (ip_flag)
              break; 
          } 
        } else if (chk_ip.indexOf("*") == -1) {
          if (chk_ip.equals(rip))
            ip_flag = true; 
        } else {
          String tmp_ip = chk_ip.substring(0, chk_ip.indexOf("*"));
          if (rip.indexOf(tmp_ip) != -1)
            ip_flag = true; 
        } 
      } else {
        ip_flag = true;
      } 
      this.i++;
    } 
    return ip_flag;
  }
  
  private boolean checkip(String rip, String cip) {
    boolean flag = false;
    StringTokenizer rst = new StringTokenizer(rip, ".");
    String[] tmprst = new String[4];
    String[] tmpst = new String[4];
    int i = 0;
    StringTokenizer st = new StringTokenizer(cip, ".");
    i = 0;
    while (st.hasMoreTokens()) {
      tmpst[i] = st.nextToken();
      i++;
    } 
    i = 0;
    while (rst.hasMoreTokens()) {
      tmprst[i] = rst.nextToken();
      i++;
    } 
    if (tmprst[0].equals(tmpst[0])) {
      flag = true;
      if (tmprst[1].equals(tmpst[1])) {
        flag = true;
        if (tmpst[2].indexOf("*") != -1) {
          flag = true;
          if (tmpst[3].indexOf("*") != -1) {
            flag = true;
          } else if (tmpst[3].indexOf("-") != -1) {
            StringTokenizer tip = new StringTokenizer(tmpst[3], "-");
            String[] tiprang = new String[2];
            int j = 0;
            while (tip.hasMoreTokens()) {
              tiprang[j] = tip.nextToken();
              j++;
            } 
            if (Integer.parseInt(tmprst[3]) >= Integer.parseInt(tiprang[0]) && Integer.parseInt(tmprst[3]) <= Integer.parseInt(tiprang[1])) {
              flag = true;
            } else {
              flag = false;
            } 
          } else if (tmprst[3].equals(tmpst[3])) {
            flag = true;
          } else {
            flag = false;
          } 
        } else if (tmpst[2].indexOf("-") != -1) {
          StringTokenizer tip = new StringTokenizer(tmpst[2], "-");
          String[] tiprang = new String[2];
          int j = 0;
          while (tip.hasMoreTokens()) {
            tiprang[j] = tip.nextToken();
            j++;
          } 
          if (Integer.parseInt(tmprst[2]) >= Integer.parseInt(tiprang[0]) && Integer.parseInt(tmprst[2]) <= Integer.parseInt(tiprang[1])) {
            flag = true;
          } else {
            flag = false;
          } 
        } else if (tmpst[3].indexOf("-") != -1) {
          StringTokenizer tip1 = new StringTokenizer(tmpst[3], "-");
          String[] tiprang1 = new String[2];
          int k = 0;
          while (tip1.hasMoreTokens()) {
            tiprang1[k] = tip1.nextToken();
            k++;
          } 
          if (Integer.parseInt(tmprst[3]) >= Integer.parseInt(tiprang1[0]) && Integer.parseInt(tmprst[3]) <= Integer.parseInt(tiprang1[1])) {
            flag = true;
          } else {
            flag = false;
          } 
        } else if (tmprst[2].equals(tmpst[2])) {
          flag = true;
          if (tmprst[3].equals(tmpst[3])) {
            flag = true;
          } else if (tmpst[3].indexOf("*") != -1) {
            flag = true;
          } else {
            flag = false;
          } 
        } else {
          flag = false;
        } 
      } else {
        flag = false;
      } 
    } else {
      flag = false;
    } 
    return flag;
  }
  
  public String getAddress() {
    try {
      InetAddress localIp = InetAddress.getLocalHost();
      String ip = localIp.getHostAddress();
      return ip;
    } catch (UnknownHostException unknownHostException) {
      return null;
    } 
  }
  
  public boolean FirstLogin(String userid) throws IOException, SQLException {
    try {
      boolean result = false;
      init("user_reg");
      queryMe("userid='" + userid + "'");
      this.i = 0;
      this.up = showCount();
      while (this.i < this.up) {
        String usrid = showData("userid", this.i);
        String passwd = showData("passwd", this.i);
        if (usrid.equals(passwd))
          result = true; 
        this.i++;
      } 
      return result;
    } catch (Exception e) {
      return false;
    } finally {
      closeall();
    } 
  }
  
  public long calculateMonthDifference(String from, String to) {
    try {
      SimpleDateFormat myFormatter = new SimpleDateFormat("yyyy/MM/dd");
      Date date1 = myFormatter.parse(from);
      Date date2 = myFormatter.parse(to);
      long day = (date2.getTime() - date1.getTime()) / 86400000L;
      return day;
    } catch (Exception e) {
      return 0L;
    } 
  }
  
  public boolean chk_starttime(String starttime) {
    boolean result = false;
    Calendar rightNow = Calendar.getInstance();
    String date = Integer.toString(rightNow.get(5));
    if (date.length() == 1)
      date = "0" + date; 
    String month = Integer.toString(rightNow.get(2) + 1);
    if (month.length() == 1)
      month = "0" + month; 
    String year = Integer.toString(rightNow.get(1));
    String start_year = starttime.substring(0, 4);
    String start_month = starttime.substring(4, 6);
    String start_date = starttime.substring(6, 8);
    String from = String.valueOf(start_year) + "/" + start_month + "/" + start_date;
    String to = String.valueOf(year) + "/" + month + "/" + date;
    try {
      SimpleDateFormat myFormatter = new SimpleDateFormat("yyyy/MM/dd");
      Date date1 = myFormatter.parse(from);
      Date date2 = myFormatter.parse(to);
      long day = (date2.getTime() - date1.getTime()) / 86400000L;
      if (day >= 0L)
        result = true; 
    } catch (Exception exception) {}
    return result;
  }
  
  public boolean Invalidate_Pass(String duration, String pswsetdate, String lstacttime) {
    boolean result = false;
    long dur = Integer.parseInt(duration);
    String psw_year = pswsetdate.substring(0, 4);
    String psw_month = pswsetdate.substring(4, 6);
    String psw_date = pswsetdate.substring(6, 8);
    String from = String.valueOf(psw_year) + "/" + psw_month + "/" + psw_date;
    String act_yr = lstacttime.substring(0, 4);
    String act_mn = lstacttime.substring(4, 6);
    String act_dy = lstacttime.substring(6, 8);
    String to = String.valueOf(act_yr) + "/" + act_mn + "/" + act_dy;
    long days = calculateMonthDifference(from, to);
    if (days == dur)
      result = true; 
    return result;
  }
}
