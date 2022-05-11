package wisoft;

import java.io.IOException;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class getData1 extends Utility1 {
  ResultSet rs = null;
  
  ResultSet rs1 = null;
  
  ResultSet rs2 = null;
  
  String get_name = "";
  
  String get_type = "";
  
  int get_name_length = 0;
  
  String get_ip = "";
  
  String get_user = "";
  
  String get_session = "";
  
  String get_jsp = "";
  
  int sync_flag = 0;
  
  String this_keyvalue = "";
  
  String this_keytype = "";
  
  String tbnames = "";
  
  String tbfield = "";
  
  List<List<String>> al = new ArrayList<>();
  
  private String[] cmd;
  
  public static void main(String[] args) {}
  
  private String seek_db = "";
  
  private int rec_num = 0;
  
  public void closeall() throws IOException, SQLException {
    super.closeall();
    if (this.rs != null)
      this.rs.close(); 
    if (this.rs1 != null)
      this.rs1.close(); 
    if (this.rs2 != null)
      this.rs2.close(); 
  }
  
  public String giveMeSysid() throws IOException, SQLException {
    init("sys_master");
    queryMe("type_name = 'IAM'");
    String prefix_id = showData("type_values", 0);
    String retsysid = String.valueOf(prefix_id) + "_" + todaytime2();
    this.this_keyvalue = retsysid;
    return retsysid;
  }
  
  public void SyncOff() throws IOException, SQLException {
    this.sync_flag = 0;
  }
  
  public void SyncON() throws IOException, SQLException {
    this.sync_flag = 1;
  }
  
  public void setKeyValue(String st) throws IOException, SQLException {
    this.this_keyvalue = st;
  }
  
  public void Stampme(String st, String st1) throws IOException, SQLException {
    String stt = today();
    String stw = String.valueOf(this.get_user) + "<wi>" + this.get_ip + "<wi>" + st1 + "<wi>Surfing " + st + " (at " + todaytime3() + ")_";
    int sysid = find_me("manage_log", "log_date", stt, "sysid");
    if (sysid > 0) {
      super.updateData("update manage_log set surf_log = CONCAT_WS(CHAR(10 using utf8), '" + todaytime() + "<wi>" + stw + "', surf_log) where sysid = " + sysid + " ");
    } else {
      super.updateData("insert into manage_log (log_date, surf_log) values ('" + stt + "','" + todaytime() + "<wi>" + stw + "')");
    } 
    super.updateData("update manage_log set all_log = CONCAT_WS(CHAR(10 using utf8), '" + todaytime() + "<wi>" + stw + "', all_log) where sysid = " + sysid + " ");
  }
  
  public void giveInfo(String st1, String st2, String st3) throws IOException, SQLException {
    this.get_ip = st1;
    this.get_user = st2;
    this.get_session = st3;
  }
  
  public void giveInfo(String st1, String st2, String st3, String st4) throws IOException, SQLException {
    this.get_ip = st1;
    this.get_user = st2;
    this.get_session = st3;
    this.get_jsp = st4;
  }
  
  public void init(String st) throws IOException, SQLException {
    this.seek_db = st;
    DatabaseMetaData meta = this.conn.getMetaData();
    this.rs2 = meta.getColumns(null, null, this.seek_db, null);
    this.get_name = "";
    this.get_type = "";
    while (this.rs2.next()) {
      if (this.get_name.equals("")) {
        this.get_name = String.valueOf(this.get_name) + this.rs2.getString("COLUMN_NAME");
        this.get_type = String.valueOf(this.get_type) + this.rs2.getString("TYPE_NAME");
        continue;
      } 
      this.get_name = String.valueOf(this.get_name) + ";" + this.rs2.getString("COLUMN_NAME");
      this.get_type = String.valueOf(this.get_type) + ";" + this.rs2.getString("TYPE_NAME");
    } 
    this.cmd = this.get_name.split(";");
    this.get_name_length = this.cmd.length;
    this.al.clear();
  }
  
  public ArrayList<?> getThisData() throws IOException, SQLException {
    return (ArrayList)this.al.get(0);
  }
  
  public void writeitnow(String st, String st1, String st2, ArrayList<?> al0, String st3, String st4) throws IOException, SQLException {
    String[] t1 = st1.split(";");
    String[] t2 = st2.split(";");
    String runstring = "";
    String keytype = "";
    int ri = 0;
    int rup = t1.length;
    init(st);
    queryMe(String.valueOf(st3) + "= '" + st4 + "'");
    if (showCount() > 0) {
      runstring = "update " + st + " set ";
      ri = 0;
      while (ri < rup) {
        if (ri > 0)
          runstring = String.valueOf(runstring) + " , "; 
        runstring = String.valueOf(runstring) + t1[ri];
        if (t2[ri].indexOf("INT") < 0) {
          runstring = String.valueOf(runstring) + " = '" + al0.get(ri).toString() + "' ";
        } else {
          runstring = String.valueOf(runstring) + " = " + al0.get(ri).toString() + " ";
        } 
        if (t1[ri].equals(st3))
          keytype = t2[ri]; 
        ri++;
      } 
      runstring = String.valueOf(runstring) + " where " + st3 + " = ";
      if (keytype.indexOf("INT") < 0) {
        runstring = String.valueOf(runstring) + "'" + st4 + "' ";
      } else {
        runstring = String.valueOf(runstring) + " " + st4 + " ";
      } 
    } else {
      runstring = "insert into " + st + " (";
      ri = 0;
      while (ri < rup) {
        if (ri > 0)
          runstring = String.valueOf(runstring) + " , "; 
        runstring = String.valueOf(runstring) + t1[ri];
        ri++;
      } 
      runstring = String.valueOf(runstring) + ") values (";
      ri = 0;
      while (ri < rup) {
        if (ri > 0)
          runstring = String.valueOf(runstring) + " , "; 
        if (t2[ri].indexOf("INT") < 0) {
          runstring = String.valueOf(runstring) + "'" + al0.get(ri).toString() + "' ";
        } else {
          runstring = String.valueOf(runstring) + " " + al0.get(ri).toString() + " ";
        } 
        ri++;
      } 
      runstring = String.valueOf(runstring) + ")";
    } 
    updateData(runstring);
  }
  
  public void writeitnow(String st, String st1, String st2, ArrayList<?> al0, String st3, int st4) throws IOException, SQLException {
    String[] t1 = st1.split(";");
    String[] t2 = st2.split(";");
    String runstring = "";
    String keytype = "";
    int ri = 0;
    int rup = t1.length;
    init(st);
    queryMe(String.valueOf(st3) + "= " + st4 + " ");
    if (showCount() > 0) {
      runstring = "update " + st + " set ";
      ri = 0;
      while (ri < rup) {
        if (ri > 0)
          runstring = String.valueOf(runstring) + " , "; 
        runstring = String.valueOf(runstring) + t1[ri];
        if (t2[ri].indexOf("INT") < 0) {
          runstring = String.valueOf(runstring) + " = '" + al0.get(ri).toString() + "' ";
        } else {
          runstring = String.valueOf(runstring) + " = " + al0.get(ri).toString() + " ";
        } 
        if (t1[ri].equals(st3))
          keytype = t2[ri]; 
        ri++;
      } 
      runstring = String.valueOf(runstring) + " where " + st3 + " = ";
      if (keytype.indexOf("INT") < 0) {
        runstring = String.valueOf(runstring) + "'" + st4 + "' ";
      } else {
        runstring = String.valueOf(runstring) + " " + st4 + " ";
      } 
    } else {
      runstring = "insert into " + st + " (";
      ri = 0;
      while (ri < rup) {
        if (ri > 0)
          runstring = String.valueOf(runstring) + " , "; 
        runstring = String.valueOf(runstring) + t1[ri];
        ri++;
      } 
      runstring = String.valueOf(runstring) + ") values (";
      ri = 0;
      while (ri < rup) {
        if (ri > 0)
          runstring = String.valueOf(runstring) + " , "; 
        if (t2[ri].indexOf("INT") < 0) {
          runstring = String.valueOf(runstring) + "'" + al0.get(ri).toString() + "' ";
        } else {
          runstring = String.valueOf(runstring) + " " + al0.get(ri).toString() + " ";
        } 
        ri++;
      } 
      runstring = String.valueOf(runstring) + ")";
    } 
    updateData(runstring);
  }
  
  public void init(String st, String st1) throws IOException, SQLException {
    this.seek_db = st;
    DatabaseMetaData meta = this.conn.getMetaData();
    this.rs2 = meta.getColumns(null, null, this.seek_db, null);
    this.get_name = "";
    while (this.rs2.next()) {
      if (this.get_name.equals("")) {
        this.get_name = String.valueOf(this.get_name) + this.rs2.getString("COLUMN_NAME");
        continue;
      } 
      this.get_name = String.valueOf(this.get_name) + ";" + this.rs2.getString("COLUMN_NAME");
    } 
    this.get_name = String.valueOf(this.get_name) + ";" + st1;
    this.cmd = this.get_name.split(";");
    this.get_name_length = this.cmd.length;
    this.al.clear();
  }
  
  public String get_type() throws IOException, SQLException {
    return this.get_type;
  }
  
  public String get_field() throws IOException, SQLException {
    return this.get_name;
  }
  
  public String get_field(int n) throws IOException, SQLException {
    String retcmd = "";
    if (n >= 0 && n < this.get_name_length)
      retcmd = this.cmd[n]; 
    return retcmd;
  }
  
  public void queryMeAll() throws IOException, SQLException {
    this.rs = queryData("select * from " + this.seek_db);
    this.rec_num = showCount();
    this.rs.beforeFirst();
    this.rs.next();
    for (int i = 0; i < this.rec_num; i++) {
      List<String> list = new ArrayList<>();
      this.al.add(list);
      for (int j = 0; j < this.cmd.length; j++)
        list.add(getNotNull(this.rs.getObject(this.cmd[j]))); 
      this.rs.next();
    } 
  }
  
  public void queryMeAll(String st0) throws IOException, SQLException {
    this.rs = queryData("select * from " + this.seek_db + " " + st0);
    this.rec_num = showCount();
    this.rs.beforeFirst();
    this.rs.next();
    for (int i = 0; i < this.rec_num; i++) {
      List<String> list = new ArrayList<>();
      this.al.add(list);
      for (int j = 0; j < this.cmd.length; j++)
        list.add(getNotNull(this.rs.getObject(this.cmd[j]))); 
      this.rs.next();
    } 
  }
  
  public String showDataInput(String st, int n) throws IOException, SQLException {
    String retval = "";
    int ch_num;
    for (ch_num = 0; ch_num < this.cmd.length && 
      !st.equals(this.cmd[ch_num]); ch_num++);
    if (n < this.rec_num && ch_num < this.cmd.length) {
      ArrayList<?> innerList = (ArrayList)this.al.get(n);
      retval = innerList.get(ch_num).toString();
    } 
    retval = retval.replaceAll("'", "&apos;");
    retval = retval.replaceAll("\"", "&quot;");
    return retval;
  }
  
  public String ChangeInput(String st) throws IOException, SQLException {
    String retval = "";
    retval = getNotNull(st);
    retval = retval.replaceAll("'", "&apos;");
    retval = retval.replaceAll("\"", "&quot;");
    return retval;
  }
  
  public void queryMe2(String st) throws IOException, SQLException {
    goQueryBySql(st);
  }
  
  public void queryMe1(String st, String st1) throws IOException, SQLException {
    goQuery(st, st1);
  }
  
  public void queryMe(String st) throws IOException, SQLException {
    goQuery(st);
  }
  
  public void queryMe(String st, String st1) throws IOException, SQLException {
    goQuery(st);
    recordKeyword(st1);
  }
  
  public void queryMeSingle(String st, String tb) throws IOException, SQLException {
    this.rs = queryData("select * from " + tb + " where " + st);
    this.rec_num = showCount();
    this.rs.beforeFirst();
    this.rs.next();
  }
  
  public String showDataSingle(String st, int n) throws IOException, SQLException {
    String retval = "";
    retval = this.rs.getString(st);
    return retval;
  }
  
  public ResultSet queryMeResultset(String st, String tb) throws IOException, SQLException {
    this.rs = queryData("select * from " + tb + " where " + st);
    this.rec_num = showCount();
    this.rs.beforeFirst();
    this.rs.next();
    return this.rs;
  }
  
  public ResultSet queryMeResultsetSql(String st) throws IOException, SQLException {
    this.rs = queryData(st);
    this.rec_num = showCount();
    this.rs.beforeFirst();
    this.rs.next();
    return this.rs;
  }
  
  public void KeywordMe(String st) throws IOException, SQLException {
    recordKeyword(st);
  }
  
  public void updateData(String st) throws IOException, SQLException {
    try {
      Thread.sleep(1L);
    } catch (InterruptedException e) {
      e.printStackTrace();
    } 
    super.updateData(st);
  }
  
  public void updateData(String st, String st1) throws IOException, SQLException {
    this.this_keyvalue = st1;
    super.updateData(st);
  }
  
  public String showData(String st, int n) throws IOException, SQLException {
    String retval = "";
    int ch_num;
    for (ch_num = 0; ch_num < this.cmd.length && 
      !st.equals(this.cmd[ch_num]); ch_num++);
    if (n < this.rec_num && ch_num < this.cmd.length) {
      ArrayList<?> innerList = (ArrayList)this.al.get(n);
      retval = innerList.get(ch_num).toString();
    } 
    return retval;
  }
  
  public String showDataDES(String st, int n) throws IOException, SQLException {
    String retval = "";
    int ch_num;
    for (ch_num = 0; ch_num < this.cmd.length && 
      !st.equals(this.cmd[ch_num]); ch_num++);
    if (n < this.rec_num && ch_num < this.cmd.length) {
      ArrayList<?> innerList = (ArrayList)this.al.get(n);
      retval = innerList.get(ch_num).toString();
      retval = hex2bin(retval);
    } 
    return getNotNull(retval);
  }
  
  public int SeekCount() throws IOException, SQLException {
    return this.rec_num;
  }
  
  private void goQueryBySql(String st) throws IOException, SQLException {
    this.rs = queryData(st);
    this.rec_num = showCount();
    this.rs.beforeFirst();
    this.rs.next();
    for (int i = 0; i < this.rec_num; i++) {
      List<String> list = new ArrayList<>();
      this.al.add(list);
      for (int j = 0; j < this.cmd.length; j++)
        list.add(getNotNull(this.rs.getObject(this.cmd[j]))); 
      this.rs.next();
    } 
  }
  
  private void goQuery(String st) throws IOException, SQLException {
    this.rs = queryData("select * from " + this.seek_db + " where " + st);
    this.rec_num = showCount();
    this.rs.beforeFirst();
    this.rs.next();
    for (int i = 0; i < this.rec_num; i++) {
      List<String> list = new ArrayList<>();
      this.al.add(list);
      for (int j = 0; j < this.cmd.length; j++)
        list.add(getNotNull(this.rs.getObject(this.cmd[j]))); 
      this.rs.next();
    } 
  }
  
  private void goQuery(String st, String st1) throws IOException, SQLException {
    this.rs = queryData("select * ," + st1 + " from " + this.seek_db + " where " + st);
    this.rec_num = showCount();
    this.rs.beforeFirst();
    this.rs.next();
    for (int i = 0; i < this.rec_num; i++) {
      List<String> list = new ArrayList<>();
      this.al.add(list);
      for (int j = 0; j < this.cmd.length; j++)
        list.add(getNotNull(this.rs.getObject(this.cmd[j]))); 
      this.rs.next();
    } 
  }
  
  private void recordQuery(String st) throws IOException, SQLException {}
  
  private void recordQuery(String st, String st1) throws IOException, SQLException {}
  
  private void saveAccessLog(String stw) throws IOException, SQLException {
    String stt = today();
    int sysid = find_me("manage_log", "log_date", stt, "sysid");
    try {
      if (sysid > 0) {
        super.updateData("update manage_log set access_log = CONCAT_WS(CHAR(10 using utf8), '" + todaytime() + "<wi>" + stw + "', access_log) where sysid = " + sysid + " ");
      } else {
        super.updateData("insert into manage_log (log_date, access_log) values ('" + stt + "','" + todaytime() + "<wi>" + stw + "')");
      } 
    } catch (IOException e) {
      stw = getNotNull(stw);
      if (sysid > 0) {
        super.updateData("update manage_log set access_log = CONCAT_WS(CHAR(10 using utf8), '" + todaytime() + "<wi>" + stw + "', access_log) where sysid = " + sysid + " ");
      } else {
        super.updateData("insert into manage_log (log_date, access_log) values ('" + stt + "','" + todaytime() + "<wi>" + stw + "')");
      } 
    } finally {
      super.updateData("update manage_log set all_log = CONCAT_WS(CHAR(10 using utf8), '" + todaytime() + "<wi>" + stw + "', all_log) where sysid = " + sysid + " ");
    } 
  }
  
  private void recordUpdate(String st) throws IOException, SQLException {
    String stt = today();
    String stw = getNotNull(String.valueOf(this.get_user) + "<wi>" + this.get_ip + "<wi>" + this.get_session + "<wi>" + this.get_jsp + "<wi>" + st);
    int sysid = find_me("manage_log", "log_date", stt, "sysid");
    try {
      if (sysid > 0) {
        super.updateData("update manage_log set update_log = CONCAT_WS(CHAR(10 using utf8), '" + todaytime() + "<wi>" + stw + "', update_log) where sysid = " + sysid + " ");
      } else {
        super.updateData("insert into manage_log (log_date, update_log) values ('" + stt + "','" + todaytime() + "<wi>" + stw + "')");
      } 
    } catch (IOException e) {
      stw = getNotNull(stw);
      if (sysid > 0) {
        super.updateData("update manage_log set update_log = CONCAT_WS(CHAR(10 using utf8), '" + todaytime() + "<wi>" + stw + "', update_log) where sysid = " + sysid + " ");
      } else {
        super.updateData("insert into manage_log (log_date, update_log) values ('" + stt + "','" + todaytime() + "<wi>" + stw + "')");
      } 
    } finally {
      super.updateData("update manage_log set all_log = CONCAT_WS(CHAR(10 using utf8), '" + todaytime() + "<wi>" + stw + "', all_log) where sysid = " + sysid + " ");
    } 
  }
  
  private void recordKeyword(String st) throws IOException, SQLException {
    String stw = getNotNull(st);
    String keyme = "";
    this.this_keyvalue = todaytime2();
    if (!stw.equals(""))
      try {
        keyme = "insert into keyword_log (sysid, log_date, log_keyword, log_user, log_session, log_ip) values ('" + this.this_keyvalue + "','" + today() + "','" + stw + "', '" + this.get_user + "' , '" + this.get_session + "', '" + this.get_ip + "')";
        super.updateData(keyme);
      } catch (IOException e) {
        stw = getNotNull(stw);
        keyme = "insert into keyword_log (sysid, log_date, log_keyword, log_user, log_session, log_ip) values ('" + this.this_keyvalue + "','" + today() + "','" + stw + "', '" + this.get_user + "' , '" + this.get_session + "', '" + this.get_ip + "')";
        super.updateData(keyme);
      }  
  }
  
  private String getPrimaryKey(String tb) throws IOException, SQLException {
    DatabaseMetaData dmd = this.conn.getMetaData();
    ResultSet rstb = dmd.getPrimaryKeys(null, null, getNotNull(tb.trim()));
    String primaryKey = "";
    while (rstb.next())
      primaryKey = rstb.getString("COLUMN_NAME"); 
    rstb = dmd.getColumns(null, null, getNotNull(tb.trim()), null);
    while (rstb.next()) {
      if (rstb.getString("COLUMN_NAME").equals(primaryKey)) {
        this.this_keytype = rstb.getString("TYPE_NAME");
        break;
      } 
    } 
    return primaryKey;
  }
  
  private void saveToSyncList(String st) throws IOException, SQLException {
    if (this.sync_flag == 1) {
      int findtable = 0;
      int tb_begin = 0;
      int tb_end = 0;
      if (st.indexOf("insert into") == 0) {
        tb_begin = st.indexOf("into") + 4;
        tb_end = st.indexOf("(");
        findtable = 1;
      } 
      if (st.indexOf("update") == 0) {
        tb_begin = st.indexOf("update") + 6;
        tb_end = st.indexOf("set");
        findtable = 1;
      } 
      if (findtable == 1) {
        this.tbnames = st.substring(tb_begin, tb_end).trim();
        this.tbfield = getPrimaryKey(this.tbnames);
        String states = "insert into sync_records (sysid, org_stat , tb , fd , typ, vl) values ('" + todaytime2() + "' , '" + getNotNull(st) + "' , '" + this.tbnames + "', '" + this.tbfield + "', '" + this.this_keytype + "' , '" + this.this_keyvalue + "')";
        super.updateData(states);
      } 
    } 
  }
}
