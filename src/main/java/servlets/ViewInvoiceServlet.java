package servlets;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewInvoiceServlet")
public class ViewInvoiceServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String billId = request.getParameter("id");
        Map<String, String> billData = new HashMap<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medical", "root", "root");
            
            // Get specific bill joined with patient info
            String sql = "SELECT b.bill_id, p.name, p.age, p.phone, b.treatment_name, b.amount, b.bill_date " +
                         "FROM bills b JOIN patients p ON b.patient_id = p.id WHERE b.bill_id = ?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(billId));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                billData.put("id", rs.getString("bill_id"));
                billData.put("name", rs.getString("name"));
                billData.put("age", rs.getString("age"));
                billData.put("phone", rs.getString("phone"));
                billData.put("treatment", rs.getString("treatment_name"));
                billData.put("amount", rs.getString("amount"));
                billData.put("date", rs.getString("bill_date"));
            }
            con.close();
        } catch (Exception e) { e.printStackTrace(); }

        request.setAttribute("bill", billData);
        request.getRequestDispatcher("invoice.jsp").forward(request, response);
    }
}