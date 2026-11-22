<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Generate Bill - Medical Billing</title>
    <style>
        body { font-family: 'Segoe UI'; margin: 0; display: flex; background: #f0f2f5; }
        .sidebar { width: 250px; background: #2c3e50; height: 100vh; color: white; padding-top: 20px; position: fixed; }
        .sidebar h2 { text-align: center; color: #3498db; }
        .sidebar a { display: block; color: white; padding: 15px 25px; text-decoration: none; }
        .main-content { margin-left: 250px; flex: 1; padding: 40px; display:flex; justify-content:center; }
        
        .bill-box { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); width: 400px; height: fit-content; }
        h2 { margin-top: 0; color: #2c3e50; text-align: center; }
        label { display: block; margin-top: 15px; font-weight: 600; color: #555; }
        select, input { width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #ddd; border-radius: 6px; }
        .btn-bill { background: #f1c40f; color: #2c3e50; border: none; padding: 12px; width: 100%; border-radius: 6px; font-weight: bold; cursor: pointer; margin-top: 20px; font-size: 16px; }
        .btn-bill:hover { background: #d4ac0d; }
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
        <a href="index.jsp" style="margin-top: 50px; color: #e74c3c;">🚪 Logout</a>
    </div>

    <div class="main-content">
        <div class="bill-box">
            <h2>💰 Generate Invoice</h2>
            <form action="GenerateBillServlet" method="post">
                <label>Select Patient</label>
                <select name="patientId" required>
                    <option value="">-- Choose Patient --</option>
                    <% 
                        List<Map<String, String>> patients = (List<Map<String, String>>) request.getAttribute("patients");
                        if(patients != null) {
                            for(Map<String, String> p : patients) {
                    %>
                        <option value="<%= p.get("id") %>"><%= p.get("name") %> (ID: <%= p.get("id") %>)</option>
                    <%      } 
                        } 
                    %>
                </select>

                <label>Treatment / Service</label>
                <input type="text" name="treatment" placeholder="e.g. Blood Test, X-Ray" required>

                <label>Amount (₹)</label>
                <input type="number" name="amount" step="0.01" placeholder="Enter cost" required>

                <button type="submit" class="btn-bill">Create Bill</button>
            </form>
        </div>
    </div>

</body>
</html>