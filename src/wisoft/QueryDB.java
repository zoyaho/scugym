package wisoft;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class QueryDB extends DBConnect {
  Connection conn = null;
  
  Statement stmt = null;
  
  ResultSet rs = null;
  
  Statement stmt1 = null;
  
  ResultSet rs1 = null;
  
  int rs_count = 0;
  
  int rs_count1 = 0;
  
  public static void main(String[] args) {}
  
  public QueryDB() {
    try {
      this.conn = getDBConnect();
      this.stmt = this.conn.createStatement();
      this.stmt1 = this.conn.createStatement();
    } catch (Exception exception) {}
  }
  
  public void closeall() throws IOException, SQLException {
    try {
      if (this.rs != null)
        this.rs.close(); 
      if (this.rs1 != null)
        this.rs1.close(); 
      this.stmt.close();
      this.stmt1.close();
      this.conn.close();
    } catch (Exception exception) {}
  }
  
  public int showCount() throws IOException, SQLException {
    return this.rs_count;
  }
  
  public ResultSet queryData(String st) throws IOException, SQLException {
    this.rs_count = 0;
    this.rs = this.stmt.executeQuery(st);
    this.rs.last();
    this.rs_count = this.rs.getRow();
    return this.rs;
  }
  
  public ResultSet queryData1(String st) throws IOException, SQLException {
    this.rs_count1 = 0;
    this.rs1 = this.stmt1.executeQuery(st);
    this.rs1.last();
    this.rs_count1 = this.rs1.getRow();
    return this.rs1;
  }
  
  public void updateData(String st) throws IOException, SQLException {
    this.stmt.executeUpdate(st);
  }
}
