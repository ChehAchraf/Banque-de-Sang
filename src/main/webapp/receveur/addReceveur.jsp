<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter un receveur</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">
    <jsp:include page="../partials/navbar.jsp" />

    <!-- Hero with background image -->
    <header class="relative overflow-hidden">
        <div class="absolute inset-0">
            <img src="../assets/img/heroimage.svg" alt="" aria-hidden="true" class="w-full h-full object-cover opacity-20" />
        </div>
        <div class="relative bg-gradient-to-br from-red-600/90 via-red-700/90 to-red-800/90">
            <div class="max-w-6xl mx-auto px-4 py-16 md:py-20">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-10 items-center">
                    <div class="text-red-50 max-md:text-center">
                        <p class="uppercase tracking-wider text-red-100 text-sm font-semibold">Banque de Sang</p>
                        <h1 class="mt-3 text-3xl md:text-5xl font-extrabold leading-tight">Ajouter un receveur</h1>
                        <p class="mt-4 md:mt-6 text-red-100/90 text-base md:text-lg">Renseignez les informations du receveur pour faciliter l'appariement avec des donneurs compatibles.</p>
                        <div class="mt-8 flex items-center gap-3 max-md:justify-center">
                            <a href="#receveur-form" class="inline-flex items-center justify-center rounded-lg px-5 py-3 text-sm font-semibold text-red-700 bg-white hover:bg-red-50 focus:outline-none focus:ring-2 focus:ring-white">Commencer</a>
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
                                <p class="mt-3 text-red-100">Veuillez fournir des informations exactes pour assurer une prise en charge adaptée.</p>
                            </div>
                            <div class="mt-10 flex items-end justify-center">
                                <img src="../assets/img/happygroup.svg" alt="Receveur" class="w-40 opacity-90">
                            </div>
                        </div>
                    </div>

                    <div class="col-span-2 p-6 md:p-8">
                        <form action="${pageContext.request.contextPath}/add/receveur" method="post" class="space-y-8" novalidate>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <label for="nom" class="block text-sm font-medium text-gray-700">Nom</label>
                                    <input type="text" id="nom" name="nom" required autocomplete="family-name" placeholder="Ex. El Amrani" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600" />
                                </div>
                                <div>
                                    <label for="prenom" class="block text-sm font-medium text-gray-700">Prénom</label>
                                    <input type="text" id="prenom" name="prenom" required autocomplete="given-name" placeholder="Ex. Youssef" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600" />
                                </div>

                                <div>
                                    <label for="cin" class="block text-sm font-medium text-gray-700">CIN</label>
                                    <input type="text" id="cin" name="cin" required placeholder="Ex. AA123456" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600" />
                                </div>
                                <div>
                                    <label for="telephone" class="block text-sm font-medium text-gray-700">Téléphone</label>
                                    <input type="tel" id="telephone" name="telephone" required autocomplete="tel" placeholder="Ex. 06 12 34 56 78" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600" />
                                </div>

                                <div>
                                    <label for="dateNaissance" class="block text-sm font-medium text-gray-700">Date de naissance</label>
                                    <input type="date" id="dateNaissance" name="dateNaissance" required autocomplete="bday" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600" />
                                </div>
                                <div>
                                    <label for="poids" class="block text-sm font-medium text-gray-700">Poids (kg)</label>
                                    <input type="number" id="poids" name="poids" min="10" max="300" step="0.1" placeholder="Ex. 65" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600" />
                                </div>

                                <div>
                                    <label for="sexe" class="block text-sm font-medium text-gray-700">Sexe</label>
                                    <div class="mt-2 flex items-center gap-6">
                                        <label class="inline-flex items-center gap-2 text-gray-700">
                                            <input type="radio" name="sexe" value="F" class="text-red-600 focus:ring-red-600" />
                                            <span>Femme</span>
                                        </label>
                                        <label class="inline-flex items-center gap-2 text-gray-700">
                                            <input type="radio" name="sexe" value="M" class="text-red-600 focus:ring-red-600" />
                                            <span>Homme</span>
                                        </label>
                                    </div>
                                </div>

                                <div>
                                    <label for="groupeSanguin" class="block text-sm font-medium text-gray-700">Groupe sanguin</label>
                                    <select id="groupeSanguin" name="groupesanguin" required class="mt-2 block w-full rounded-lg border-gray-300 bg-white shadow-sm focus:ring-red-600 focus:border-red-600">
                                        <option value="" disabled selected>Choisir un groupe</option>
                                        <option value="O_POS">O+</option>
                                        <option value="O_NEG">O-</option>
                                        <option value="A_POS">A+</option>
                                        <option value="A_NEG">A-</option>
                                        <option value="B_POS">B+</option>
                                        <option value="B_NEG">B-</option>
                                        <option value="AB_POS">AB+</option>
                                        <option value="AB_NEG">AB-</option>
                                    </select>
                                </div>

                                <div>
                                    <label for="disponibilite" class="block text-sm font-medium text-gray-700">Priorité</label>
                                    <select id="disponibilite" name="disponibilite" class="mt-2 block w-full rounded-lg border-gray-300 bg-white shadow-sm focus:ring-red-600 focus:border-red-600">
                                        <option value="" disabled selected>Choisir</option>
                                        <option value="DISPONIBLE">Urgent</option>
                                        <option value="INDISPONIBLE">Non urgent</option>
                                    </select>
                                </div>

                                <div class="md:col-span-2">
                                    <label for="maladie" class="block text-sm font-medium text-gray-700">Conditions médicales</label>
                                    <textarea id="maladie" name="maladie" rows="3" placeholder="Pathologies, allergies, traitements…" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600"></textarea>
                                </div>
                            </div>

                            <div class="flex items-center justify-end gap-3">
                                <a href="../index.jsp" class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-gray-400">Annuler</a>
                                <button type="submit" class="inline-flex items-center justify-center rounded-lg px-5 py-2.5 text-sm font-semibold text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-400">Enregistrer le receveur</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

</body>
</html>

