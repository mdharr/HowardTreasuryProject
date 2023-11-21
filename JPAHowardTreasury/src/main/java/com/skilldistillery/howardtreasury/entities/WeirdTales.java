package com.skilldistillery.howardtreasury.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "weird_tales")
public class WeirdTales {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
}
