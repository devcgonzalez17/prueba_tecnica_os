/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.onesystem.services;

import com.onesystem.entidades.Medico;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.onesystem.repositorios.MedicoRepositorio;

/**
 *
 * @author ADMIN
 */
@Service
public class MedicoServiceImpl implements MedicoService {

    @Autowired
    private MedicoRepositorio medRep;

    @Override
    public List<Medico> findAll() {
        return medRep.findAll();
    }

    @Override
    public Optional<Medico> findAllById(String documento) {
        return medRep.findById(documento);
    }

    @Override
    public Medico add(Medico m) {
        return medRep.save(m);
    }

    @Override
    public Medico update(Medico m) {
        Medico medico = medRep.getById(m.getDocumento());
        BeanUtils.copyProperties(m, medico);
        return medRep.save(medico);
    }

    @Override
    public Medico delet(Medico m) {
        Medico medico = medRep.getById(m.getDocumento());
        BeanUtils.copyProperties(m, medico);
        medRep.deleteById(m.getDocumento());
        return (m);
    }
    
    public Medico activar (String documento) {
        Medico medico = medRep.getById(documento);
        medico.setEstado("Activo");
        return medRep.save(medico);
    }
    
    public Medico desactivar (String documento) {
        Medico medico = medRep.getById(documento);
        medico.setEstado("Inactivo");
        return medRep.save(medico);
    }

}
