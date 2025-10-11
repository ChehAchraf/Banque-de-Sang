package org.medical.banquedesang;

import org.medical.banquedesang.dao.DonneurDAO;
import org.medical.banquedesang.dao.ReceveurDAO;
import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.service.DonneurService;
import org.medical.banquedesang.service.ReceveurService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class BanqueServlet extends HttpServlet {
    private ReceveurService receveurService;
    private DonneurService donneurService;

    @Override
    public void init() throws ServletException {
        receveurService = new ReceveurService(new ReceveurDAO());
        donneurService = new DonneurService(new DonneurDAO());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            // Fetch both donneurs and receveurs for the index page
            request.setAttribute("receveurs", receveurService.findAll());
            request.setAttribute("donneurs", donneurService.findAll());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/index.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if ("details".equals(action)) {
            String idString = request.getParameter("id");
            if (idString != null) {
                try {
                    Long id = Long.parseLong(idString);
                    Receveur receveur = receveurService.findById(id);
                    if (receveur != null) {
                        request.setAttribute("receveur", receveur);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/receveur/details.jsp");
                        dispatcher.forward(request, response);
                        return;
                    }
                } catch (NumberFormatException ignored) {
                }
            }
            // Fallback to list if id missing/invalid/not found
            request.setAttribute("receveurs", receveurService.findAll());
            request.setAttribute("donneurs", donneurService.findAll());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/index.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Unknown action → list
        request.setAttribute("receveurs", receveurService.findAll());
        request.setAttribute("donneurs", donneurService.findAll());
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/index.jsp");
        dispatcher.forward(request, response);
    }

}