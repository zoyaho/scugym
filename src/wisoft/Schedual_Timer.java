package wisoft;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet({"/Schedual_Timer"})
public class Schedual_Timer extends HttpServlet {
  private static final long serialVersionUID = 1L;
  
  private ScheduledExecutorService scheduler;
  
  public void init(ServletConfig config) throws ServletException {
    Utility util = new Utility();
    try {
      System.out.println("scugym"+ util.todaytime());
    } catch (IOException e) {
      e.printStackTrace();
    } catch (SQLException e) {
      e.printStackTrace();
    } 
    ScheduledThreadPoolExecutor threadPool = new ScheduledThreadPoolExecutor(5);
    try {
      System.out.println("scugym Auto"+ util.todaytime());
      Long midnight = Long.valueOf(LocalDateTime.now().until(LocalDate.now().plusDays(1L).atStartOfDay(), ChronoUnit.MINUTES));
      threadPool.scheduleWithFixedDelay(new AutoCancel(), 0L, 1440L, TimeUnit.MINUTES);
    } catch (Exception e) {
      e.printStackTrace();
    } 
  }
  
  public void destroy() {}
}
