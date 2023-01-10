package com.somsomhouse.backend.dao;

import org.apache.ibatis.session.SqlSession;

import com.somsomhouse.backend.dto.ApartmentDealLengthDto;

public class ApartmentDealLengthDaoImpl implements ApartmentDealLengthDao {
	
	SqlSession sqlSession;
	
	public static String nameSpace = "com.somsomhouse.backend.dao.ApartmentDealLengthDao";

	@Override
	public ApartmentDealLengthDto getEndIndex(String name) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(nameSpace + ".getEndIndex");
	}

}
