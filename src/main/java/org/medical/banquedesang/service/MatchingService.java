package org.medical.banquedesang.service;

import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.enums.Disponibilite;
import org.medical.banquedesang.enums.EtatReceveur;
import java.util.logging.Logger;


public class MatchingService {
    
    private static final Logger logger = Logger.getLogger(MatchingService.class.getName());
    
    private final BloodCompatibilityService compatibilityService;
    private final DonneurService donneurService;
    private final ReceveurService receveurService;
    
    public MatchingService(DonneurService donneurService, ReceveurService receveurService) {
        this.donneurService = donneurService;
        this.receveurService = receveurService;
        this.compatibilityService = new BloodCompatibilityService();
    }
    

    public boolean associateDonneurWithReceveur(Donneur donneur, Receveur receveur) throws Exception {
        
        if (donneur == null || receveur == null) {
            throw new IllegalArgumentException("Donneur et receveur ne peuvent pas être null");
        }
        
        if (!compatibilityService.isDonneurEligible(donneur)) {
            throw new IllegalStateException("Le donneur n'est pas éligible pour le don");
        }
        
        if (donneur.getDisponibilite() != Disponibilite.DISPONIBLE) {
            throw new IllegalStateException("Le donneur n'est pas disponible");
        }
        
        if (donneur.getReceveur() != null) {
            throw new IllegalStateException("Le donneur est déjà associé à un autre receveur");
        }
        
        if (!compatibilityService.isBloodTypeCompatible(donneur, receveur)) {
            throw new IllegalStateException("Incompatibilité sanguine entre le donneur et le receveur");
        }
        
        if (!compatibilityService.canReceiveMoreDonors(receveur)) {
            throw new IllegalStateException("Le receveur a déjà le nombre requis de donneurs");
        }
        
        if (receveur.getEtatReceveur() == EtatReceveur.SATISFAIT) {
            throw new IllegalStateException("Le receveur est déjà satisfait");
        }
        

        donneur.setReceveur(receveur);
        receveur.addDonneur(donneur);
        

        donneur.setDisponibilite(Disponibilite.NON_DISPONIBLE);
        

        receveur.setEtatReceveur(compatibilityService.calculateEtatReceveur(receveur));
        
        // Save changes
        donneurService.update(donneur);
        receveurService.update(receveur);
        
        logger.info(String.format("Association réussie: Donneur %s %s (%s) -> Receveur %s %s (%s)", 
            donneur.getPrenom(), donneur.getNom(), donneur.getGroupesanguin().getLabel(),
            receveur.getPrenom(), receveur.getNom(), receveur.getGroupesanguin().getLabel()));
        
        return true;
    }
    

    public boolean dissociateDonneur(Donneur donneur) throws Exception {
        
        if (donneur == null) {
            throw new IllegalArgumentException("Donneur ne peut pas être null");
        }
        
        Receveur receveur = donneur.getReceveur();
        if (receveur == null) {
            throw new IllegalStateException("Le donneur n'est associé à aucun receveur");
        }
        

        donneur.setReceveur(null);
        receveur.removeDonneur(donneur);
        

        donneur.setDisponibilite(compatibilityService.calculateDonneurDisponibilite(donneur));
        
        receveur.setEtatReceveur(compatibilityService.calculateEtatReceveur(receveur));
        
        donneurService.update(donneur);
        receveurService.update(receveur);
        
        logger.info(String.format("Dissociation réussie: Donneur %s %s libéré du receveur %s %s", 
            donneur.getPrenom(), donneur.getNom(),
            receveur.getPrenom(), receveur.getNom()));
        
        return true;
    }
    

    public boolean canAssociate(Donneur donneur, Receveur receveur) {
        try {
            // Basic null checks
            if (donneur == null || receveur == null) {
                return false;
            }
            

            if (!compatibilityService.isDonneurEligible(donneur) || 
                donneur.getDisponibilite() != Disponibilite.DISPONIBLE ||
                donneur.getReceveur() != null) {
                return false;
            }
            
            return compatibilityService.isBloodTypeCompatible(donneur, receveur) &&
                   compatibilityService.canReceiveMoreDonors(receveur) &&
                   receveur.getEtatReceveur() != EtatReceveur.SATISFAIT;
                   
        } catch (Exception e) {
            logger.warning("Erreur lors de la vérification d'association: " + e.getMessage());
            return false;
        }
    }
    

    public String getCompatibilitySummary(Donneur donneur, Receveur receveur) {
        if (donneur == null || receveur == null) {
            return "Données manquantes";
        }
        
        if (!compatibilityService.isBloodTypeCompatible(donneur, receveur)) {
            return "Incompatibilité sanguine";
        }
        
        if (!compatibilityService.isDonneurEligible(donneur)) {
            return "Donneur non éligible";
        }
        
        if (donneur.getDisponibilite() != Disponibilite.DISPONIBLE) {
            return "Donneur non disponible";
        }
        
        if (!compatibilityService.canReceiveMoreDonors(receveur)) {
            return "Receveur complet";
        }
        
        if (canAssociate(donneur, receveur)) {
            return "Compatible - Association possible";
        }
        
        return "Non compatible";
    }
}