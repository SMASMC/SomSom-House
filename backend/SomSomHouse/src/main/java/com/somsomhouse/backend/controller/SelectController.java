package com.somsomhouse.backend.controller;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.somsomhouse.backend.service.ApartmentInfoService;

import jakarta.servlet.http.HttpServletRequest;

@RestController
public class SelectController {
	
	@Autowired
	ApartmentInfoService apartmentInfoService;
	
	
	@RequestMapping("/get_location")
	public JSONObject getLocation(HttpServletRequest request) throws Exception{
		JSONObject jsonList = apartmentInfoService.getLocation(request);
		
		return jsonList;
		
	}
}
