package org.medical.banquedesang.validation;

import org.medical.banquedesang.entities.Receveur;

public class ReceveurValidation {
    public static void validate(Receveur receveur) throws Exception {
        if (receveur.getNom() == null || receveur.getNom().isEmpty()) {
            throw new Exception("Le nom est requis");
        }
        if (receveur.getPrenom() == null || receveur.getPrenom().isEmpty()) {
            throw new Exception("Le prénom est requis");
        }
        if (receveur.getCin() == null || receveur.getCin().isEmpty()) {
            throw new Exception("Le CIN est requis");
        }
        if (receveur.getTelephone() == null || receveur.getTelephone().isEmpty()) {
            throw new Exception("Le téléphone est requis");
        }
        if (receveur.getDateNaissance() == null) {
            throw new Exception("La date de naissance est requise");
        }
        double poids = receveur.getPoids();
        if (poids <= 0) {
            throw new Exception("Le poids est requis");
        }
        if (receveur.getSexe() == null || receveur.getSexe().isEmpty()) {
            throw new Exception("Le sexe est requis");
        }
        if (receveur.getMaladie() == null || receveur.getMaladie().isEmpty()) {
            throw new Exception("La maladie est requise");
        }
        if (receveur.getDisponibilite() == null) {
            throw new Exception("La disponibilité est requise");
        }
        if (receveur.getGroupesanguin() == null) {
            throw new Exception("Le groupe sanguin est requise");
        }
        
    }
}
