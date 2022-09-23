package com.my.hr.dao;

import java.time.LocalDate;
import java.util.List;

import com.my.hr.domain.Laborer;

public interface LaborerDao {
	List<Laborer> selectLaborers();
	Laborer selectLaborer(int laborerId);
	void insertLaborer(String name, LocalDate hireDate);
	void updateLaborer(Laborer laborer);
	void deleteLaborer(int laboerId);
}
