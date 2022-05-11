package wisoft;

import java.io.IOException;
import java.sql.SQLException;

public class FinishAuto extends getData {
  public void goAuto() throws IOException, SQLException, InterruptedException {
    try {
      Utility ul = new Utility();
      ul.updateData("update rev_room set less = 0,updatetime='" + ul.todaytime() + "' where less !=0  and Date(updatetime) < '" + ul.today() + "' ");
      ul.closeall();
    } catch (Exception exception) {}
  }
}
