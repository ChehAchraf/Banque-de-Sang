package org.medical.banquedesang.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.medical.banquedesang.dao.DonneurDAO;
import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.enums.Disponibilite;
import org.medical.banquedesang.enums.GroupeSanguin;
import org.medical.banquedesang.service.DonneurService;
import org.medical.banquedesang.util.JPAUtil;

import java.io.IOException;
import java.time.LocalDate;

public class DonneurServlet extends HttpServlet {

    private DonneurService service;
    

    @Override
    public void init() throws ServletException {
        service = new DonneurService( new DonneurDAO() );
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            Donneur donneur = new Donneur();
            donneur.setNom(request.getParameter("nom"));
            donneur.setPrenom(request.getParameter("prenom"));
            donneur.setCin(request.getParameter("cin"));
            donneur.setTelephone(request.getParameter("telephone"));
            donneur.setDateNaissance(LocalDate.parse(request.getParameter("dateNaissance")));
            donneur.setPoids(Double.parseDouble(request.getParameter("poids")));
            donneur.setSexe(request.getParameter("sexe"));
            donneur.setGroupesanguin(GroupeSanguin.valueOf(request.getParameter("groupesanguin")));
            donneur.setDisponibilite(Disponibilite.valueOf(request.getParameter("disponibilite")));
            donneur.setMaladie(request.getParameter("maladie"));
            service.createDonneur(donneur);
            response.sendRedirect(request.getContextPath() + "/operation/success.jsp");
        }catch(Exception e){
            request.setAttribute("groupesSanguins", GroupeSanguin.values());
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/donneur/addDonneur.jsp").forward(request, response);
        }
    }

}
