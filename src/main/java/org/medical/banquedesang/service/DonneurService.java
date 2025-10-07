package org.medical.banquedesang.service;

import java.util.List;

import org.medical.banquedesang.dao.DonneurDAO;
import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.validation.DonneurValidation;

public class DonneurService {
    private DonneurDAO donneurDAO;

    public DonneurService() {
        this.donneurDAO = new DonneurDAO();
    }

    public void createDonneur(Donneur donneur) throws Exception {
        DonneurValidation.Validate(donneur);
        donneurDAO.addDonneur(donneur);
    }

    public List<Donneur> findAllDonneurs() {
        return donneurDAO.findAll();
    }

    public Donneur findDonneurById(Long id) {
        return donneurDAO.findById(id);
    }

    public void updateDonneur(Donneur donneur) throws Exception {
        DonneurValidation.Validate(donneur);
        donneurDAO.update(donneur);
    }

    public void deleteDonneur(Donneur donneur) {
        donneurDAO.delete(donneur);
    }
}
