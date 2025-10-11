<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter un receveur</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body class="bg-gray-50 text-gray-800">
<jsp:include page="../partials/navbar.jsp"/>

<!-- Hero with background image -->
<header class="relative overflow-hidden">
    <div class="absolute inset-0">
        <img src="../../../assets/img/heroimage.svg" alt="" aria-hidden="true"
             class="w-full h-full object-cover opacity-20"/>
    </div>
    <div class="relative bg-gradient-to-br from-red-600/90 via-red-700/90 to-red-800/90">
        <div class="max-w-6xl mx-auto px-4 py-16 md:py-20">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-10 items-center">
                <div class="text-red-50 max-md:text-center">
                    <p class="uppercase tracking-wider text-red-100 text-sm font-semibold">Banque de Sang</p>
                    <h1 class="mt-3 text-3xl md:text-5xl font-extrabold leading-tight">${receveur != null ? 'Modifier le receveur' : 'Ajouter un receveur'}</h1>
                    <p class="mt-4 md:mt-6 text-red-100/90 text-base md:text-lg">Renseignez les informations du receveur
                        pour faciliter l'appariement avec des donneurs compatibles.</p>
                    <div class="mt-8 flex items-center gap-3 max-md:justify-center">
                        <a href="#receveur-form"
                           class="inline-flex items-center justify-center rounded-lg px-5 py-3 text-sm font-semibold text-red-700 bg-white hover:bg-red-50 focus:outline-none focus:ring-2 focus:ring-white">Commencer</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Form Section -->
<section id="receveur-form" class="py-12">
    <div class="max-w-5xl mx-auto px-4">
        <div class="bg-white shadow-xl ring-1 ring-black/5 rounded-2xl overflow-hidden">
            <div class="grid grid-cols-1 md:grid-cols-3">
                <div class="hidden md:block md:col-span-1 bg-gradient-to-b from-red-600 to-red-700 p-8">
                    <div class="h-full flex flex-col justify-between text-red-50">
                        <div>
                            <h2 class="text-2xl font-semibold">Informations nécessaires</h2>
                            <p class="mt-3 text-red-100">Veuillez fournir des informations exactes pour assurer une
                                prise en charge adaptée.</p>
                        </div>
                        <div class="mt-10 flex items-end justify-center">
                            <img src="../../../assets/img/happygroup.svg" alt="Receveur" class="w-40 opacity-90">
                        </div>
                    </div>
                </div>

                <div class="col-span-2 p-6 md:p-8">
                    <form action="${pageContext.request.contextPath}/receveur" method="post" class="space-y-8"
                          novalidate>
                        <c:if test="${receveur != null}">
                            <input type="hidden" name="id" value="${receveur.id}"/>
                        </c:if>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label for="nom" class="block text-sm font-medium text-gray-700">Nom</label>
                                <input type="text" id="nom" name="nom" required autocomplete="family-name"
                                       placeholder="Ex. El Amrani" value="${receveur != null ? receveur.nom : ''}"
                                       class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600"/>
                            </div>
                            <div>
                                <label for="prenom" class="block text-sm font-medium text-gray-700">Prénom</label>
                                <input type="text" id="prenom" name="prenom" required autocomplete="given-name"
                                       placeholder="Ex. Youssef" value="${receveur != null ? receveur.prenom : ''}"
                                       class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600"/>
                            </div>

                            <div>
                                <label for="cin" class="block text-sm font-medium text-gray-700">CIN</label>
                                <input type="text" id="cin" name="cin" required placeholder="Ex. AA123456"
                                       value="${receveur != null ? receveur.cin : ''}"
                                       class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600"/>
                            </div>
                            <div>
                                <label for="telephone" class="block text-sm font-medium text-gray-700">Téléphone</label>
                                <input type="tel" id="telephone" name="telephone" required autocomplete="tel"
                                       placeholder="Ex. 06 12 34 56 78"
                                       value="${receveur != null ? receveur.telephone : ''}"
                                       class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600"/>
                            </div>

                            <div>
                                <label for="dateNaissance" class="block text-sm font-medium text-gray-700">Date de
                                    naissance</label>
                                <input type="date" id="dateNaissance" name="dateNaissance" required autocomplete="bday"
                                       value="${receveur != null ? receveur.dateNaissance : ''}"
                                       class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600"/>
                            </div>
                            <div>
                                <label for="poids" class="block text-sm font-medium text-gray-700">Poids (kg)</label>
                                <input type="number" id="poids" name="poids" min="10" max="300" step="0.1"
                                       placeholder="Ex. 65" value="${receveur != null ? receveur.poids : ''}"
                                       class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600"/>
                            </div>

                            <div>
                                <label for="sexe" class="block text-sm font-medium text-gray-700">Sexe</label>
                                <div class="mt-2 flex items-center gap-6">
                                    <label class="inline-flex items-center gap-2 text-gray-700">
                                        <input type="radio" name="sexe"
                                               value="F" ${receveur != null && receveur.sexe == 'F' ? 'checked' : ''}
                                               class="text-red-600 focus:ring-red-600"/>
                                        <span>Femme</span>
                                    </label>
                                    <label class="inline-flex items-center gap-2 text-gray-700">
                                        <input type="radio" name="sexe"
                                               value="M" ${receveur != null && receveur.sexe == 'M' ? 'checked' : ''}
                                               class="text-red-600 focus:ring-red-600"/>
                                        <span>Homme</span>
                                    </label>
                                </div>
                            </div>

                            <div>
                                <label for="groupeSanguin" class="block text-sm font-medium text-gray-700">Groupe
                                    sanguin</label>
                                <select id="groupeSanguin" name="groupesanguin" required
                                        class="mt-2 block w-full rounded-lg border-gray-300 bg-white shadow-sm focus:ring-red-600 focus:border-red-600">
                                    <option value="" disabled ${receveur == null ? 'selected' : ''}>Choisir un groupe</option>
                                    <c:forEach var="g" items="${groupesSanguins}">
                                        <option value="${g.name()}" ${receveur != null && receveur.groupesanguin != null && receveur.groupesanguin.name() == g.name() ? 'selected' : ''}>${g.label}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div>
                                <label for="urgence" class="block text-sm font-medium text-gray-700">Urgence médicale</label>
                                <select id="urgence" name="urgence" required
                                        class="mt-2 block w-full rounded-lg border-gray-300 bg-white shadow-sm focus:ring-red-600 focus:border-red-600">
                                    <option value="" disabled ${receveur == null ? 'selected' : ''}>Choisir le niveau d'urgence</option>
                                    <c:forEach var="u" items="${urgences}">
                                        <option value="${u.name()}" ${receveur != null && receveur.urgence != null && receveur.urgence.name() == u.name() ? 'selected' : ''}>
                                            ${u.description}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="md:col-span-2">
                                <label for="maladie" class="block text-sm font-medium text-gray-700">Conditions
                                    médicales</label>
                                <textarea id="maladie" name="maladie" rows="3"
                                          placeholder="Pathologies, allergies, traitements…"
                                          class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600">${receveur != null ? receveur.maladie : ''}</textarea>
                            </div>
                        </div>

                        <div class="flex items-center justify-end gap-3">
                            <a href="${pageContext.request.contextPath}/receveur"
                               class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-gray-400">Annuler</a>
                            <button type="submit"
                                    class="inline-flex items-center justify-center rounded-lg px-5 py-2.5 text-sm font-semibold text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-400">${receveur != null ? 'Mettre à jour' : 'Enregistrer le receveur'}</button>
                        </div>
                    </form>
                    
                    <!-- Error Message Display -->
                    <c:if test="${not empty error}">
                        <div class="mt-4 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                            <span class="block sm:inline">${error}</span>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</section>

</body>
</html>

