package com.induwara.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(
                "jdbc:mysql://127.0.0.1:3306/Pahana_Edu?useSSL=false", 
                "root", 
                "g8VzsFBBl$m@Kx+");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
