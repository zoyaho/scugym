package wisoft;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Timer;
import java.util.TimerTask;

public class Door_Timer extends TimerTask {
  private static final long serialVersionUID = 1L;
  
  private String IN_CARD = "";
  
  private String OUT_CARD = "";
  
  String towho = "";
  
  String from = "libcir@nccu.edu.tw";
  
  private Timer tm = new Timer();
  
  public void run() {
    getDoor gdr52 = new getDoor();
    try {
      gdr52.forServlet2("52");
    } catch (SQLException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    } catch (InterruptedException e) {
      e.printStackTrace();
    } 
  }
}
