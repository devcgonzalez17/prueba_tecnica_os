/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.onesystem.services;

import com.onesystem.entidades.Cita;
import java.util.List;
import java.util.Optional;

/**
 *
 * @author ADMIN
 */
public interface CitaService {

    public List<Cita> findAll();

    public Optional<Cita> findAllById(Integer numero_cita);

    public Cita add(Cita m);

    public Cita update(Cita m);

    public Cita delet(Cita m);
}
