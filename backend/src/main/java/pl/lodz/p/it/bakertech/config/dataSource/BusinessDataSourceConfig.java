package pl.lodz.p.it.bakertech.config.dataSource;

import jakarta.persistence.EntityManagerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.orm.jpa.EntityManagerFactoryBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

@Configuration
@EnableTransactionManagement
@EnableJpaRepositories(
        basePackages = {"pl.lodz.p.it.bakertech.service", "pl.lodz.p.it.bakertech.reports"},
        entityManagerFactoryRef = "businessEntityManagerFactory",
        transactionManagerRef = "businessTransactionManager"
)
public class BusinessDataSourceConfig {
    @Value("${bakertech.transaction.default-timeout}")
    private int txTimeout;

    @Bean(name = "businessProperties")
    @ConfigurationProperties("spring.datasource.business")
    public DataSourceProperties businessProperties() {
        return new DataSourceProperties();
    }

    @Bean(name = "businessDatasource")
    public DataSource businessDatasource(@Qualifier("businessProperties") DataSourceProperties properties) {
        return properties.initializeDataSourceBuilder().build();
    }

    @Bean(name = "businessEntityManagerFactory")
    public LocalContainerEntityManagerFactoryBean businessEntityManagerFactory(EntityManagerFactoryBuilder builder,
                                                                               @Qualifier("businessDatasource") DataSource dataSource) {
        return builder.dataSource(dataSource)
                .packages("pl.lodz.p.it.bakertech.model")
                .persistenceUnit("business")
                .build();
    }

    @Bean(name = "businessTransactionManager")
    public PlatformTransactionManager businessTransactionManager(@Qualifier("businessEntityManagerFactory") EntityManagerFactory entityManagerFactory) {
        JpaTransactionManager jpaTransactionManager = new JpaTransactionManager(entityManagerFactory);
        jpaTransactionManager.setDefaultTimeout(txTimeout);
        return jpaTransactionManager;
    }
}
