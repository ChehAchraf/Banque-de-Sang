package org.medical.banquedesang.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.medical.banquedesang.enums.GroupeSanguin;

import java.io.IOException;

public class DonneurFormServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setAttribute("groupesSanguins", GroupeSanguin.values());
        RequestDispatcher dispatcher = request.getRequestDispatcher("/donneur/addDonneur.jsp");
        dispatcher.forward(request, response);
    }
}