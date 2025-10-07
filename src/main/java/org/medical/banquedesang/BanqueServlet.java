package org.medical.banquedesang;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class BanqueServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
            dispatcher.forward(request, response);
    }

}