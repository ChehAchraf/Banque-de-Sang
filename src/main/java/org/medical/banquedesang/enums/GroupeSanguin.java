package org.medical.banquedesang.enums;

public enum GroupeSanguin {
    O_NEG("O-"),
    O_POS("O+"),
    A_NEG("A-"),
    A_POS("A+"),
    B_NEG("B-"),
    B_POS("B+"),
    AB_NEG("AB-"),
    AB_POS("AB+");

    private final String label;

    GroupeSanguin(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}
