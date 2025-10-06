package org.medical.banquedesang.entities;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "donation")
public class Donation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDate dateDonation;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "donneur_id")
    private Donneur donneur;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "receveur_id")
    private Receveur receveur;

    public Donation() {
    }

    // Getters & Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDate getDateDonation() {
        return dateDonation;
    }

    public void setDateDonation(LocalDate dateDonation) {
        this.dateDonation = dateDonation;
    }

    public Donneur getDonneur() {
        return donneur;
    }

    public void setDonneur(Donneur donneur) {
        this.donneur = donneur;
    }

    public Receveur getReceveur() {
        return receveur;
    }

    public void setReceveur(Receveur receveur) {
        this.receveur = receveur;
    }

    @Override
    public String toString() {
        return "Donation{" +
                "id=" + id +
                ", dateDonation=" + dateDonation +
                ", donneurId=" + (donneur != null ? donneur.getId() : "null") +
                ", receveurId=" + (receveur != null ? receveur.getId() : "null") +
                '}';
    }
}
