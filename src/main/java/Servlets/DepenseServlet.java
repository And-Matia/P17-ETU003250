package Servlets;

import DataBase.DataBase;
import Models.Credit;
import Models.Depense;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DepenseServlet {

    private Connection connection;

    public DepenseServlet() {
        try {
            this.connection = DataBase.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Depense> getAllDepense(int id) {
        List<Depense> depenses = new ArrayList<>();
        Connection conn = connection;
        try (
                PreparedStatement statement = conn.prepareStatement("SELECT * FROM depenses WHERE id_credit = ?");
        ) {

                statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    double montant = resultSet.getDouble("montant");
                    String date = resultSet.getString("date");
                    int id_d = resultSet.getInt("id");
                    depenses.add(new Depense(id_d, montant, date));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Database error: " + e.getMessage(), e);
        }
        return depenses;
    }
}
