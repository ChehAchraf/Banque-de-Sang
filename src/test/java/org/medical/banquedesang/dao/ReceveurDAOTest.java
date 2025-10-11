package org.medical.banquedesang.dao;

import static org.junit.jupiter.api.Assertions.*;
import org.mockito.Mock;
import org.mockito.InjectMocks;
import org.medical.banquedesang.service.ReceveurService;
import org.junit.jupiter.api.BeforeEach;
import java.util.ArrayList;
import java.util.List;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import java.time.LocalDate;
import org.medical.banquedesang.enums.GroupeSanguin;
import org.medical.banquedesang.enums.Urgence;
import org.medical.banquedesang.entities.Receveur;
import static org.mockito.Mockito.*;

class ReceveurDAOTest {

    @Mock
    private ReceveurDAO receveurDAO;

    @InjectMocks
    private ReceveurService receveurService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @AfterEach
    void tearDown() {
    }

    @Test
    void addReceveur() throws Exception {
        Receveur receveur = new Receveur();
        receveur.setId(1L);
        receveur.setNom("Test");
        receveur.setPrenom("Test");
        receveur.setCin("test");
        receveur.setTelephone("test");
        receveur.setDateNaissance(LocalDate.now());
        receveur.setPoids(100);
        receveur.setSexe("F");
        receveur.setMaladie("test");
        receveur.setGroupesanguin(GroupeSanguin.A_POS);
        receveur.setUrgence(Urgence.NORMAL);
        doNothing().when(receveurDAO).addReceveur(receveur);
        receveurService.createReceveur(receveur);
        verify(receveurDAO, times(1)).addReceveur(receveur);
    }

    @Test
    void findById() {
        Receveur receveur = new Receveur();
        receveur.setId(1L);
        receveur.setNom("Test");
        receveur.setPrenom("Test");
        receveur.setCin("test");
        when(receveurDAO.findById(1L)).thenReturn(receveur);
        Receveur result = receveurService.findById(1L);
        assertEquals(receveur, result);
        verify(receveurDAO, times(1)).findById(1L);
    }

    @Test
    void findAll() {
        List<Receveur> receveurs = new ArrayList<>();
        Receveur receveur = new Receveur();
        receveurs.add(receveur);
        when(receveurDAO.findAll()).thenReturn(receveurs);
        List<Receveur> result = receveurService.findAll();
        assertEquals(receveurs, result);
        verify(receveurDAO, times(1)).findAll();
    }

    @Test
    void update() throws Exception {
        Receveur receveur = new Receveur();
        receveur.setId(1L);
        receveur.setNom("Test");
        receveur.setPrenom("Test");
        receveur.setCin("test");
        doNothing().when(receveurDAO).update(receveur);
        receveurService.update(receveur);
        verify(receveurDAO, times(1)).update(receveur); 
    }

    @Test
    void delete() {
        Receveur receveur = new Receveur();
        receveur.setId(1L);
        doNothing().when(receveurDAO).delete(receveur);
        receveurService.delete(receveur);
        verify(receveurDAO, times(1)).delete(receveur);
        
    }

    
}