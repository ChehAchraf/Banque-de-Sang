<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Opération réussie</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">
    <jsp:include page="partials/navbar.jsp" />

    <header class="bg-gradient-to-br from-emerald-500 via-emerald-600 to-emerald-700">
        <div class="max-w-5xl mx-auto px-4 py-16 md:py-20 text-emerald-50">
            <div class="text-center">
                <span class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-white/10 ring-1 ring-white/30">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-9 h-9 text-white">
                        <path fill-rule="evenodd" d="M2.25 12c0-5.385 4.365-9.75 9.75-9.75s9.75 4.365 9.75 9.75-4.365 9.75-9.75 9.75S2.25 17.385 2.25 12Zm13.36-2.59a.75.75 0 1 0-1.22-.88l-3.6 5a.75.75 0 0 1-1.12.09l-1.5-1.5a.75.75 0 1 0-1.06 1.06l1.5 1.5a2.25 2.25 0 0 0 3.36-.27l3.64-5.01Z" clip-rule="evenodd" />
                    </svg>
                </span>
                <h1 class="mt-6 text-3xl md:text-4xl font-extrabold leading-tight">Enregistrement réussi</h1>
                <p class="mt-3 text-emerald-100/90 max-w-2xl mx-auto">Merci. Les informations ont été enregistrées avec succès dans notre système.</p>
                <div class="mt-8 flex items-center justify-center gap-3">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="inline-flex items-center justify-center rounded-lg px-5 py-2.5 text-sm font-semibold text-emerald-700 bg-white hover:bg-emerald-50 focus:outline-none focus:ring-2 focus:ring-white">Aller à l'accueil</a>
                    <a href="${pageContext.request.contextPath}/donneur/addDonneur.jsp" class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-medium text-white/90 hover:text-white ring-1 ring-inset ring-white/30 focus:outline-none focus:ring-2 focus:ring-white/70">Ajouter un donneur</a>
                    <a href="${pageContext.request.contextPath}/add/receveur" class="inline-flex items-center justify-center rounded-lg px-4 py-2 text-sm font-medium text-white/90 hover:text-white ring-1 ring-inset ring-white/30 focus:outline-none focus:ring-2 focus:ring-white/70">Ajouter un receveur</a>
                </div>
            </div>
        </div>
    </header>

    <section class="py-12">
        <div class="max-w-5xl mx-auto px-4">
            <div class="bg-white rounded-2xl shadow-sm ring-1 ring-gray-200 p-8">
                <h2 class="text-xl font-semibold text-gray-900">Que souhaitez-vous faire ensuite ?</h2>
                <div class="mt-6 grid grid-cols-1 md:grid-cols-3 gap-4">
                    <a href="${pageContext.request.contextPath}/donneur/addDonneur.jsp" class="group block rounded-xl border border-gray-200 p-5 hover:border-emerald-300 hover:bg-emerald-50/30 transition">
                        <div class="font-medium text-gray-900">Ajouter un autre donneur</div>
                        <div class="mt-1 text-sm text-gray-600">Créer un nouveau profil donneur.</div>
                    </a>
                    <a href="${pageContext.request.contextPath}/add/receveur" class="group block rounded-xl border border-gray-200 p-5 hover:border-emerald-300 hover:bg-emerald-50/30 transition">
                        <div class="font-medium text-gray-900">Ajouter un receveur</div>
                        <div class="mt-1 text-sm text-gray-600">Créer un nouveau profil receveur.</div>
                    </a>
                    <a href="${pageContext.request.contextPath}/index.jsp" class="group block rounded-xl border border-gray-200 p-5 hover:border-emerald-300 hover:bg-emerald-50/30 transition">
                        <div class="font-medium text-gray-900">Revenir à l'accueil</div>
                        <div class="mt-1 text-sm text-gray-600">Voir les donneurs disponibles et plus encore.</div>
                    </a>
                </div>
            </div>
        </div>
    </section>

</body>
</html>

