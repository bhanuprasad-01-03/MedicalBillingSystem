package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PatientServlet")
public class PatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Getting parameters from the form
        String name = request.getParameter("name");
        String ageStr = request.getParameter("age");
        String phone = request.getParameter("phone");
        String disease = request.getParameter("disease");

        // Basic validation for Age to prevent NumberFormatException
        int age = 0;
        if (ageStr != null && !ageStr.isEmpty()) {
            try {
                age = Integer.parseInt(ageStr);
            } catch (NumberFormatException e) {
                age = 0;
            }
        }

        // Database Credentials
        String url = "jdbc:mysql://localhost:3306/medical?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        String user = "root";
        String pass = "root";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection con = DriverManager.getConnection(url, user, pass);
                 // 🔥 Updated SQL to include reg_date column
                 PreparedStatement ps = con.prepareStatement("INSERT INTO patients(name, age, phone, disease, reg_date) VALUES (?, ?, ?, ?, CURRENT_DATE)")) {
                
                ps.setString(1, name);
                ps.setInt(2, age);
                ps.setString(3, phone);
                ps.setString(4, disease);

                ps.executeUpdate();

                // SUCCESS PAGE HTML
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Success</title>");
                out.println("<style>");
                out.println("body { font-family: 'Segoe UI', sans-serif; background: #f4f7fb; display:flex; justify-content:center; align-items:center; height:100vh; margin:0; }");
                out.println(".card { background:white; padding:40px; border-radius:15px; box-shadow:0 10px 30px rgba(0,0,0,0.1); text-align:center; width:380px; }");
                out.println("h2 { color: #28a745; margin-bottom:15px; }");
                out.println("p { color:#555; margin-bottom:25px; }");
                out.println(".btn { display:block; padding:12px; margin: 10px 0; text-decoration:none; border-radius:8px; font-weight: 600; transition: 0.3s; }");
                out.println(".btn-dash { background:#007bff; color:white; }");
                out.println(".btn-dash:hover { background:#0056b3; }");
                out.println(".btn-view { background:#28a745; color:white; }");
                out.println(".btn-view:hover { background:#218838; }");
                out.println("</style>");
                out.println("</head>");
                out.println("<body>");
                
                out.println("<div class='card'>");
                out.println("<h2>✔ Patient Registered</h2>");
                out.println("<p>Patient <b>" + name + "</b> has been added to the system.</p>");
                
                // --- BUTTONS LINKING TO THE DASHBOARD AND VIEW SERVLET ---
                out.println("<a href='ViewPatientsServlet' class='btn btn-view'>📋 View Patient Records</a>");
                out.println("<a href='dashboard.jsp' class='btn btn-dash'>🏠 Back to Dashboard</a>");
                
                out.println("</div>");
                out.println("</body></html>");
            }

        } catch (ClassNotFoundException e) {
            out.println("<h3 style='color:red;'>Driver Error: " + e.getMessage() + "</h3>");
        } catch (SQLException e) {
            out.println("<h3 style='color:red;'>Database Error: " + e.getMessage() + "</h3>");
        } catch (Exception e) {
            out.println("<h3 style='color:red;'>General Error: " + e.getMessage() + "</h3>");
        }
    }
}