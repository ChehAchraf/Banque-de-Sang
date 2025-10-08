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
        
        if (action == null) {
            // Default action: show list of donneurs
            showDonneurList(request, response);
        } else {
            switch (action) {
                case "list":
                    showDonneurList(request, response);
                    break;
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "view":
                    showDonneurDetails(request, response);
                    break;
                case "delete":
                    deleteDonneur(request, response);
                    break;
                default:
                    showDonneurList(request, response);
                    break;
            }
        }
    }
    
    private void showDonneurList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setAttribute("donneurs", service.findAll());
            request.getRequestDispatcher("/WEB-INF/jsp/donneur/list.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors du chargement de la liste des donneurs: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/donneur/list.jsp").forward(request, response);
        }
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("groupesSanguins", GroupeSanguin.values());
        request.getRequestDispatcher("/WEB-INF/jsp/donneur/addDonneur.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Donneur donneur = service.findById(id);
            if (donneur != null) {
                request.setAttribute("donneur", donneur);
                request.setAttribute("groupesSanguins", GroupeSanguin.values());
                request.getRequestDispatcher("/WEB-INF/jsp/donneur/addDonneur.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Donneur introuvable.");
                showDonneurList(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de donneur invalide.");
            showDonneurList(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors du chargement du donneur: " + e.getMessage());
            showDonneurList(request, response);
        }
    }
    
    private void showDonneurDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Donneur donneur = service.findById(id);
            if (donneur != null) {
                request.setAttribute("donneur", donneur);
                request.getRequestDispatcher("/WEB-INF/jsp/donneur/details.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Donneur introuvable.");
                showDonneurList(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de donneur invalide.");
            showDonneurList(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors du chargement du donneur: " + e.getMessage());
            showDonneurList(request, response);
        }
    }
    
    private void deleteDonneur(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long id = Long.parseLong(request.getParameter("id"));
            Donneur donneur = service.findById(id);
            if (donneur != null) {
                service.delete(donneur);
                response.sendRedirect(request.getContextPath() + "/donneur?action=list");
            } else {
                request.setAttribute("error", "Donneur introuvable.");
                showDonneurList(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de donneur invalide.");
            showDonneurList(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la suppression du donneur: " + e.getMessage());
            showDonneurList(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            Donneur donneur;

            if (idParam != null && !idParam.trim().isEmpty()) {
                Long id = Long.parseLong(idParam);
                donneur = service.findById(id);
                if (donneur == null) {
                    throw new IllegalArgumentException("Donneur avec ID " + id + " introuvable");
                }
            } else {
                donneur = new Donneur();
            }

            // Set basic fields with validation
            donneur.setNom(request.getParameter("nom"));
            donneur.setPrenom(request.getParameter("prenom"));
            donneur.setCin(request.getParameter("cin"));
            donneur.setTelephone(request.getParameter("telephone"));
            donneur.setSexe(request.getParameter("sexe"));
            donneur.setMaladie(request.getParameter("maladie"));
            
            // Parse date with validation
            String dateParam = request.getParameter("dateNaissance");
            if (dateParam != null && !dateParam.trim().isEmpty()) {
                donneur.setDateNaissance(LocalDate.parse(dateParam));
            } else {
                throw new IllegalArgumentException("Date de naissance obligatoire");
            }
            
            // Parse poids with validation
            String poidsParam = request.getParameter("poids");
            if (poidsParam != null && !poidsParam.trim().isEmpty()) {
                donneur.setPoids(Double.parseDouble(poidsParam));
            } else {
                throw new IllegalArgumentException("Poids obligatoire");
            }
            
            // Parse enums with validation
            String groupeSanguinParam = request.getParameter("groupesanguin");
            if (groupeSanguinParam != null && !groupeSanguinParam.trim().isEmpty()) {
                donneur.setGroupesanguin(GroupeSanguin.valueOf(groupeSanguinParam.trim()));
            } else {
                throw new IllegalArgumentException("Groupe sanguin obligatoire");
            }
            
            String disponibiliteParam = request.getParameter("disponibilite");
            if (disponibiliteParam != null && !disponibiliteParam.trim().isEmpty()) {
                donneur.setDisponibilite(Disponibilite.valueOf(disponibiliteParam.trim()));
            } else {
                throw new IllegalArgumentException("Disponibilité obligatoire");
            }
            
            // Save or update
            if (idParam != null && !idParam.trim().isEmpty()) {
                service.update(donneur);
            } else {
                service.createDonneur(donneur);
            }
            
            response.sendRedirect(request.getContextPath() + "/donneur?action=list");
        } catch (Exception e) {
            // Preserve form data on error
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.trim().isEmpty()) {
                try {
                    Donneur donneur = service.findById(Long.parseLong(idParam));
                    request.setAttribute("donneur", donneur);
                } catch (Exception ignored) {
                    // If we can't load the donneur, that's okay, form will be empty
                }
            }
            
            request.setAttribute("groupesSanguins", GroupeSanguin.values());
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/jsp/donneur/addDonneur.jsp").forward(request, response);
        }
    }

}
