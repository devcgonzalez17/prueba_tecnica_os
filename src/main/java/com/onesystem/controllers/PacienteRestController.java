/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.onesystem.controllers;

import com.onesystem.entidades.Paciente;
import com.onesystem.services.PacienteService;
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

@RestController
@RequestMapping("/paciente")
public class PacienteRestController {

    @Autowired
    private PacienteService pacientesvs;

    @GetMapping
    public ResponseEntity<?> findAll() {
        try {
            List<Paciente> response = pacientesvs.findAll();
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
            Optional<Paciente> response = pacientesvs.findAllById(doc);
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
                + "    \"nombre\": \"Andrea\",\n"
                + "    \"apellidos\": \"Fonseca\",\n"
                + "    \"fechaDeNacimiento\": \"1995-01-04\",\n"
                + "    \"direccion\": \"Cr 4 # 12-34\",\n"
                + "    \"telefono\": 31020234,\n"
                + "    \"correoElectronico\": \"andrefo@terra.com\",\n"
                + "    \"estado\": \"Activo\"\n"
                + "}";
    }

    @PostMapping("/create")
    public ResponseEntity<?> create(@RequestBody Paciente m) {
        try {
            Paciente response = pacientesvs.add(m);
            if (response != null) {
                return new ResponseEntity<>("Agregado correctamente", HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
    }

    @PutMapping("/update")
    public ResponseEntity<?> update(@RequestBody Paciente m) {
        try {
            Paciente response = pacientesvs.update(m);
            if (response != null) {
                return new ResponseEntity<>("Agregado correctamente", HttpStatus.OK);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);

    }
}
