package com.example.moviemanagement;

import java.sql.Connection;
import java.sql.DriverManager;

public class TestDatabaseConnection {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/cinema";
        String user = "root";
        String password = "123";

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            System.out.println("✅ Kết nối thành công với MySQL!");
        } catch (Exception e) {
            System.out.println("❌ Lỗi kết nối: " + e.getMessage());
        }
    }
}
