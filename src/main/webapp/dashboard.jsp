<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // SECURITY CHECK: Kick back to login if no session
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("index.jsp");
        return; 
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard - MedBill Pro</title>
<style>
    * { box-sizing: border-box; }
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; background: #f0f2f5; display: flex; }
    
    /* Sidebar Navigation */
    .sidebar { width: 250px; background: #2c3e50; height: 100vh; color: white; padding-top: 20px; position: fixed; }
    .sidebar h2 { text-align: center; color: #3498db; margin-bottom: 30px; }
    .sidebar a { display: block; color: white; padding: 15px 25px; text-decoration: none; transition: 0.3s; }
    .sidebar a:hover { background: #34495e; border-left: 4px solid #3498db; }
    
    /* Main Content */
    .main-content { margin-left: 250px; flex: 1; padding: 40px; }
    .header { margin-bottom: 30px; }
    
    /* The Card Grid - This keeps them aligned */
    .card-container { 
        display: flex; 
        flex-direction: column; 
        gap: 20px; 
        max-width: 800px; 
    }
    
    .card { 
        background: white; 
        padding: 30px; 
        border-radius: 15px; 
        box-shadow: 0 4px 15px rgba(0,0,0,0.05); 
        display: flex; 
        align-items: center; 
        justify-content: space-between; 
        transition: 0.3s;
        border: 1px solid #eee;
    }
    
    .card:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
    
    .card-info { display: flex; align-items: center; gap: 20px; }
    .card-icon { font-size: 40px; }
    .card-text h3 { margin: 0; color: #333; }
    .card-text p { margin: 5px 0 0 0; color: #777; font-size: 14px; }
    
    .btn-go { 
        padding: 10px 25px; 
        border-radius: 8px; 
        color: white; 
        text-decoration: none; 
        font-weight: bold; 
        cursor: pointer;
    }
    
    /* Colors for different buttons */
    .bg-green { background: #2ecc71; }
    .bg-blue { background: #3498db; }
    .bg-yellow { background: #f1c40f; color: #333 !important; }

</style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>🏥 Medical Billing </h2>
        <a href="dashboard.jsp">🏠 Dashboard</a>
        <a href="addPatient.html">➕ Add Patient</a>
        <a href="ViewPatientsServlet">📋 View Patients</a>
        <a href="GenerateBillServlet">💰 Billing</a>
        <a href="ViewBillsServlet">📑 View All Bills</a>
        <a href="DailyReportServlet">📅 Daily Report</a>
        <a href="index.jsp" style="margin-top: 50px; color: #e74c3c;">🚪 Logout</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <h1>Welcome back, <%= session.getAttribute("adminUser") %>! 👋</h1>
            <p style="color: #666;">Medical Billing System Management Portal</p>
        </div>

        <div class="card-container">
            
            <!-- Card 1: Add Patient -->
            <div class="card">
                <div class="card-info">
                    <div class="card-icon">👤</div>
                    <div class="card-text">
                        <h3>Add New Patient</h3>
                        <p>Register a new patient into the medical database.</p>
                    </div>
                </div>
                <a href="addPatient.html" class="btn-go bg-green">Go →</a>
            </div>

            <!-- Card 2: Patient Records -->
            <div class="card">
                <div class="card-info">
                    <div class="card-icon">📂</div>
                    <div class="card-text">
                        <h3>Patient Records</h3>
                        <p>Search and manage existing patient profiles.</p>
                    </div>
                </div>
                <a href="ViewPatientsServlet" class="btn-go bg-blue">View →</a>
            </div>

            <!-- Card 3: Billing - NOW MATCHING THE OTHERS -->
            <div class="card">
                <div class="card-info">
                    <div class="card-icon">💰</div>
                    <div class="card-text">
                        <h3>Billing & Invoices</h3>
                        <p>Generate new bills and view transaction history.</p>
                    </div>
                </div>
                <div style="display: flex; gap: 10px;">
                    <a href="GenerateBillServlet" class="btn-go bg-yellow">Create Bill</a>
                    <a href="ViewBillsServlet" class="btn-go bg-blue">History</a>
                </div>
            </div>

        </div>
    </div>

</body>
</html>