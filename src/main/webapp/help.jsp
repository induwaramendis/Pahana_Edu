<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String adminName = (String) session.getAttribute("adminName");
    if (adminName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Help - Admin Guide</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        :root {
            --bg-color: #f8f9fa;
            --text-color: #212529;
            --card-bg: #ffffff;
            --accent: #0d6efd;
        }

        body.dark-mode {
            --bg-color: #121212;
            --text-color: #ffffff;
            --card-bg: #1e1e2f;
            --accent: #66b2ff;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            transition: background 0.3s, color 0.3s;
            font-family: 'Segoe UI', sans-serif;
        }

        .container {
            margin-top: 60px;
            max-width: 900px;
            padding: 40px;
            background-color: var(--card-bg);
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: var(--accent);
            font-weight: 600;
            margin-bottom: 20px;
        }

        h4 {
            margin-top: 25px;
            font-weight: 500;
        }

        .btn-primary {
            background-color: var(--accent);
            border-color: var(--accent);
        }

        .dark-toggle {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
        }
    </style>
</head>
<body>

<!-- 🌙 Dark Mode Toggle -->
<div class="dark-toggle">
    <button id="toggleTheme" class="btn btn-outline-dark btn-sm">
        <i class="bi bi-moon-stars-fill"></i> Dark Mode
    </button>
</div>

<div class="container">
    <h2><i class="bi bi-info-circle-fill me-2"></i>Help - Admin System Guide</h2>
    <p class="lead">This page provides step-by-step instructions to guide admins on how to use the system efficiently.</p>

    <hr>

    <h4>1. 📝 Register New Admin</h4>
    <p>Visit the registration page, enter your name, email, and password, then click <b>"Register"</b>.</p>

    <h4>2. 🔐 Login</h4>
    <p>Login with your registered email and password from the login screen.</p>

    <h4>3. ➕ Add New Customer</h4>
    <p>Go to <b>"Add Customer"</b>, fill in details like account number, name, address, and phone, and click <b>"Add Customer"</b>.</p>

    <h4>4. ✏️ Edit Customer Info</h4>
    <p>In the <b>"Edit Customer"</b> section, enter the account number, search the customer, edit details, and save updates.</p>

    <h4>5. 📦 Manage Items</h4>
    <ul>
        <li><b>Add</b>: Fill item name, price, stock → Click <b>Add</b>.</li>
        <li><b>Update</b>: Edit directly in the table → Click <b>Update</b>.</li>
        <li><b>Delete</b>: Click <b>Delete</b> beside the item row.</li>
    </ul>

    <h4>6. 📋 View Customer Accounts</h4>
    <p>Displays all customer records with account number, name, email, address, and contact.</p>

    <h4>7. 💰 Calculate & Print Bill</h4>
    <p>Enter customer contact and item quantities. The system calculates the total. You can then save or print the bill.</p>

    <h4>8. ❓ Forgot Password</h4>
    <p>Click <b>"Forgot Password"</b> on the login page and follow email instructions to reset.</p>

    <h4>9. 🚪 Exit System</h4>
    <p>Click <b>Logout</b> to safely sign out.</p>

    <hr>
    <a href="dashboard.jsp" class="btn btn-primary"><i class="bi bi-arrow-left"></i> Back to Dashboard</a>
</div>

<!-- 🌙 Dark Mode Script -->
<script>
    function setCookie(name, value, days) {
        const d = new Date();
        d.setTime(d.getTime() + (days*24*60*60*1000));
        document.cookie = name + "=" + value + ";expires=" + d.toUTCString() + ";path=/";
    }

    function getCookie(name) {
        const cname = name + "=";
        const decoded = decodeURIComponent(document.cookie);
        const parts = decoded.split(';');
        for (let c of parts) {
            if (c.trim().indexOf(cname) === 0)
                return c.trim().substring(cname.length);
        }
        return "";
    }

    const toggleBtn = document.getElementById('toggleTheme');
    toggleBtn.addEventListener('click', () => {
        document.body.classList.toggle('dark-mode');
        const icon = toggleBtn.querySelector('i');
        if (document.body.classList.contains('dark-mode')) {
            setCookie("theme", "dark", 30);
            toggleBtn.innerHTML = '<i class="bi bi-sun-fill"></i> Light Mode';
        } else {
            setCookie("theme", "light", 30);
            toggleBtn.innerHTML = '<i class="bi bi-moon-stars-fill"></i> Dark Mode';
        }
    });

    window.addEventListener('DOMContentLoaded', () => {
        if (getCookie("theme") === "dark") {
            document.body.classList.add("dark-mode");
            toggleBtn.innerHTML = '<i class="bi bi-sun-fill"></i> Light Mode';
        }
    });
</script>

</body>
</html>
