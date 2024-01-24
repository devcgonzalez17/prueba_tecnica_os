/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.onesystem.services;

import com.onesystem.entidades.Paciente;
import com.onesystem.repositorios.PacienteRepositorio;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author ADMIN
 */
@Service
public class PacienteServiceImpl implements PacienteService {

    @Autowired
    private PacienteRepositorio pacRepo;

    @Override
    public List<Paciente> findAll() {
        return pacRepo.findAll();
    }

    @Override
    public Optional<Paciente> findAllById(String documento) {
        return pacRepo.findById(documento);
    }

    @Override
    public Paciente add(Paciente m) {
        return pacRepo.save(m);
    }

    @Override
    public Paciente update(Paciente m) {
        Paciente paciente = pacRepo.getById(m.getDocumento());
        BeanUtils.copyProperties(m, paciente);
        return pacRepo.save(paciente);
    }

    @Override
    public Paciente delet(Paciente m) {
        Paciente paciente = pacRepo.getById(m.getDocumento());
        BeanUtils.copyProperties(m, paciente);
        pacRepo.deleteById(m.getDocumento());
        return (m);
    }

    public Paciente activar(String documento) {
        Paciente paciente = pacRepo.getById(documento);
        paciente.setEstado("Activo");
        return pacRepo.save(paciente);
    }

    public Paciente desactivar(String documento) {
        Paciente paciente = pacRepo.getById(documento);
        paciente.setEstado("Inactivo");
        return pacRepo.save(paciente);
    }

}
