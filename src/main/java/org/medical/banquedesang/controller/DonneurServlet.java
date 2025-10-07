package org.medical.banquedesang.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.medical.banquedesang.dao.DonneurDAO;
import org.medical.banquedesang.entities.Donneur;

import java.io.IOException;

public class DonneurServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        Donneur donneur = new Donneur();
        donneur.setNom(nom);
        donneur.setPrenom(prenom);
        new DonneurDAO().addDonneur(donneur);
        response.sendRedirect("success.jsp");
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/donneur/addDonneur.jsp");
        dispatcher.forward(request, response);
    }
}
