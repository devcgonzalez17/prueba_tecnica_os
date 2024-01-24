/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.onesystem;

import com.onesystem.entidades.Cita;
import com.onesystem.services.CitaService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
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
}
