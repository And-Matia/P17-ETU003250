package DataBase;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataBase {
    private static Connection conn;

    public static Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/db_s2_ETU003250";
        String user = "ETU003250";
        String password = "7Hyb7tZL";

        try {
            if (conn == null) {
                conn = DriverManager.getConnection(url, user, password);
            }
            return conn;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}