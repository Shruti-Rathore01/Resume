<%@ page import="java.sql.*" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String url = "jdbc:mysql://localhost:3306/resume_db";
    String dbUser = "root";
    String dbPassword = "ConfirmMysql@12";
    Connection conn = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM resumes WHERE user_id = ?");
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
%>
<h1>Resume</h1>
<p>Name: <%= rs.getString("name") %></p>
<p>Email: <%= rs.getString("email") %></p>
<p>Phone: <%= rs.getString("phone") %></p>
<p>Skills: <%= rs.getString("skills") %></p>
<a href="logout.jsp">Logout</a>
<%
        } else {
            out.println("No resume found.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (conn != null) conn.close();
    }
%>
