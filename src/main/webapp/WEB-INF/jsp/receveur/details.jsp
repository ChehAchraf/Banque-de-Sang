<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.medical.banquedesang.entities.Receveur" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Détails du receveur</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body class="bg-gray-50 text-gray-800">
<jsp:include page="../partials/navbar.jsp" />

<%
    Receveur r = (Receveur) request.getAttribute("receveur");
%>

<section class="py-12">
    <div class="max-w-4xl mx-auto px-4">
        <div class="bg-white rounded-2xl shadow-sm ring-1 ring-gray-200 overflow-hidden">
            <div class="p-6 md:p-8">
                <h1 class="text-2xl md:text-3xl font-extrabold text-red-700">Détails du receveur</h1>
                <p class="mt-2 text-gray-600">Informations du profil pour faciliter la prise de contact.</p>

                <div class="mt-8 grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <dt class="text-gray-500">Nom complet</dt>
                        <dd class="font-medium text-gray-900"><%= r != null ? (r.getPrenom() + " " + r.getNom()) : "-" %></dd>
                    </div>
                    <div>
                        <dt class="text-gray-500">CIN</dt>
                        <dd class="font-medium text-gray-900"><%= r != null ? r.getCin() : "-" %></dd>
                    </div>
                    <div>
                        <dt class="text-gray-500">Téléphone</dt>
                        <dd class="font-medium text-gray-900"><%= r != null ? r.getTelephone() : "-" %></dd>
                    </div>
                    <div>
                        <dt class="text-gray-500">Groupe sanguin</dt>
                        <dd class="font-medium text-gray-900"><%= (r != null && r.getGroupesanguin()!=null) ? r.getGroupesanguin().getLabel() : "-" %></dd>
                    </div>
                    <div>
                        <dt class="text-gray-500">Disponibilité</dt>
                        <dd class="font-medium text-gray-900"><%= r != null ? String.valueOf(r.getDisponibilite()) : "-" %></dd>
                    </div>
                    <div>
                        <dt class="text-gray-500">Poids</dt>
                        <dd class="font-medium text-gray-900"><%= r != null ? String.valueOf(r.getPoids()) : "-" %> kg</dd>
                    </div>
                    <div class="md:col-span-2">
                        <dt class="text-gray-500">Conditions médicales</dt>
                        <dd class="font-medium text-gray-900"><%= r != null ? r.getMaladie() : "-" %></dd>
                    </div>
                </div>

                <div class="mt-8 flex gap-3">
                    <a href="<%= request.getContextPath() %>/banque-sang" class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-semibold text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-400">Retour</a>
                    <a href="tel:<%= r != null ? r.getTelephone() : "" %>" class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-medium text-red-700 bg-red-50 hover:bg-red-100 ring-1 ring-inset ring-red-200 focus:outline-none focus:ring-2 focus:ring-red-300">Appeler</a>
                </div>
            </div>
        </div>
    </div>
</section>

</body>
</html>


