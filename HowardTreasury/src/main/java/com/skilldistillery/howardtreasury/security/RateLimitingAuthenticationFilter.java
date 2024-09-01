package com.skilldistillery.howardtreasury.security;

import java.io.IOException;
import java.util.Base64;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import com.skilldistillery.howardtreasury.services.RateLimitService;

public class RateLimitingAuthenticationFilter extends OncePerRequestFilter {
	
	private static final int STATUS_TOO_MANY_REQUESTS = 429;

    private final RateLimitService rateLimitService;

    public RateLimitingAuthenticationFilter(RateLimitService rateLimitService) {
        this.rateLimitService = rateLimitService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        
        String username = extractUsernameFromRequest(request);
        
        if (username != null) {
            RateLimitService.RateLimitResult result = rateLimitService.tryConsume(username);
            if (!result.isAllowed) {
                response.setStatus(STATUS_TOO_MANY_REQUESTS);
                response.getWriter().write("Rate limit exceeded. Try again in " + result.secondsUntilRefill + " seconds.");
                return;
            }
        }
        
        filterChain.doFilter(request, response);
        
        // Check if authentication was successful
        if (SecurityContextHolder.getContext().getAuthentication() != null &&
            SecurityContextHolder.getContext().getAuthentication().isAuthenticated()) {
            rateLimitService.resetOrAdjustLimit(username);
        }
    }

    private String extractUsernameFromRequest(HttpServletRequest request) {
        String authHeader = request.getHeader("Authorization");
        if (authHeader != null && authHeader.startsWith("Basic")) {
            String base64Credentials = authHeader.substring("Basic".length()).trim();
            String credentials = new String(Base64.getDecoder().decode(base64Credentials));
            return credentials.split(":", 2)[0];
        }
        return null;
    }
}
