package com.skilldistillery.howardtreasury.services;

import com.skilldistillery.howardtreasury.entities.ResetPasswordToken;
import com.skilldistillery.howardtreasury.entities.User;

public interface ResetPasswordTokenService {
    public String createPasswordResetToken(User user);
    public ResetPasswordToken getResetPasswordToken(String token);
    void deleteResetPasswordToken(String token);
}
