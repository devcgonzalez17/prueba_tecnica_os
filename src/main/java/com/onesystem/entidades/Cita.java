/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.onesystem.entidades;

import jakarta.persistence.Basic;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import java.io.Serializable;
import java.util.Date;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author ADMIN
 */
@Entity
@Table(name = "cita")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Cita.findAll", query = "SELECT c FROM Cita c"),
    @NamedQuery(name = "Cita.findByNumeroCita", query = "SELECT c FROM Cita c WHERE c.numeroCita = :numeroCita"),
    @NamedQuery(name = "Cita.findByFechaCita", query = "SELECT c FROM Cita c WHERE c.fechaCita = :fechaCita"),
    @NamedQuery(name = "Cita.findByHoraCita", query = "SELECT c FROM Cita c WHERE c.horaCita = :horaCita"),
    @NamedQuery(name = "Cita.findByObservaciones", query = "SELECT c FROM Cita c WHERE c.observaciones = :observaciones"),
    @NamedQuery(name = "Cita.findByEstado", query = "SELECT c FROM Cita c WHERE c.estado = :estado")})
public class Cita implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "numero_cita")
    private Integer numeroCita;
    @Basic(optional = false)
    @Column(name = "fecha_cita")
    @Temporal(TemporalType.DATE)
    private Date fechaCita;
    @Basic(optional = false)
    @Column(name = "hora_cita")
    @Temporal(TemporalType.TIMESTAMP)
    private Date horaCita;
    @Column(name = "observaciones")
    private String observaciones;
    @Column(name = "estado")
    private String estado;
    @JoinColumn(name = "documento_medico", referencedColumnName = "documento")
    @ManyToOne(optional = false)
    private Medico documentoMedico;
    @JoinColumn(name = "documento_paciente", referencedColumnName = "documento")
    @ManyToOne(optional = false)
    private Paciente documentoPaciente;

    public Cita() {
    }

    public Cita(Integer numeroCita) {
        this.numeroCita = numeroCita;
    }

    public Cita(Integer numeroCita, Date fechaCita, Date horaCita) {
        this.numeroCita = numeroCita;
        this.fechaCita = fechaCita;
        this.horaCita = horaCita;
    }

    public Integer getNumeroCita() {
        return numeroCita;
    }

    public void setNumeroCita(Integer numeroCita) {
        this.numeroCita = numeroCita;
    }

    public Date getFechaCita() {
        return fechaCita;
    }

    public void setFechaCita(Date fechaCita) {
        this.fechaCita = fechaCita;
    }

    public Date getHoraCita() {
        return horaCita;
    }

    public void setHoraCita(Date horaCita) {
        this.horaCita = horaCita;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Medico getDocumentoMedico() {
        return documentoMedico;
    }

    public void setDocumentoMedico(Medico documentoMedico) {
        this.documentoMedico = documentoMedico;
    }

    public Paciente getDocumentoPaciente() {
        return documentoPaciente;
    }

    public void setDocumentoPaciente(Paciente documentoPaciente) {
        this.documentoPaciente = documentoPaciente;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (numeroCita != null ? numeroCita.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Cita)) {
            return false;
        }
        Cita other = (Cita) object;
        if ((this.numeroCita == null && other.numeroCita != null) || (this.numeroCita != null && !this.numeroCita.equals(other.numeroCita))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.onesystem.entidades.Cita[ numeroCita=" + numeroCita + " ]";
    }
    
}
