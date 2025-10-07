package org.medical.banquedesang.service;

import java.util.List;

import org.medical.banquedesang.dao.ReceveurDAO;
import org.medical.banquedesang.entities.Receveur;
import org.medical.banquedesang.validation.ReceveurValidation;

public class ReceveurService {
    private final ReceveurDAO receveurDAO;

    public ReceveurService(ReceveurDAO receveurDAO) {
        this.receveurDAO = receveurDAO;
    }

    public void createReceveur(Receveur receveur) throws Exception {
        ReceveurValidation.validate(receveur);
        receveurDAO.addReceveur(receveur);
    }

    public List<Receveur> findAll() {
        return receveurDAO.findAll();
    }

    public Receveur findById(Long id) {
        return receveurDAO.findById(id);
    }

    public void update(Receveur receveur) throws Exception {
        ReceveurValidation.validate(receveur);
        receveurDAO.update(receveur);
    }

    public void delete(Receveur receveur) {
        receveurDAO.delete(receveur);
    }
}


