package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get parameters from the form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 2. Simple logic check
        if ("admin".equals(username) && "1234".equals(password)) {
            
            // SUCCESS: Create a Session
            HttpSession session = request.getSession();
            session.setAttribute("adminUser", username); // This "tags" the user as logged in
            
            // Redirect to dashboard
            response.sendRedirect("dashboard.jsp");

        } else {
            
            // FAILURE: Send an error message back to index.jsp
            request.setAttribute("errorMessage", "Invalid Username or Password. Please try again.");
            
            // Forward back to index.jsp (don't use sendRedirect here so the error message stays)
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}