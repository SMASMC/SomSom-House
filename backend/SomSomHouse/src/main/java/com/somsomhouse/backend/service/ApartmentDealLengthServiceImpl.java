package com.somsomhouse.backend.service;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.somsomhouse.backend.dao.ApartmentDealLengthDao;
import com.somsomhouse.backend.dto.ApartmentDealLengthDto;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class ApartmentDealLengthServiceImpl implements ApartmentDealLengthService {
	
	@Autowired
	ApartmentDealLengthDao apartmentDealLengthDao;
	

	@Override
	public JSONObject getEndIndex(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		String name = request.getParameter("name");
		
		ApartmentDealLengthDto myBatis = apartmentDealLengthDao.getEndIndex(name);
		
		JSONObject jsonList = new JSONObject();
	    JSONArray itemList = new JSONArray();
	    JSONObject tempJson = new JSONObject();
	    
	    tempJson.put("apartName", myBatis.getName());
	    tempJson.put("geonSaeEndIndex", myBatis.getGeon_sae_freq());
	    tempJson.put("wallSaeEndIndex", myBatis.getWall_sae_freq());
	    
	    itemList.add(tempJson);
		
		
		jsonList.put("results",itemList);
		return jsonList;
	}

}


