<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Prepa Exam</title>
    <link rel="stylesheet" href="css/auth-style.css">

</head>
<body>
    <div class="container">
        <div class="row full-height justify-content-center">
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                <div class="card auth-card">
                    <div class="card-header text-center">
                        <h2 class="mb-0">Welcome Back</h2>
                        <p class="text-muted">Sign in to continue</p>
                    </div>
                    <div class="card-body">
                        <!-- Affichage des messages d'erreur -->
                        <% if(request.getAttribute("errorMessage") != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= request.getAttribute("errorMessage") %>
                            </div>
                        <% } %>
                        
                        <form method="post" action="login">
                            <div class="form-group mb-3">
                                <label for="email" class="form-label">Email</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                    <input type="email" class="form-control" id="email" name="logemail" value="admin@gmail.com" placeholder="Enter your email" required>
                                </div>
                                <div class="invalid-feedback">Please enter a valid email address.</div>
                            </div>
                            
                            <div class="form-group mb-3">
                                <label for="password" class="form-label">Password</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    <input type="password" class="form-control" id="password"  value="admin" name="logpassword" placeholder="Enter your password" required>
                                    <span class="input-group-text password-toggle"><i class="far fa-eye"></i></span>
                                </div>
                                <div class="invalid-feedback">Password is required.</div>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="remember">
                                    <label class="form-check-label" for="remember">Remember me</label>
                                </div>
                                <a href="#" class="forgot-link">Forgot password?</a>
                            </div>
                            
                            <div class="d-grid gap-2 mb-3">
                                <button type="submit" class="btn btn-primary btn-lg">Sign In</button>
                            </div>
                        </form>
                        
                        <div class="divider d-flex align-items-center my-4">
                            <p class="text-center fw-bold mx-3 mb-0">OR</p>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button class="btn btn-outline-primary social-btn">
                                <i class="fab fa-google me-2"></i> Continue with Google
                            </button>
                            <button class="btn btn-outline-primary social-btn">
                                <i class="fab fa-facebook-f me-2"></i> Continue with Facebook
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</body>
</html>
