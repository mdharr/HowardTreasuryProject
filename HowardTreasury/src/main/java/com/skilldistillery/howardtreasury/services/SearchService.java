package com.skilldistillery.howardtreasury.services;

import java.util.List;
import java.util.Map;

public interface SearchService {

	public List<Map<String, Object>> search(String query);
}
