CREATE DATABASE login_system;
USE login_system;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL
);
INSERT INTO users (username, password) VALUES
('user1', 'password1'),
('user2', 'password2');
import java.sql.*;

public class DatabaseConnector {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/login_system";
        String username = "your_username";
        String password = "your_password";

        try (Connection connection = DriverManager.getConnection(url, username, password)) {
            System.out.println("Connected to the database.");

            // Authenticate user
            String inputUsername = "user1";
            String inputPassword = "password1";
            boolean isAuthenticated = authenticateUser(connection, inputUsername, inputPassword);

            if (isAuthenticated) {
                System.out.println("Login successful!");
            } else {
                System.out.println("Invalid username or password.");
            }
        } catch (SQLException e) {
            System.err.println("Error connecting to the database: " + e.getMessage());
        }
    }

    public static boolean authenticateUser(Connection connection, String username, String password) throws SQLException {
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, username);
            statement.setString(2, password);
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next(); // True if a row is found, indicating successful authentication
            }
        }
    }
}
