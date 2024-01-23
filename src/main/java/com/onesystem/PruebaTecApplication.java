package com.onesystem;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
/*@ComponentScan({"com.onesystem.entidades"})
@EntityScan("com.onesystem.entidades")
@EnableJpaRepositories("com.onesystem.repositorios")*/
public class PruebaTecApplication {

	public static void main(String[] args) {
		SpringApplication.run(PruebaTecApplication.class, args);
	}

}
