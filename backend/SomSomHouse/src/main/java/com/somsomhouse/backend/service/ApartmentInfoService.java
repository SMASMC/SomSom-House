package com.somsomhouse.backend.service;

import org.json.simple.JSONObject;

import jakarta.servlet.http.HttpServletRequest;


public interface ApartmentInfoService {
	public JSONObject getLocation(HttpServletRequest request)throws Exception;
	public JSONObject apartmentInfo(HttpServletRequest request)throws Exception;
}
