package com.skilldistillery.howardtreasury.entities;

import java.util.Calendar;
import java.util.Date;
import java.util.Objects;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name = "reset_password_token")
public class ResetPasswordToken {

    private static final int EXPIRATION_TIME_IN_MINUTES = 60 * 24;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "token", unique = true)
    private String token;

    @Column(name="expiry_date")
    private Date expiryDate;

    @JsonBackReference
    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(nullable = false, name = "user_id")
    private User user;
	
	public ResetPasswordToken() {
        this.token = UUID.randomUUID().toString();
        this.expiryDate = calculateExpiryDate(EXPIRATION_TIME_IN_MINUTES);
	}
	
    public ResetPasswordToken(User user) {
        this();
        this.user = user;
    }
    
    public ResetPasswordToken(User user, String token) {
        this.user = user;
        this.token = token;
        this.expiryDate = calculateExpiryDate(EXPIRATION_TIME_IN_MINUTES);
    }

	public ResetPasswordToken(Long id, String token, Date expiryDate, User user) {
		super();
		this.id = id;
		this.token = token;
		this.expiryDate = expiryDate;
		this.user = user;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Date getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(Date expiryDate) {
		this.expiryDate = expiryDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public static int getExpiration() {
		return EXPIRATION_TIME_IN_MINUTES;
	}
	
	private Date calculateExpiryDate(int expiryTimeInMinutes) {
	    Calendar cal = Calendar.getInstance();
	    cal.add(Calendar.MINUTE, expiryTimeInMinutes);
	    return cal.getTime();
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ResetPasswordToken other = (ResetPasswordToken) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "VerificationToken [id=" + id + ", token=" + token + ", expiryDate=" + expiryDate + ", user=" + user
				+ "]";
	}
    
}

