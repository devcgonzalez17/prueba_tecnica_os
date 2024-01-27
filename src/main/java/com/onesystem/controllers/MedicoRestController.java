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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
    public ResponseEntity<?> findAll() {
        try {
            List<Medico> response = medsvs.findAll();
            if (response != null) {
                return new ResponseEntity<>(response, HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
    }

    @GetMapping("/{doc}")
    public ResponseEntity<?> findAllById(@PathVariable String doc) {
        try {
            Optional<Medico> response = medsvs.findAllById(doc);
            if (response != null) {
                return new ResponseEntity<>(response, HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);

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
    public ResponseEntity<?> create(@RequestBody Medico m) {
        try {
            Medico response = medsvs.add(m);
            if (response != null) {
                return new ResponseEntity<>("Agregado correctamente", HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
    }

    @PutMapping("/update")
    public ResponseEntity<?> update(@RequestBody Medico m) {
        try {
            Medico response = medsvs.update(m);
            if (response != null) {
                return new ResponseEntity<>("Agregado correctamente", HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);

    }
}
