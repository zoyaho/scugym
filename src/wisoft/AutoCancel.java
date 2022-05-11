package wisoft;

import java.io.IOException;
import java.util.TimerTask;

public class AutoCancel extends TimerTask {
  FinishAuto finish = new FinishAuto();
  
  Utility util = new Utility();
  
  public void run() {
    try {
      this.finish.goAuto();
    } catch (IOException|java.sql.SQLException e) {
      System.out.println(e);
      e.printStackTrace();
    } catch (InterruptedException e) {
      System.out.println(e);
      e.printStackTrace();
    } 
  }
}
