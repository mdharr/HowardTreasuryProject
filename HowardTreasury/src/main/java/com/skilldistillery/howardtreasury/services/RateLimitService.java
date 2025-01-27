package com.skilldistillery.howardtreasury.services;

import java.time.Duration;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import io.github.bucket4j.Bandwidth;
import io.github.bucket4j.Bucket;
import io.github.bucket4j.Refill;

@Service
public class RateLimitService {
    private static final Logger logger = LoggerFactory.getLogger(RateLimitService.class);
    private final ConcurrentHashMap<String, Bucket> buckets = new ConcurrentHashMap<>();

    @Value("${rate.limit.attempts:5}")
    private int maxAttempts;

    @Value("${rate.limit.period-minutes:15}")
    private int periodMinutes;

    public RateLimitResult tryConsume(String key) {
        logger.debug("Attempting to consume for key: {}", key);
        Bucket bucket = buckets.computeIfAbsent(key, k -> createNewBucket());
        
        if (bucket.tryConsume(1)) {
            logger.debug("Consumption allowed for key: {}. Remaining tokens: {}", key, bucket.getAvailableTokens());
            return new RateLimitResult(true, bucket.getAvailableTokens(), getRemainingTimeInSeconds(bucket));
        } else {
            logger.debug("Consumption denied for key: {}. Time to refill: {} seconds", key, getRemainingTimeInSeconds(bucket));
            return new RateLimitResult(false, 0, getRemainingTimeInSeconds(bucket));
        }
    }
    
    public void resetOrAdjustLimit(String key) {
        if (key == null) {
            logger.warn("Attempted to reset/adjust rate limit for null key");
            return;
        }
        logger.debug("Resetting/adjusting rate limit for key: {}", key);
        Bucket bucket = buckets.computeIfPresent(key, (k, existingBucket) -> {
            return createNewBucket();
        });

        if (bucket == null) {
            logger.debug("No existing bucket found for key: {}. Creating new bucket.", key);
            buckets.put(key, createNewBucket());
        }
    }

    private Bucket createNewBucket() {
        logger.debug("Creating new bucket with max attempts: {} and period: {} minutes", maxAttempts, periodMinutes);
        return Bucket.builder()
                .addLimit(Bandwidth.classic(maxAttempts, Refill.intervally(maxAttempts, Duration.ofMinutes(periodMinutes))))
                .build();
    }

    private long getRemainingTimeInSeconds(Bucket bucket) {
        return bucket.estimateAbilityToConsume(1).getNanosToWaitForRefill() / 1_000_000_000;
    }

    public static class RateLimitResult {
        public final boolean isAllowed;
        public final long remainingAttempts;
        public final long secondsUntilRefill;

        public RateLimitResult(boolean isAllowed, long remainingAttempts, long secondsUntilRefill) {
            this.isAllowed = isAllowed;
            this.remainingAttempts = remainingAttempts;
            this.secondsUntilRefill = secondsUntilRefill;
        }
    }
}
