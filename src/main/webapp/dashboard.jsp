<%
    String adminName = (String) session.getAttribute("adminName");
    if (adminName == null) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("adminName".equals(c.getName())) {
                    adminName = c.getValue();
                    session.setAttribute("adminName", adminName);
                    break;
                }
            }
        }
    }
    if (adminName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Pahana Edu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        :root {
            --bg-color: #f8f9fa;
            --card-bg: #ffffff;
            --text-color: #343a40;
            --card-shadow: rgba(0, 0, 0, 0.05);
            --highlight: #0d6efd;
        }

        body.dark-mode {
            --bg-color: #1e1e2f;
            --card-bg: #2c2c3e;
            --text-color: #ffffff;
            --card-shadow: rgba(0, 0, 0, 0.2);
            --highlight: #66b2ff;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .dashboard-container {
            padding: 60px 15px;
        }

        h2.text-center {
            font-weight: 700;
            color: var(--text-color);
        }

        .card {
            border: none;
            border-radius: 15px;
            background-color: var(--card-bg);
            box-shadow: 0 8px 20px var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px var(--card-shadow);
        }

        .card h5 {
            font-size: 1.25rem;
            color: var(--highlight);
            font-weight: 600;
        }

        .card p {
            color: var(--text-color);
            opacity: 0.85;
            font-size: 0.95rem;
        }

        .text-decoration-none {
            color: inherit;
        }

        .text-decoration-none:hover {
            text-decoration: none;
        }

        .logout {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
        }

        .dark-toggle {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
        }

        @media (max-width: 576px) {
            .logout a,
            .dark-toggle button {
                padding: 6px 10px;
                font-size: 0.875rem;
            }

            h2.text-center {
                font-size: 1.5rem;
            }

            .card h5 {
                font-size: 1.1rem;
            }

            .card p {
                font-size: 0.85rem;
            }
        }
    </style>
</head>
<body>

<!-- Dark Mode Toggle -->
<div class="dark-toggle">
    <button id="toggleTheme" class="btn btn-outline-dark btn-sm">
        <i class="bi bi-moon-stars-fill"></i> Dark Mode
    </button>
</div>

<!-- Logout Buttons -->
<div class="logout d-flex flex-column gap-2">
    
    <a href="LogoutServlet" class="btn btn-danger"><i class="bi bi-x-circle-fill"></i> Exit System</a>
</div>

<div class="container dashboard-container">
    <h2 class="text-center mb-5">Admin Dashboard - Pahana Edu</h2>

    <div class="row g-4">

        <div class="col-md-4">
            <a href="add-customer.jsp" class="text-decoration-none">
                <div class="card text-center shadow p-4">
                    <h5><i class="bi bi-person-plus-fill me-2"></i>Add Customer Account</h5>
                    <p>Store new customer details</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="edit-customer.jsp" class="text-decoration-none">
                <div class="card text-center shadow p-4">
                    <h5><i class="bi bi-pencil-square me-2"></i>Edit Customer</h5>
                    <p>Modify existing customer info</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="ManageItemServlet" class="text-decoration-none">
                <div class="card text-center shadow p-4">
                    <h5><i class="bi bi-box-seam me-2"></i>Manage Items</h5>
                    <p>Add / Update / Delete items</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="ViewAccountServlet" class="text-decoration-none">
                <div class="card text-center shadow p-4">
                    <h5><i class="bi bi-person-lines-fill me-2"></i>Account Details</h5>
                    <p>View customer account data</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="calculate-bill.jsp" class="text-decoration-none">
                <div class="card text-center shadow p-4">
                    <h5><i class="bi bi-calculator-fill me-2"></i>Calculate & Print Bill</h5>
                    <p>Compute bill for consumption</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="ViewBillsServlet" class="text-decoration-none">
                <div class="card text-center shadow p-4">
                    <h5><i class="bi bi-receipt-cutoff me-2"></i>View Previous Bills</h5>
                    <p>Check Bills</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="help.jsp" class="text-decoration-none">
                <div class="card text-center shadow p-4">
                    <h5><i class="bi bi-question-circle-fill me-2"></i>Help</h5>
                    <p>View system usage guide</p>
                </div>
            </a>
        </div>

    </div>
</div>

<!-- JavaScript: Theme Switcher -->
<script>
    const toggleBtn = document.getElementById('toggleTheme');
    toggleBtn.addEventListener('click', () => {
        document.body.classList.toggle('dark-mode');
        const icon = toggleBtn.querySelector('i');
        if (document.body.classList.contains('dark-mode')) {
            icon.className = 'bi bi-sun-fill';
            toggleBtn.innerHTML = '<i class="bi bi-sun-fill"></i> Light Mode';
        } else {
            icon.className = 'bi bi-moon-stars-fill';
            toggleBtn.innerHTML = '<i class="bi bi-moon-stars-fill"></i> Dark Mode';
        }
    });
</script>

</body>
</html>
