package servlets;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DailyReportServlet")
public class DailyReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. Get the date from the user picker
        String reportDate = request.getParameter("reportDate");
        if (reportDate == null || reportDate.isEmpty()) {
            reportDate = java.time.LocalDate.now().toString();
        }

        List<Map<String, String>> dailyRecords = new ArrayList<>();
        double totalDayEarnings = 0.0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medical?useSSL=false&serverTimezone=UTC", "root", "root");
            
            // 🔥 NEW LOGIC: We query from the BILLS table.
            // This ensures we ONLY see people who had financial activity on that day.
            String sql = "SELECT p.name, " +
                         "GROUP_CONCAT(b.treatment_name SEPARATOR ', ') as treatments, " +
                         "SUM(b.amount) as total_cost " +
                         "FROM bills b " +
                         "JOIN patients p ON b.patient_id = p.id " +
                         "WHERE DATE(b.bill_date) = ? " +
                         "GROUP BY p.id, p.name";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, reportDate);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("name", rs.getString("name"));
                row.put("reason", rs.getString("treatments"));
                
                double patientTotal = rs.getDouble("total_cost");
                row.put("amount", String.valueOf(patientTotal));
                
                totalDayEarnings += patientTotal;
                dailyRecords.add(row);
            }
            con.close();
            
        } catch (Exception e) { 
            e.printStackTrace(); 
            response.setContentType("text/html");
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
            return;
        }

        request.setAttribute("records", dailyRecords);
        request.setAttribute("total", totalDayEarnings);
        request.setAttribute("selectedDate", reportDate);
        
        request.getRequestDispatcher("dailyReport.jsp").forward(request, response);
    }
}