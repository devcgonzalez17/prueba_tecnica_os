/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.onesystem;

import com.onesystem.entidades.Cita;
import com.onesystem.entidades.Paciente;
import com.onesystem.services.CitaService;
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
@RequestMapping("/citas")
public class CitaRestController {

    @Autowired
    private CitaService citasvs;

    @GetMapping("/all")
    public List<Cita> findAll() {
        return citasvs.findAll();
    }

    @GetMapping("/activas")
    public List<Cita> findActivas() {
        return citasvs.findActivas();
    }

    @GetMapping("/{num_cita}")
    public Optional<Cita> findAllById(@PathVariable Integer num_cita) {
        return citasvs.findAllById(num_cita);
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
    public Cita create(@RequestBody Cita m) {
        return citasvs.add(m);
    }

    @PutMapping("/update")
    public Cita update(@RequestBody Cita m) {
        return citasvs.update(m);
    }
}
