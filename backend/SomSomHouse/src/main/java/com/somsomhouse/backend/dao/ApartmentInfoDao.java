package com.somsomhouse.backend.dao;

import java.util.List;

import com.somsomhouse.backend.dto.ApartmentInfoDto;

public interface ApartmentInfoDao {
	public List<ApartmentInfoDto> getLocation(double lat, double lng, double km) throws Exception;
	public List<ApartmentInfoDto> getApartName(String dong) throws Exception;
}
