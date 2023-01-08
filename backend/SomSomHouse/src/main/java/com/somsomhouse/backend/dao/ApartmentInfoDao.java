package com.somsomhouse.backend.dao;

import java.util.List;

import com.somsomhouse.backend.dto.ApartmentInfoDto;

public interface ApartmentInfoDao {
	public List<ApartmentInfoDto> getLocation(double lat, double lng) throws Exception;
}
