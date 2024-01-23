/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.onesystem.services;

import com.onesystem.entidades.Medico;
import java.util.Collection;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 *
 * @author ADMIN
 */
public interface MedicoService {

    public List<Medico> findAll();

    public Optional<Medico> findAllById(String documento);

    public Medico add(Medico m);

    public Medico update(Medico m);

    public Medico delet(Medico m);
}
