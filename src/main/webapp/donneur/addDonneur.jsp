<%--
  Created by IntelliJ IDEA.
  User: shaor
  Date: 07/10/2025
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ajouter une donneur</title>
    <!-- Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    <jsp:include page="../partials/navbar.jsp" />
    <!-- Hero Section -->
    <header class="bg-gradient-to-br from-red-600 via-red-700 to-red-800">
        <div class="max-w-6xl mx-auto px-4 py-16 md:py-20">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-10 items-center">
                <div class="text-red-50">
                    <p class="uppercase tracking-wider text-red-100 text-sm font-semibold">Banque de Sang</p>
                    <h1 class="mt-3 text-3xl md:text-5xl font-extrabold leading-tight">Ajoutez un donneur et aidez à sauver des vies</h1>
                    <p class="mt-4 md:mt-6 text-red-100/90 text-base md:text-lg">Chaque don compte. Renseignez les informations du donneur en toute simplicité et confidentialité.</p>
                    <div class="mt-8 flex items-center gap-3">
                        <a href="#donneur-form" class="inline-flex items-center justify-center rounded-lg px-5 py-3 text-sm font-semibold text-red-700 bg-white hover:bg-red-50 focus:outline-none focus:ring-2 focus:ring-white">Commencer l'inscription</a>
                        <a href="../index.jsp" class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-medium text-white/90 hover:text-white ring-1 ring-inset ring-white/30 focus:outline-none focus:ring-2 focus:ring-white/70">Retour à l'accueil</a>
                    </div>
                </div>
                <div class="relative">
                    <img src="../assets/img/heroimage.svg" alt="Illustration du don de sang" class="w-full h-auto drop-shadow-2xl" />
                </div>
            </div>
        </div>
    </header>

    <!-- Form Section -->
    <section id="donneur-form" class="bg-red-50 py-12" aria-labelledby="form-title">
        <div class="max-w-5xl mx-auto px-4">
            <h2 id="form-title" class="sr-only">Formulaire d'ajout d'un donneur</h2>

            <div class="bg-white shadow-xl ring-1 ring-black/5 rounded-2xl overflow-hidden">
                <div class="grid grid-cols-1 md:grid-cols-3">
                    <div class="hidden md:block md:col-span-1 bg-gradient-to-b from-red-600 to-red-700 p-8">
                        <div class="h-full flex flex-col justify-between text-red-50">
                            <div>
                                <h2 class="text-2xl font-semibold">Pourquoi donner ?</h2>
                                <p class="mt-3 text-red-100">Une seule donation peut sauver jusqu'à trois vies. Merci pour votre générosité.</p>
                            </div>
                            <div class="mt-10 flex items-end justify-center">
                                <img src="../assets/img/happykid.svg" alt="Don de sang" class="w-40 opacity-90">
                            </div>
                        </div>
                    </div>

                    <div class="col-span-2 p-6 md:p-8">
                        <form action="#" method="post" class="space-y-8" novalidate>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div>
                                    <label for="nom" class="block text-sm font-medium text-gray-700">Nom</label>
                                    <input type="text" id="nom" name="nom" required autocomplete="family-name" placeholder="Ex. Dupont" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600" />
                                </div>
                                <div>
                                    <label for="prenom" class="block text-sm font-medium text-gray-700">Prénom</label>
                                    <input type="text" id="prenom" name="prenom" required autocomplete="given-name" placeholder="Ex. Marie" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600" />
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
                                    <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                                    <input type="email" id="email" name="email" autocomplete="email" placeholder="Ex. nom.prenom@email.com" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600" />
                                </div>
                                <div>
                                    <label for="dateNaissance" class="block text-sm font-medium text-gray-700">Date de naissance</label>
                                    <input type="date" id="dateNaissance" name="dateNaissance" required autocomplete="bday" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600" />
                                </div>

                                <div class="md:col-span-2">
                                    <label for="adresse" class="block text-sm font-medium text-gray-700">Adresse</label>
                                    <input type="text" id="adresse" name="adresse" autocomplete="street-address" placeholder="Rue, numéro, appartement" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600" />
                                </div>

                                <div>
                                    <label for="ville" class="block text-sm font-medium text-gray-700">Ville</label>
                                    <input type="text" id="ville" name="ville" autocomplete="address-level2" placeholder="Ex. Casablanca" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600" />
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
                                    <select id="groupeSanguin" name="groupeSanguin" required class="mt-2 block w-full rounded-lg border-gray-300 bg-white shadow-sm focus:ring-red-600 focus:border-red-600">
                                        <option value="" disabled selected>Choisir un groupe</option>
                                        <option>O+</option>
                                        <option>O-</option>
                                        <option>A+</option>
                                        <option>A-</option>
                                        <option>B+</option>
                                        <option>B-</option>
                                        <option>AB+</option>
                                        <option>AB-</option>
                                    </select>
                                </div>
                                <div>
                                    <label for="disponibilite" class="block text-sm font-medium text-gray-700">Disponibilité</label>
                                    <select id="disponibilite" name="disponibilite" class="mt-2 block w-full rounded-lg border-gray-300 bg-white shadow-sm focus:ring-red-600 focus:border-red-600">
                                        <option value="" disabled selected>Choisir</option>
                                        <option value="DISPONIBLE">Disponible</option>
                                        <option value="INDISPONIBLE">Indisponible</option>
                                    </select>
                                </div>

                                <div>
                                    <label for="poids" class="block text-sm font-medium text-gray-700">Poids (kg)</label>
                                    <input type="number" id="poids" name="poids" min="40" max="200" step="0.1" placeholder="Ex. 70" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600" />
                                </div>
                                <div>
                                    <label for="derniereDonation" class="block text-sm font-medium text-gray-700">Dernière donation</label>
                                    <input type="date" id="derniereDonation" name="derniereDonation" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600" />
                                </div>

                                <div class="md:col-span-2">
                                    <label for="conditions" class="block text-sm font-medium text-gray-700">Conditions médicales</label>
                                    <textarea id="conditions" name="conditions" rows="3" placeholder="Maladies chroniques, allergies, traitements en cours…" class="mt-2 block w-full rounded-lg border-gray-300 shadow-sm focus:ring-red-600 focus:border-red-600"></textarea>
                                </div>
                            </div>

                            <div class="flex items-center justify-end gap-3">
                                <button type="reset" class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-gray-400">Effacer</button>
                                <button type="submit" class="inline-flex items-center justify-center rounded-lg px-5 py-2.5 text-sm font-semibold text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-400">Enregistrer le donneur</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <p class="mt-6 text-center text-sm text-gray-500">Vos informations sont protégées et ne seront utilisées qu'à des fins médicales.</p>
        </div>
    </section>

</body>
</html>
