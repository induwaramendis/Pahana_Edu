<%@ page import="java.util.*, com.induwara.model.Bill" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Previous Bills - Pahana Edu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        :root {
            --bg-color: #f8f9fa;
            --card-bg: #ffffff;
            --text-color: #343a40;
            --highlight: #0d6efd;
        }

        body.dark-mode {
            --bg-color: #1e1e2f;
            --card-bg: #2c2c3e;
            --text-color: #ffffff;
            --highlight: #66b2ff;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            font-family: 'Segoe UI', sans-serif;
            transition: all 0.3s ease-in-out;
        }

        .container {
            margin-top: 60px;
            max-width: 1100px;
            padding: 40px;
            background-color: var(--card-bg);
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: var(--highlight);
            font-weight: 600;
            margin-bottom: 30px;
        }

        .form-label {
            font-weight: 500;
        }

        .btn-primary {
            background-color: var(--highlight);
            border-color: var(--highlight);
        }

        .table td, .table th {
            vertical-align: middle;
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
    <h2><i class="bi bi-receipt-cutoff me-2"></i>Previous Bills</h2>

    <a href="dashboard.jsp" class="btn btn-secondary mb-4"><i class="bi bi-arrow-left me-1"></i> Back to Dashboard</a>

    <!-- 🔍 Filter Form -->
    <form method="get" action="ViewBillsServlet" class="row g-3 mb-4">
        <div class="col-md-4">
            <label for="phone" class="form-label"><i class="bi bi-telephone me-1"></i>Phone Number</label>
            <input type="text" class="form-control" id="phone" name="phone"
                   value="<%= request.getAttribute("searchPhone") != null ? request.getAttribute("searchPhone") : "" %>">
        </div>
        <div class="col-md-4">
            <label for="date" class="form-label"><i class="bi bi-calendar-date me-1"></i>Date</label>
            <input type="date" class="form-control" id="date" name="date"
                   value="<%= request.getAttribute("searchDate") != null ? request.getAttribute("searchDate") : "" %>">
        </div>
        <div class="col-md-4 d-flex align-items-end gap-2">
            <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Search</button>
            <a href="ViewBillsServlet" class="btn btn-secondary"><i class="bi bi-arrow-clockwise"></i> Reset</a>
        </div>
    </form>

    <!-- 📋 Bills Table -->
    <%
        List<Bill> bills = (List<Bill>) request.getAttribute("bills");
        if (bills != null && !bills.isEmpty()) {
    %>
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-light">
                <tr>
                    <th>Bill ID</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Total (Rs.)</th>
                    <th>Date</th>
                </tr>
                </thead>
                <tbody>
                <% for (Bill bill : bills) { %>
                    <tr>
                        <td><%= bill.getBillId() %></td>
                        <td><%= bill.getCustomerEmail() %></td>
                        <td><%= bill.getCustomerPhone() %></td>
                        <td>Rs. <%= String.format("%.2f", bill.getTotal()) %></td>
                        <td><%= bill.getBillDate() %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    <%
        } else {
    %>
        <div class="alert alert-info mt-4">
            <i class="bi bi-info-circle me-1"></i> No previous bills found.
        </div>
    <%
        }
    %>
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
            icon.className = 'bi bi-sun-fill';
            toggleBtn.innerHTML = '<i class="bi bi-sun-fill"></i> Light Mode';
        } else {
            setCookie("theme", "light", 30);
            icon.className = 'bi bi-moon-stars-fill';
            toggleBtn.innerHTML = '<i class="bi bi-moon-stars-fill"></i> Dark Mode';
        }
    });

    window.addEventListener('DOMContentLoaded', () => {
        if (getCookie("theme") === "dark") {
            document.body.classList.add("dark-mode");
            const icon = toggleBtn.querySelector('i');
            icon.className = 'bi bi-sun-fill';
            toggleBtn.innerHTML = '<i class="bi bi-sun-fill"></i> Light Mode';
        }
    });
</script>

</body>
</html>
