/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.onesystem.services;

import com.onesystem.entidades.Paciente;
import java.util.List;
import java.util.Optional;

/**
 *
 * @author ADMIN
 */
public interface PacienteService {

    public List<Paciente> findAll();

    public Optional<Paciente> findAllById(String documento);

    public Paciente add(Paciente m);

    public Paciente update(Paciente m);

    public Paciente delet(Paciente m);
}
