<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des receveurs</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">
    <jsp:include page="../partials/navbar.jsp" />

    <!-- Header Section -->
    <header class="bg-gradient-to-br from-red-600 via-red-700 to-red-800">
        <div class="max-w-6xl mx-auto px-4 py-12 md:py-16">
            <div class="text-center text-red-50">
                <h1 class="text-3xl md:text-4xl font-extrabold mb-4">Gestion des Receveurs</h1>
                <p class="text-red-100/90 text-lg">Gérez les informations des receveurs en attente de transfusion</p>
                <div class="mt-6">
                    <a href="${pageContext.request.contextPath}/receveur?action=add" class="inline-flex items-center justify-center rounded-lg px-6 py-3 text-sm font-semibold text-red-700 bg-white hover:bg-red-50 focus:outline-none focus:ring-2 focus:ring-white">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                        </svg>
                        Ajouter un receveur
                    </a>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="max-w-6xl mx-auto px-4 py-8">
        <div class="bg-white rounded-xl shadow-sm ring-1 ring-gray-200 overflow-hidden">
            <!-- Table Header -->
            <div class="bg-gray-50 px-6 py-4 border-b border-gray-200">
                <h2 class="text-lg font-semibold text-gray-900">Liste des Receveurs</h2>
                <p class="text-sm text-gray-600 mt-1">${receveurs.size()} receveur(s) enregistré(s)</p>
            </div>

            <!-- Table Content -->
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nom & Prénom</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Contact</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Groupe Sanguin</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Urgence</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">État</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach items="${receveurs}" var="receveur">
                            <tr class="hover:bg-gray-50">
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex items-center">
                                        <div class="flex-shrink-0 h-10 w-10">
                                            <div class="h-10 w-10 rounded-full bg-red-100 flex items-center justify-center">
                                                <span class="text-sm font-medium text-red-600">
                                                    ${receveur.nom.charAt(0)}${receveur.prenom.charAt(0)}
                                                </span>
                                            </div>
                                        </div>
                                        <div class="ml-4">
                                            <div class="text-sm font-medium text-gray-900">${receveur.nom} ${receveur.prenom}</div>
                                            <div class="text-sm text-gray-500">CIN: ${receveur.cin}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">
                                        <a href="tel:${receveur.telephone}" class="text-red-600 hover:text-red-800">${receveur.telephone}</a>
                                    </div>
                                    <div class="text-sm text-gray-500">${receveur.dateNaissance}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                                        ${receveur.groupesanguin.label}
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:if test="${receveur.urgence != null}">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${
                                            receveur.urgence.name() == 'CRITIQUE' ? 'bg-red-100 text-red-800' :
                                            receveur.urgence.name() == 'URGENT' ? 'bg-orange-100 text-orange-800' :
                                            'bg-blue-100 text-blue-800'
                                        }">
                                            <c:choose>
                                                <c:when test="${receveur.urgence.name() == 'CRITIQUE'}">Critique (${receveur.urgence.pochesRequises} poches)</c:when>
                                                <c:when test="${receveur.urgence.name() == 'URGENT'}">Urgent (${receveur.urgence.pochesRequises} poches)</c:when>
                                                <c:otherwise>Normal (${receveur.urgence.pochesRequises} poche)</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </c:if>
                                    <c:if test="${receveur.urgence == null}">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">Non spécifié</span>
                                    </c:if>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:if test="${receveur.etatReceveur != null}">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${
                                            receveur.etatReceveur.name() == 'SATISFAIT' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'
                                        }">
                                            ${receveur.etatReceveur.label} (${receveur.nombreDonneursAssocies}/${receveur.pochesRequises})
                                        </span>
                                    </c:if>
                                    <c:if test="${receveur.etatReceveur == null}">
                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">En attente</span>
                                    </c:if>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <div class="flex items-center space-x-3">
                                        <a href="${pageContext.request.contextPath}/receveur/details?id=${receveur.id}" class="text-blue-600 hover:text-blue-800">Voir</a>
                                        <a href="${pageContext.request.contextPath}/receveur?action=edit&id=${receveur.id}" class="text-green-600 hover:text-green-800">Modifier</a>
                                        <c:if test="${receveur.etatReceveur.name() != 'SATISFAIT'}">
                                            <a href="${pageContext.request.contextPath}/donation?action=form&receveurId=${receveur.id}" class="text-amber-600 hover:text-amber-800">Associer donneur</a>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/receveur?action=delete&id=${receveur.id}" 
                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce receveur ?')" 
                                           class="text-red-600 hover:text-red-800">Supprimer</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty receveurs}">
                            <tr>
                                <td colspan="6" class="px-6 py-12 text-center">
                                    <div class="text-gray-500">
                                        <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
                                        </svg>
                                        <h3 class="mt-2 text-sm font-medium text-gray-900">Aucun receveur</h3>
                                        <p class="mt-1 text-sm text-gray-500">Commencez par ajouter un receveur.</p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-gray-100 mt-12">
        <div class="max-w-6xl mx-auto px-4 py-8">
            <div class="text-center text-gray-600">
                <p class="text-sm">Banque de Sang - Système de gestion des receveurs</p>
            </div>
        </div>
    </footer>
</body>
</html>

