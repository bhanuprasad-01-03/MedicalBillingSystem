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
    <title>Daily Report - Medical Billing</title>
    <style>
        /* --- SCREEN STYLES (What you see in browser) --- */
        body { font-family: 'Segoe UI'; margin: 0; display: flex; background: #f0f2f5; }
        .sidebar { width: 250px; background: #2c3e50; height: 100vh; color: white; padding-top: 20px; position: fixed; }
        .sidebar h2 { text-align: center; color: #3498db; }
        .sidebar a { display: block; color: white; padding: 15px 25px; text-decoration: none; border-bottom: 1px solid #34495e; }
        .sidebar a:hover { background: #34495e; }
        .main-content { margin-left: 250px; flex: 1; padding: 40px; }
        .card { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .filter-bar { display: flex; align-items: center; gap: 15px; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #f8f9fa; color: #333; }
        .total-box { margin-top: 20px; padding: 20px; background: #28a745; color: white; border-radius: 8px; text-align: right; font-size: 22px; font-weight: bold; }
        
        .btn-gen { background: #007bff; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; font-weight: bold; }
        /* Print Button Style */
        .btn-print { background: #6c757d; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; font-weight: bold; margin-left: 10px; }
        .btn-print:hover { background: #5a6268; }

        /* --- PRINT STYLES (What the printer sees) --- */
        @media print {
            .sidebar, .filter-bar, .btn-print, .no-print {
                display: none !important;
            }
            body { background: white; }
            .main-content { margin-left: 0; padding: 0; width: 100%; }
            .card { box-shadow: none; border: 1px solid #eee; }
            h1 { text-align: center; color: black; }
            .total-box { background: white !important; color: black !important; border: 2px solid black; }
            table { border: 1px solid black; }
            th { border-bottom: 2px solid black; }
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>🏥 Medical Billing</h2>
        <a href="dashboard.jsp">🏠 Dashboard</a>
        <a href="addPatient.html">➕ Add Patient</a>
        <a href="ViewPatientsServlet">📋 View Patients</a>
        <a href="GenerateBillServlet">💰 Billing</a>
        <a href="DailyReportServlet">📅 Daily Report</a>
        <a href="ViewBillsServlet">📑 View All Bills</a>
        <a href="index.jsp" style="margin-top: 50px; color: #ff4d4d;">🚪 Logout</a>
    </div>

    <div class="main-content">
        <h1>📅 Daily Audit Report</h1>
        
        <div class="card">
            <div class="filter-bar">
                <form action="DailyReportServlet" method="GET" style="display:flex; align-items:center; gap:10px;">
                    <label><b>View Report For:</b></label>
                    <input type="date" name="reportDate" style="padding:8px;" value="<%= (request.getAttribute("selectedDate") != null) ? request.getAttribute("selectedDate") : "" %>">
                    <button type="submit" class="btn-gen">Generate Report</button>
                </form>
                <!-- 🔥 THE PRINT BUTTON -->
                <button onclick="window.print()" class="btn-print">🖨️ Print Report</button>
            </div>

            <p class="no-print" style="color:#666;">Report for Date: <b><%= request.getAttribute("selectedDate") %></b></p>

            <table>
                <thead>
                    <tr>
                        <th>Patient Name</th>
                        <th>Treatment / Details</th>
                        <th>Amount (INR)</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Map<String, String>> records = (List<Map<String, String>>) request.getAttribute("records");
                        if(records != null && !records.isEmpty()) {
                            for(Map<String, String> r : records) {
                    %>
                        <tr>
                            <td><b><%= r.get("name") %></b></td>
                            <td><%= r.get("reason") %></td>
                            <td>₹<%= r.get("amount") %></td>
                        </tr>
                    <%      } 
                        } else { %>
                        <tr><td colspan="3" style="text-align:center; padding:30px; color:#999;">No transactions found for this date.</td></tr>
                    <%  } %>
                </tbody>
            </table>

            <div class="total-box">
                Total Day Revenue: ₹<%= (request.getAttribute("total") != null) ? request.getAttribute("total") : "0.0" %>
            </div>
        </div>
        
        <p style="text-align:center; margin-top:20px; font-size:12px; color:#aaa;" class="only-print">
            Report generated on <%= new java.util.Date() %> | Medical Billing System
        </p>
    </div>
</body>
</html>