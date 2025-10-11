package org.medical.banquedesang.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.medical.banquedesang.dao.DonationDAO;
import org.medical.banquedesang.dao.DonneurDAO;
import org.medical.banquedesang.dao.ReceveurDAO;
import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.enums.EtatReceveur;
import org.medical.banquedesang.service.DonationService;
import org.medical.banquedesang.service.ReceveurService;

import java.io.IOException;
import java.util.List;

public class DonationServlet extends HttpServlet {
    private DonationService donationService;
    private ReceveurService receveurService;

    @Override
    public void init() throws ServletException {
        DonationDAO donationDAO = new DonationDAO();
        DonneurDAO donneurDAO = new DonneurDAO();
        ReceveurDAO receveurDAO = new ReceveurDAO();
        this.donationService = new DonationService(donationDAO, donneurDAO, receveurDAO);
        this.receveurService = new ReceveurService(receveurDAO);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.equals("form")) {
            showForm(request, response);
            return;
        }
        response.sendRedirect(request.getContextPath() + "/");
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String receveurIdParam = request.getParameter("receveurId");
        String donneurIdParam = request.getParameter("donneurId");

        // Always provide receivers to choose from (waiting only, sorted by priority)
        request.setAttribute("receveurs", receveurService.getWaitingReceveurs());

        // Receiver-first flow: if a receiver is selected, show compatible donors
        if (receveurIdParam != null && !receveurIdParam.isEmpty()) {
            try {
                Long receveurId = Long.parseLong(receveurIdParam);
                Receveur receveur = receveurService.findById(receveurId);
                request.setAttribute("receveur", receveur);
                List<Donneur> donneursCompatibles = donationService.getCompatibleAvailableDonneursForReceveur(receveurId);
                request.setAttribute("donneurs", donneursCompatibles);
            } catch (NumberFormatException ignored) { }
        }

        // Donor-first : if a donor is provided, list compatible receivers for that donor
        if (donneurIdParam != null && !donneurIdParam.isEmpty()) {
            try {
                Long donneurId = Long.parseLong(donneurIdParam);
                request.setAttribute("donneurId", donneurId);
                request.setAttribute("receveurs", donationService.getCompatibleReceveursForDonneur(donneurId));
            } catch (NumberFormatException ignored) { }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/donation/form.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String receveurIdParam = request.getParameter("receveurId");
        String donneurIdParam = request.getParameter("donneurId");
        try {
            Long receveurId = Long.parseLong(receveurIdParam);
            Long donneurId = Long.parseLong(donneurIdParam);

            donationService.registerDonation(donneurId, receveurId);

            response.sendRedirect(request.getContextPath() + "/receveur");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            // Re-show form with compatible donors for the same receiver if present
            if (receveurIdParam != null) {
                try {
                    Long rid = Long.parseLong(receveurIdParam);
                    request.setAttribute("receveur", receveurService.findById(rid));
                    request.setAttribute("donneurs", donationService.getCompatibleAvailableDonneursForReceveur(rid));
                } catch (NumberFormatException ignored) {}
            }
            request.getRequestDispatcher("/WEB-INF/jsp/donation/form.jsp").forward(request, response);
        }
    }
}