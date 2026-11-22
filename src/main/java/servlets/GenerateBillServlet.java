package servlets;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/GenerateBillServlet")
public class GenerateBillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, String>> patientList = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medical?useSSL=false&serverTimezone=UTC", "root", "root");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT id, name FROM patients");
            while (rs.next()) {
                Map<String, String> p = new HashMap<>();
                p.put("id", rs.getString("id"));
                p.put("name", rs.getString("name"));
                patientList.add(p);
            }
            con.close();
        } catch (Exception e) { e.printStackTrace(); }
        request.setAttribute("patients", patientList);
        request.getRequestDispatcher("generateBill.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String patientId = request.getParameter("patientId");
        String treatment = request.getParameter("treatment");
        String amountStr = request.getParameter("amount");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medical?useSSL=false&serverTimezone=UTC", "root", "root");
            
            // 🔥 IMPORTANT: Added RETURN_GENERATED_KEYS to get the new Bill ID
            String sql = "INSERT INTO bills (patient_id, treatment_name, amount) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            ps.setInt(1, Integer.parseInt(patientId));
            ps.setString(2, treatment);
            ps.setDouble(3, Double.parseDouble(amountStr));
            ps.executeUpdate();

            // 🔥 GET THE NEWLY CREATED BILL ID
            ResultSet rs = ps.getGeneratedKeys();
            int newBillId = 0;
            if (rs.next()) {
                newBillId = rs.getInt(1);
            }
            con.close();

            // ✅ REDIRECT TO THE SPECIFIC INVOICE ONLY
            response.sendRedirect("ViewInvoiceServlet?id=" + newBillId);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}