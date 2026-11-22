<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Medical Billing System - Login</title>

<style>
* { box-sizing: border-box; } /* Prevents inputs from overflowing */

body {
    margin: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.box {
    background: white;
    padding: 40px;
    border-radius: 15px;
    width: 380px;
    box-shadow: 0 15px 35px rgba(0,0,0,0.2);
    text-align: center;
}

h2 {
    margin-bottom: 10px;
    color: #333;
}

p.subtitle {
    color: #777;
    margin-bottom: 25px;
    font-size: 14px;
}

input {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    border-radius: 8px;
    border: 1px solid #ddd;
    outline: none;
    transition: 0.3s;
}

input:focus {
    border-color: #007bff;
    box-shadow: 0 0 5px rgba(0,123,255,0.2);
}

button {
    width: 100%;
    padding: 12px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    margin-top: 15px;
    transition: 0.3s;
}

button:hover {
    background: #0056b3;
}

.error-msg {
    color: #d9534f;
    background: #fdf7f7;
    padding: 10px;
    border-radius: 5px;
    margin-bottom: 15px;
    font-size: 14px;
    border: 1px solid #ebccd1;
}
</style>

</head>

<body>

<div class="box">
    <h2>Medical Billing</h2>
    <p class="subtitle">Please enter your credentials</p>

    <% 
       // This checks if the LoginServlet sent back an error attribute
       String error = (String) request.getAttribute("errorMessage");
       if (error != null) { 
    %>
        <div class="error-msg">
            <%= error %>
        </div>
    <% } %>

    <form action="LoginServlet" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>
</div>

</body>
</html>