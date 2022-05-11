package wisoft;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBConnect {
  public Connection getDBConnect() throws IOException, SQLException, NamingException {
    Context initContext = new InitialContext();
    Context envContext = (Context)initContext.lookup("java:comp/env");
    DataSource ds = (DataSource)envContext.lookup("jdbc/SCUGYM");
    Connection conn = ds.getConnection();
    return conn;
  }
  
  public Connection getDBConnect1() throws IOException, SQLException, NamingException {
    Context initContext = new InitialContext();
    Context envContext = (Context)initContext.lookup("java:comp/env");
    DataSource ds = (DataSource)envContext.lookup("jdbc/SCUDB");
    Connection conn = ds.getConnection();
    return conn;
  }
}
