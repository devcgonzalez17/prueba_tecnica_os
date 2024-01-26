/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.onesystem.services;

import com.onesystem.entidades.Cita;
import com.onesystem.repositorios.CitaRepositorio;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CitaServiceImpl implements CitaService {

    @Autowired
    private CitaRepositorio citaRepo;

    @Override
    public List<Cita> findAll() {
        return citaRepo.findAll();
    }

    @Override
    public Optional<Cita> findAllById(Integer numero_cita) {
        return citaRepo.findById(numero_cita.toString());
    }

    @Override
    public Cita add(Cita m) {
            return citaRepo.save(m);
    }

    @Override
    public Cita update(Cita m) {
        Cita cita = citaRepo.getById(m.getNumeroCita().toString());
        BeanUtils.copyProperties(m, cita);
        return citaRepo.save(cita);
    }

    @Override
    public Cita delet(Cita m) {
        Cita cita = citaRepo.getById(m.getNumeroCita().toString());
        BeanUtils.copyProperties(m, cita);
        citaRepo.deleteById(m.getNumeroCita().toString());
        return (m);
    }

    @Override
    public List<Cita> findActivas() {
        return citaRepo.findActiveCitas();
    }

}
