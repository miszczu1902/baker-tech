package pl.lodz.p.it.bakertech.security;

import com.nimbusds.jose.shaded.gson.internal.LinkedTreeMap;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.util.ArrayList;
import java.util.List;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {
    @Value("${spring.security.oauth2.resourceserver.jwt.jwk-set-uri}")
    private String jwkUri;

    @Bean
    public JwtAuthenticationConverter jwtAuthenticationConverter() {
        JwtAuthenticationConverter converter = new JwtAuthenticationConverter();
        converter.setJwtGrantedAuthoritiesConverter(jwt -> {
            converter.setPrincipalClaimName("preferred_username");

            final LinkedTreeMap<String, List<String>> resourceAccess = jwt.getClaim("realm_access");
            final List<String> clientRoles = new ArrayList<>(resourceAccess.get("roles"))
                    .stream()
                    .filter(role -> Roles.getAuthenticatedRoles().contains(role))
                    .map("ROLE_%s"::formatted)
                    .toList();

            if (!clientRoles.isEmpty()) {
                return AuthorityUtils.createAuthorityList(clientRoles);
            } else {
                return AuthorityUtils.createAuthorityList("ROLE_%s".formatted(Roles.GUEST));
            }
        });
        return converter;
    }


    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .cors(Customizer.withDefaults())
                .csrf(AbstractHttpConfigurer::disable)
                .addFilterBefore(new CustomJwtFilter(), UsernamePasswordAuthenticationFilter.class)
                .authorizeHttpRequests(authorize ->
                        authorize.requestMatchers(
                                        "/api/accounts",
                                        "/api/auth",
                                        "/api/devices",
                                        "/api/parameters",
                                        "/api/orders",
                                        "/api/reports")
                                .permitAll()
                                .anyRequest()
                                .authenticated()
                )
                .oauth2ResourceServer(oauth2 ->
                        oauth2.jwt(jwt -> jwt.jwkSetUri(jwkUri)
                                .jwtAuthenticationConverter(jwtAuthenticationConverter()))
                )
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .exceptionHandling(Customizer.withDefaults());
        return http.build();
    }
}
