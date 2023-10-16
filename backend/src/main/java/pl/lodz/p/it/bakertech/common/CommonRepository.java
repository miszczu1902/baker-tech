package pl.lodz.p.it.bakertech.common;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.NoRepositoryBean;
import pl.lodz.p.it.bakertech.interceptors.Interception;

@Interception
@NoRepositoryBean
public interface CommonRepository<T extends AbstractEntity> extends JpaRepository<T, Long> {
}
