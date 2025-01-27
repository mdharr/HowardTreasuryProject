package com.skilldistillery.howardtreasury.services;

import com.skilldistillery.howardtreasury.entities.User;
import com.skilldistillery.howardtreasury.exceptions.UsernameNotFoundException;

public interface AuthService {
	
	public User register(User user);
	public User getUserByUsername(String username);
	public User login(String username);
	public User updateUser(User updatedUser, String username);
	public User enable(User userToEnable);
	public boolean disable(int id);
	public boolean disableUser(String username);
	void requestPasswordReset(String email);
	boolean resetPassword(String token, String newPassword);
	public boolean checkPassword(String token, String newPassword);
	public boolean isAccountDeactivated(String username);
    public void sendActivationEmail(String username);
    public boolean verifyActivationCode(String username, String code);
	User getUserDetails(String username) throws UsernameNotFoundException;
}
