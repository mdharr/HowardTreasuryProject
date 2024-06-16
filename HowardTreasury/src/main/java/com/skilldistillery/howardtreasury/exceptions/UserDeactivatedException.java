package com.skilldistillery.howardtreasury.exceptions;

public class UserDeactivatedException extends RuntimeException {
	
	private static final long serialVersionUID = 1L;

    public UserDeactivatedException(String message) {
        super(message);
    }
}
