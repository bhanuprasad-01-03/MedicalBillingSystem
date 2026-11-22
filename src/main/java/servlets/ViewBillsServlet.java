package servlets;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewBillsServlet")
public class ViewBillsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, String>> billList = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/medical", "root", "root");
            
            // JOIN query to get Patient Name from the patients table
            String sql = "SELECT b.bill_id, p.name, b.treatment_name, b.amount, b.bill_date " +
                         "FROM bills b JOIN patients p ON b.patient_id = p.id ORDER BY b.bill_date DESC";
            
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);

            while (rs.next()) {
                Map<String, String> bill = new HashMap<>();
                bill.put("id", rs.getString("bill_id"));
                bill.put("patient", rs.getString("name"));
                bill.put("treatment", rs.getString("treatment_name"));
                bill.put("amount", rs.getString("amount"));
                bill.put("date", rs.getString("bill_date"));
                billList.add(bill);
            }
            con.close();
        } catch (Exception e) { e.printStackTrace(); }

        request.setAttribute("billList", billList);
        request.getRequestDispatcher("viewBills.jsp").forward(request, response);
    }
}