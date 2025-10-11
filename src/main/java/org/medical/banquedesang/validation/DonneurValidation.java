package org.medical.banquedesang.validation;

import org.medical.banquedesang.entities.Donneur;

public class DonneurValidation {

    public static void Validate(Donneur donneur) throws Exception {
        if(donneur.getNom() == null || "".equals(donneur.getNom())) throw new Exception("Nom obligatoire");
        if(donneur.getPrenom() == null || "".equals(donneur.getPrenom())) throw new Exception("Prenom obligatoire");
        // type casting bach ntchecki
        double poids = donneur.getPoids();
        if(poids <= 0) throw new Exception("Poids obligatoire");
        if(donneur.getDateNaissance() == null) throw new Exception("Date de naissance obligatoire");
        if(donneur.getCin() == null || "".equals(donneur.getCin())) throw new Exception("CIN obligatoire");
        // Email validation removed as it's not in the form
        if(donneur.getTelephone() == null || "".equals(donneur.getTelephone())) throw new Exception("Telephone obligatoire");
        if(donneur.getSexe() == null || "".equals(donneur.getSexe())) throw new Exception("Sexe obligatoire");
        if(donneur.getGroupesanguin() == null) throw new Exception("Groupe sanguin obligatoire");
        if(donneur.getDisponibilite() == null) throw new Exception("Disponibilite obligatoire");
        if(donneur.getMaladie() == null || "".equals(donneur.getMaladie())) throw new Exception("Maladie obligatoire");
        // Receveur is optional for donors
    }

}
