package wisoft;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.sql.SQLException;
import java.util.Scanner;

public class DoorControl {
  public static void main(String[] args) {}
  
  private String myIP = "127.0.0.1";
  
  private String myPort = "5000";
  
  public void setIpAddress(String st) throws IOException, SQLException {
    this.myIP = st;
  }
  
  public void setConnectPort(String st) throws IOException, SQLException {
    this.myPort = st;
  }
  
  public String doorControl(String st) throws IOException, SQLException {
    this.myIP = st;
    return Connect2Reader("openallgates", "");
  }
  
  public String ForceDoorOpen() throws IOException, SQLException {
    return Connect2Reader("openallgates", "");
  }
  
  public String ForceDoorOpen(String st) throws IOException, SQLException {
    this.myIP = st;
    return Connect2Reader("openallgates", "");
  }
  
  public String BackNormal() throws IOException, SQLException {
    return Connect2Reader("closeallgates", "");
  }
  
  public String BackNormal(String st) throws IOException, SQLException {
    this.myIP = st;
    return Connect2Reader("closeallgates", "");
  }
  
  public String checkReader() throws IOException, SQLException {
    return Connect2Reader("checkme", "");
  }
  
  public String checkReader(String st) throws IOException, SQLException {
    this.myIP = st;
    return Connect2Reader("checkme", "");
  }
  
  public String RebootReader() throws IOException, SQLException {
    return Connect2Reader("rebootme", "");
  }
  
  public String RebootReader(String st) throws IOException, SQLException {
    this.myIP = st;
    return Connect2Reader("rebootme", "");
  }
  
  public String ReSetHistory() throws IOException, SQLException {
    return Connect2Reader("clearhistory", "");
  }
  
  public String ReSetHistory(String st) throws IOException, SQLException {
    this.myIP = st;
    return Connect2Reader("clearhistory", "");
  }
  
  public String ClearAllCard() throws IOException, SQLException {
    return Connect2Reader("clearcard", "");
  }
  
  public String ClearAllCard(String st) throws IOException, SQLException {
    this.myIP = st;
    return Connect2Reader("clearcard", "");
  }
  
  public String checkCard(String st1) throws IOException, SQLException {
    return Connect2Reader("chkcard", "id=" + st1);
  }
  
  public String checkCard(String st, String st1) throws IOException, SQLException {
    this.myIP = st;
    return Connect2Reader("chkcard", "id=" + st1);
  }
  
  public String skipCardHistory() throws IOException, SQLException {
    return Connect2Reader("nextone", "");
  }
  
  public String skipCardHistory(String st) throws IOException, SQLException {
    return Connect2Reader("nextone", "");
  }
  
  public String skipCardHistory_new(String st) throws IOException, SQLException {
    this.myIP = st;
    return Connect2Reader("nextone", "");
  }
  
  public String readUntilCardHistory_310(String st) throws IOException, SQLException {
    String retval = "";
    retval = Connect2Reader("gethistory", "").trim();
    if (retval.equals("NONE")) {
      retval = retval.toLowerCase();
    } else {
      try {
        String[] tmp = retval.split(":");
        tmp[1] = tmp[1].toUpperCase();
        int Inverse = 0;
        if (this.myIP.equals("163.14.16.147") && tmp[3].equals("24"))
          Inverse = 1; 
        if (Inverse == 0) {
          if (tmp[4].equals("2"))
            retval = String.valueOf(tmp[1]) + "_0803_" + retval + "_" + tmp[3] + "_IN"; 
          if (tmp[4].equals("3"))
            retval = String.valueOf(tmp[1]) + "_0803_" + retval + "_" + tmp[3] + "_OUT"; 
          if (tmp[4].equals("0"))
            retval = String.valueOf(tmp[1]) + "_0001_" + retval + "_" + tmp[3] + "_IN"; 
          if (tmp[4].equals("1"))
            retval = String.valueOf(tmp[1]) + "_0001_" + retval + "_" + tmp[3] + "_OUT"; 
        } else {
          if (tmp[4].equals("2"))
            retval = String.valueOf(tmp[1]) + "_0803_" + retval + "_" + tmp[3] + "_OUT"; 
          if (tmp[4].equals("3"))
            retval = String.valueOf(tmp[1]) + "_0803_" + retval + "_" + tmp[3] + "_IN"; 
          if (tmp[4].equals("0"))
            retval = String.valueOf(tmp[1]) + "_0001_" + retval + "_" + tmp[3] + "_OUT"; 
          if (tmp[4].equals("1"))
            retval = String.valueOf(tmp[1]) + "_0001_" + retval + "_" + tmp[3] + "_IN"; 
        } 
      } catch (Exception e) {
        retval = "error";
      } 
    } 
    return retval;
  }
  
  public String readUntilCardHistory_310U(String st) throws IOException, SQLException {
    String retval = "";
    retval = Connect2Reader("gethistory", "").trim();
    if (retval.equals("NONE")) {
      retval = retval.toLowerCase();
    } else {
      String[] tmp = retval.split(":");
      tmp[1] = UpsideDown(tmp[1]);
      if (tmp[4].equals("2"))
        retval = String.valueOf(tmp[1]) + "_0803_" + retval + "_" + tmp[3] + "_IN"; 
      if (tmp[4].equals("3"))
        retval = String.valueOf(tmp[1]) + "_0803_" + retval + "_" + tmp[3] + "_OUT"; 
      if (tmp[4].equals("0"))
        retval = String.valueOf(tmp[1]) + "_0001_" + retval + "_" + tmp[3] + "_IN"; 
      if (tmp[4].equals("1"))
        retval = String.valueOf(tmp[1]) + "_0001_" + retval + "_" + tmp[3] + "_OUT"; 
    } 
    return retval;
  }
  
  public String readUntilCardHistory(String st) throws IOException, SQLException {
    this.myIP = st;
    String retval = "";
    retval = Connect2Reader("gethistory", "").trim();
    String[] tmp = retval.split(":");
    if (tmp[4].equals("2") || tmp[4].equals("3"))
      retval = String.valueOf(tmp[1]) + "_0803_" + retval; 
    if (tmp[4].equals("0") || tmp[4].equals("1"))
      retval = String.valueOf(tmp[1]) + "_0001_" + retval; 
    return retval;
  }
  
  public String readUntilCardHistory_310() throws IOException, SQLException {
    String retval = "";
    retval = Connect2Reader("gethistory", "").trim();
    if (retval.equals("NONE")) {
      retval = retval.toLowerCase();
    } else {
      String[] tmp = retval.split(":");
      if (tmp[4].equals("2"))
        retval = String.valueOf(tmp[1]) + "_0803_" + retval + "_" + tmp[3] + "_IN"; 
      if (tmp[4].equals("3"))
        retval = String.valueOf(tmp[1]) + "_0803_" + retval + "_" + tmp[3] + "_OUT"; 
      if (tmp[4].equals("0"))
        retval = String.valueOf(tmp[1]) + "_0001_" + retval + "_" + tmp[3] + "_IN"; 
      if (tmp[4].equals("1"))
        retval = String.valueOf(tmp[1]) + "_0001_" + retval + "_" + tmp[3] + "_OUT"; 
    } 
    return retval;
  }
  
  public String readUntilCardHistory() throws IOException, SQLException {
    String retval = "";
    retval = Connect2Reader("gethistory", "").trim();
    String[] tmp = retval.split(":");
    if (tmp[4].equals("2") || tmp[4].equals("3"))
      retval = String.valueOf(tmp[1]) + "_0803_" + retval; 
    if (tmp[4].equals("0") || tmp[4].equals("1"))
      retval = String.valueOf(tmp[1]) + "_0001_" + retval; 
    return retval;
  }
  
  public String delUntilCardNumber(String st1) throws IOException, SQLException {
    return Connect2Reader("delcard", "id=" + st1);
  }
  
  public String delUntilCardNumberU(String st, String st1) throws IOException, SQLException {
    String retval = "";
    retval = Connect2Reader("delcard", "id=" + UpsideDown(st1)).trim();
    if (retval.equals("OK"))
      retval = "1"; 
    return retval;
  }
  
  public int delUntilCardNumber(String st, String st1) throws IOException, SQLException {
    String retval = "";
    int ret_val = 0;
    retval = Connect2Reader("delcard", "id=" + st1.toLowerCase()).trim();
    if (retval.equals("OK"))
      ret_val = 1; 
    return ret_val;
  }
  
  public String delUntilCardNumber_new(String st, String st1) throws IOException, SQLException {
    this.myIP = st;
    return Connect2Reader("delcard", "id=" + st1);
  }
  
  public int addUntilCardNumber(String st, String st1) throws IOException, SQLException {
    String retval = "";
    int ret_val = 0;
    retval = Connect2Reader("addcard", "id=" + st1.toLowerCase()).trim();
    if (retval.equals("OK"))
      ret_val = 1; 
    return ret_val;
  }
  
  public int addUntilCardNumberU(String st, String st1) throws IOException, SQLException {
    String retval = "";
    int ret_val = 0;
    retval = Connect2Reader("addcard", "id=" + UpsideDown(st1)).trim();
    if (retval.equals("OK"))
      ret_val = 1; 
    return ret_val;
  }
  
  public String addUntilCardNumber(String st1) throws IOException, SQLException {
    return Connect2Reader("addcard", "id=" + st1);
  }
  
  public String addUntilCardNumber_new(String st, String st1) throws IOException, SQLException {
    this.myIP = st;
    return Connect2Reader("addcard", "id=" + st1);
  }
  
  public String Connect2Reader(String st, String st1) {
    String retval = "";
    try {
      retval = sentHttpGetRequest("http://" + this.myIP + ":" + this.myPort + "/" + st + "?" + st1, 10000);
    } catch (Exception exception) {}
    return retval;
  }
  
  private static String sentHttpPostRequest(String url, String args) throws IOException {
    URLConnection connection = (new URL(url)).openConnection();
    connection.setDoOutput(true);
    connection.setDoInput(true);
    OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream());
    out.write(args);
    out.flush();
    out.close();
    InputStream is = connection.getInputStream();
    Scanner scanner = new Scanner(is, "UTF-8");
    String stx = scanner.useDelimiter("\\A").next();
    is.close();
    return stx.trim();
  }
  
  private static String sentHttpGetRequest(String url, int timeout) throws IOException {
    BufferedReader br;
    StringBuilder sb;
    String line;
    URL u = new URL(url);
    HttpURLConnection c = (HttpURLConnection)u.openConnection();
    c.setRequestMethod("GET");
    c.setUseCaches(false);
    c.setAllowUserInteraction(false);
    c.setConnectTimeout(timeout);
    c.setReadTimeout(timeout);
    c.setRequestProperty("User-Agent", "Mozilla/5.0");
    c.connect();
    int status = c.getResponseCode();
    switch (status) {
      case 200:
      case 201:
        br = new BufferedReader(new InputStreamReader(c.getInputStream(), "utf-8"));
        sb = new StringBuilder();
        while ((line = br.readLine()) != null)
          sb.append(String.valueOf(line) + "\n"); 
        br.close();
        return sb.toString();
    } 
    return null;
  }
  
  private String UpsideDown(String st) throws IOException, SQLException {
    String tmpString = "";
    for (int i = 0; i < st.length(); i++) {
      tmpString = String.valueOf(st.substring(i, i + 2)) + tmpString;
      i++;
    } 
    return tmpString;
  }
}
