package org.medical.banquedesang;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class BanqueServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.getWriter().println("<h1>Bienvenue à la Banque de Sang 🩸</h1>");
    }
}