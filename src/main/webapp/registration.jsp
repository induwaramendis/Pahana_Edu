<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign Up Form</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Main CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <!-- Hidden field to capture status -->
    <input type="hidden" id="status" value="<%= request.getAttribute("status") != null ? request.getAttribute("status") : "" %>">

    <div class="main">
        <!-- Sign up form -->
        <section class="signup">
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">
                        <h2 class="form-title">Sign up</h2>

                        <form method="post" action="RegistrationServlet" class="register-form" id="register-form">

                            <!-- Name field -->
                            <div class="form-group">
                                <label for="name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                <input type="text" name="name" id="name" placeholder="Your Name" required
                                       value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>" />
                                <% if (request.getAttribute("nameError") != null) { %>
                                    <span style="color:red; font-size: 12px;"><%= request.getAttribute("nameError") %></span>
                                <% } %>
                            </div>

                            <!-- Email field -->
                            <div class="form-group">
                                <label for="email"><i class="zmdi zmdi-email"></i></label>
                                <input type="email" name="email" id="email" placeholder="Your Email" required
                                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" />
                                <% if (request.getAttribute("emailError") != null) { %>
                                    <span style="color:red; font-size: 12px;"><%= request.getAttribute("emailError") %></span>
                                <% } %>
                            </div>

                            <!-- Password field -->
                            <div class="form-group">
                                <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                                <input type="password" name="pass" id="pass" placeholder="Password" required />
                                <% if (request.getAttribute("passwordError") != null) { %>
                                    <span style="color:red; font-size: 12px;"><%= request.getAttribute("passwordError") %></span>
                                <% } %>
                            </div>

                            <!-- Submit -->
                            <div class="form-group form-button">
                                <input type="submit" name="signup" id="signup" class="form-submit" value="Register" />
                            </div>
                        </form>
                    </div>
                    <div class="signup-image">
                        <figure><img src="images/signup-image.jpg" alt="sign up image"></figure>
                        <a href="login.jsp" class="signup-image-link">I am already a member</a>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- JS -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/main.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <!-- Client-side validation -->
    <script>
        document.getElementById("register-form").addEventListener("submit", function(e) {
            let name = document.getElementById("name").value.trim();
            let email = document.getElementById("email").value.trim();
            let pass = document.getElementById("pass").value;

            if (name.length < 3) {
                e.preventDefault();
                swal("Warning", "Name must be at least 3 characters long.", "warning");
                return false;
            }

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                swal("Warning", "Please enter a valid email address.", "warning");
                return false;
            }

            if (pass.length < 6) {
                e.preventDefault();
                swal("Warning", "Password must be at least 6 characters long.", "warning");
                return false;
            }
        });
    </script>

    <!-- SweetAlert trigger based on server-side status -->
    <script type="text/javascript">
        var status = document.getElementById("status").value;
        if (status === "success") {
            swal("Congrats", "Account Created Successfully!", "success");
        } else if (status === "failed") {
            swal("Oops", "Something went wrong. Please try again.", "error");
        }
    </script>

</body>
</html>
