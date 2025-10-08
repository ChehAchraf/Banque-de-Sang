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
        
        if (action == null) {
            // Show list of receveurs
            request.setAttribute("receveurs", service.findAll());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/receveur/list.jsp");
            dispatcher.forward(request, response);
        } else {
            switch (action) {
                case "add":
                    // Show add form
                    RequestDispatcher addDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/receveur/addReceveur.jsp");
                    addDispatcher.forward(request, response);
                    break;
                case "edit":
                    // Show edit form with receveur data
                    String idParam = request.getParameter("id");
                    if (idParam != null && !idParam.isEmpty()) {
                        try {
                            Long id = Long.parseLong(idParam);
                            Receveur receveur = service.findById(id);
                            if (receveur != null) {
                                request.setAttribute("receveur", receveur);
                                RequestDispatcher editDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/receveur/addReceveur.jsp");
                                editDispatcher.forward(request, response);
                            } else {
                                response.sendRedirect(request.getContextPath() + "/receveur");
                            }
                        } catch (NumberFormatException e) {
                            response.sendRedirect(request.getContextPath() + "/receveur");
                        }
                    } else {
                        response.sendRedirect(request.getContextPath() + "/receveur");
                    }
                    break;
                case "delete":
                    // Handle delete
                    String deleteIdParam = request.getParameter("id");
                    if (deleteIdParam != null && !deleteIdParam.isEmpty()) {
                        try {
                            Long id = Long.parseLong(deleteIdParam);
                            Receveur receveur = service.findById(id);
                            if (receveur != null) {
                                service.delete(receveur);
                            }
                        } catch (NumberFormatException e) {
                            // Invalid ID, ignore
                        }
                    }
                    response.sendRedirect(request.getContextPath() + "/receveur");
                    break;
                default:
                    // Unknown action, show list
                    request.setAttribute("receveurs", service.findAll());
                    RequestDispatcher defaultDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/receveur/list.jsp");
                    defaultDispatcher.forward(request, response);
                    break;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            String idParam = request.getParameter("id");
            Receveur receveur;
            
            // Check if this is an update operation
            if (idParam != null && !idParam.isEmpty()) {
                Long id = Long.parseLong(idParam);
                receveur = service.findById(id);
                if (receveur == null) {
                    response.sendRedirect(request.getContextPath() + "/receveur");
                    return;
                }
            } else {
                receveur = new Receveur();
            }
            
            // Set receveur properties
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
            
            // Save or update
            if (idParam != null && !idParam.isEmpty()) {
                service.update(receveur);
            } else {
                service.createReceveur(receveur);
            }
            
            response.sendRedirect(request.getContextPath() + "/receveur");
        }catch(Exception e){
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/receveur/addReceveur.jsp").forward(request, response);
        }
    }
    
}
