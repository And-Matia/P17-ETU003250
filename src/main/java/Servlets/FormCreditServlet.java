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
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class FormCreditServlet extends HttpServlet {

    private Connection connection;

    public FormCreditServlet() {
        try {
            this.connection = DataBase.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Credit> listCredits = new ArrayList<>();

        Connection conn = connection;
        try(
            PreparedStatement statement = conn.prepareStatement("SELECT * FROM credits");
            ResultSet resultSet = statement.executeQuery()) {
            
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                double montant = resultSet.getDouble("montant");
                String date = resultSet.getString("date");
                Credit credit = new Credit(id, name, montant, date);
                listCredits.add(credit);
            }
            request.setAttribute("listCredits", listCredits);
            // Fix the infinite loop by forwarding to a JSP instead of "depense" servlet
            request.getRequestDispatcher("depense.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String montant = request.getParameter("montant");
        double montantDec = Double.parseDouble(montant);
        String date = request.getParameter("date");
        Connection conn = connection;
        try(
            PreparedStatement statement = conn.prepareStatement("INSERT INTO credits (name, montant, date) VALUES ( ?, ?, ?)")) {
            
            statement.setString(1, name);
            statement.setDouble(2, montantDec);
            statement.setString(3, date);
            statement.executeUpdate();

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("credit.jsp").forward(request, response);
            throw new ServletException("Database error", e);
        }

        request.setAttribute("message", "Form submitted successfully");
        response.sendRedirect("list");
    }
}
