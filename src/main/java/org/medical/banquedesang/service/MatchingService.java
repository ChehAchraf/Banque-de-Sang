package org.medical.banquedesang.service;

import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.enums.Disponibilite;
import org.medical.banquedesang.enums.EtatReceveur;
import java.util.logging.Logger;

/**
 * Service responsible for matching donors with receivers.
 * Follows Single Responsibility Principle - handles only matching logic.
 */
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
    
    /**
     * Associate a donor with a receiver if they are compatible
     * 
     * @param donneur The donor to associate
     * @param receveur The receiver to associate with
     * @return true if association was successful, false otherwise
     * @throws Exception if validation fails or business rules are violated
     */
    public boolean associateDonneurWithReceveur(Donneur donneur, Receveur receveur) throws Exception {
        
        // Validate inputs
        if (donneur == null || receveur == null) {
            throw new IllegalArgumentException("Donneur et receveur ne peuvent pas être null");
        }
        
        // Check if donor is eligible
        if (!compatibilityService.isDonneurEligible(donneur)) {
            throw new IllegalStateException("Le donneur n'est pas éligible pour le don");
        }
        
        // Check if donor is available
        if (donneur.getDisponibilite() != Disponibilite.DISPONIBLE) {
            throw new IllegalStateException("Le donneur n'est pas disponible");
        }
        
        // Check if donor is already associated
        if (donneur.getReceveur() != null) {
            throw new IllegalStateException("Le donneur est déjà associé à un autre receveur");
        }
        
        // Check blood type compatibility
        if (!compatibilityService.isBloodTypeCompatible(donneur, receveur)) {
            throw new IllegalStateException("Incompatibilité sanguine entre le donneur et le receveur");
        }
        
        // Check if receiver can receive more donors
        if (!compatibilityService.canReceiveMoreDonors(receveur)) {
            throw new IllegalStateException("Le receveur a déjà le nombre requis de donneurs");
        }
        
        // Check if receiver is satisfied
        if (receveur.getEtatReceveur() == EtatReceveur.SATISFAIT) {
            throw new IllegalStateException("Le receveur est déjà satisfait");
        }
        
        // Perform the association
        donneur.setReceveur(receveur);
        receveur.addDonneur(donneur);
        
        // Update donor status - becomes NON_DISPONIBLE after association
        donneur.setDisponibilite(Disponibilite.NON_DISPONIBLE);
        
        // Update receiver status based on current donors
        receveur.setEtatReceveur(compatibilityService.calculateEtatReceveur(receveur));
        
        // Save changes
        donneurService.update(donneur);
        receveurService.update(receveur);
        
        logger.info(String.format("Association réussie: Donneur %s %s (%s) -> Receveur %s %s (%s)", 
            donneur.getPrenom(), donneur.getNom(), donneur.getGroupesanguin().getLabel(),
            receveur.getPrenom(), receveur.getNom(), receveur.getGroupesanguin().getLabel()));
        
        return true;
    }
    
    /**
     * Remove association between a donor and receiver
     * 
     * @param donneur The donor to dissociate
     * @return true if dissociation was successful
     * @throws Exception if validation fails
     */
    public boolean dissociateDonneur(Donneur donneur) throws Exception {
        
        if (donneur == null) {
            throw new IllegalArgumentException("Donneur ne peut pas être null");
        }
        
        Receveur receveur = donneur.getReceveur();
        if (receveur == null) {
            throw new IllegalStateException("Le donneur n'est associé à aucun receveur");
        }
        
        // Remove the association
        donneur.setReceveur(null);
        receveur.removeDonneur(donneur);
        
        // Recalculate donor availability (might become DISPONIBLE again if eligible)
        donneur.setDisponibilite(compatibilityService.calculateDonneurDisponibilite(donneur));
        
        // Recalculate receiver status
        receveur.setEtatReceveur(compatibilityService.calculateEtatReceveur(receveur));
        
        // Save changes
        donneurService.update(donneur);
        receveurService.update(receveur);
        
        logger.info(String.format("Dissociation réussie: Donneur %s %s libéré du receveur %s %s", 
            donneur.getPrenom(), donneur.getNom(),
            receveur.getPrenom(), receveur.getNom()));
        
        return true;
    }
    
    /**
     * Check if a donor and receiver can be associated
     */
    public boolean canAssociate(Donneur donneur, Receveur receveur) {
        try {
            // Basic null checks
            if (donneur == null || receveur == null) {
                return false;
            }
            
            // Check eligibility and availability
            if (!compatibilityService.isDonneurEligible(donneur) || 
                donneur.getDisponibilite() != Disponibilite.DISPONIBLE ||
                donneur.getReceveur() != null) {
                return false;
            }
            
            // Check compatibility and receiver capacity
            return compatibilityService.isBloodTypeCompatible(donneur, receveur) &&
                   compatibilityService.canReceiveMoreDonors(receveur) &&
                   receveur.getEtatReceveur() != EtatReceveur.SATISFAIT;
                   
        } catch (Exception e) {
            logger.warning("Erreur lors de la vérification d'association: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Get compatibility summary for a donor-receiver pair
     */
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