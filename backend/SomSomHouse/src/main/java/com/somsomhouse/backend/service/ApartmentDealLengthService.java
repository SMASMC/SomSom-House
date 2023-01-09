package com.somsomhouse.backend.service;

import org.json.simple.JSONObject;

import jakarta.servlet.http.HttpServletRequest;

public interface ApartmentDealLengthService {
	public JSONObject getEndIndex(HttpServletRequest request)throws Exception;
}
