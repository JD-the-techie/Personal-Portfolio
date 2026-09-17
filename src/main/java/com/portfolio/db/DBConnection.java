package com.portfolio.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/portfolio_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASSWORD = "your_password";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found!", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        String url = System.getenv("DB_URL") != null ? System.getenv("DB_URL") : DEFAULT_URL;
        String user = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : DEFAULT_USER;
        String pass = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : DEFAULT_PASSWORD;
        return DriverManager.getConnection(url, user, pass);
    }
}
