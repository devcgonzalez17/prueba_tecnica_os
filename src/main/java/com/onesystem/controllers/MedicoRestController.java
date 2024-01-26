/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.onesystem.controllers;

import com.onesystem.entidades.Medico;
import com.onesystem.services.MedicoService;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author ADMIN
 */
@RestController
@RequestMapping("/medico")
public class MedicoRestController {

    @Autowired
    private MedicoService medsvs;

    @GetMapping
    public List<Medico> findAll() {
        return medsvs.findAll();
    }

    @GetMapping("/{doc}")
    public Optional<Medico> findAllById(@PathVariable String doc) {
        return medsvs.findAllById(doc);
    }

    @GetMapping("/create")
    public String createRow() {
        return "{{\n"
                + "    \"documento\": \"123476\",\n"
                + "    \"nombre\": \"Andres\",\n"
                + "    \"apellidos\": \"Sanabria\",\n"
                + "    \"telefono\": 310000000,\n"
                + "    \"correoElectronico\": \"andres2@gmail.com\",\n"
                + "    \"estado\": \"Activo\"\n"
                + "}";
    }

    @PostMapping("/create")
    public Medico create(@RequestBody Medico m) {
        return medsvs.add(m);
    }

    @PutMapping("/update")
    public Medico update(@RequestBody Medico m) {
        return medsvs.update(m);
    }
}
