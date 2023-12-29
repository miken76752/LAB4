<%@page import="java.util.*"%>
<%@page import="sumdu.edu.ua.webstudent.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <style>
        h1 {
            text-align: center;
        }
        #page {
            width: 800px;
            margin: auto;
        }
        form {
            width: 400px;
            margin: 20px auto;
        }
        input[type=submit] {
            margin: auto;
        }
        .list, .list td, .list th {
            margin: auto;
            border: 1px solid black;
            border-collapse: collapse;
        }
    </style>
</head>

<body>
<div id="page">
    <h1>Student Form</h1>
    <form method="post" action="studentAdd">
        <table>
            <tbody>
            <tr>
                <td><label for="name">Name:</label></td>
                <td><input id="name" type="text" name="name"></td>
            </tr>
            <tr>
                <td><label for="surname">Surname:</label></td>
                <td><input id="surname" type="text" name="surname"></td>
            </tr>
            <tr>
                <td><label for="email">Email:</label></td>
                <td><input id="email" type="email" name="email"></td>
            </tr>
            <tr>
                <td><label for="group">Group:</label></td>
                <td><input id="group" type="text" name="group"></td>
            </tr>
            <tr>
                <td><label for="faculty">Faculty:</label></td>
                <td><input id="faculty" type="text" name="faculty"></td>
            </tr>
            </tbody>
        </table>
        <input type="submit" name="send" value="Send">
    </form>

    <table class="list">
        <tr>
            <th>Name</th>
            <th>Surname</th>
            <th>Email</th>
            <th>Group</th>
            <th>Faculty</th>
        </tr>
        <%
            try {
                Class.forName("org.postgresql.Driver");
                String url = "jdbc:postgresql://localhost:5432/studentsdb";
                String username = "postgres";
                String password = "postgres";
                Connection connection = DriverManager.getConnection(url, username, password);

                String sql = "SELECT * FROM students";
                try (Statement statement = connection.createStatement();
                     ResultSet resultSet = statement.executeQuery(sql)) {

                    while (resultSet.next()) {
                        String name = resultSet.getString("name");
                        String surname = resultSet.getString("surname");
                        String email = resultSet.getString("email");
                        String group = resultSet.getString("group_name");
                        String faculty = resultSet.getString("faculty");

        %>
        <tr>
            <td><c:out value="<%= name %>"/></td>
            <td><c:out value="<%= surname %>"/></td>
            <td><c:out value="<%= email %>"/></td>
            <td><c:out value="<%= group %>"/></td>
            <td><c:out value="<%= faculty %>"/></td>
        </tr>
        <%
                    }
                }

                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</div>
</body>
</html>