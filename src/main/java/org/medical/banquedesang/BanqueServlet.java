package org.medical.banquedesang;

import org.medical.banquedesang.dao.ReceveurDAO;
import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.service.ReceveurService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class BanqueServlet extends HttpServlet {
    private ReceveurService service;

    @Override
    public void init() throws ServletException {
        service = new ReceveurService(new ReceveurDAO());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            request.setAttribute("receveurs", service.findAll());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if ("details".equals(action)) {
            String idString = request.getParameter("id");
            if (idString != null) {
                try {
                    Long id = Long.parseLong(idString);
                    Receveur receveur = service.findById(id);
                    if (receveur != null) {
                        request.setAttribute("receveur", receveur);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/receveur/details.jsp");
                        dispatcher.forward(request, response);
                        return;
                    }
                } catch (NumberFormatException ignored) {
                }
            }
            // Fallback to list if id missing/invalid/not found
            request.setAttribute("receveurs", service.findAll());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Unknown action → list
        request.setAttribute("receveurs", service.findAll());
        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);
    }

}