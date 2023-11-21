package com.skilldistillery.howardtreasury.services;

import java.util.List;

import com.skilldistillery.howardtreasury.entities.WeirdTales;

public interface WeirdTalesService {

	public List<WeirdTales> findAll();
	
	public WeirdTales find(int weirdTalesId);
}
