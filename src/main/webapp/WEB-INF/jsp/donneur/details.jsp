<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Détails du donneur - ${donneur.nom} ${donneur.prenom}</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">
    <jsp:include page="../partials/navbar.jsp" />

    <!-- Header Section -->
    <header class="bg-gradient-to-br from-blue-600 via-blue-700 to-blue-800">
        <div class="max-w-6xl mx-auto px-4 py-12 md:py-16">
            <div class="text-center text-blue-50">
                <div class="flex items-center justify-center mb-4">
                    <div class="h-20 w-20 rounded-full bg-blue-100 flex items-center justify-center">
                        <span class="text-2xl font-bold text-blue-600">
                            ${donneur.nom.charAt(0)}${donneur.prenom.charAt(0)}
                        </span>
                    </div>
                </div>
                <h1 class="text-3xl md:text-4xl font-extrabold mb-2">${donneur.nom} ${donneur.prenom}</h1>
                <p class="text-blue-100/90 text-lg">Informations détaillées du donneur</p>
                <div class="mt-6 flex justify-center space-x-4">
                    <a href="${pageContext.request.contextPath}/donneur?action=edit&id=${donneur.id}" 
                       class="inline-flex items-center justify-center rounded-lg px-6 py-3 text-sm font-semibold text-blue-700 bg-white hover:bg-blue-50 focus:outline-none focus:ring-2 focus:ring-white">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                        </svg>
                        Modifier
                    </a>
                    <a href="${pageContext.request.contextPath}/donneur?action=list" 
                       class="inline-flex items-center justify-center rounded-lg px-6 py-3 text-sm font-semibold text-white border border-white/30 hover:bg-white/10 focus:outline-none focus:ring-2 focus:ring-white">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                        </svg>
                        Retour à la liste
                    </a>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="max-w-4xl mx-auto px-4 py-8">
        <div class="bg-white rounded-xl shadow-sm ring-1 ring-gray-200 overflow-hidden">
            <!-- Personal Information Section -->
            <div class="bg-gray-50 px-6 py-4 border-b border-gray-200">
                <h2 class="text-lg font-semibold text-gray-900 flex items-center">
                    <svg class="w-6 h-6 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                    </svg>
                    Informations personnelles
                </h2>
            </div>
            <div class="px-6 py-6">
                <dl class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <dt class="text-sm font-medium text-gray-500">Nom complet</dt>
                        <dd class="mt-1 text-sm font-semibold text-gray-900">${donneur.nom} ${donneur.prenom}</dd>
                    </div>
                    <div>
                        <dt class="text-sm font-medium text-gray-500">CIN</dt>
                        <dd class="mt-1 text-sm text-gray-900">${donneur.cin}</dd>
                    </div>
                    <div>
                        <dt class="text-sm font-medium text-gray-500">Téléphone</dt>
                        <dd class="mt-1 text-sm text-gray-900">
                            <a href="tel:${donneur.telephone}" class="text-blue-600 hover:text-blue-800">${donneur.telephone}</a>
                        </dd>
                    </div>
                    <div>
                        <dt class="text-sm font-medium text-gray-500">Date de naissance</dt>
                        <dd class="mt-1 text-sm text-gray-900">
                            ${donneur.dateNaissance}
                        </dd>
                    </div>
                    <div>
                        <dt class="text-sm font-medium text-gray-500">Sexe</dt>
                        <dd class="mt-1 text-sm text-gray-900">${donneur.sexe == 'M' ? 'Homme' : 'Femme'}</dd>
                    </div>
                    <div>
                        <dt class="text-sm font-medium text-gray-500">Poids</dt>
                        <dd class="mt-1 text-sm text-gray-900">${donneur.poids} kg</dd>
                    </div>
                </dl>
            </div>
        </div>

        <!-- Medical Information Section -->
        <div class="bg-white rounded-xl shadow-sm ring-1 ring-gray-200 overflow-hidden mt-6">
            <div class="bg-gray-50 px-6 py-4 border-b border-gray-200">
                <h2 class="text-lg font-semibold text-gray-900 flex items-center">
                    <svg class="w-6 h-6 mr-2 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                    </svg>
                    Informations médicales
                </h2>
            </div>
            <div class="px-6 py-6">
                <dl class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <dt class="text-sm font-medium text-gray-500">Groupe sanguin</dt>
                        <dd class="mt-1">
                            <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-red-100 text-red-800">
                                ${donneur.groupesanguin != null ? donneur.groupesanguin.label : 'N/A'}
                            </span>
                        </dd>
                    </div>
                    <div>
                        <dt class="text-sm font-medium text-gray-500">Disponibilité</dt>
                        <dd class="mt-1">
                            <c:if test="${donneur.disponibilite != null}">
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium ${donneur.disponibilite.name() == 'DISPONIBLE' ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'}">
                                    <c:choose>
                                        <c:when test="${donneur.disponibilite.name() == 'DISPONIBLE'}">Disponible</c:when>
                                        <c:when test="${donneur.disponibilite.name() == 'NON_DISPONIBLE'}">Non disponible</c:when>
                                        <c:otherwise>Non éligible</c:otherwise>
                                    </c:choose>
                                </span>
                            </c:if>
                            <c:if test="${donneur.disponibilite == null}">
                                <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-gray-100 text-gray-800">Non spécifié</span>
                            </c:if>
                        </dd>
                    </div>
                    <div class="md:col-span-2">
                        <dt class="text-sm font-medium text-gray-500">Conditions médicales</dt>
                        <dd class="mt-1 text-sm text-gray-900">
                            <c:choose>
                                <c:when test="${not empty donneur.maladie and donneur.maladie != 'Aucune'}">
                                    <div class="bg-yellow-50 border-l-4 border-yellow-400 p-4">
                                        <div class="flex">
                                            <div class="flex-shrink-0">
                                                <svg class="h-5 w-5 text-yellow-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.728-.833-2.498 0L3.316 16.5c-.77.833.192 2.5 1.732 2.5z"></path>
                                                </svg>
                                            </div>
                                            <div class="ml-3">
                                                <p class="text-sm text-yellow-700">${donneur.maladie}</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="bg-green-50 border-l-4 border-green-400 p-4">
                                        <div class="flex">
                                            <div class="flex-shrink-0">
                                                <svg class="h-5 w-5 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                                                </svg>
                                            </div>
                                            <div class="ml-3">
                                                <p class="text-sm text-green-700">Aucune condition médicale signalée</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </dd>
                    </div>
                </dl>
            </div>
        </div>

        <!-- Associated Receiver Section -->
        <c:if test="${donneur.receveur != null}">
            <div class="bg-white rounded-xl shadow-sm ring-1 ring-gray-200 overflow-hidden mt-6">
                <div class="bg-gray-50 px-6 py-4 border-b border-gray-200">
                    <h2 class="text-lg font-semibold text-gray-900 flex items-center">
                        <svg class="w-6 h-6 mr-2 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.828 10.172a4 4 0 00-5.656 0l-4 4a4 4 0 105.656 5.656l1.102-1.101m-.758-4.899a4 4 0 005.656 0l4-4a4 4 0 00-5.656-5.656l-1.1 1.1"></path>
                        </svg>
                        Receveur associé
                    </h2>
                </div>
                <div class="px-6 py-6">
                    <div class="flex items-center space-x-4">
                        <div class="h-12 w-12 rounded-full bg-purple-100 flex items-center justify-center">
                            <span class="text-sm font-medium text-purple-600">
                                ${donneur.receveur.nom.charAt(0)}${donneur.receveur.prenom.charAt(0)}
                            </span>
                        </div>
                        <div class="flex-1 min-w-0">
                            <p class="text-sm font-medium text-gray-900">${donneur.receveur.nom} ${donneur.receveur.prenom}</p>
                            <p class="text-sm text-gray-500">Groupe sanguin: ${donneur.receveur.groupesanguin}</p>
                        </div>
                        <div>
                            <a href="${pageContext.request.contextPath}/receveur/details?id=${donneur.receveur.id}" 
                               class="text-purple-600 hover:text-purple-800 text-sm font-medium">Voir détails</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Action Buttons -->
        <div class="flex justify-center space-x-4 mt-8 pb-8">
            <a href="${pageContext.request.contextPath}/donneur?action=edit&id=${donneur.id}" 
               class="inline-flex items-center px-6 py-3 border border-transparent shadow-sm text-base font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                <svg class="-ml-1 mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                </svg>
                Modifier ce donneur
            </a>
            <a href="${pageContext.request.contextPath}/donneur?action=delete&id=${donneur.id}" 
               onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce donneur ? Cette action est irréversible.')"
               class="inline-flex items-center px-6 py-3 border border-red-300 shadow-sm text-base font-medium rounded-md text-red-700 bg-white hover:bg-red-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                <svg class="-ml-1 mr-3 h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                </svg>
                Supprimer
            </a>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-gray-100">
        <div class="max-w-6xl mx-auto px-4 py-8">
            <div class="text-center text-gray-600">
                <p class="text-sm">Banque de Sang - Système de gestion des donneurs</p>
            </div>
        </div>
    </footer>
</body>
</html>