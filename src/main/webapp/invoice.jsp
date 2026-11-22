<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<% Map<String, String> b = (Map<String, String>) request.getAttribute("bill"); %>
<!DOCTYPE html>
<html>
<head>
    <title>Invoice #<%= b.get("id") %></title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f4f7f6; margin: 0; padding: 20px; }
        .invoice-box {
            max-width: 800px; margin: auto; padding: 30px; border: 1px solid #eee;
            background: #fff; box-shadow: 0 0 10px rgba(0, 0, 0, 0.15); color: #555;
        }
        .header { border-bottom: 2px solid #3498db; padding-bottom: 20px; margin-bottom: 20px; display: flex; justify-content: space-between; }
        .hospital-info h2 { color: #3498db; margin: 0; }
        .patient-info { margin-bottom: 20px; line-height: 1.6; }
        table { width: 100%; line-height: inherit; text-align: left; border-collapse: collapse; }
        th { background: #eee; border-bottom: 1px solid #ddd; padding: 10px; }
        td { padding: 10px; border-bottom: 1px solid #eee; }
        .total { font-size: 20px; font-weight: bold; text-align: right; margin-top: 20px; color: #2ecc71; }
        .no-print-area { text-align: center; margin-top: 30px; }
        .btn { padding: 10px 20px; color: white; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; }
        .btn-print { background: #3498db; }
        .btn-back { background: #95a5a6; }

        /* THIS PART ONLY PRINTS THE BILL */
        @media print {
            .no-print-area { display: none; }
            body { background: white; padding: 0; }
            .invoice-box { box-shadow: none; border: none; width: 100%; max-width: 100%; }
        }
    </style>
</head>
<body>

<div class="invoice-box">
    <div class="header">
        <div class="hospital-info">
            <h2>🏥 Medical Billing System</h2>
            <p>Vaagdevi Hospital, Warangal<br>Phone: +91 9876543210</p>
        </div>
        <div class="invoice-details">
            <p><strong>Invoice ID:</strong> #<%= b.get("id") %></p>
            <p><strong>Date:</strong> <%= b.get("date") %></p>
        </div>
    </div>

    <div class="patient-info">
        <h3>Patient Details</h3>
        <p><strong>Name:</strong> <%= b.get("name") %></p>
        <p><strong>Age:</strong> <%= b.get("age") %> Years</p>
        <p><strong>Phone:</strong> <%= b.get("phone") %></p>
    </div>

    <table>
        <thead>
            <tr>
                <th>Treatment Description</th>
                <th>Amount (INR)</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><%= b.get("treatment") %></td>
                <td>₹<%= b.get("amount") %></td>
            </tr>
        </tbody>
    </table>

    <div class="total">
        Total Amount: ₹<%= b.get("amount") %>
    </div>
</div>

<div class="no-print-area">
    <button class="btn btn-print" onclick="window.print()">Print Invoice</button>
    <a href="dashboard.jsp" class="btn btn-back">Back to Dashboard</a>
</div>

</body>
</html>