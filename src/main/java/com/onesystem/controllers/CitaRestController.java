/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.onesystem.controllers;

import com.onesystem.entidades.Cita;
import com.onesystem.entidades.Paciente;
import com.onesystem.services.CitaService;
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
@RequestMapping("/citas")
public class CitaRestController {

    @Autowired
    private CitaService citasvs;

    @GetMapping("/all")
    public ResponseEntity<?> findAll() {
        try {
            List<Cita> response = citasvs.findAll();
            if (response != null) {
                return new ResponseEntity<>(response, HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
    }

    @GetMapping("/activas")
    public ResponseEntity<?> findActivas() {
        try {
            List<Cita> response = citasvs.findActivas();
            if (response != null) {
                return new ResponseEntity<>(response, HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);

    }

    @GetMapping("/{num_cita}")
    public ResponseEntity<?> findAllById(@PathVariable Integer num_cita) {
        try {
            Optional<Cita> response = citasvs.findAllById(num_cita);
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
        return "{\n"
                + "    \"documento\": \"123456\",\n"
                + "    \"nombre\": \"Augusto\",\n"
                + "    \"apellidos\": \"Herrera\",\n"
                + "    \"fechaDeNacimiento\": \"1999-04-12\",\n"
                + "    \"direccion\": \"Cr 4 # 12-34\",\n"
                + "    \"telefono\": 31020020,\n"
                + "    \"correoElectronico\": \"august@hotmail.com\",\n"
                + "    \"estado\": \"Retirado\"\n"
                + "}";
    }

    @PostMapping("/create")
    public ResponseEntity<?> create(@RequestBody Cita m) {
        try {
            Cita response = citasvs.add(m);
            if (response != null) {
                return new ResponseEntity<>("Agregado correctamente", HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
    }

    @PutMapping("/update")
    public ResponseEntity<?> update(@RequestBody Cita m) {
        try {
            Cita response = citasvs.update(m);
            if (response != null) {
                return new ResponseEntity<>("Actualizado correctamente", HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
    }
}
