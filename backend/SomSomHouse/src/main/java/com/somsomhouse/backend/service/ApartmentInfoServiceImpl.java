package com.somsomhouse.backend.service;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.somsomhouse.backend.dao.ApartmentInfoDao;
import com.somsomhouse.backend.dto.ApartmentInfoDto;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class ApartmentInfoServiceImpl implements ApartmentInfoService {
	
	@Autowired
	ApartmentInfoDao apartmentInfoDao;
	
	@Override
	public JSONObject getLocation(HttpServletRequest request) throws Exception {
		
		// TODO Auto-generated method stub
		
		double lat = Double.parseDouble(request.getParameter("lat"));
		double lng = Double.parseDouble(request.getParameter("lng"));
		
		List<ApartmentInfoDto> myBatisList = apartmentInfoDao.getLocation(lat , lng);
		
		JSONObject jsonList = new JSONObject();
	    JSONArray itemList = new JSONArray();
		
		for(ApartmentInfoDto myBatis : myBatisList) {
			JSONObject tempJson = new JSONObject();
			tempJson.put("name", myBatis.getName());
            tempJson.put("lat", myBatis.getLat());
            tempJson.put("lng", myBatis.getLng());
            itemList.add(tempJson);
            
		}
		
		jsonList.put("results",itemList);
		
		return jsonList;
	}
}
