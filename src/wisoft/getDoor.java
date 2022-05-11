package wisoft;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.sql.SQLException;

public class getDoor extends getData {
  DoorControl dcl;
  
  private String door_in;
  
  private String door_out;
  
  private String response_in;
  
  private String response_out;
  
  private String ip;
  
  private int run_times;
  
  private int fail_times;
  
  private String fail_message;
  
  private int fail_times20;
  
  private int fail_times52;
  
  private int run_times20;
  
  private int run_times52;
  
  public static void main(String[] args) {}
  
  public getDoor() {
    this.dcl = new DoorControl();
    this.door_in = "4";
    this.door_out = "3";
    this.response_in = "";
    this.response_out = "";
    this.ip = "";
    this.run_times = 0;
    this.fail_times = 0;
    this.fail_message = "";
    this.fail_times20 = 0;
    this.fail_times52 = 0;
    this.run_times20 = 0;
    this.run_times52 = 0;
  }
  
  public void setIP(String ip) throws IOException, SQLException {
    this.dcl.setIpAddress(ip);
  }
  
  public void opendoor_out() throws IOException, SQLException {
    this.dcl.doorControl(this.door_out);
  }
  
  public void opendoor_in() throws IOException, SQLException {
    this.dcl.doorControl(this.door_in);
  }
  
  public void opendoor(String st1, String st2) throws IOException, SQLException {
    this.dcl.setIpAddress(st1);
    this.dcl.doorControl(st2);
  }
  
  public String get_RESP_IN() throws IOException, SQLException {
    if (this.response_in.length() > 6) {
      String[] tmp = this.response_in.split("_");
      if (tmp[1].equals("0001")) {
        init("rev_booking");
        queryMe("(rev_status = 1 or rev_status = 7 or rev_status=8) and card_id like '" + 
            tmp[0] + "%'");
        if (showCount() > 0) {
          this.response_in = showData("card_id", 0);
        } else {
          init("librarian");
          queryMe("tempid like '" + tmp[0] + "%'");
          if (showCount() > 0) {
            this.response_in = showData("card_id", 0);
          } else {
            this.response_in = "end";
          } 
        } 
      } else {
        this.response_in = "end";
      } 
    } 
    return this.response_in;
  }
  
  public String get_RESP_OUT() throws IOException, SQLException {
    if (this.response_out.length() > 6) {
      String[] tmp = this.response_out.split("_");
      if (tmp[1].equals("0001")) {
        init("rev_booking");
        queryMe("(rev_status = 1 or rev_status = 7 or rev_status=8) and card_id like '" + 
            tmp[0] + "%'");
        if (showCount() > 0) {
          this.response_out = showData("card_id", 0);
        } else {
          init("librarian");
          queryMe("tempid like '" + tmp[0] + "%'");
          if (showCount() > 0) {
            this.response_out = showData("card_id", 0);
          } else {
            this.response_out = "end";
          } 
        } 
      } else if (tmp[1].equals("0803")) {
        this.response_out = "0803@" + tmp[0];
      } else {
        this.response_out = "end";
      } 
    } 
    return this.response_out;
  }
  
  public void forServlet_one() throws IOException, SQLException, InterruptedException {
    int retval = 0;
    if (DoAction_one() == 9) {
      Thread.sleep(20L);
      getInfo_IN();
      Thread.sleep(60L);
      getInfo_OUT();
    } 
  }
  
  public void insertCard(String st) throws IOException, SQLException, InterruptedException {
    do_Card(0, st);
  }
  
  public void deleteCard(String st) throws IOException, SQLException, InterruptedException {
    do_Card(1, st);
  }
  
  public String getInfo_IN() throws IOException, SQLException, InterruptedException {
    String get_in_info = this.dcl.readUntilCardHistory_310(this.door_in);
    System.out.println("IN:" + get_in_info);
    if (!get_in_info.equals("end") && !get_in_info.equals("error") && 
      !get_in_info.equals("")) {
      Thread.sleep(2L);
      updateData("insert into door_record (sysid , queuesysid , do_type, do_card) values ('" + 
          todaytimelong() + 
          "' , '" + 
          get_in_info + 
          "' , " + 
          this.door_in + 
          ", '')");
    } 
    this.response_in = get_in_info;
    return get_in_info;
  }
  
  public String getInfo_OUT() throws IOException, SQLException, InterruptedException {
    Thread.sleep(20L);
    String get_out_info = this.dcl.readUntilCardHistory_310(this.door_out);
    System.out.println("OUT:" + get_out_info);
    if (!get_out_info.equals("end") && !get_out_info.equals("error") && 
      !get_out_info.equals("")) {
      Thread.sleep(20L);
      this.dcl.skipCardHistory(this.door_out);
      updateData("insert into door_record (sysid , queuesysid , do_type, do_card) values ('" + 
          todaytimelong() + 
          "' , '" + 
          get_out_info + 
          "' ," + 
          this.door_out + 
          ", '')");
    } 
    this.response_out = get_out_info;
    return get_out_info;
  }
  
  public int DoAction_one() throws IOException, SQLException, InterruptedException {
    int retval = 9;
    int testno_in = 1;
    int testno_out = 1;
    init("doorqueue");
    queryMe(" sysid is not null order by sysid");
    if (showCount() > 0) {
      if (showData("do_type", 0).equals("0")) {
        Thread.sleep(20L);
        if (this.dcl.addUntilCardNumber(this.door_in, showData("do_card", 0)) == 1) {
          Thread.sleep(20L);
          if (this.dcl.addUntilCardNumber(this.door_out, showData("do_card", 0)) == 1) {
            updateData("insert into door_record (sysid , queuesysid , do_type, do_card) values ('" + 
                todaytimelong() + 
                "' , '" + 
                showData("sysid", 0) + 
                "' , " + 
                showData("do_type", 0) + 
                ", '" + 
                showData("do_card", 0) + "')");
            updateData("delete from doorqueue where sysid = '" + 
                showData("sysid", 0) + "'");
            retval = 2;
          } else {
            retval = 0;
          } 
        } else {
          retval = 1;
        } 
      } 
      if (showData("do_type", 0).equals("1")) {
        Thread.sleep(20L);
        if (this.dcl.delUntilCardNumber(this.door_in, showData("do_card", 0)) == 1) {
          Thread.sleep(20L);
          if (this.dcl.delUntilCardNumber(this.door_out, showData("do_card", 0)) == 1) {
            updateData("insert into door_record (sysid , queuesysid , do_type, do_card) values ('" + 
                todaytimelong() + 
                "' , '" + 
                showData("sysid", 0) + 
                "' , " + 
                showData("do_type", 0) + 
                ", '" + 
                showData("do_card", 0) + "')");
            updateData("delete from doorqueue where sysid = '" + 
                showData("sysid", 0) + "'");
            retval = 2;
          } else {
            retval = 0;
          } 
        } else {
          retval = 1;
        } 
      } 
    } 
    return retval;
  }
  
  private void do_Card(int n, String st) throws IOException, SQLException, InterruptedException {
    Thread.sleep(20L);
    String get_sysid = todaytimelong();
    if (!st.equals("")) {
      updateData("insert into doorqueue (sysid, do_type , do_card) values ('" + 
          get_sysid + "', " + n + " , '" + st + "' )");
    } else {
      System.out.println(String.valueOf(get_sysid) + "= type:" + n + " card:" + st + " ");
    } 
  }
  
  public int doTest() throws IOException, SQLException {
    init("doorqueue");
    queryMe("sysid is not null order by sysid");
    return showCount();
  }
  
  public void forServlet2(String st) throws IOException, SQLException, InterruptedException {
    try {
      init("code_tab");
      queryMe("seq = '" + st + "'");
      if (showData("name_desc_en", 0).equals("0") && 
        DoAction(st) == 9) {
        Thread.sleep(2L);
        getInfo_IN_ALL(st);
      } 
    } catch (Exception exception) {}
  }
  
  public void forServlet2() throws IOException, SQLException, InterruptedException {
    if (DoAction("52") == 9) {
      Thread.sleep(2L);
      getInfo_IN_ALL("52");
    } 
    if (DoAction("20") == 9) {
      Thread.sleep(2L);
      getInfo_IN_ALL("20");
    } 
  }
  
  public void forServlet() throws IOException, SQLException, InterruptedException {
    if (DoAction() == 9) {
      Thread.sleep(2L);
      getInfo_IN_ALL();
    } 
  }
  
  public void insertCard(String st0, String st1, String st2, String st3, String st4) throws IOException, SQLException, InterruptedException {
    do_Card_new(0, st0, st1, st2, st3, st4);
  }
  
  public void deleteCard(String st0, String st1, String st2, String st3, String st4) throws IOException, SQLException, InterruptedException {
    do_Card_new(1, st0, st1, st2, st3, st4);
  }
  
  public void getInfo_IN_ALL(String st) throws IOException, SQLException, InterruptedException {
    init("gate_info");
    queryMe("sysid > 0 and ip <> '127.0.0.1' and location = '" + st + "' group by ip");
    String getback_info = "";
    int get_i = 0;
    int get_up = showCount();
    int get_times = 0;
    while (get_i < get_up) {
      getback_info = getInfo_new(showData("ip", get_i), showData("station", get_i), showData("gate_type", get_i));
      get_i++;
    } 
  }
  
  public void getInfo_IN_ALL() throws IOException, SQLException, InterruptedException {
    init("gate_info");
    queryMe("sysid > 0 and ip <> '127.0.0.1' group by ip");
    String getback_info = "";
    int get_i = 0;
    int get_up = showCount();
    int get_times = 0;
    while (get_i < get_up) {
      getback_info = getInfo_new(showData("ip", get_i), showData("station", get_i), showData("gate_type", get_i));
      get_i++;
    } 
  }
  
  public String getInfo_new(String st1, String st2, String st3) throws IOException, SQLException, InterruptedException {
    String ret_info = "end";
    this.dcl.setIpAddress(st1);
    String get_info = this.dcl.readUntilCardHistory_310(st2);
    String[] get_infosplit = get_info.split("_");
    System.out.println(String.valueOf(todaytime()) + "@" + st3 + ":" + st1 + "/" + st2 + "/" + get_info);
    if (!get_info.equals("end") && !get_info.equals("error") && 
      !get_info.equals("") && !get_info.equals("none")) {
      Thread.sleep(2L);
      this.dcl.skipCardHistory(st2);
      updateData("insert into door_record (sysid , queuesysid , do_type, do_card , do_ip , do_station, do_inout) values ('" + 
          todaytimelong() + 
          "' , '" + 
          get_info + 
          "' , " + 
          this.door_in + 
          ", '' , '" + st1 + "' , '" + get_infosplit[3] + "' , '" + get_infosplit[4] + "')");
      String card_in = get_infosplit[0];
      if (get_infosplit[1].equals("0001")) {
        URL oracle = null;
        System.out.println("GO CHECKNOW/" + get_infosplit[4]);
        try {
          oracle = new URL("http://163.14.93.170:8080/scudesk/doors/checknow.jsp?id=" + card_in + "&gate=0&io=" + get_infosplit[4]);
          URLConnection urlConnection = oracle.openConnection();
          HttpURLConnection connection = null;
          if (urlConnection instanceof HttpURLConnection) {
            connection = (HttpURLConnection)urlConnection;
            int code = connection.getResponseCode();
            System.out.println("code=" + code);
          } else {
            System.out.println("Please enter an HTTP URL.");
          } 
          System.out.println("AFTER ORACLE" + oracle.getProtocol());
        } catch (MalformedURLException e) {
          System.out.println(e.toString());
          e.printStackTrace();
        } 
        System.out.println("AFTER CHECKNOW and TRY");
      } 
      ret_info = get_info;
    } 
    return ret_info;
  }
  
  public int DoAction() throws IOException, SQLException, InterruptedException {
    System.out.println("DO Action");
    int get_retval = 9;
    this.run_times = 0;
    this.fail_times = 1;
    get_retval = DoAction_new();
    while (get_retval < 9 && this.run_times < 50) {
      Thread.sleep(2L);
      this.run_times++;
      this.fail_times++;
      get_retval = DoAction_new();
    } 
    if (this.run_times >= 50)
      get_retval = 9; 
    return get_retval;
  }
  
  public int DoAction_new() throws IOException, SQLException, InterruptedException {
    int do_i = this.fail_times - 1;
    int retval = 9;
    init("doorqueue");
    queryMe(" sysid is not null order by sysid");
    while (do_i < showCount() && 
      showData("do_card", do_i).length() != 8)
      do_i++; 
    System.out.println("DO Queue : " + do_i + "/" + showData("do_card", do_i));
    if (do_i < showCount()) {
      if (showData("do_type", do_i).equals("0")) {
        this.dcl.setIpAddress(showData("do_ip", do_i));
        Thread.sleep(2L);
        try {
          if (this.dcl.addUntilCardNumber(showData("do_station", do_i), showData("do_card", do_i)) == 1) {
            updateData("insert into door_record (sysid , queuesysid , do_type, do_card , do_ip , do_station, do_inout) values ('" + 
                todaytimelong() + "' , '" + 
                showData("sysid", do_i) + "' , " + 
                showData("do_type", do_i) + ", '" + 
                showData("do_card", do_i) + "' , '" + 
                showData("do_ip", do_i) + "' , '" + 
                showData("do_station", do_i) + "' , '" + 
                showData("do_inout", do_i) + "')");
            updateData("delete from doorqueue where sysid = '" + showData("sysid", do_i) + "'");
            this.fail_times--;
            retval = 2;
          } else {
            retval = 1;
          } 
        } catch (Exception e) {
          this.fail_message = String.valueOf(this.fail_message) + "\nInsertCard:" + showData("do_station", do_i) + "/" + showData("do_card", do_i) + "\n" + e.toString() + "\n";
          retval = 9;
        } 
      } 
      if (showData("do_type", do_i).equals("1")) {
        this.dcl.setIpAddress(showData("do_ip", do_i));
        Thread.sleep(2L);
        try {
          if (this.dcl.delUntilCardNumber(showData("do_station", do_i), showData("do_card", do_i)) == 1) {
            updateData("insert into door_record (sysid , queuesysid , do_type, do_card , do_ip , do_station, do_inout) values ('" + 
                todaytimelong() + "' , '" + 
                showData("sysid", do_i) + "' , " + 
                showData("do_type", do_i) + ", '" + 
                showData("do_card", do_i) + "' , '" + 
                showData("do_ip", do_i) + "' , '" + 
                showData("do_station", do_i) + "' , '" + 
                showData("do_inout", do_i) + "')");
            updateData("delete from doorqueue where sysid = '" + showData("sysid", do_i) + "'");
            this.fail_times--;
            retval = 2;
          } else {
            retval = 1;
          } 
        } catch (Exception e) {
          this.fail_message = String.valueOf(this.fail_message) + "\nDeleteCard:" + showData("do_station", do_i) + "/" + showData("do_card", do_i) + "\n" + e.toString() + "\n";
          retval = 9;
        } 
      } 
    } 
    return retval;
  }
  
  public int DoAction(String st) throws IOException, SQLException, InterruptedException {
    System.out.println("DO Action");
    int get_retval = 9;
    if (st.equals("20")) {
      this.fail_times20 = 1;
      this.run_times20 = 0;
    } 
    if (st.equals("52")) {
      this.fail_times52 = 1;
      this.run_times52 = 0;
    } 
    get_retval = DoAction_new(st);
    while (get_retval < 9 && this.run_times < 50) {
      Thread.sleep(2L);
      if (st.equals("20")) {
        this.fail_times20++;
        this.run_times20++;
      } 
      if (st.equals("52")) {
        this.fail_times52++;
        this.run_times52++;
      } 
      get_retval = DoAction_new(st);
    } 
    if (st.equals("20") && this.run_times20 >= 50)
      get_retval = 9; 
    if (st.equals("52") && this.run_times52 >= 50)
      get_retval = 9; 
    return get_retval;
  }
  
  public int DoAction_new(String st) throws IOException, SQLException, InterruptedException {
    int fail_times_new = 0;
    if (st.equals("20"))
      fail_times_new = this.fail_times20; 
    if (st.equals("52"))
      fail_times_new = this.fail_times52; 
    int do_i = fail_times_new - 1;
    int retval = 9;
    init("doorqueue");
    queryMe(" sysid is not null and do_location = '" + st + "' order by sysid");
    while (do_i < showCount() && 
      showData("do_card", do_i).length() != 8)
      do_i++; 
    System.out.println("DO Queue " + st + ": " + do_i + "/" + showData("do_card", do_i));
    if (do_i < showCount()) {
      if (showData("do_type", do_i).equals("0")) {
        this.dcl.setIpAddress(showData("do_ip", do_i));
        Thread.sleep(2L);
        try {
          if (this.dcl.addUntilCardNumber(showData("do_station", do_i), showData("do_card", do_i)) == 1) {
            updateData("insert into door_record (sysid , queuesysid , do_type, do_card , do_ip , do_station, do_inout) values ('" + 
                todaytimelong() + "' , '" + 
                showData("sysid", do_i) + "' , " + 
                showData("do_type", do_i) + ", '" + 
                showData("do_card", do_i) + "' , '" + 
                showData("do_ip", do_i) + "' , '" + 
                showData("do_station", do_i) + "' , '" + 
                showData("do_inout", do_i) + "')");
            updateData("delete from doorqueue where sysid = '" + showData("sysid", do_i) + "'");
            fail_times_new--;
            retval = 2;
          } else {
            retval = 1;
          } 
        } catch (Exception e) {
          this.fail_message = String.valueOf(this.fail_message) + "\nInsertCard:" + showData("do_station", do_i) + "/" + showData("do_card", do_i) + "\n" + e.toString() + "\n";
          retval = 9;
        } 
      } 
      if (showData("do_type", do_i).equals("1")) {
        this.dcl.setIpAddress(showData("do_ip", do_i));
        Thread.sleep(2L);
        try {
          if (this.dcl.delUntilCardNumber(showData("do_station", do_i), showData("do_card", do_i)) == 1) {
            updateData("insert into door_record (sysid , queuesysid , do_type, do_card , do_ip , do_station, do_inout) values ('" + 
                todaytimelong() + "' , '" + 
                showData("sysid", do_i) + "' , " + 
                showData("do_type", do_i) + ", '" + 
                showData("do_card", do_i) + "' , '" + 
                showData("do_ip", do_i) + "' , '" + 
                showData("do_station", do_i) + "' , '" + 
                showData("do_inout", do_i) + "')");
            updateData("delete from doorqueue where sysid = '" + showData("sysid", do_i) + "'");
            fail_times_new--;
            retval = 2;
          } else {
            retval = 1;
          } 
        } catch (Exception e) {
          this.fail_message = String.valueOf(this.fail_message) + "\nDeleteCard:" + showData("do_station", do_i) + "/" + showData("do_card", do_i) + "\n" + e.toString() + "\n";
          retval = 9;
        } 
      } 
    } 
    if (st.equals("20"))
      this.fail_times20 = fail_times_new; 
    if (st.equals("52"))
      this.fail_times52 = fail_times_new; 
    return retval;
  }
  
  private void do_Card_new(int n, String st1, String st2, String st3, String st4, String st5) throws IOException, SQLException, InterruptedException {
    Thread.sleep(1L);
    String get_gateIP = "";
    String get_sysid = "";
    int gate_i = 0;
    int gate_up = 0;
    init("gate_info");
    queryMe("location = '" + st1 + "' and floor = '" + st2 + "' and area='" + st3 + "' group by ip");
    System.out.println("do card new=location = '" + st1 + "' and floor = '" + st2 + "' and area = '" + st3 + "' ");
    gate_up = showCount();
    if (gate_up > 0)
      while (gate_i < gate_up) {
        get_gateIP = showData("ip", gate_i);
        Thread.sleep(1L);
        get_sysid = todaytimelong();
        if (!st5.equals("")) {
          updateData("insert into doorqueue (sysid, do_type , do_card , do_location, do_floor , do_area , do_ip , do_station , do_inout) values ('" + 
              get_sysid + "', " + n + " , '" + st5 + "' , '" + st1 + "', '" + st2 + "', " + 
              "'" + st3 + "', '" + get_gateIP + "', '" + showData("station", gate_i) + "' ," + 
              " '" + showData("gate_type", gate_i) + "')");
          System.out.println("insert into doorqueue (sysid, do_type , do_card , do_location, do_floor , do_area , do_ip , do_station , do_inout) values ('" + 
              get_sysid + "', " + n + " , '" + st5 + "' , '" + st1 + "', '" + st2 + "', " + 
              "'" + st3 + "', '" + get_gateIP + "', '" + showData("station", gate_i) + "' ," + 
              " '" + showData("gate_type", gate_i) + "')");
        } else {
          System.out.println(String.valueOf(get_sysid) + "= type:" + n + " card:" + st5 + " ");
        } 
        gate_i++;
      }  
  }
}
