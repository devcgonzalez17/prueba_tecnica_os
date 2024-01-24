/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.onesystem;

import com.onesystem.entidades.Paciente;
import com.onesystem.services.PacienteService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
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
}
