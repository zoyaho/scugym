package wisoft;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Random;
import org.htmlparser.Node;
import org.htmlparser.NodeFactory;
import org.htmlparser.NodeFilter;
import org.htmlparser.Parser;
import org.htmlparser.PrototypicalNodeFactory;
import org.htmlparser.Tag;
import org.htmlparser.http.ConnectionManager;
import org.htmlparser.lexer.Page;
import org.htmlparser.tags.CompositeTag;
import org.htmlparser.util.NodeList;

public class Utility extends QueryDB {
  private String xmlURLStringsuc = "https://api.sys.scu.edu.tw/query/LibSeatAuth.ashx";
  
  ResultSet rs = null;
  
  ResultSet rs1 = null;
  
  public static void main(String[] args) {}
  
  private String nowtime = null;
  
  private String qry_sql = null;
  
  private String ret_value = null;
  
  private String[] tmp;
  
  private String num = "0123456789";
  
  private String Cdate = "";
  
  private int rs_count = 0;
  
  private int i = 0;
  
  private int lg = 0;
  
  private int rs_count1 = 0;
  
  private int rtval = 0;
  
  private String source = "ABCDEFGHJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz0123456789*^$()@!-/:~}{][";
  
  private String source1 = "ABCDEFGHJKLMNOPQRSTUVWXYZ0123456789";
  
  private String source2 = "0123456789";
  
  private String ncode = "";
  
  private int j = 0;
  
  private int k = 0;
  
  private int m = 0;
  
  private Random rd = new Random();
  
  private int perpage = 10;
  
  private int totalpage = 0;
  
  private int totalitem = 0;
  
  private int pagebegin = 0;
  
  private int pageend = 0;
  
  private int pagefirst = 0;
  
  private int pagelast = 0;
  
  private int pagenumber = 10;
  
  private int tmp_int = 0;
  
  private int tmp1 = 0;
  
  public void closeall() throws IOException, SQLException {
    super.closeall();
    if (this.rs != null)
      this.rs.close(); 
  }
  
  public static String getNotNull(Object obj) {
    Object obj1;
    if (obj == null || String.valueOf(obj).length() == 0 || obj.equals("null")) {
      obj1 = "";
    } else {
      obj1 = obj;
    } 
    if (String.valueOf(obj1).length() == 0)
      return String.valueOf(obj1); 
    if (String.valueOf(obj1).indexOf("'") != -1) {
      obj1 = String.valueOf(obj1).replaceAll("'", "&apos;");
    } else if (String.valueOf(obj1).indexOf("SingleQuote") != -1) {
      obj1 = String.valueOf(obj1).replaceAll("SingleQuote", "'");
    } 
    if (String.valueOf(obj1).indexOf("\"") != -1) {
      obj1 = String.valueOf(obj1).replaceAll("\"", "&quot;");
    } else if (String.valueOf(obj1).indexOf("DoubleQuote") != -1) {
      obj1 = String.valueOf(obj1).replaceAll("DoubleQuote", "\"");
    } 
    if (String.valueOf(obj1).indexOf("& #39;") != -1)
      obj1 = String.valueOf(obj1).replaceAll("& #39;", "&#39;"); 
    if (String.valueOf(obj1).indexOf("& #40;") != -1)
      obj1 = String.valueOf(obj1).replaceAll("& #40;", "&#40;"); 
    if (String.valueOf(obj1).indexOf("& lt;") != -1)
      obj1 = String.valueOf(obj1).replaceAll("& lt;", "&lt;"); 
    if (String.valueOf(obj1).indexOf("& gt;") != -1)
      obj1 = String.valueOf(obj1).replaceAll("& gt;", "&gt;"); 
    if (String.valueOf(obj1).indexOf("&gt;") != -1)
      obj1 = String.valueOf(obj1).replaceAll("&gt;", ">"); 
    if (String.valueOf(obj1).indexOf("&lt;") != -1)
      obj1 = String.valueOf(obj1).replaceAll("&lt;", "<"); 
    return String.valueOf(obj1);
  }
  
  public String getCdate() throws IOException, SQLException {
    return this.Cdate;
  }
  
  public int dayformat(String st) throws IOException, SQLException {
    this.Cdate = "";
    if (st.indexOf("-") == -1)
      return 1; 
    this.tmp = st.split("-");
    if (this.tmp.length == 3) {
      this.i = 0;
      while (this.i < this.tmp[0].length()) {
        if (this.num.indexOf(this.tmp[0].substring(this.i, this.i + 1)) == -1)
          return 3; 
        this.i++;
      } 
      this.i = 0;
      while (this.i < this.tmp[1].length()) {
        if (this.num.indexOf(this.tmp[1].substring(this.i, this.i + 1)) == -1)
          return 3; 
        this.i++;
      } 
      this.i = 0;
      while (this.i < this.tmp[2].length()) {
        if (this.num.indexOf(this.tmp[2].substring(this.i, this.i + 1)) == -1)
          return 3; 
        this.i++;
      } 
      if (this.tmp[0].length() < 3)
        return 4; 
      if (this.tmp[0].length() > 4)
        return 5; 
      if (this.tmp[1].length() > 2)
        return 6; 
      if (this.tmp[2].length() > 2)
        return 7; 
      if (Integer.parseInt(this.tmp[1]) > 12)
        return 6; 
      if (Integer.parseInt(this.tmp[2]) > 31)
        return 7; 
      if ((Integer.parseInt(this.tmp[1]) == 4 || Integer.parseInt(this.tmp[1]) == 6 || Integer.parseInt(this.tmp[1]) == 9 || Integer.parseInt(this.tmp[1]) == 11) && 
        Integer.parseInt(this.tmp[2]) > 30)
        return 9; 
      if (Integer.parseInt(this.tmp[1]) == 2 && Integer.parseInt(this.tmp[2]) > 29)
        return 8; 
      if (Integer.parseInt(this.tmp[1]) == 2)
        if (Integer.parseInt(this.tmp[0]) % 4 > 0) {
          if (Integer.parseInt(this.tmp[2]) > 28)
            return 10; 
        } else if (Integer.parseInt(this.tmp[2]) > 29) {
          return 8;
        }  
      this.Cdate = String.valueOf(this.Cdate) + this.tmp[0] + "-";
      if (this.tmp[1].length() == 1) {
        this.Cdate = String.valueOf(this.Cdate) + "0" + this.tmp[1] + "-";
      } else {
        this.Cdate = String.valueOf(this.Cdate) + this.tmp[1] + "-";
      } 
      if (this.tmp[2].length() == 1) {
        this.Cdate = String.valueOf(this.Cdate) + "0" + this.tmp[2];
      } else {
        this.Cdate = String.valueOf(this.Cdate) + this.tmp[2];
      } 
      return 0;
    } 
    return 2;
  }
  
  public Boolean onlynumber(String st) throws IOException, SQLException {
    return checknumber(st);
  }
  
  public Boolean onlynumber(int n) throws IOException, SQLException {
    return Boolean.valueOf(true);
  }
  
  public String addBR(String str) throws IOException, SQLException {
    this.tmp = str.split("\n");
    this.i = 0;
    this.ret_value = "";
    this.lg = this.tmp.length;
    while (this.i < this.lg) {
      this.ret_value = String.valueOf(this.ret_value) + this.tmp[this.i];
      this.i++;
      if (this.i < this.lg)
        this.ret_value = String.valueOf(this.ret_value) + "<br>"; 
    } 
    return this.ret_value;
  }
  
  public Boolean dup_field(String tb, String fd, String vl) throws IOException, SQLException {
    this.rs_count = 0;
    this.qry_sql = "select " + fd + " from " + tb + " where " + fd + "= '" + vl + "' ";
    this.rs = queryData(this.qry_sql);
    this.rs.last();
    this.rs_count = this.rs.getRow();
    if (this.rs_count == 0)
      return Boolean.valueOf(false); 
    return Boolean.valueOf(true);
  }
  
  public Boolean dup_field(String tb, String fd, int vl) throws IOException, SQLException {
    this.rs_count = 0;
    this.qry_sql = "select " + fd + " from " + tb + " where " + fd + "=" + vl + " ";
    this.rs = queryData(this.qry_sql);
    this.rs.last();
    this.rs_count = this.rs.getRow();
    if (this.rs_count == 0)
      return Boolean.valueOf(false); 
    return Boolean.valueOf(true);
  }
  
  public String getMM() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("mm")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String getHH() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("HH")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String getHHMM() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("HH:mm")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String getNewHHMM(String myTime, int minsToAdd) throws IOException, SQLException, ParseException {
    SimpleDateFormat df = new SimpleDateFormat("HH:mm");
    Date d = df.parse(myTime);
    Calendar cal = Calendar.getInstance();
    cal.setTime(d);
    cal.add(12, minsToAdd);
    String newTime = df.format(cal.getTime());
    return newTime;
  }
  
  public boolean ckCloseTime(int weekday) throws IOException, SQLException, ParseException {
    Date clostime;
    SimpleDateFormat parser = new SimpleDateFormat("HH:mm");
    boolean close = false;
    if (weekday == 1) {
      clostime = parser.parse("17:00");
    } else {
      clostime = parser.parse("22:00");
    } 
    try {
      Date userDate = parser.parse(getHHMM());
      if (userDate.after(clostime))
        close = true; 
    } catch (ParseException parseException) {}
    return close;
  }
  
  public int getYear() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("yyyy")).format(rightNow.getTime());
    return Integer.parseInt(this.nowtime);
  }
  
  public int getMonth() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("MM")).format(rightNow.getTime());
    return Integer.parseInt(this.nowtime);
  }
  
  public String getMonthString() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("MM")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public int getDate() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("dd")).format(rightNow.getTime());
    return Integer.parseInt(this.nowtime);
  }
  
  public int getDayOfWeek() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    int nowtime = rightNow.get(7);
    return nowtime;
  }
  
  public int getDayOfWeek(int year, int month, int day) throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    rightNow.clear();
    rightNow.set(1, year);
    rightNow.set(2, month - 1);
    rightNow.set(5, day);
    int nowtime = rightNow.get(7);
    return nowtime;
  }
  
  public int getDayofMonth(int year, int month) throws IOException, SQLException {
    Calendar cal = Calendar.getInstance();
    cal.set(2, month);
    int dayOfMonth = cal.getActualMaximum(5);
    return dayOfMonth;
  }
  
  public String getMonthForInt(int num) {
    String month = "wrong";
    DateFormatSymbols dfs = new DateFormatSymbols(Locale.US);
    String[] months = dfs.getShortMonths();
    if (num >= 0 && num <= 11)
      month = months[num]; 
    return month;
  }
  
  public String weekDay(int num) {
    String week = "wrong";
    DateFormatSymbols dfs = new DateFormatSymbols(Locale.US);
    String[] weekDaysNameArray = dfs.getShortWeekdays();
    if (num >= 0 && num <= 11)
      week = weekDaysNameArray[num]; 
    return week;
  }
  
  public String weekDay(int num, String locale) {
    DateFormatSymbols dfs;
    String week = "wrong";
    if (locale.equals("zh")) {
      dfs = new DateFormatSymbols(Locale.TAIWAN);
    } else {
      dfs = new DateFormatSymbols(Locale.US);
    } 
    String[] weekDaysNameArray = dfs.getShortWeekdays();
    if (num >= 0 && num <= 11)
      week = weekDaysNameArray[num]; 
    return week;
  }
  
  public String addMonth(int n, String start_date) throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    String[] rs_splis = start_date.split("-");
    rightNow.set(1, Integer.parseInt(rs_splis[0]));
    rightNow.set(2, Integer.parseInt(rs_splis[1]) - 1);
    rightNow.set(5, Integer.parseInt(rs_splis[2]));
    rightNow.add(2, n);
    this.nowtime = (new SimpleDateFormat("yyyy-MM-dd")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String today() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("yyyy-MM-dd")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String today(int n) throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    rightNow.add(5, n);
    this.nowtime = (new SimpleDateFormat("yyyy-MM-dd")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String MonthofToday(int n) throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    rightNow.add(5, n);
    this.nowtime = (new SimpleDateFormat("yyyyMM")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String todaytime(int m, int n) throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    rightNow.add(12, n);
    switch (m) {
      case 0:
        this.nowtime = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(rightNow.getTime());
        return this.nowtime;
      case 1:
        this.nowtime = (new SimpleDateFormat("yyyyMMddHHmmss")).format(rightNow.getTime());
        return this.nowtime;
      case 2:
        this.nowtime = (new SimpleDateFormat("yyyyMMddHHmmssSSS")).format(rightNow.getTime());
        return this.nowtime;
      case 3:
        this.nowtime = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS")).format(rightNow.getTime());
        return this.nowtime;
    } 
    this.nowtime = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String todaytime() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String todaytime1() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("yyyyMMddHHmmss")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String todaytime2() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("yyyyMMddHHmmssSSS")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String todaytimelong() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("yyyyMMddHHmmssSSS")).format(rightNow.getTime());
    this.nowtime = String.valueOf(this.nowtime) + addzero(Integer.toString(givemenumber(0, 100)), 3);
    return this.nowtime;
  }
  
  public String todaytime3() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String todaytime_hhmm() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("yyyy-MM-dd HH:mm")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String addHour(int n) throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    rightNow.add(11, n);
    this.nowtime = (new SimpleDateFormat("yyyy-MM-dd HH:mm")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String YearMonth() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("yyyyMM")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public String YearMonth(int n) throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    rightNow.add(2, n);
    this.nowtime = (new SimpleDateFormat("yyyyMM")).format(rightNow.getTime());
    return this.nowtime;
  }
  
  public int getWeekDay(String st) throws IOException, SQLException {
    int get_week = 7;
    String get_sample = st;
    SimpleDateFormat get_sdf = new SimpleDateFormat("yyyy-MM-dd");
    try {
      Date get_date = get_sdf.parse(get_sample);
      Calendar get_cal = Calendar.getInstance();
      get_cal.setTime(get_date);
      get_week = get_cal.get(7);
    } catch (Exception exception) {}
    return get_week;
  }
  
  public String getDay(String st, int n) throws IOException, SQLException {
    String retval = "";
    String get_sample = st;
    SimpleDateFormat get_sdf = new SimpleDateFormat("yyyy-MM-dd");
    try {
      Date get_date = get_sdf.parse(get_sample);
      Calendar get_cal = Calendar.getInstance();
      get_cal.setTime(get_date);
      get_cal.add(5, n);
      retval = (new SimpleDateFormat("yyyy-MM-dd")).format(get_cal.getTime());
    } catch (Exception exception) {}
    return retval;
  }
  
  public int secretid(int n) throws IOException, SQLException {
    return (n + 2008) * 2 - 1911;
  }
  
  public int desecretid(int n) throws IOException, SQLException {
    return (n + 1911) / 2 - 2008;
  }
  
  public int givemenumber(int m, int n) throws IOException, SQLException {
    int retvals = 0;
    if (m < n)
      retvals = this.rd.nextInt(n - m); 
    retvals = m + retvals;
    return retvals;
  }
  
  public String gencode(int n) throws IOException, SQLException {
    this.ncode = "";
    this.i = 0;
    this.m = 0;
    this.k = 0;
    while (this.i < n) {
      this.j = this.rd.nextInt(this.source.length());
      this.k += this.source.substring(this.j, this.j + 1).hashCode() * (this.m + 1);
      this.ncode = String.valueOf(this.ncode) + this.source.substring(this.j, this.j + 1);
      this.m++;
      this.i++;
      if (this.i == n - 1) {
        this.j = this.k % this.source.length();
        this.ncode = String.valueOf(this.ncode) + this.source.substring(this.j, this.j + 1);
        this.m++;
        this.i++;
      } 
    } 
    return this.ncode;
  }
  
  public String gencode1(int n) throws IOException, SQLException {
    this.ncode = "";
    this.i = 0;
    this.m = 0;
    this.k = 0;
    while (this.i < n) {
      this.j = this.rd.nextInt(this.source1.length());
      this.k += this.source1.substring(this.j, this.j + 1).hashCode() * (this.m + 1);
      this.ncode = String.valueOf(this.ncode) + this.source1.substring(this.j, this.j + 1);
      this.m++;
      this.i++;
      if (this.i == n - 1) {
        this.j = this.k % this.source1.length();
        this.ncode = String.valueOf(this.ncode) + this.source1.substring(this.j, this.j + 1);
        this.m++;
        this.i++;
      } 
    } 
    return this.ncode;
  }
  
  public String gencode2(int n) throws IOException, SQLException {
    this.ncode = "";
    this.i = 0;
    this.m = 0;
    this.k = 0;
    while (this.i < n) {
      this.j = this.rd.nextInt(this.source2.length());
      this.k += this.source2.substring(this.j, this.j + 1).hashCode() * (this.m + 1);
      this.ncode = String.valueOf(this.ncode) + this.source2.substring(this.j, this.j + 1);
      this.m++;
      this.i++;
      if (this.i == n - 1) {
        this.j = this.k % this.source2.length();
        this.ncode = String.valueOf(this.ncode) + this.source2.substring(this.j, this.j + 1);
        this.m++;
        this.i++;
      } 
    } 
    return this.ncode;
  }
  
  public String subString(String st, int n) throws IOException, SQLException {
    if (st.length() > n)
      return String.valueOf(st.substring(0, n)) + "..."; 
    return st;
  }
  
  public String find_meString(String tb, String fd, String vl, String retfield) throws IOException, SQLException {
    return find_string("select " + retfield + " from " + tb + " where " + fd + "= '" + vl + "' ", retfield);
  }
  
  public String find_meString(String tb, String fd, int vl, String retfield) throws IOException, SQLException {
    return find_string("select " + retfield + " from " + tb + " where " + fd + "= " + vl + " ", retfield);
  }
  
  public int find_me(String tb, String fd, String vl, String retfield) throws IOException, SQLException {
    return find_sysid("select " + retfield + " from " + tb + " where " + fd + "= '" + vl + "' ", retfield);
  }
  
  public int find_me(String tb, String fd, int vl, String retfield) throws IOException, SQLException {
    return find_sysid("select " + retfield + " from " + tb + " where " + fd + "= " + vl + " ", retfield);
  }
  
  public int validPUID(String st) throws IOException, SQLException {
    String FC = "ABCDEFGHJKLMNPQRSTUVXYWZIO";
    int FN = FC.indexOf(st.substring(0, 1).toUpperCase());
    int SL = st.length();
    int AA = 9;
    this.rtval = 0;
    if (FN < 0 || !onlynumber(st.substring(1, SL)).booleanValue()) {
      this.rtval = 0;
    } else {
      FN += 10;
      if (SL == 10) {
        this.i = 1;
        this.rtval = FN / 10 + FN % 10 * AA;
        while (this.i < SL - 1) {
          this.rtval += Integer.parseInt(st.substring(this.i, this.i + 1)) * (AA - this.i);
          this.i++;
        } 
        if (this.rtval % 10 > 0) {
          this.rtval = 10 - this.rtval % 10;
        } else {
          this.rtval = 0;
        } 
        if (this.rtval == Integer.parseInt(st.substring(SL - 1, SL))) {
          this.rtval = 99;
        } else {
          this.rtval = 0;
        } 
      } else {
        this.rtval = 0;
      } 
    } 
    return this.rtval;
  }
  
  private int find_sysid(String sql, String ff) throws IOException, SQLException {
    this.rs_count = 0;
    this.rs = queryData(sql);
    this.rs.last();
    this.rs_count = this.rs.getRow();
    if (this.rs_count > 0) {
      this.rs.beforeFirst();
      while (this.rs.next())
        this.rs_count = this.rs.getInt(ff); 
    } 
    return this.rs_count;
  }
  
  private String find_string(String sql, String ff) throws IOException, SQLException {
    String retString = "";
    this.rs_count1 = 0;
    this.rs1 = queryData(sql);
    this.rs1.last();
    this.rs_count1 = this.rs1.getRow();
    if (this.rs_count1 > 0) {
      this.rs1.beforeFirst();
      while (this.rs1.next())
        retString = getNotNull(this.rs1.getObject(ff)); 
    } 
    return retString;
  }
  
  private static final String[] hexDigits = new String[] { 
      "0", "1", "2", "3", "4", "5", "6", "7", 
      "8", "9", 
      "A", "B", "C", "D", "E", "F" };
  
  public static String byteArrayToString(byte[] b) {
    StringBuffer resultSb = new StringBuffer();
    for (int i = 0; i < b.length; i++)
      resultSb.append(byteToHexString(b[i])); 
    return resultSb.toString();
  }
  
  public String bin2hex(String bin) {
    char[] digital = "FEDCBA9876543210".toCharArray();
    StringBuffer sb = new StringBuffer("");
    byte[] bs = bin.getBytes();
    for (int i = 0; i < bs.length; i++) {
      int bit = (bs[i] & 0xF0) >> 4;
      sb.append(digital[bit]);
      bit = bs[i] & 0xF;
      sb.append(digital[bit]);
    } 
    return sb.toString();
  }
  
  public String hex2bin(String hex) {
    String digital = "FEDCBA9876543210";
    char[] hex2char = hex.toCharArray();
    byte[] bytes = new byte[hex.length() / 2];
    for (int i = 0; i < bytes.length; i++) {
      int temp = digital.indexOf(hex2char[2 * i]) * 16;
      temp += digital.indexOf(hex2char[2 * i + 1]);
      bytes[i] = (byte)(temp & 0xFF);
    } 
    return new String(bytes);
  }
  
  private static String byteToNumString(byte b) {
    int _b = b;
    if (_b < 0)
      _b += 256; 
    return String.valueOf(_b);
  }
  
  private static String byteToHexString(byte b) {
    int n = b;
    if (n < 0)
      n += 256; 
    int d1 = n / 16;
    int d2 = n % 16;
    return String.valueOf(hexDigits[d1]) + hexDigits[d2];
  }
  
  public static String MD5Encode(String origin) {
    String resultString = null;
    try {
      resultString = new String(origin);
      MessageDigest md = MessageDigest.getInstance("MD5");
      resultString = byteArrayToString(md.digest(resultString.getBytes()));
    } catch (Exception exception) {}
    return resultString;
  }
  
  public Boolean MakeFolder(String st) throws IOException, SQLException {
    Boolean retval = Boolean.valueOf(false);
    File fl = new File(st);
    if (!fl.exists()) {
      fl.mkdir();
      retval = Boolean.valueOf(true);
    } 
    return retval;
  }
  
  public Boolean DeleteFoler(File directory) {
    if (directory == null)
      return Boolean.valueOf(false); 
    if (!directory.exists())
      return Boolean.valueOf(true); 
    if (!directory.isDirectory())
      return Boolean.valueOf(false); 
    String[] list = directory.list();
    if (list != null)
      for (int i = 0; i < list.length; i++) {
        File entry = new File(directory, list[i]);
        if (entry.isDirectory()) {
          if (!DeleteFoler(entry).booleanValue())
            return Boolean.valueOf(false); 
        } else if (!entry.delete()) {
          return Boolean.valueOf(false);
        } 
      }  
    return Boolean.valueOf(directory.delete());
  }
  
  public Boolean checkFile(String st1) throws IOException, SQLException {
    Boolean retval = Boolean.valueOf(false);
    File fl1 = new File(st1);
    if (fl1.exists())
      retval = Boolean.valueOf(true); 
    return retval;
  }
  
  public void copyImage(String st1, String st2) throws IOException, SQLException {
    try {
      File sourceFile = new File(st1);
      BufferedInputStream bis = new BufferedInputStream(new FileInputStream(st1), 4096);
      File targetFile = new File(st2);
      BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(st2), 4096);
      int theChar;
      while ((theChar = bis.read()) != -1)
        bos.write(theChar); 
      bos.close();
      bis.close();
    } catch (Exception ex) {
      ex.printStackTrace();
    } 
  }
  
  public void SetPageinfo(int m, int n) throws IOException, SQLException {
    this.totalitem = m;
    this.perpage = n;
    this.totalpage = this.totalitem / this.perpage;
    this.tmp_int = this.totalitem % this.perpage;
    if (this.tmp_int > 0)
      this.totalpage++; 
    this.pagefirst = 1;
    if (this.totalpage > this.pagenumber) {
      this.pagelast = this.pagenumber;
    } else {
      this.pagelast = this.totalpage;
    } 
    callpage(1);
  }
  
  public void resetall() throws IOException, SQLException {
    this.perpage = 10;
    this.totalpage = 0;
    this.pagebegin = 0;
    this.pageend = 0;
    this.pagefirst = 0;
    this.pagelast = 0;
    this.pagenumber = 10;
    this.tmp_int = 0;
  }
  
  public int showPagebegin() {
    return this.pagebegin;
  }
  
  public int showPageend() {
    return this.pageend;
  }
  
  public int showTotalpage() {
    return this.totalpage;
  }
  
  public void gotoPage(int n) throws IOException {
    if (n <= 0)
      n = 1; 
    callpage(n);
  }
  
  public void setPagenumber(int n) throws IOException, SQLException {
    this.pagenumber = n;
  }
  
  public int PagetagBegin() throws IOException, SQLException {
    return this.pagefirst;
  }
  
  public int PagetagEnd() throws IOException, SQLException {
    return this.pagelast;
  }
  
  public void JumpPage(int n, int p) throws IOException, SQLException {
    this.tmp_int = n / this.pagenumber + p;
    if (this.tmp_int <= 0)
      this.tmp_int = 0; 
    this.tmp1 = this.tmp_int * this.pagenumber + 1;
    if (this.tmp1 > this.totalpage) {
      this.pagefirst = this.totalpage % this.pagenumber;
      if (this.pagefirst == 0) {
        this.pagefirst = this.totalpage - this.pagenumber + 1;
      } else {
        this.pagefirst = this.totalpage - this.pagefirst + 1;
      } 
      this.tmp1 = this.pagefirst;
    } else {
      this.pagefirst = this.tmp1;
    } 
    this.tmp1 = this.tmp1 + this.pagenumber - 1;
    if (this.tmp1 > this.totalpage) {
      this.pagelast = this.totalpage;
    } else {
      this.pagelast = this.tmp1;
    } 
  }
  
  private void callpage(int n) throws IOException {
    if (this.totalitem <= this.perpage) {
      this.pagebegin = 0;
      this.pageend = this.totalitem;
    } else {
      this.tmp_int = n * this.perpage;
      if (this.totalitem >= this.tmp_int) {
        this.pagebegin = (n - 1) * this.perpage;
        this.pageend = n * this.perpage;
      } else {
        this.pagebegin = this.perpage * this.totalitem / this.perpage;
        this.pageend = this.totalitem;
      } 
    } 
  }
  
  public void Logme_Update(String st1) throws IOException, SQLException {
    String st = today();
    int sysid = find_me("manage_log", "log_date", st, "sysid");
    if (sysid > 0) {
      updateData("update manage_log set update_log = CONCAT_WS(CHAR(10 using utf8), '" + todaytime() + "_" + st1 + "', update_log) where sysid = " + sysid + " ");
    } else {
      updateData("insert into manage_log (log_date, update_log) values ('" + st + "','" + todaytime() + "_" + st1 + "')");
    } 
  }
  
  public void Logme_Update(String st0, String st1) throws IOException, SQLException {
    String st = today();
    int sysid = find_me(st0, "log_date", st, "sysid");
    if (sysid > 0) {
      updateData("update " + st0 + " set update_log = CONCAT_WS(CHAR(10 using utf8), '" + todaytime() + "_" + st1 + "', update_log) where sysid = " + sysid + " ");
    } else {
      updateData("insert into " + st0 + " (log_date, update_log) values ('" + st + "','" + todaytime() + "_" + st1 + "')");
    } 
  }
  
  public void Logme_Access(String st1) throws IOException, SQLException {
    String st = today();
    int sysid = find_me("manage_log", "log_date", st, "sysid");
    if (sysid > 0) {
      updateData("update manage_log set access_log = CONCAT_WS(CHAR(10 using utf8), '" + todaytime() + "_" + st1 + "', access_log) where sysid = " + sysid + " ");
    } else {
      updateData("insert into manage_log (log_date, access_log) values ('" + st + "','" + todaytime() + "_" + st1 + "')");
    } 
  }
  
  public void Logme_Access(String st0, String st1) throws IOException, SQLException {
    String st = today();
    int sysid = find_me(st0, "log_date", st, "sysid");
    if (sysid > 0) {
      updateData("update " + st0 + " set access_log = CONCAT_WS(CHAR(10 using utf8), '" + todaytime() + "_" + st1 + "', access_log) where sysid = " + sysid + " ");
    } else {
      updateData("insert into " + st0 + " (log_date, access_log) values ('" + st + "','" + todaytime() + "_" + st1 + "')");
    } 
  }
  
  public void OnOff(String st0, int n) throws IOException, SQLException {
    updateData("update " + st0 + " set on_off = ((on_off + 1) mod 2) where sysid = " + n + " ");
  }
  
  public void OnOff(String st0, String st1, int n) throws IOException, SQLException {
    updateData("update " + st0 + " set " + st1 + " = ((" + st1 + " + 1) mod 2) where sysid = " + n + " ");
  }
  
  public void OnOff(String st0, String st1, String st2, int n) throws IOException, SQLException {
    updateData("update " + st0 + " set " + st1 + " = ((" + st1 + " + 1) mod 2) where " + st2 + " = " + n + " ");
  }
  
  public String timeformat(String st) throws IOException, SQLException {
    String retval = "error";
    if (st.indexOf(":") > 0) {
      String[] tmp = st.split(":");
      if (checknumber(tmp[0]).booleanValue() && checknumber(tmp[1]).booleanValue() && 
        Integer.parseInt(tmp[0]) < 24 && Integer.parseInt(tmp[1]) < 60) {
        retval = Integer.toString(Integer.parseInt(tmp[0]));
        if (Integer.parseInt(tmp[0]) < 10)
          retval = "0" + retval; 
        retval = String.valueOf(retval) + ":";
        if (Integer.parseInt(tmp[1]) < 10) {
          retval = String.valueOf(retval) + "0" + Integer.toString(Integer.parseInt(tmp[1]));
        } else {
          retval = String.valueOf(retval) + Integer.toString(Integer.parseInt(tmp[1]));
        } 
      } 
    } 
    return retval;
  }
  
  public String get_Time_now_1() {
    SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd-HH_mm_ss");
    String currentDate = date.format(new Date(System.currentTimeMillis()));
    return currentDate;
  }
  
  public boolean isEffectiveDate(Date nowTime, Date startTime, Date endTime) {
    if (nowTime.getTime() == startTime.getTime() || 
      nowTime.getTime() == endTime.getTime())
      return true; 
    Calendar date = Calendar.getInstance();
    date.setTime(nowTime);
    Calendar begin = Calendar.getInstance();
    begin.setTime(startTime);
    Calendar end = Calendar.getInstance();
    end.setTime(endTime);
    if (date.after(begin) && date.before(end))
      return true; 
    return false;
  }
  
  public Boolean compareDate(String st1, String st2) throws IOException, SQLException {
    Boolean retval = Boolean.valueOf(false);
    String tmp1 = st1.replaceAll("-", "");
    String tmp2 = st2.replaceAll("-", "");
    if (Integer.parseInt(tmp1) <= Integer.parseInt(tmp2))
      retval = Boolean.valueOf(true); 
    return retval;
  }
  
  public Boolean compareDate1(String st1, String st2) throws IOException, SQLException {
    Boolean retval = Boolean.valueOf(false);
    String tmp1 = st1.replaceAll("-", "");
    String tmp2 = st2.replaceAll("-", "");
    if (Integer.parseInt(tmp1) < Integer.parseInt(tmp2))
      retval = Boolean.valueOf(true); 
    return retval;
  }
  
  private int thisyear() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("yyyy")).format(rightNow.getTime());
    return Integer.parseInt(this.nowtime);
  }
  
  private int thismonth() throws IOException, SQLException {
    Calendar rightNow = Calendar.getInstance();
    this.nowtime = (new SimpleDateFormat("-MM")).format(rightNow.getTime());
    return Integer.parseInt(this.nowtime);
  }
  
  private Boolean checknumber(String st) throws IOException, SQLException {
    this.i = 0;
    if (st.length() > 0) {
      while (this.i < st.length()) {
        if (this.num.indexOf(st.substring(this.i, this.i + 1)) == -1)
          return Boolean.valueOf(false); 
        this.i++;
      } 
      return Boolean.valueOf(true);
    } 
    return Boolean.valueOf(false);
  }
  
  public static String[] GenerateNonDuplicateRan2(int range) {
    Random rand = new Random();
    String[] rdm = new String[range];
    List<Object> holeList = new ArrayList();
    for (int i = 0; i < range; i++) {
      int cnt = 0;
      while (holeList.size() > 0) {
        String pv = (String)holeList.remove(rand.nextInt(holeList.size()));
        rdm[cnt++] = pv;
      } 
    } 
    return rdm;
  }
  
  public boolean deleteDir(File dir) {
    if (dir.isDirectory()) {
      String[] children = dir.list();
      for (int i = 0; i < children.length; i++) {
        boolean success = deleteDir(new File(dir, children[i]));
        if (!success)
          return false; 
      } 
    } 
    return dir.delete();
  }
  
  public String replaceCharAt(String s, int spos, int epos, char c) {
    StringBuilder myName = new StringBuilder(s);
    int i = 0;
    for (i = spos; i < epos; i++)
      myName.setCharAt(i, c); 
    return myName.toString();
  }
  
  public String getReaderStatus(String cardid, int timeout) throws IOException, SQLException, InterruptedException, ParseException {
    BufferedReader br;
    StringBuilder sb;
    String line, readerstatus = "";
    String msg = "";
    String UID = "";
    String NAME = "";
    String TYPE = "";
    String DEAPRT_1 = "";
    String DEAPRT_2 = "";
    String YEAR = "";
    String CARDID = "";
    String authCARDID = "0";
    String hexCARDID = "";
    URL u = new URL(this.xmlURLStringsuc);
    HttpURLConnection c = (HttpURLConnection)u.openConnection();
    int aucode = 0;
    try {
      if (cardid.length() < 10) {
        authCARDID = addzero(Long.toString(hex2DecimalLong(upsidedown_HEX(cardid))), 10);
      } else if (onlynumber(cardid).booleanValue()) {
        authCARDID = cardid;
      } 
      System.out.println("authCARDID=" + authCARDID);
      Long val = Long.valueOf(Long.parseLong(authCARDID));
      if (val.longValue() > 2147483647L) {
        aucode = (int)(Long.parseLong(authCARDID) / 13L + Long.parseLong(authCARDID) % 13L);
      } else {
        aucode = Integer.parseInt(authCARDID) / 13 + Integer.parseInt(authCARDID) % 13;
      } 
    } catch (Exception e) {
      System.out.println(e);
      authCARDID = "0";
      aucode = 0;
    } 
    System.out.println("aucode=" + aucode);
    String urlParameters = "cardId=" + authCARDID + "&AuthCode=" + aucode;
    byte[] postData = urlParameters.getBytes(StandardCharsets.UTF_8);
    int postDataLength = postData.length;
    c.setRequestMethod("POST");
    c.setRequestProperty("User-Agent", "Mozilla/5.0");
    c.setRequestProperty("Content-Length", Integer.toString(postDataLength));
    c.setUseCaches(false);
    c.setAllowUserInteraction(false);
    c.setConnectTimeout(timeout);
    c.setReadTimeout(timeout);
    c.setRequestProperty("charset", "utf-8");
    c.setDoOutput(true);
    DataOutputStream wr = new DataOutputStream(c.getOutputStream());
    wr.write(urlParameters.getBytes("utf-8"));
    wr.flush();
    wr.close();
    c.connect();
    int status = c.getResponseCode();
    System.out.println("status=" + status);
    switch (status) {
      case 200:
      case 201:
        br = new BufferedReader(new InputStreamReader(c.getInputStream(), "utf-8"));
        sb = new StringBuilder();
        while ((line = br.readLine()) != null) {
          sb.append(String.valueOf(line) + "\n");
          System.out.println("tag=" + line);
          JsonObject jsonObject = (new JsonParser()).parse(line).getAsJsonObject();
          readerstatus = jsonObject.get("status").getAsString();
          msg = jsonObject.get("msg").getAsString();
          UID = jsonObject.get("UID").getAsString();
          NAME = jsonObject.get("NAME").getAsString();
          TYPE = jsonObject.get("TYPE").getAsString();
          DEAPRT_1 = jsonObject.get("DEAPRT_1").getAsString();
          DEAPRT_2 = jsonObject.get("DEAPRT_2").getAsString();
          YEAR = jsonObject.get("YEAR").getAsString();
          CARDID = jsonObject.get("CARDID").getAsString();
          if (cardid.length() >= 10 && onlynumber(cardid).booleanValue()) {
            Long val1 = Long.valueOf(Long.parseLong(cardid));
            if (val1.longValue() > 2147483647L) {
              hexCARDID = upsidedown_HEX(decimal2Hex(Long.parseLong(cardid)));
            } else if (onlynumber(cardid).booleanValue()) {
              hexCARDID = upsidedown_HEX(decimal2Hex(Integer.parseInt(cardid)));
            } 
          } else {
            hexCARDID = cardid;
          } 
          System.out.println("hexCARDID=" + hexCARDID);
          CaseData cst = new CaseData();
          cst.SaveReader("0", readerstatus, msg, UID, NAME, TYPE, DEAPRT_1, DEAPRT_2, YEAR, CARDID, "", "", "", 
              "", hexCARDID);
          cst.closeall();
        } 
        br.close();
        break;
    } 
    if (!readerstatus.equals("TRUE")) {
      ReserveData rst = new ReserveData();
      String decimalid = "";
      if (cardid.length() >= 10) {
        decimalid = cardid;
      } else {
        decimalid = addzero(Long.toString(hex2DecimalLong(upsidedown_HEX(cardid))), 10);
      } 
      readerstatus = rst.getReaderInfoByCardId(decimalid);
      return readerstatus;
    } 
    return readerstatus;
  }
  
  public String getXmlResult1(String userTarget) throws IOException, SQLException {
    String returnString = "";
    try {
      ConnectionManager manager = Page.getConnectionManager();
      Parser parser = new Parser(manager.openConnection(String.valueOf(this.xmlURLStringsuc) + userTarget));
      parser.setEncoding("UTF-8");
      PrototypicalNodeFactory factory = new PrototypicalNodeFactory();
      factory.registerTag((Tag)new z303GoTag());
      parser.setNodeFactory((NodeFactory)factory);
      NodeList nlist = parser.extractAllNodesThatMatch(lnkFilter);
      for (int i = 0; i < nlist.size(); i++) {
        CompositeTag node = (CompositeTag)nlist.elementAt(i);
        if (node instanceof z303GoTag) {
          z303GoTag go = (z303GoTag)node;
          if (returnString.length() != 0)
            returnString = String.valueOf(returnString) + ":"; 
          returnString = String.valueOf(returnString) + go.toPlainTextString().replace(" ", "");
        } 
      } 
    } catch (Exception e) {
      returnString = "";
    } 
    return returnString;
  }
  
  static NodeFilter lnkFilter = new NodeFilter() {
      public boolean accept(Node node) {
        if (node instanceof Utility.z303GoTag)
          return true; 
        return false;
      }
    };
  
  private static final int sizeOfIntInHalfBytes = 8;
  
  private static final int numberOfBitsInAHalfByte = 4;
  
  private static final int halfByte = 15;
  
  static class z303GoTag extends CompositeTag {
    private static final String[] mIds = new String[] { 
        "z303-id", "z303-name", "z303-birth-date", "z303-gender", "z303-delinq-1", "z304-address-0", "z304-address-1", "z304-address-2", "z305-bor-type", "z305-bor-status", 
        "z308-encryption" };
    
    private static final String[] mEndTagEnders = new String[] { "ill-bor-info" };
    
    public String[] getIds() {
      return mIds;
    }
    
    public String[] getEnders() {
      return mIds;
    }
    
    public String[] getEndTagEnders() {
      return mEndTagEnders;
    }
  }
  
  public static String upsidedown_HEX(String s) {
    int i = 0;
    String retval = "";
    while (i < s.length()) {
      retval = String.valueOf(s.substring(i, i + 2)) + retval;
      i += 2;
    } 
    return retval;
  }
  
  public int hex2Decimal(String s) {
    String digits = "0123456789ABCDEF";
    s = s.toUpperCase();
    int val = 0;
    for (int i = 0; i < s.length(); i++) {
      char c = s.charAt(i);
      int d = digits.indexOf(c);
      val = 16 * val + d;
    } 
    return val;
  }
  
  public long hex2DecimalLong(String s) {
    String digits = "0123456789ABCDEF";
    s = s.toUpperCase();
    long val = 0L;
    for (int i = 0; i < s.length(); i++) {
      char c = s.charAt(i);
      int d = digits.indexOf(c);
      val = 16L * val + d;
    } 
    return val;
  }
  
  public String decimal2Hex(int d) {
    String digits = "0123456789ABCDEF";
    if (d == 0)
      return "0"; 
    String hex = "";
    while (d > 0) {
      int digit = d % 16;
      hex = String.valueOf(digits.charAt(digit)) + hex;
      d /= 16;
    } 
    return addzero(hex, 8);
  }
  
  public String decimal2Hex(long d) {
    String hex16Chars = String.format("%016X", new Object[] { Long.valueOf(d) });
    return addzero(hex16Chars, 8);
  }
  
  private static final char[] hexDigits1 = new char[] { 
      '0', '1', '2', '3', '4', '5', '6', '7', 
      '8', '9', 
      'A', 'B', 'C', 'D', 'E', 'F' };
  
  public String decToHex(int dec) {
    StringBuilder hexBuilder = new StringBuilder(8);
    hexBuilder.setLength(8);
    for (int i = 7; i >= 0; i--) {
      int j = dec & 0xF;
      hexBuilder.setCharAt(i, hexDigits1[j]);
      dec >>= 4;
    } 
    return hexBuilder.toString();
  }
  
  public String addzero(String st, int ln) {
    String retval = "0000000000000000000000000000000000000000000000000";
    retval = String.valueOf(retval) + st;
    retval = retval.substring(retval.length() - ln, retval.length());
    return retval;
  }
}
