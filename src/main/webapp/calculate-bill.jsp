<%@ page import="java.util.*, com.induwara.dao.ItemDAO, com.induwara.model.Item" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Generate Bill - Pahana Edu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap + Icons -->
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
            max-width: 1000px;
            padding: 40px;
            background-color: var(--card-bg);
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: var(--highlight);
            font-weight: 600;
            margin-bottom: 30px;
        }

        .form-label {
            font-weight: 500;
        }

        .btn-primary, .btn-success {
            background-color: var(--highlight);
            border-color: var(--highlight);
        }

        .dark-toggle {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
        }

        .table td, .table th {
            vertical-align: middle;
        }

        .table input[type="number"] {
            width: 100%;
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
    <h2><i class="bi bi-receipt me-2"></i>Generate Customer Bill</h2>

    <form action="GenerateBillServlet" method="post">

        <!-- 🛒 Items Table -->
        <div class="table-responsive mb-4">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Item Name</th>
                        <th>Price (Rs.)</th>
                        <th>Available Stock</th>
                        <th>Quantity to Purchase</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    ItemDAO dao = new ItemDAO();
                    List<Item> items = dao.getAllItems();

                    for (Item item : items) {
                %>
                    <tr>
                        <td><%= item.getItemName() %></td>
                        <td>Rs. <%= String.format("%.2f", item.getPrice()) %></td>
                        <td><%= item.getStock() %></td>
                        <td>
                            <input type="number" min="0" name="quantity_<%= item.getItemId() %>" class="form-control" value="0">
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

        <!-- 📞 Customer Phone -->
        <div class="mb-3">
            <label for="customerPhone" class="form-label"><i class="bi bi-telephone me-1"></i>Customer Phone Number</label>
            <input type="text" name="customerPhone" id="customerPhone" class="form-control" required>
        </div>

        <!-- 📧 Customer Email -->
        <div class="mb-3">
            <label for="customerEmail" class="form-label"><i class="bi bi-envelope me-1"></i>Customer Email</label>
            <input type="email" name="customerEmail" id="customerEmail" class="form-control" required>
        </div>

        <!-- 🔘 Buttons -->
        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-success"><i class="bi bi-calculator-fill me-1"></i>Generate Bill</button>
            <a href="dashboard.jsp" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Back</a>
        </div>
    </form>
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
