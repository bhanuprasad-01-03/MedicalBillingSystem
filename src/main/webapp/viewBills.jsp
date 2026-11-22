<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Bill History - Medical Billing</title>
    <style>
        body { font-family: 'Segoe UI'; margin: 0; display: flex; background: #f0f2f5; }
        .sidebar { width: 250px; background: #2c3e50; height: 100vh; color: white; padding-top: 20px; position: fixed; }
        .sidebar h2 { text-align: center; color: #3498db; }
        .sidebar a { display: block; color: white; padding: 15px 25px; text-decoration: none; }
        .main-content { margin-left: 250px; flex: 1; padding: 40px; }
        .card { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { background: #f8f9fa; color: #333; text-align: left; padding: 12px; border-bottom: 2px solid #dee2e6; }
        td { padding: 12px; border-bottom: 1px solid #eee; }
        .amt { font-weight: bold; color: #2ecc71; }
        
        /* NEW STYLING FOR VIEW BUTTON */
        .btn-view { 
            background: #3498db; color: white; padding: 6px 12px; 
            border-radius: 4px; text-decoration: none; font-size: 13px; font-weight: bold;
        }
        .btn-view:hover { background: #2980b9; }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>🏥 Medical Billing</h2>
        <a href="dashboard.jsp">🏠 Dashboard</a>
        <a href="addPatient.html">➕ Add Patient</a>
        <a href="ViewPatientsServlet">📋 View Patients</a>
        <a href="GenerateBillServlet">💰 Billing</a>
        <a href="ViewBillsServlet">📑 View All Bills</a>
        <a href="DailyReportServlet">📅 Daily Report</a>
    </div>

    <div class="main-content">
        <h1>All Billing Transactions</h1>
        <div class="card">
            <table>
                <thead>
                    <tr>
                        <th>Bill ID</th>
                        <th>Patient Name</th>
                        <th>Treatment</th>
                        <th>Amount</th>
                        <th>Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Map<String, String>> bills = (List<Map<String, String>>) request.getAttribute("billList");
                        if(bills != null && !bills.isEmpty()) {
                            for(Map<String, String> b : bills) {
                    %>
                        <tr>
                            <td>#<%= b.get("id") %></td>
                            <td style="font-weight:bold;"><%= b.get("patient") %></td>
                            <td><%= b.get("treatment") %></td>
                            <td class="amt">₹<%= b.get("amount") %></td>
                            <td><%= b.get("date") %></td>
                            <td>
                                <!-- ✅ ACTION: Only view/print THIS specific bill -->
                                <a href="ViewInvoiceServlet?id=<%= b.get("id") %>" class="btn-view">View / Print 📄</a>
                            </td>
                        </tr>
                    <%      } 
                        } else { %>
                        <tr><td colspan="6" style="text-align:center;">No billing records found.</td></tr>
                    <%  } %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>