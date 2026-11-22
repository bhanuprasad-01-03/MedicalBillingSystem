<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    // Security Check
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Patient Records - Medical Billing</title>
    <style>
        body { font-family: 'Segoe UI'; margin: 0; display: flex; background: #f0f2f5; }
        .sidebar { width: 250px; background: #2c3e50; height: 100vh; color: white; padding-top: 20px; position: fixed; }
        .sidebar h2 { text-align: center; color: #3498db; }
        .sidebar a { display: block; color: white; padding: 15px 25px; text-decoration: none; transition: 0.3s; }
        .sidebar a:hover { background: #34495e; }
        
        .main-content { margin-left: 250px; flex: 1; padding: 40px; }
        .card { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { background: #f8f9fa; color: #333; text-align: left; padding: 12px; border-bottom: 2px solid #dee2e6; }
        td { padding: 12px; border-bottom: 1px solid #eee; color: #555; }
        tr:hover { background: #f1f1f1; }
        
        .badge { padding: 5px 10px; border-radius: 20px; font-size: 12px; background: #e3f2fd; color: #0d47a1; }
        
        /* Delete Button Styling */
        .btn-delete { 
            color: #e74c3c; 
            text-decoration: none; 
            font-weight: bold; 
            background: #fdeaea; 
            padding: 5px 10px; 
            border-radius: 5px;
            font-size: 13px;
        }
        .btn-delete:hover { background: #e74c3c; color: white; }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2>🏥 Medical Billing</h2>
        <a href="dashboard.jsp">🏠 Dashboard</a>
        <a href="addPatient.html">➕ Add Patient</a>
        <a href="ViewPatientsServlet">📋 View Patients</a>
        <a href="GenerateBillServlet">💰 Billing</a> <!-- Fixed Link -->
        <a href="ViewBillsServlet">📑 View All Bills</a>
        <a href="DailyReportServlet">📅 Daily Report</a>
        <a href="index.jsp" style="margin-top: 50px; color: #e74c3c;">🚪 Logout</a>
    </div>

    <div class="main-content">
        <h1>Patient Records</h1>
        <div class="card">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Age</th>
                        <th>Phone</th>
                        <th>Disease</th>
                        <th>Action</th> <!-- New Column -->
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Map<String, String>> patients = (List<Map<String, String>>) request.getAttribute("patientList");
                        if (patients != null && !patients.isEmpty()) {
                            for (Map<String, String> p : patients) {
                    %>
                        <tr>
                            <td>#<%= p.get("id") %></td>
                            <td style="font-weight:bold;"><%= p.get("name") %></td>
                            <td><%= p.get("age") %></td>
                            <td><%= p.get("phone") %></td>
                            <td><span class="badge"><%= p.get("disease") %></span></td>
                            <td>
                                <!-- DELETE LINK WITH CONFIRMATION -->
                                <a href="DeletePatientServlet?id=<%= p.get("id") %>" 
                                   class="btn-delete" 
                                   onclick="return confirm('Are you sure you want to delete this patient record?')">
                                   Delete 🗑️
                                </a>
                            </td>
                        </tr>
                    <% 
                            }
                        } else {
                    %>
                        <tr><td colspan="6" style="text-align:center;">No records found.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>