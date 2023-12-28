package pl.lodz.p.it.bakertech;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class BakerTechApplication {
	public static void main(String[] args) {
		SpringApplication.run(BakerTechApplication.class, args);
	}
}
