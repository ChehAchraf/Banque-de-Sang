<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Banque de Sang</title>
    <!-- Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">

<!-- Include Navbar -->
<jsp:include page="partials/navbar.jsp"/>
<!-- Hero Section (Index) -->
<header class="bg-[url('assets/img/heroimage.svg')] bg-cover bg-center bg-no-repeat bg-red-600 bg-opacity-40">
    <div class="max-w-6xl mx-auto px-4 py-16 md:py-20">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-10 items-center">
            <div class="text-red-50 max-md:text-center">
                <p class="uppercase tracking-wider text-red-100 text-sm font-semibold">Banque de Sang</p>
                <h1 class="mt-3 text-3xl md:text-5xl font-extrabold leading-tight">Trouvez un donneur ou devenez donneur
                    aujourd'hui</h1>
                <p class="mt-4 md:mt-6 text-red-100/90 text-base md:text-lg">Chaque don peut sauver des vies.
                    Rejoignez-nous et faites la différence.</p>
                <div class="mt-8 flex items-center gap-3 max-md:justify-center">
                    <a href="donneur/addDonneur.jsp"
                       class="inline-flex items-center justify-center rounded-lg px-5 py-3 text-sm font-semibold text-red-700 bg-white hover:bg-red-50 focus:outline-none focus:ring-2 focus:ring-white">S'inscrire
                        comme donneur</a>
                    <a href="#donneurs"
                       class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-medium text-white/90 hover:text-white ring-1 ring-inset ring-white/30 focus:outline-none focus:ring-2 focus:ring-white/70">Voir
                        les donneurs disponibles</a>
                </div>
            </div>
            
        </div>
    </div>
    <div class="bg-white/5 backdrop-blur-sm border-t border-white/10">
        <div class="max-w-6xl mx-auto px-4 py-4 text-center text-sm text-red-100/80">
            Ensemble, faisons la différence aujourd'hui.
        </div>
    </div>
</header>

<!-- Donors Ready Section (Static Template) -->
<section id="donneurs" class="py-12">
    <div class="max-w-6xl mx-auto px-4">
        <div class="flex items-end justify-between gap-4 mb-8">
            <div>
                <h2 class="text-2xl md:text-3xl font-extrabold text-red-700">Donneurs disponibles</h2>
                <p class="mt-2 text-gray-600">Liste des donneurs prêts à donner leur sang.</p>
            </div>
            <div>
                <a href="donneur/addDonneur.jsp"
                   class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-semibold text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-400">Ajouter
                    un donneur</a>
            </div>
        </div>

        <!-- Static card grid example -->
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:set var="receveurs" value="${requestScope.receveurs}"/>
            <c:forEach items="${receveurs}" var="r">
                <article

                        class="group bg-white rounded-xl shadow-sm ring-1 ring-gray-200 hover:shadow-md transition overflow-hidden">
                    <div class="p-5">
                        <div class="flex items-center justify-between">
                            <h3 class="text-lg font-semibold text-gray-900">
                                    ${r.nom} ${r.prenom}
                            </h3>
                            <span class="inline-flex items-center rounded-md bg-red-50 px-2 py-1 text-xs font-medium text-red-700 ring-1 ring-inset ring-red-600/20">
                                    ${r.groupesanguin.label}
                            </span>
                        </div>
                        <dl class="mt-4 grid grid-cols-2 gap-3 text-sm">
                                <%--                            <!-- <div class="col-span-2">--%>
                                <%--                                <dt class="text-gray-500">Ville</dt>--%>
                                <%--                                <dd class="font-medium text-gray-900">${r.ville}</dd>--%>
                                <%--                            </div> -->--%>
                            <div>
                                <dt class="text-gray-500">Téléphone</dt>
                                <dd class="font-medium text-gray-900">
                                    <a class="text-red-700 hover:underline" href="tel:${r.telephone}">${r.telephone}</a>
                                </dd>
                            </div>
                            <div>
                                <dt class="text-gray-500">Disponibilité</dt>
                                <dd class="font-medium ${r.disponibilite == 'DISPONIBLE' ? 'text-green-700' : 'text-gray-500'}">
                                        ${r.disponibilite}
                                </dd>
                            </div>
                        </dl>
                    </div>
                    <div class="px-5 pb-5">
                        <a href="${pageContext.request.contextPath}/receveur/details?id=${r.id}"
                           class="inline-flex items-center rounded-lg px-3 py-2 text-sm font-medium text-red-700 hover:bg-red-50 focus:outline-none focus:ring-2 focus:ring-red-400">
                            Contacter
                        </a>
                    </div>
                </article>
            </c:forEach>

            <!-- <article class="group bg-white rounded-xl shadow-sm ring-1 ring-gray-200 hover:shadow-md transition overflow-hidden">
                <div class="p-5">
                    <div class="flex items-center justify-between">
                        <h3 class="text-lg font-semibold text-gray-900">Marie Dupont</h3>
                        <span class="inline-flex items-center rounded-md bg-red-50 px-2 py-1 text-xs font-medium text-red-700 ring-1 ring-inset ring-red-600/20">O+</span>
                    </div>
                    <dl class="mt-4 grid grid-cols-2 gap-3 text-sm">
                        <div class="col-span-2">
                            <dt class="text-gray-500">Ville</dt>
                            <dd class="font-medium text-gray-900">Casablanca</dd>
                        </div>
                        <div>
                            <dt class="text-gray-500">Téléphone</dt>
                            <dd class="font-medium text-gray-900"><a class="text-red-700 hover:underline" href="tel:+212612345678">+212 6 12 34 56 78</a></dd>
                        </div>
                        <div>
                            <dt class="text-gray-500">Disponibilité</dt>
                            <dd class="font-medium text-green-700">Disponible</dd>
                        </div>
                    </dl>
                </div>
                <div class="px-5 pb-5">
                    <a href="#" class="inline-flex items-center rounded-lg px-3 py-2 text-sm font-medium text-red-700 hover:bg-red-50 focus:outline-none focus:ring-2 focus:ring-red-400">Contacter</a>
                </div>
            </article> -->

        </div>
    </div>

    <!-- CTA Banner -->
    <div class="mt-12">
        <div class="max-w-6xl mx-auto px-4">
            <div class="relative overflow-hidden rounded-2xl bg-gradient-to-r from-red-600 via-red-700 to-red-800 text-red-50">
                <div class="p-8 md:p-10 flex flex-col md:flex-row md:items-center md:justify-between gap-6">
                    <div class="max-w-2xl">
                        <h3 class="text-xl md:text-2xl font-bold">Chaque don peut sauver des vies</h3>
                        <p class="mt-2 text-red-100">Rejoignez notre communauté de donneurs et faites la différence dès
                            aujourd'hui.</p>
                    </div>
                    <div class="flex gap-3">
                        <a href="donneur/addDonneur.jsp"
                           class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-semibold text-red-700 bg-white hover:bg-red-50 focus:outline-none focus:ring-2 focus:ring-white">S'inscrire
                            comme donneur</a>
                        <a href="#donneurs"
                           class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-medium text-white/90 hover:text-white ring-1 ring-inset ring-white/30 focus:outline-none focus:ring-2 focus:ring-white/70">Voir
                            les donneurs</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

</body>
</html>