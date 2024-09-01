package com.skilldistillery.howardtreasury.security;

import java.io.IOException;
import java.time.Instant;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import com.skilldistillery.howardtreasury.services.RateLimitService;

public class RateLimitingAuthenticationFilter extends OncePerRequestFilter {
	
	private static final int STATUS_TOO_MANY_REQUESTS = 429;

    private final RateLimitService rateLimitService;
    private final ObjectMapper objectMapper;

    public RateLimitingAuthenticationFilter(RateLimitService rateLimitService, ObjectMapper objectMapper) {
        this.rateLimitService = rateLimitService;
        this.objectMapper = objectMapper;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        
        String username = extractUsernameFromRequest(request);
        
        if (username != null) {
            RateLimitService.RateLimitResult result = rateLimitService.tryConsume(username);
            if (!result.isAllowed) {
                sendErrorResponse(response, request, result.secondsUntilRefill);
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

    private void sendErrorResponse(HttpServletResponse response, HttpServletRequest request, long secondsUntilRefill) throws IOException {
        response.setStatus(STATUS_TOO_MANY_REQUESTS);
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);

        Map<String, Object> errorDetails = new HashMap<>();
        errorDetails.put("timestamp", Instant.now().toString());
        errorDetails.put("status", STATUS_TOO_MANY_REQUESTS);
        errorDetails.put("error", "Too Many Requests");
        errorDetails.put("message", "Rate limit exceeded. Try again in " + secondsUntilRefill + " seconds.");
        errorDetails.put("path", request.getRequestURI());

        objectMapper.writeValue(response.getWriter(), errorDetails);
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
