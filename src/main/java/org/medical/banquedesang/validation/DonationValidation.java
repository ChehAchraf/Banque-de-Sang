package org.medical.banquedesang.validation;

import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.entities.Receveur;

public class DonationValidation {
    public static void validate(Donneur donneur, Receveur receveur) {
        if (donneur == null || donneur.getId() == null) {
            throw new IllegalArgumentException("Donneur invalide");
        }
        if (receveur == null || receveur.getId() == null) {
            throw new IllegalArgumentException("Receveur invalide");
        }
        if (donneur.getGroupesanguin() == null) {
            throw new IllegalArgumentException("Groupe sanguin du donneur manquant");
        }
        if (receveur.getGroupesanguin() == null) {
            throw new IllegalArgumentException("Groupe sanguin du receveur manquant");
        }
    }
}