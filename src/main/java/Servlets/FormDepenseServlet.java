package Servlets;

import DataBase.DataBase;
import Models.Depense;
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
import java.util.Date;
import java.util.List;

public class FormDepenseServlet extends HttpServlet {
    private Connection connection;

    public FormDepenseServlet() {
        try {
            this.connection = DataBase.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Depense> listDepenses = new ArrayList<>();
        Connection conn = connection;
        try(
            PreparedStatement statement = conn.prepareStatement("SELECT * FROM depense");
            ResultSet resultSet = statement.executeQuery()) {
            
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                double montant = resultSet.getDouble("montant");
                String date = resultSet.getString("date");
                Depense depense = new Depense(id, montant, date);
                listDepenses.add(depense);
            }
            request.setAttribute("listDepenses", listDepenses);
            request.getRequestDispatcher("depense.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String montant = request.getParameter("montant");
        double montantDec = Double.parseDouble(montant);
        String date = request.getParameter("date");
        int id = Integer.parseInt(request.getParameter("credit"));
        CreditServlet creditServlet = new CreditServlet();
        try {
            creditServlet.updateCredit(id, montantDec);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        Connection conn = connection;
        try(
            PreparedStatement statement = conn.prepareStatement("INSERT INTO depenses (montant, date, id_credit) VALUES (?, ?, ?)")) {
            
            statement.setDouble(1, montantDec);
            statement.setString(2, date);
            statement.setInt(3, id);

            statement.executeUpdate();
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("depense.jsp").forward(request, response);
            throw new ServletException("Database error", e);
        }

        request.setAttribute("message", "Form submitted successfully");
        response.sendRedirect("list");
    }
}
