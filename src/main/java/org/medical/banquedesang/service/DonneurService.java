package org.medical.banquedesang.service;

import java.util.List;

import org.medical.banquedesang.dao.DonneurDAO;
import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.validation.DonneurValidation;

public class DonneurService {
    private DonneurDAO donneurDAO;

    public DonneurService(DonneurDAO donneurDAO) {
        this.donneurDAO = donneurDAO;
    }

    public void createDonneur(Donneur donneur) throws Exception {
        DonneurValidation.Validate(donneur);
        donneurDAO.addDonneur(donneur);
    }

    public List<Donneur> findAllDonneurs() {
        return donneurDAO.findAllDonneurs();
    }

    public Donneur findDonneurById(Long id) {
        return donneurDAO.findDonneurById(id);
    }

    public void updateDonneur(Donneur donneur) throws Exception {
        DonneurValidation.Validate(donneur);
        donneurDAO.updateDonneur(donneur);
    }

    public void deleteDonneur(Donneur donneur) {
        donneurDAO.deleteDonneur(donneur);
    }
}
