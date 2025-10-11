<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Associer un donneur</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">
<jsp:include page="../partials/navbar.jsp" />

<section class="py-12">
    <div class="max-w-3xl mx-auto px-4">
        <div class="bg-white rounded-2xl shadow-sm ring-1 ring-gray-200 p-6 md:p-8">
            <h1 class="text-2xl md:text-3xl font-extrabold text-red-700">Associer un donneur à un receveur</h1>
            <p class="mt-2 text-gray-600">Sélectionnez un donneur compatible et disponible pour le receveur.</p>

            <c:if test="${not empty error}">
                <div class="mt-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                    <span class="block sm:inline">${error}</span>
                </div>
            </c:if>

            <!-- Donor-first flow: donor is known, choose a compatible receiver -->
            <c:if test="${not empty donneurId}">
                <form method="post" action="${pageContext.request.contextPath}/donation" class="mt-6 space-y-6">
                    <input type="hidden" name="donneurId" value="${donneurId}" />
                    <div>
                        <label for="receveurId" class="block text-sm font-medium text-gray-700">Receveur compatible</label>
                        <select id="receveurId" name="receveurId" required class="mt-2 block w-full rounded-lg border-gray-300 bg-white shadow-sm focus:ring-red-600 focus:border-red-600">
                            <option value="" disabled selected>Choisir un receveur</option>
                            <c:forEach items="${receveurs}" var="r">
                                <option value="${r.id}">${r.nom} ${r.prenom} · ${r.groupesanguin.label} · Besoin ${r.pochesRequises}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="flex items-center justify-end gap-3">
                        <a href="${pageContext.request.contextPath}/receveur" class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-gray-400">Annuler</a>
                        <button type="submit" class="inline-flex items-center justify-center rounded-lg px-5 py-2.5 text-sm font-semibold text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-400">Valider l'association</button>
                    </div>
                </form>
            </c:if>

            <!-- Receiver-first flow: choose receiver, then donor -->
            <c:if test="${empty donneurId}">
                <!-- Step 1: choose a receiver (GET to reload donors list) -->
                <form method="get" action="${pageContext.request.contextPath}/donation" class="mt-6 space-y-4">
                    <input type="hidden" name="action" value="form" />
                    <div>
                        <label for="receveurId" class="block text-sm font-medium text-gray-700">Receveur</label>
                        <select id="receveurId" name="receveurId" class="mt-2 block w-full rounded-lg border-gray-300 bg-white shadow-sm focus:ring-red-600 focus:border-red-600">
                            <option value="" ${receveur == null ? 'selected' : ''}>Choisir un receveur</option>
                            <c:forEach items="${receveurs}" var="r">
                                <option value="${r.id}" ${receveur != null && receveur.id == r.id ? 'selected' : ''}>${r.nom} ${r.prenom} · ${r.groupesanguin.label} · Besoin ${r.pochesRequises}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="flex items-center justify-end">
                        <button type="submit" class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-medium text-red-700 bg-red-50 hover:bg-red-100 ring-1 ring-inset ring-red-200 focus:outline-none focus:ring-2 focus:ring-red-300">Charger donneurs</button>
                    </div>
                </form>

                <!-- Step 2: show compatible donors when a receiver is selected -->
                <c:if test="${receveur != null}">
                    <form method="post" action="${pageContext.request.contextPath}/donation" class="mt-6 space-y-6">
                        <input type="hidden" name="receveurId" value="${receveur.id}" />
                        <div class="bg-gray-50 rounded-lg p-4 border border-gray-200">
                            <div class="text-sm text-gray-600">Receveur sélectionné</div>
                            <div class="mt-1 font-medium text-gray-900">${receveur.nom} ${receveur.prenom} · ${receveur.groupesanguin.label}</div>
                            <div class="text-sm text-gray-500">Besoin: ${receveur.urgence != null ? receveur.urgence.pochesRequises : 1} poches · État: ${receveur.etatReceveur != null ? receveur.etatReceveur.label : 'En attente'}</div>
                        </div>
                        <div>
                            <label for="donneurId" class="block text-sm font-medium text-gray-700">Donneur compatible et disponible</label>
                            <select id="donneurId" name="donneurId" required class="mt-2 block w-full rounded-lg border-gray-300 bg-white shadow-sm focus:ring-red-600 focus:border-red-600">
                                <option value="" disabled selected>Choisir un donneur</option>
                                <c:forEach items="${donneurs}" var="d">
                                    <option value="${d.id}">${d.nom} ${d.prenom} · ${d.groupesanguin != null ? d.groupesanguin.label : 'N/A'} · ${d.telephone}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="flex items-center justify-end gap-3">
                            <a href="${pageContext.request.contextPath}/receveur" class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-gray-400">Annuler</a>
                            <button type="submit" class="inline-flex items-center justify-center rounded-lg px-5 py-2.5 text-sm font-semibold text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-400">Valider l'association</button>
                        </div>
                    </form>
                </c:if>
            </c:if>
        </div>
    </div>
</section>

</body>
</html>