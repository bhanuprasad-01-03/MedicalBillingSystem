package servlets;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewPatientsServlet")
public class ViewPatientsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // List to hold patient data maps
        List<Map<String, String>> patientList = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medical", "root", "root");
            
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM patients");

            while (rs.next()) {
                Map<String, String> patient = new HashMap<>();
                patient.put("id", rs.getString("id"));
                patient.put("name", rs.getString("name"));
                patient.put("age", rs.getString("age"));
                patient.put("phone", rs.getString("phone"));
                patient.put("disease", rs.getString("disease"));
                patientList.add(patient);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Send the list to the JSP page
        request.setAttribute("patientList", patientList);
        request.getRequestDispatcher("viewPatients.jsp").forward(request, response);
    }
}