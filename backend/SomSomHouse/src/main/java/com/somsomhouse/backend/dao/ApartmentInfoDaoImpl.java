package com.somsomhouse.backend.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.somsomhouse.backend.dto.ApartmentInfoDto;

public class ApartmentInfoDaoImpl implements ApartmentInfoDao {
	
	SqlSession sqlSession;
	
	public static String nameSpace = "com.somsomhouse.backend.dao.ApartmentInfoDao";

	@Override
	public List<ApartmentInfoDto> getLocation(double lat, double lng , double km) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(nameSpace + ".getLocation");
	}

	@Override
	public ApartmentInfoDto apartmentInfo(String name) throws Exception {
		// TODO Auto-generated method stub
		return (ApartmentInfoDto) sqlSession.selectList(nameSpace + ".apartmentInfo");
	}
	
	@Override
	public List<ApartmentInfoDto> getApartName(String dong, String gu) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(nameSpace + ".getApartName");
	}

}
