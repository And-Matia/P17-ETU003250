package Servlets;

import DataBase.DataBase;
import Models.Credit;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class CreditServlet extends HttpServlet {

    private Connection connection;

    public CreditServlet() {
        try {
            this.connection = DataBase.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle GET requests
        // Typically forward to a JSP page to display information
        request.getRequestDispatcher("/WEB-INF/views/credit.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Handle POST requests
        // Process form submission for credit operations
        
        // Example: Get parameters from the request
        String amount = request.getParameter("amount");
        String duration = request.getParameter("duration");
        
        // Process the credit request
        // Add your business logic here
        
        // Redirect or forward to appropriate view
        response.sendRedirect(request.getContextPath() + "/creditResult");
    }

    public void updateCredit(int id, double montant) throws Exception {
        Credit credit = getCreditById(id);
        montant = credit.montant - montant;
        if(montant < 0) {
            throw new Exception("Insufficient credit amount");
        }
        Connection conn = connection;

        try(
            PreparedStatement ps = conn.prepareStatement("update credits set montant=? where id=?")) {
            
            ps.setDouble(1, montant);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Credit getCreditById(int id) {
        Connection conn = connection;
        try (
             PreparedStatement statement = conn.prepareStatement("SELECT * FROM credits WHERE id = ?");
            ) {
            
            statement.setInt(1, id);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String name = resultSet.getString("name");
                    double montant = resultSet.getDouble("montant");
                    String date = resultSet.getString("date");
                    return new Credit(id, name, montant, date);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error: " + e.getMessage(), e);
        }
        return null;
    }


    public List<Credit> getAllCredits() {
        List<Credit> credits = new ArrayList<>();
        Connection conn = connection;
        try (
                PreparedStatement statement = conn.prepareStatement("SELECT * FROM credits");
        ) {


            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    String name = resultSet.getString("name");
                    double montant = resultSet.getDouble("montant");
                    String date = resultSet.getString("date");
                    int id = resultSet.getInt("id");
                    credits.add(new Credit(id, name, montant, date));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error: " + e.getMessage(), e);
        }
        return credits;
    }
}
