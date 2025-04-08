package Servlets;

import DataBase.DataBase;
import Models.Credit;
import Models.Depense;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public class dashboardServlet extends HttpServlet {
    private Connection con;

    public dashboardServlet() {
        try {
            this.con = DataBase.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HashMap<Credit, List<Depense>> results = new HashMap<>();
        CreditServlet creditServlet = new CreditServlet();
        DepenseServlet depenseServlet = new DepenseServlet();
        for(Credit credit : creditServlet.getAllCredits()){
            results.put(credit, depenseServlet.getAllDepense(credit.id));
        }
        request.setAttribute("results", results);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
