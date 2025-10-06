package org.medical.banquedesang.entities;

import jakarta.persistence.*;

@Entity
@Table(name="donneur")

public class Donneur extends Account{
    @ManyToOne(fetch=FetchType.LAZY, optional=true)
    @JoinColumn(name = "receveur_id")
    private Receveur receveur;

    public Donneur(){

    }

    public Receveur getReceveur() {
        return receveur;
    }

    public void setReceveur(Receveur receveur) {
        this.receveur = receveur;
    }

    @Override
    public String toString() {
        return "Donneur{" +
                "id=" + getId() +
                ", nom=" + getNom() +
                ", prenom=" + getPrenom() +
                ", receveur=" + (receveur != null ? receveur.getId() : "null") +
                '}';
    }
}
