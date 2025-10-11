package org.medical.banquedesang.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.medical.banquedesang.dao.ReceveurDAO;
import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.service.ReceveurService;

public class ReceveurDetailsServlet extends HttpServlet {
    private ReceveurService service;

    @Override
    public void init() throws ServletException {
        service = new ReceveurService(new ReceveurDAO());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idString = request.getParameter("id");
        if (idString != null) {
            try {
                Long id = Long.parseLong(idString);
                Receveur receveur = service.findById(id);
                if (receveur != null) {
                    request.setAttribute("receveur", receveur);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/receveur/details.jsp");
                    dispatcher.forward(request, response);
                    return;
                }
            } catch (NumberFormatException ignored) { }
        }
        
        response.sendRedirect(request.getContextPath() + "/");
    }
}


