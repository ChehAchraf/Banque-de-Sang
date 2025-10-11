<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Banque de Sang - Sauvons des vies ensemble</title>
    
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Tailwind Config -->
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        'inter': ['Inter', 'sans-serif'],
                    },
                    animation: {
                        'fade-in-up': 'fadeInUp 0.6s ease-out',
                        'slide-in-left': 'slideInLeft 0.6s ease-out',
                        'pulse-slow': 'pulse 2s infinite',
                    },
                    keyframes: {
                        fadeInUp: {
                            '0%': { opacity: '0', transform: 'translateY(30px)' },
                            '100%': { opacity: '1', transform: 'translateY(0)' }
                        },
                        slideInLeft: {
                            '0%': { opacity: '0', transform: 'translateX(-50px)' },
                            '100%': { opacity: '1', transform: 'translateX(0)' }
                        }
                    }
                }
            }
        }
    </script>
</head>
<body class="font-inter bg-gray-50">

<!-- Navigation -->
<nav class="bg-white shadow-sm border-b border-gray-200 sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
            <a href="${pageContext.request.contextPath}/" class="flex items-center gap-3 text-xl font-bold text-red-600 hover:text-red-700 transition-colors">
                <i class="fas fa-heartbeat text-2xl"></i>
                Banque de Sang
            </a>
            
            <div class="hidden md:flex items-center gap-8">
                <a href="${pageContext.request.contextPath}/" class="flex items-center gap-2 text-gray-600 hover:text-red-600 font-medium transition-colors relative group">
                    <i class="fas fa-home"></i> Accueil
                    <span class="absolute bottom-0 left-0 w-0 h-0.5 bg-red-600 group-hover:w-full transition-all duration-300"></span>
                </a>
                <a href="${pageContext.request.contextPath}/donneur?action=add" class="flex items-center gap-2 text-gray-600 hover:text-red-600 font-medium transition-colors relative group">
                    <i class="fas fa-user-plus"></i> Nouveau Donneur
                    <span class="absolute bottom-0 left-0 w-0 h-0.5 bg-red-600 group-hover:w-full transition-all duration-300"></span>
                </a>
                <a href="${pageContext.request.contextPath}/receveur?action=add" class="flex items-center gap-2 text-gray-600 hover:text-red-600 font-medium transition-colors relative group">
                    <i class="fas fa-user-injured"></i> Nouveau Receveur
                    <span class="absolute bottom-0 left-0 w-0 h-0.5 bg-red-600 group-hover:w-full transition-all duration-300"></span>
                </a>
                <a href="${pageContext.request.contextPath}/donation?action=form" class="flex items-center gap-2 text-gray-600 hover:text-red-600 font-medium transition-colors relative group">
                    <i class="fas fa-hand-holding-medical"></i> Donation
                    <span class="absolute bottom-0 left-0 w-0 h-0.5 bg-red-600 group-hover:w-full transition-all duration-300"></span>
                </a>
            </div>
            
            <button class="md:hidden p-2 rounded-md text-gray-600 hover:text-red-600 hover:bg-gray-100 transition-colors" onclick="toggleMobileMenu()">
                <i class="fas fa-bars text-xl"></i>
            </button>
        </div>
        
        <!-- Mobile Menu -->
        <div id="mobileMenu" class="hidden pb-4 md:hidden border-t border-gray-200 mt-2">
            <div class="flex flex-col gap-1 pt-4">
                <a href="${pageContext.request.contextPath}/" class="flex items-center gap-2 px-3 py-2 rounded-md text-gray-600 hover:text-red-600 hover:bg-gray-50 transition-colors">
                    <i class="fas fa-home"></i> Accueil
                </a>
                <a href="${pageContext.request.contextPath}/donneur?action=add" class="flex items-center gap-2 px-3 py-2 rounded-md text-gray-600 hover:text-red-600 hover:bg-gray-50 transition-colors">
                    <i class="fas fa-user-plus"></i> Nouveau Donneur
                </a>
                <a href="${pageContext.request.contextPath}/receveur?action=add" class="flex items-center gap-2 px-3 py-2 rounded-md text-gray-600 hover:text-red-600 hover:bg-gray-50 transition-colors">
                    <i class="fas fa-user-injured"></i> Nouveau Receveur
                </a>
                <a href="${pageContext.request.contextPath}/donation?action=form" class="flex items-center gap-2 px-3 py-2 rounded-md text-gray-600 hover:text-red-600 hover:bg-gray-50 transition-colors">
                    <i class="fas fa-hand-holding-medical"></i> Donation
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="bg-gradient-to-r from-red-600 via-red-700 to-red-800 text-white relative overflow-hidden">
    <!-- Background Pattern -->
    <div class="absolute inset-0 opacity-10">
        <svg class="w-full h-full" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
            <defs>
                <pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse">
                    <path d="M 10 0 L 0 0 0 10" fill="none" stroke="white" stroke-width="0.5"/>
                </pattern>
            </defs>
            <rect width="100" height="100" fill="url(#grid)" />
        </svg>
    </div>
    
    <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24">
        <div class="text-center animate-fade-in-up">
            <h1 class="text-4xl md:text-6xl font-extrabold mb-6 leading-tight">
                Sauvons des vies <span class="text-red-200">ensemble</span>
            </h1>
            <p class="text-xl md:text-2xl text-red-100 mb-8 max-w-3xl mx-auto leading-relaxed">
                Chaque don de sang peut sauver jusqu'à <span class="font-bold text-white">3 vies</span>. 
                Rejoignez notre communauté de héros du quotidien.
            </p>
            
            <div class="flex flex-wrap justify-center gap-4 mt-12">
                <a href="${pageContext.request.contextPath}/donneur?action=add" 
                   class="inline-flex items-center gap-3 px-8 py-4 bg-white text-red-600 font-bold rounded-xl hover:bg-red-50 hover:scale-105 transition-all duration-300 shadow-lg hover:shadow-xl">
                    <i class="fas fa-heart text-xl"></i>
                    Devenir Donneur
                </a>
                <a href="${pageContext.request.contextPath}/receveur?action=add" 
                   class="inline-flex items-center gap-3 px-8 py-4 border-2 border-white text-white font-bold rounded-xl hover:bg-white hover:text-red-600 hover:scale-105 transition-all duration-300">
                    <i class="fas fa-user-injured text-xl"></i>
                    Demander du Sang
                </a>
                <a href="${pageContext.request.contextPath}/donation?action=form" 
                   class="inline-flex items-center gap-3 px-8 py-4 border-2 border-white text-white font-bold rounded-xl hover:bg-white hover:text-red-600 hover:scale-105 transition-all duration-300">
                    <i class="fas fa-hand-holding-medical text-xl"></i>
                    Faire une Donation
                </a>
            </div>
            
            <div class="mt-12 text-red-100">
                <p class="text-lg">
                    <i class="fas fa-info-circle mr-2"></i>
                    Ensemble, faisons la différence dès aujourd'hui
                </p>
            </div>
        </div>
    </div>
</section>

<!-- Statistics Dashboard -->
<section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 -mt-12 relative z-10">
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 animate-slide-in-left">
        <!-- Total Donneurs -->
        <div class="bg-gradient-to-br from-red-500 to-red-600 text-white rounded-2xl p-6 shadow-xl hover:shadow-2xl transition-all duration-300 hover:scale-105 relative overflow-hidden">
            <div class="absolute top-0 right-0 w-20 h-20 bg-white opacity-10 rounded-full -mr-10 -mt-10"></div>
            <div class="relative text-center">
                <i class="fas fa-users text-4xl mb-4 opacity-90"></i>
                <h3 class="text-4xl font-bold mb-2">${fn:length(donneurs)}</h3>
                <p class="text-red-100 text-sm font-medium">Donneurs Inscrits</p>
            </div>
        </div>
        
        <!-- Total Receveurs -->
        <div class="bg-gradient-to-br from-blue-500 to-blue-600 text-white rounded-2xl p-6 shadow-xl hover:shadow-2xl transition-all duration-300 hover:scale-105 relative overflow-hidden">
            <div class="absolute top-0 right-0 w-20 h-20 bg-white opacity-10 rounded-full -mr-10 -mt-10"></div>
            <div class="relative text-center">
                <i class="fas fa-user-injured text-4xl mb-4 opacity-90"></i>
                <h3 class="text-4xl font-bold mb-2">${fn:length(receveurs)}</h3>
                <p class="text-blue-100 text-sm font-medium">Receveurs Inscrits</p>
            </div>
        </div>
        
        <!-- Donneurs Disponibles -->
        <div class="bg-gradient-to-br from-green-500 to-green-600 text-white rounded-2xl p-6 shadow-xl hover:shadow-2xl transition-all duration-300 hover:scale-105 relative overflow-hidden">
            <div class="absolute top-0 right-0 w-20 h-20 bg-white opacity-10 rounded-full -mr-10 -mt-10"></div>
            <div class="relative text-center">
                <i class="fas fa-heart text-4xl mb-4 opacity-90"></i>
                <h3 class="text-4xl font-bold mb-2">
                    <c:set var="donneursDisponibles" value="0" />
                    <c:forEach items="${donneurs}" var="d">
                        <c:if test="${d.disponibilite == 'DISPONIBLE'}">
                            <c:set var="donneursDisponibles" value="${donneursDisponibles + 1}" />
                        </c:if>
                    </c:forEach>
                    ${donneursDisponibles}
                </h3>
                <p class="text-green-100 text-sm font-medium">Donneurs Disponibles</p>
            </div>
        </div>
        
        <!-- Receveurs Urgents -->
        <div class="bg-gradient-to-br from-orange-500 to-orange-600 text-white rounded-2xl p-6 shadow-xl hover:shadow-2xl transition-all duration-300 hover:scale-105 relative overflow-hidden">
            <div class="absolute top-0 right-0 w-20 h-20 bg-white opacity-10 rounded-full -mr-10 -mt-10"></div>
            <div class="relative text-center">
                <i class="fas fa-exclamation-triangle text-4xl mb-4 opacity-90"></i>
                <h3 class="text-4xl font-bold mb-2">
                    <c:set var="receveursUrgents" value="0" />
                    <c:forEach items="${receveurs}" var="r">
                        <c:if test="${r.urgence == 'URGENT' or r.urgence == 'CRITIQUE'}">
                            <c:set var="receveursUrgents" value="${receveursUrgents + 1}" />
                        </c:if>
                    </c:forEach>
                    ${receveursUrgents}
                </h3>
                <p class="text-orange-100 text-sm font-medium">Cas Urgents</p>
            </div>
        </div>
    </div>
</section>

<!-- Main Dashboard Content -->
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
    <div class="grid grid-cols-1 xl:grid-cols-2 gap-12">
        <!-- Donneurs Section -->
        <section class="animate-fade-in-up">
            <div class="flex items-center justify-between mb-8">
                <div>
                    <h2 class="text-3xl font-bold text-gray-900 flex items-center gap-3">
                        <i class="fas fa-users text-red-600"></i>
                        Donneurs Récents
                    </h2>
                    <p class="text-gray-600 mt-2">Nos héros du don de sang</p>
                </div>
                <div class="flex gap-3">
                    <a href="${pageContext.request.contextPath}/donneur?action=list" 
                       class="inline-flex items-center gap-2 px-4 py-2 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition-colors">
                        <i class="fas fa-list"></i> Voir Tout
                    </a>
                    <a href="${pageContext.request.contextPath}/donneur?action=add" 
                       class="inline-flex items-center gap-2 px-4 py-2 bg-red-600 text-white font-medium rounded-lg hover:bg-red-700 transition-colors">
                        <i class="fas fa-plus"></i> Ajouter
                    </a>
                </div>
            </div>
            
            <div class="space-y-4">
                <c:choose>
                    <c:when test="${empty donneurs}">
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-8 text-center">
                            <i class="fas fa-users text-6xl text-gray-300 mb-4"></i>
                            <h3 class="text-xl font-semibold text-gray-700 mb-2">Aucun donneur inscrit</h3>
                            <p class="text-gray-500 mb-6">Commencez par ajouter le premier donneur à votre système.</p>
                            <a href="${pageContext.request.contextPath}/donneur?action=add" 
                               class="inline-flex items-center gap-2 px-6 py-3 bg-red-600 text-white font-medium rounded-lg hover:bg-red-700 transition-colors">
                                <i class="fas fa-plus"></i> Ajouter le premier donneur
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${donneurs}" var="d" end="4">
                            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 hover:shadow-md transition-all duration-300 hover:-translate-y-1">
                                <div class="flex items-start justify-between">
                                    <div class="flex items-center gap-4">
                                        <div class="w-12 h-12 bg-gradient-to-br from-red-500 to-red-600 text-white font-bold rounded-full flex items-center justify-center text-lg">
                                            ${fn:substring(d.nom, 0, 1)}${fn:substring(d.prenom, 0, 1)}
                                        </div>
                                        <div>
                                            <h3 class="font-semibold text-gray-900 text-lg">${d.nom} ${d.prenom}</h3>
                                            <p class="text-gray-600 flex items-center gap-1">
                                                <i class="fas fa-phone text-sm"></i> ${d.telephone}
                                            </p>
                                        </div>
                                    </div>
                                    <div class="text-right">
                                        <div class="inline-flex items-center justify-center w-10 h-10 bg-red-100 text-red-700 font-bold rounded-full border-2 border-red-300 mb-2">
                                            ${d.groupesanguin.label}
                                        </div>
                                        <br>
                                        <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium ${'DISPONIBLE' eq d.disponibilite ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'}">
                                            ${d.disponibilite}
                                        </span>
                                    </div>
                                </div>
                                <div class="mt-6 flex gap-3">
                                    <a href="${pageContext.request.contextPath}/donneur?action=details&id=${d.id}" 
                                       class="flex-1 inline-flex items-center justify-center gap-2 px-4 py-2 border border-gray-300 text-gray-700 font-medium rounded-lg hover:bg-gray-50 transition-colors">
                                        <i class="fas fa-eye"></i> Détails
                                    </a>
                                    <c:if test="${'DISPONIBLE' eq d.disponibilite}">
                                        <a href="${pageContext.request.contextPath}/donation?action=form&donneurId=${d.id}" 
                                           class="flex-1 inline-flex items-center justify-center gap-2 px-4 py-2 bg-red-600 text-white font-medium rounded-lg hover:bg-red-700 transition-colors">
                                            <i class="fas fa-hand-holding-medical"></i> Contacter
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
        
        <!-- Receveurs Section -->
        <section class="animate-fade-in-up">
            <div class="flex items-center justify-between mb-8">
                <div>
                    <h2 class="text-3xl font-bold text-gray-900 flex items-center gap-3">
                        <i class="fas fa-user-injured text-blue-600"></i>
                        Receveurs en Attente
                    </h2>
                    <p class="text-gray-600 mt-2">Personnes ayant besoin de sang</p>
                </div>
                <div class="flex gap-3">
                    <a href="${pageContext.request.contextPath}/?action=details" 
                       class="inline-flex items-center gap-2 px-4 py-2 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition-colors">
                        <i class="fas fa-list"></i> Voir Tout
                    </a>
                    <a href="${pageContext.request.contextPath}/receveur?action=add" 
                       class="inline-flex items-center gap-2 px-4 py-2 bg-red-600 text-white font-medium rounded-lg hover:bg-red-700 transition-colors">
                        <i class="fas fa-plus"></i> Ajouter
                    </a>
                </div>
            </div>
            
            <div class="space-y-4">
                <c:choose>
                    <c:when test="${empty receveurs}">
                        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-8 text-center">
                            <i class="fas fa-user-injured text-6xl text-gray-300 mb-4"></i>
                            <h3 class="text-xl font-semibold text-gray-700 mb-2">Aucun receveur inscrit</h3>
                            <p class="text-gray-500 mb-6">Ajoutez des receveurs qui ont besoin de sang.</p>
                            <a href="${pageContext.request.contextPath}/receveur?action=add" 
                               class="inline-flex items-center gap-2 px-6 py-3 bg-red-600 text-white font-medium rounded-lg hover:bg-red-700 transition-colors">
                                <i class="fas fa-plus"></i> Ajouter le premier receveur
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${receveurs}" var="r" end="4">
                            <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 hover:shadow-md transition-all duration-300 hover:-translate-y-1">
                                <div class="flex items-start justify-between">
                                    <div class="flex items-center gap-4">
                                        <div class="w-12 h-12 bg-gradient-to-br from-blue-500 to-blue-600 text-white font-bold rounded-full flex items-center justify-center text-lg">
                                            ${fn:substring(r.nom, 0, 1)}${fn:substring(r.prenom, 0, 1)}
                                        </div>
                                        <div>
                                            <h3 class="font-semibold text-gray-900 text-lg">${r.nom} ${r.prenom}</h3>
                                            <p class="text-gray-600 flex items-center gap-1">
                                                <i class="fas fa-phone text-sm"></i> ${r.telephone}
                                            </p>
                                        </div>
                                    </div>
                                    <div class="text-right">
                                        <div class="inline-flex items-center justify-center w-10 h-10 bg-red-100 text-red-700 font-bold rounded-full border-2 border-red-300 mb-2">
                                            ${r.groupesanguin.label}
                                        </div>
                                        <br>
                                        <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium ${'URGENT' eq r.urgence or 'CRITIQUE' eq r.urgence ? 'bg-yellow-100 text-yellow-800' : 'bg-green-100 text-green-800'}">
                                            ${r.urgence}
                                        </span>
                                    </div>
                                </div>
                                <div class="mt-6 flex gap-3">
                                    <a href="${pageContext.request.contextPath}/?action=details&id=${r.id}" 
                                       class="flex-1 inline-flex items-center justify-center gap-2 px-4 py-2 border border-gray-300 text-gray-700 font-medium rounded-lg hover:bg-gray-50 transition-colors">
                                        <i class="fas fa-eye"></i> Détails
                                    </a>
                                    <a href="${pageContext.request.contextPath}/donation?action=form&receveurId=${r.id}" 
                                       class="flex-1 inline-flex items-center justify-center gap-2 px-4 py-2 bg-red-600 text-white font-medium rounded-lg hover:bg-red-700 transition-colors">
                                        <i class="fas fa-hand-holding-medical"></i> Aider
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </div>
</div>

<!-- Call to Action Banner -->
<section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-16">
    <div class="bg-gradient-to-r from-red-600 via-red-700 to-red-800 text-white rounded-2xl shadow-2xl overflow-hidden">
        <div class="px-8 py-16 text-center relative">
            <div class="absolute inset-0 bg-black opacity-10"></div>
            <div class="relative z-10">
                <i class="fas fa-heartbeat text-6xl mb-8 opacity-90 animate-pulse-slow"></i>
                <h2 class="text-4xl md:text-5xl font-bold mb-6">Chaque don peut sauver des vies</h2>
                <p class="text-xl md:text-2xl text-red-100 mb-10 max-w-3xl mx-auto">Rejoignez notre communauté de héros et faites la différence dès aujourd'hui</p>
                <div class="flex flex-wrap justify-center gap-6">
                    <a href="${pageContext.request.contextPath}/donneur?action=add" 
                       class="inline-flex items-center gap-3 px-8 py-4 bg-white text-red-600 font-bold rounded-xl hover:bg-red-50 hover:scale-105 transition-all duration-300 shadow-lg">
                        <i class="fas fa-heart text-xl"></i>
                        Devenir Donneur
                    </a>
                    <a href="${pageContext.request.contextPath}/donation?action=form" 
                       class="inline-flex items-center gap-3 px-8 py-4 border-2 border-white text-white font-bold rounded-xl hover:bg-white hover:text-red-600 hover:scale-105 transition-all duration-300">
                        <i class="fas fa-hand-holding-medical text-xl"></i>
                        Faire une Donation
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gray-900 text-gray-300 mt-20">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            <div class="lg:col-span-1">
                <h3 class="flex items-center gap-2 text-xl font-bold text-white mb-6">
                    <i class="fas fa-heartbeat text-red-500"></i> Banque de Sang
                </h3>
                <p class="text-gray-400 mb-6 leading-relaxed">
                    Notre mission est de sauver des vies en connectant les donneurs généreux avec ceux qui ont besoin de sang. Ensemble, nous pouvons faire la différence.
                </p>
                <div class="flex gap-4">
                    <a href="#" class="w-10 h-10 bg-gray-800 hover:bg-red-600 text-gray-400 hover:text-white rounded-full flex items-center justify-center transition-all duration-300 hover:scale-110" title="Facebook">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="w-10 h-10 bg-gray-800 hover:bg-red-600 text-gray-400 hover:text-white rounded-full flex items-center justify-center transition-all duration-300 hover:scale-110" title="Twitter">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="w-10 h-10 bg-gray-800 hover:bg-red-600 text-gray-400 hover:text-white rounded-full flex items-center justify-center transition-all duration-300 hover:scale-110" title="Instagram">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="#" class="w-10 h-10 bg-gray-800 hover:bg-red-600 text-gray-400 hover:text-white rounded-full flex items-center justify-center transition-all duration-300 hover:scale-110" title="LinkedIn">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                </div>
            </div>
            
            <div>
                <h3 class="flex items-center gap-2 text-lg font-semibold text-white mb-6">
                    <i class="fas fa-link text-red-500"></i> Liens Rapides
                </h3>
                <ul class="space-y-3">
                    <li><a href="${pageContext.request.contextPath}/" class="flex items-center gap-2 text-gray-400 hover:text-red-400 transition-colors"><i class="fas fa-home w-4"></i> Accueil</a></li>
                    <li><a href="${pageContext.request.contextPath}/donneur?action=add" class="flex items-center gap-2 text-gray-400 hover:text-red-400 transition-colors"><i class="fas fa-user-plus w-4"></i> Devenir Donneur</a></li>
                    <li><a href="${pageContext.request.contextPath}/receveur?action=add" class="flex items-center gap-2 text-gray-400 hover:text-red-400 transition-colors"><i class="fas fa-user-injured w-4"></i> Demander du Sang</a></li>
                    <li><a href="${pageContext.request.contextPath}/donation?action=form" class="flex items-center gap-2 text-gray-400 hover:text-red-400 transition-colors"><i class="fas fa-hand-holding-medical w-4"></i> Faire une Donation</a></li>
                </ul>
            </div>
            
            <div>
                <h3 class="flex items-center gap-2 text-lg font-semibold text-white mb-6">
                    <i class="fas fa-info-circle text-red-500"></i> Information
                </h3>
                <ul class="space-y-3">
                    <li><a href="#" class="flex items-center gap-2 text-gray-400 hover:text-red-400 transition-colors"><i class="fas fa-question-circle w-4"></i> À propos</a></li>
                    <li><a href="#" class="flex items-center gap-2 text-gray-400 hover:text-red-400 transition-colors"><i class="fas fa-shield-alt w-4"></i> Conditions générales</a></li>
                    <li><a href="#" class="flex items-center gap-2 text-gray-400 hover:text-red-400 transition-colors"><i class="fas fa-user-secret w-4"></i> Politique de confidentialité</a></li>
                    <li><a href="#" class="flex items-center gap-2 text-gray-400 hover:text-red-400 transition-colors"><i class="fas fa-envelope w-4"></i> Contact</a></li>
                </ul>
            </div>
            
            <div>
                <h3 class="flex items-center gap-2 text-lg font-semibold text-white mb-6">
                    <i class="fas fa-phone text-red-500"></i> Contact
                </h3>
                <div class="space-y-4 text-gray-400">
                    <p class="flex items-start gap-3">
                        <i class="fas fa-map-marker-alt text-red-500 mt-1 flex-shrink-0"></i>
                        <span>123 Rue de la Santé<br>Casablanca, Maroc</span>
                    </p>
                    <p class="flex items-center gap-3">
                        <i class="fas fa-phone text-red-500 flex-shrink-0"></i>
                        <a href="tel:+212522xxxxxx" class="hover:text-red-400 transition-colors">+212 5 22 XX XX XX</a>
                    </p>
                    <p class="flex items-center gap-3">
                        <i class="fas fa-envelope text-red-500 flex-shrink-0"></i>
                        <a href="mailto:contact@banquedesang.ma" class="hover:text-red-400 transition-colors">contact@banquedesang.ma</a>
                    </p>
                    <p class="flex items-center gap-3">
                        <i class="fas fa-clock text-red-500 flex-shrink-0"></i>
                        <span class="text-green-400 font-medium">Urgences 24h/7j</span>
                    </p>
                </div>
            </div>
        </div>
        
        <div class="border-t border-gray-700 mt-12 pt-8 text-center text-gray-500">
            <p>&copy; 2025 Banque de Sang. Tous droits réservés. | Conçu avec <i class="fas fa-heart text-red-500 mx-1"></i> pour sauver des vies</p>
        </div>
    </div>
</footer>

<!-- JavaScript -->
<script>
    // Mobile menu toggle
    function toggleMobileMenu() {
        const mobileMenu = document.getElementById('mobileMenu');
        mobileMenu.classList.toggle('hidden');
    }
    
    // Enhanced interactions
    document.addEventListener('DOMContentLoaded', function() {
        // Animate statistics counters
        const statNumbers = document.querySelectorAll('.text-4xl');
        statNumbers.forEach((stat, index) => {
            if (stat.textContent.match(/^\d+$/)) {
                const finalNumber = parseInt(stat.textContent);
                let currentNumber = 0;
                const increment = Math.ceil(finalNumber / 50);
                
                setTimeout(() => {
                    const counter = setInterval(() => {
                        currentNumber += increment;
                        if (currentNumber >= finalNumber) {
                            stat.textContent = finalNumber;
                            clearInterval(counter);
                        } else {
                            stat.textContent = currentNumber;
                        }
                    }, 30);
                }, index * 200);
            }
        });
        
        // Add loading states to buttons
        document.querySelectorAll('a[href]:not([href="#"])').forEach(btn => {
            btn.addEventListener('click', function(e) {
                if (!this.href.includes('tel:') && !this.href.includes('mailto:')) {
                    const icon = this.querySelector('i:not(.fab)');
                    if (icon && !icon.classList.contains('fa-spinner')) {
                        const originalClasses = icon.className;
                        icon.className = 'fas fa-spinner fa-spin';
                        setTimeout(() => {
                            icon.className = originalClasses;
                        }, 1500);
                    }
                }
            });
        });
        
        // Add scroll animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);
        
        // Observe elements for scroll animations
        document.querySelectorAll('.animate-fade-in-up, .animate-slide-in-left').forEach(el => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(30px)';
            el.style.transition = 'opacity 0.6s ease-out, transform 0.6s ease-out';
            observer.observe(el);
        });
    });
</script>

</body>
</html>
