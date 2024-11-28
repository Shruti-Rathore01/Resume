<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    String url = "jdbc:mysql://localhost:3306/resume_db";
    String dbUser = "root";
    String dbPassword = "ConfirmMysql@12";
    Connection conn = null;
    boolean isValid = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);
        PreparedStatement ps = conn.prepareStatement("SELECT id FROM users WHERE username = ? AND password = ?");
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            session.setAttribute("userId", rs.getInt("id"));
            response.sendRedirect("resume.jsp");
            isValid = true;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (!isValid) {
            out.println("Invalid login. <a href='index.jsp'>Try again</a>");
        }
        if (conn != null) conn.close();
    }
%>
