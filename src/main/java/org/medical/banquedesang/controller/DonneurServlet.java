package org.medical.banquedesang.controller;

import java.io.IOException;
import java.time.LocalDate;

import org.medical.banquedesang.dao.DonneurDAO;
import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.enums.Disponibilite;
import org.medical.banquedesang.enums.GroupeSanguin;
import org.medical.banquedesang.service.DonneurService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DonneurServlet extends HttpServlet {

    private DonneurService service;
    

    @Override
    public void init() throws ServletException {
        service = new DonneurService( new DonneurDAO() );
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(null==action){
            request.setAttribute("groupesSanguins", GroupeSanguin.values());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/donneur/addDonneur.jsp");
            dispatcher.forward(request, response);
        } else
        switch (action) {
            case "edit":
                {
                    Long id  = Long.parseLong(request.getParameter("id"));
                    Donneur donneur = service.findDonneurById(id);
                    request.setAttribute("donneur", donneur);
                    request.setAttribute("groupesSanguins", GroupeSanguin.values());
                    request.getRequestDispatcher("/WEB-INF/jsp/donneur/addDonneur.jsp").forward(request, response);
                    break;
                }
            case "delete":
                {
                    Long id  = Long.parseLong(request.getParameter("id"));
                    Donneur  donneur = service.findDonneurById(id);
                    service.deleteDonneur(donneur);
                    response.sendRedirect(request.getContextPath() + "/");
                    break;
                }
            default:
                break;
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{

            String idParam = request.getParameter("id");
            Donneur donneur;

            if( idParam != null && !idParam.isEmpty() ){
                Long id = Long.parseLong(idParam);
                donneur = service.findDonneurById(id);
            }else {
                donneur = new Donneur();
            }

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
            if (idParam != null && !idParam.isEmpty()) {
                service.updateDonneur(donneur);
            } else {
                service.createDonneur(donneur);
            }
            response.sendRedirect(request.getContextPath() + "/operation/success.jsp");
        }catch(Exception e){
            request.setAttribute("groupesSanguins", GroupeSanguin.values());
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/donneur/addDonneur.jsp").forward(request, response);
        }
    }

}
