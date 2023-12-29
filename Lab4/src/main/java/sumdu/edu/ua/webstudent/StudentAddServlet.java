package sumdu.edu.ua.webstudent;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StudentAddServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String surname = request.getParameter("surname");
            String email = request.getParameter("email");
            String group = request.getParameter("group");
            String faculty = request.getParameter("faculty");

            Class.forName("org.postgresql.Driver");
            String url = "jdbc:postgresql://postgres.DevAndQA.online:5432/student_in12_09";
            String username = "student_in12_09";
            String password = "student";
            Connection connection = DriverManager.getConnection(url, username, password);

            String sql = "INSERT INTO students (name, surname, email, group_name, faculty) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, name);
                statement.setString(2, surname);
                statement.setString(3, email);
                statement.setString(4, group);
                statement.setString(5, faculty);

                statement.executeUpdate();
            }

            connection.close();

            response.sendRedirect("student.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}