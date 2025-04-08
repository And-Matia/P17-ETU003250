package Servlets;

import DataBase.DataBase;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class LoginServlet extends HttpServlet {

    private Connection connection;

    public LoginServlet() {
        try {
            this.connection = DataBase.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String logemail = request.getParameter("logemail");
        String logpassword = request.getParameter("logpassword");

        // Ajouter un log pour déboguer
        System.out.println("Login attempt - Email: " + logemail);

        if (logemail != null && !logemail.isEmpty() && logpassword != null && !logpassword.isEmpty()) {
            Connection conn = connection;
            try (
                 PreparedStatement statement = conn.prepareStatement("SELECT * FROM users WHERE email = ? AND password = ?");
                 ) {
                
                statement.setString(1, logemail);
                statement.setString(2, logpassword);
                
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        // Authentification réussie - créer une session
                        HttpSession session = request.getSession();
                        session.setAttribute("user_id", resultSet.getInt("id"));
                        session.setAttribute("user_email", logemail);
                        request.getRequestDispatcher("credit.jsp").forward(request, response);
                        return;
                    } else {
                        System.out.println("Login failed: Invalid credentials");
                        request.setAttribute("errorMessage", "Invalid email or password.");
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                }
            } catch (SQLException e) {
                System.out.println("Database error: " + e.getMessage());
                request.setAttribute("errorMessage", "Database error: " + e.getMessage());
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } else {
            System.out.println("Login failed: Empty fields");
            request.setAttribute("errorMessage", "Email and password are required.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Rediriger vers la page de connexion
        response.sendRedirect("index.jsp");
    }
}
