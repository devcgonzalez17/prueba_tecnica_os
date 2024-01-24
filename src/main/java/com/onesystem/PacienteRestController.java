/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.onesystem;

import com.onesystem.entidades.Medico;
import com.onesystem.entidades.Paciente;
import com.onesystem.services.PacienteService;
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

@RestController
@RequestMapping("/paciente")
public class PacienteRestController {

    @Autowired
    private PacienteService pacientesvs;

    @GetMapping
    public List<Paciente> findAll() {
        return pacientesvs.findAll();
    }

    @GetMapping("/{doc}")
    public Optional<Paciente> findAllById(@PathVariable String doc) {
        return pacientesvs.findAllById(doc);
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
    public Paciente create(@RequestBody Paciente m) {
        return pacientesvs.add(m);
    }

    @PutMapping("/update")
    public Paciente update(@RequestBody Paciente m) {
        return pacientesvs.update(m);
    }
}
