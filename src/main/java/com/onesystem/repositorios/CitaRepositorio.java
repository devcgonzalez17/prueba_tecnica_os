/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.onesystem.repositorios;

import com.onesystem.entidades.Cita;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 *
 * @author ADMIN
 */
public interface CitaRepositorio extends JpaRepository<Cita, String> {

    @Query(value = "SELECT * FROM cita c WHERE c.estado = 'Activo'", nativeQuery = true)
    public List<Cita> findActiveCitas();
}
