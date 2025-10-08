package org.medical.banquedesang.enums;

public enum EtatReceveur {
    EN_ATTENTE("En attente", "Le receveur attend d'être associé à des donneurs"),
    SATISFAIT("Satisfait", "Le receveur a le nombre requis de donneurs associés");

    private final String label;
    private final String description;

    EtatReceveur(String label, String description) {
        this.label = label;
        this.description = description;
    }

    public String getLabel() {
        return label;
    }

    public String getDescription() {
        return description;
    }
}