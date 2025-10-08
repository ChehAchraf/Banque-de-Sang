package org.medical.banquedesang.enums;

public enum Urgence {

    CRITIQUE(4, "Critique - 4 poches requises"),
    URGENT(3, "Urgent - 3 poches requises"), 
    NORMAL(1, "Normal - 1 poche requise");

    private final int pochesRequises;
    private final String description;

    Urgence(int pochesRequises, String description) {
        this.pochesRequises = pochesRequises;
        this.description = description;
    }

    public int getPochesRequises() {
        return pochesRequises;
    }

    public String getDescription() {
        return description;
    }

    public int getPriorite() {
        switch (this) {
            case CRITIQUE: return 3;
            case URGENT: return 2;
            case NORMAL: return 1;
            default: return 0;
        }
    }

}
