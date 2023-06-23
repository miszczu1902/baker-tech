package pl.p.lodz.it.baker.tech.bakertech;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.test.context.TestConfiguration;

@TestConfiguration(proxyBeanMethods = false)
public class TestBakertechApplication {

	public static void main(String[] args) {
		SpringApplication.from(BakertechApplication::main).with(TestBakertechApplication.class).run(args);
	}

}
