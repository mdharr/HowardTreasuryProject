package com.skilldistillery.howardtreasury.security;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.skilldistillery.howardtreasury.services.RateLimitService;

@Configuration
public class SecurityConfig {

    // this you get for free when you configure the db connection in application.properties file
    @Autowired
    private DataSource dataSource;

    // this bean is created in the application starter class if you're looking for it
    @Autowired
    private PasswordEncoder encoder;
    
    @Autowired
    private RateLimitService rateLimitService;
    
    @Autowired
    private ObjectMapper objectMapper;
	
    @Bean
    public SecurityFilterChain createFilterChain(HttpSecurity http) throws Exception {
        http
//        .addFilterBefore(new RateLimitingAuthenticationFilter(rateLimitService), BasicAuthenticationFilter.class)
        .addFilterBefore(new RateLimitingAuthenticationFilter(rateLimitService, objectMapper), BasicAuthenticationFilter.class)
        .csrf().disable()
        .authorizeRequests()
        .antMatchers(HttpMethod.OPTIONS, "/api/**").permitAll() // For CORS, the preflight request
        .antMatchers(HttpMethod.OPTIONS, "/**").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/collections").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/chat").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/collections/*").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/collections/*/pages").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/stories").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/stories/*").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/poems").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/poems/*").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/poems/*/collection").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/persons").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/persons/*").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/miscellaneas").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/miscellaneas/*").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/miscellaneas/*/collection").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/lists").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/search").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/posts").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/posts/*").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/posts/*/comments").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/illustrators").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/illustrators/*").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/weird-tales").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/weird-tales/*").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/votes/users/*").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/votes/stories/*").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/votes/*/*").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/api/quotes").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.POST, "/api/adventure/response").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/verify").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/password-reset-request").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/check-password").permitAll()     // will hit the OPTIONS on the route
        .antMatchers(HttpMethod.GET, "/ws/**").permitAll()     // will hit the OPTIONS on the route
        .antMatchers("/register").permitAll()
        .antMatchers("/ws/**").permitAll()
        .antMatchers("/ws/info").permitAll()
        .antMatchers("/verify").permitAll()
        .antMatchers("/api/**").authenticated() // Requests for our REST API must be authorized.
        .anyRequest().permitAll()               // All other requests are allowed without authentication.
        .and()
        .httpBasic()                           // Use HTTP Basic Authentication
        .and()
        .cors();
        
        http
        .sessionManagement()
        .sessionCreationPolicy(SessionCreationPolicy.STATELESS);
        
        return http.build();
    }
    
    @Autowired
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        // Check if username/password are valid, and user currently allowed to authenticate
        String userQuery = "SELECT username, password, enabled FROM user WHERE username=?";
        // Check what authorities the user has
        String authQuery = "SELECT username, role FROM user WHERE username=?";
        auth
        .jdbcAuthentication()
        .dataSource(dataSource)
        .usersByUsernameQuery(userQuery)
        .authoritiesByUsernameQuery(authQuery)
        .passwordEncoder(encoder);
    }
    
}