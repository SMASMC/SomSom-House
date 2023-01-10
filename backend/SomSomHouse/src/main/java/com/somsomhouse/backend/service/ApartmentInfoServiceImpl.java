package com.somsomhouse.backend.service;

import java.io.Console;
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
		double zoomLevel = Double.parseDouble(request.getParameter("zoomlevel"));
		double km = (40000/Math.pow(2,zoomLevel))*2;
		
		
		List<ApartmentInfoDto> myBatisList = apartmentInfoDao.getLocation(lat , lng , km);
		
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

	@Override
	public JSONObject apartmentInfo(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		String name = (request.getParameter("name"));
		
		
		JSONObject jsonList = new JSONObject();
	    JSONArray itemList = new JSONArray();
		
		ApartmentInfoDto myBatis= apartmentInfoDao.apartmentInfo(name);
			JSONObject tempJson = new JSONObject();
			tempJson.put("name", myBatis.getName());
            tempJson.put("gu", myBatis.getGu());
            tempJson.put("dong", myBatis.getDong());
            tempJson.put("heating", myBatis.getHeating());
            tempJson.put("household", myBatis.getHousehold());
            tempJson.put("parking", myBatis.getParking());
            
            itemList.add(tempJson);
            
		
		
		jsonList.put("results",itemList);
		
		return jsonList;
	}

	@Override
	public JSONObject getApartName(HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		
		String dong = (request.getParameter("dong"));
		
		
		List<ApartmentInfoDto> myBatisList = apartmentInfoDao.getApartName(dong);
		
		JSONObject jsonList = new JSONObject();
	    JSONArray itemList = new JSONArray();
		
		for(ApartmentInfoDto myBatis : myBatisList) {
			JSONObject tempJson = new JSONObject();
			tempJson.put("name", myBatis.getName());
           
            itemList.add(tempJson);
            
		}
		
		jsonList.put("results",itemList);
		
		return jsonList;
	}
}
