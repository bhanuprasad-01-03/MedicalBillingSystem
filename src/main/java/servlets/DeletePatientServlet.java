package servlets;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeletePatientServlet")
public class DeletePatientServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String patientId = request.getParameter("id");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medical", "root", "root");
            
            // Delete query
            PreparedStatement ps = con.prepareStatement("DELETE FROM patients WHERE id = ?");
            ps.setInt(1, Integer.parseInt(patientId));
            
            ps.executeUpdate();
            con.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to the list so you see the patient is gone
        response.sendRedirect("ViewPatientsServlet");
    }
}