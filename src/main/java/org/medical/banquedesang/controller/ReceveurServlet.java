package org.medical.banquedesang.controller;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.time.LocalDate;

import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.enums.Disponibilite;
import org.medical.banquedesang.enums.GroupeSanguin;
import org.medical.banquedesang.dao.ReceveurDAO;
import org.medical.banquedesang.service.ReceveurService;

public class ReceveurServlet extends HttpServlet {
    private ReceveurService service;

    @Override
    public void init() throws ServletException {
        service = new ReceveurService(new ReceveurDAO());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            request.setAttribute("receveurs", service.findAll());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/index.jsp");
            dispatcher.forward(request, response);
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/receveur/addReceveur.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            Receveur receveur = new Receveur();
            receveur.setNom(request.getParameter("nom"));
            receveur.setPrenom(request.getParameter("prenom"));
            receveur.setCin(request.getParameter("cin"));
            receveur.setTelephone(request.getParameter("telephone"));
            receveur.setDateNaissance(LocalDate.parse(request.getParameter("dateNaissance")));
            receveur.setPoids(Double.parseDouble(request.getParameter("poids")));
            receveur.setSexe(request.getParameter("sexe"));
            receveur.setMaladie(request.getParameter("maladie"));
            receveur.setDisponibilite(Disponibilite.valueOf(request.getParameter("disponibilite")));
            receveur.setGroupesanguin(GroupeSanguin.valueOf(request.getParameter("groupesanguin")));
            service.createReceveur(receveur);
            response.sendRedirect(request.getContextPath() + "/operation/success.jsp");
        }catch(Exception e){
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/receveur/addReceveur.jsp").forward(request, response);
        }
    }
    
}
