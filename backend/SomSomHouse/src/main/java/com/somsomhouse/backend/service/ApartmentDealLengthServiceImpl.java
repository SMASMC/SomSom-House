package com.somsomhouse.backend.service;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class ApartmentDealLengthServiceImpl implements ApartmentDealLengthService {

	@Override
	public JSONObject getEndIndex(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		String name = request.getParameter("name");
		
////		ApartmentDealLengthDto myBatis = apartmentDealLengthDao.getEndIndex(name);
//		
		JSONObject jsonList = new JSONObject();
//	    JSONArray itemList = new JSONArray();
//	    JSONObject tempJson = new JSONObject();
//	    
//	    tempJson.put("name", myBatis.getName());
//	    tempJson.put("", myBatis.getGeon_sae_freq());
//	    tempJson.put("", myBatis.getWall_sae_freq());
//	    
//	    itemList.add(tempJson);
//		
//		
//		jsonList.put("results",itemList);
//		
		return jsonList;
	}

}


