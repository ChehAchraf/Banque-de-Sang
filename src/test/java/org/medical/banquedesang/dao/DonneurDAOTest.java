package org.medical.banquedesang.dao;

import org.medical.banquedesang.entities.Donneur;
import org.medical.banquedesang.enums.Disponibilite;
import org.medical.banquedesang.enums.GroupeSanguin;
import org.medical.banquedesang.service.DonneurService;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class DonneurDAOTest {

    private Disponibilite dispo;
    private GroupeSanguin gp;
    @Mock
    private DonneurDAO donneurDAO;

    @InjectMocks
    private DonneurService donneurService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @AfterEach
    void tearDown() {
    }

    @Test
    void addDonneur() throws Exception {
        Donneur donneur = new Donneur();
        donneur.setId(1L);
        donneur.setNom("Test");
        donneur.setPrenom("Test");
        donneur.setCin("test");
        donneur.setPoids(100);
        donneur.setTelephone("test");
        donneur.setDateNaissance(LocalDate.now());
        donneur.setSexe("F");
        donneur.setGroupesanguin(GroupeSanguin.A_POS);
        donneur.setDisponibilite(Disponibilite.DISPONIBLE);
        donneur.setMaladie("test");
        doNothing().when(donneurDAO).addDonneur(donneur);
        donneurService.createDonneur(donneur);
        verify(donneurDAO, times(1)).addDonneur(donneur);
        
    }

    @Test
    void findById() {
        Donneur expectedDonneur = new Donneur();
        Donneur donneur = new Donneur();
        expectedDonneur.setId(1L);
        expectedDonneur.setNom("Donneur 1");
        expectedDonneur.setPrenom("Donneur 2");
        expectedDonneur.setCin("test");
        when(donneurDAO.findById(1L)).thenReturn(expectedDonneur);


        assertEquals(expectedDonneur, donneurService.findById(1L));
    }

    @Test
    void findAll() {
        List<Donneur> expectedDonneurs = new ArrayList<>();
        when(donneurDAO.findAll()).thenReturn(expectedDonneurs);

        List<Donneur> actualDonneurs = donneurService.findAll();
        assertEquals(expectedDonneurs, actualDonneurs);
    }

    @Test
    void update() throws Exception {
        Donneur updatedDonneur = new Donneur();
        updatedDonneur.setId(1L);
        updatedDonneur.setNom("Donneur 1 Updated");
        updatedDonneur.setPrenom("Donneur 2 Updated");
        updatedDonneur.setCin("test123");
        updatedDonneur.setPoids(70.5);
        updatedDonneur.setDateNaissance(LocalDate.now());
        updatedDonneur.setTelephone("test123");
        updatedDonneur.setDisponibilite(dispo.valueOf("DISPONIBLE"));
        updatedDonneur.setSexe("female");
        updatedDonneur.setGroupesanguin(gp.valueOf("O_NEG"));
        updatedDonneur.setMaladie("walo");

        doNothing().when(donneurDAO).update(updatedDonneur);
        donneurService.update(updatedDonneur);

        verify(donneurDAO, times(1)).update(updatedDonneur);
    }

    @Test
    void delete() {
        Donneur donneur = new Donneur();
        donneur.setId(1L);
        doNothing().when(donneurDAO).delete(donneur);
        donneurService.delete(donneur);
        verify(donneurDAO, times(1)).delete(donneur);
    }
}