package pl.lodz.p.it.bakertech.config.dataSource;

import jakarta.persistence.EntityManagerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.orm.jpa.EntityManagerFactoryBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

@Configuration
@EnableTransactionManagement
@EnableJpaRepositories(
        basePackages = {"pl.lodz.p.it.bakertech.accounts"},
        entityManagerFactoryRef = "accountsEntityManagerFactory",
        transactionManagerRef = "accountsTransactionManager"
)
public class AccountsDataSourceConfig {
    @Primary
    @Bean(name = "accountsProperties")
    @ConfigurationProperties("spring.datasource.accounts")
    public DataSourceProperties accountsProperties() {
        return new DataSourceProperties();
    }

    @Primary
    @Bean(name = "accountsDatasource")
    public DataSource accountsDatasource(@Qualifier("accountsProperties") DataSourceProperties properties) {
        return properties.initializeDataSourceBuilder().build();
    }

    @Primary
    @Bean(name = "accountsEntityManagerFactory")
    public LocalContainerEntityManagerFactoryBean accountsEntityManagerFactory(EntityManagerFactoryBuilder builder,
                                                                               @Qualifier("accountsDatasource") DataSource dataSource) {
        return builder.dataSource(dataSource)
                .packages("pl.lodz.p.it.bakertech.model.accounts")
                .persistenceUnit("accounts")
                .build();
    }

    @Primary
    @Bean(name = "accountsTransactionManager")
    @ConfigurationProperties("spring.jpa")
    public PlatformTransactionManager accountsTransactionManager(@Qualifier("accountsEntityManagerFactory") EntityManagerFactory entityManagerFactory) {
        return new JpaTransactionManager(entityManagerFactory);
    }
}
