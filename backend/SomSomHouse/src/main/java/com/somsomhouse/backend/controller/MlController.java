package com.somsomhouse.backend.controller;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;

@RestController
public class MlController {
	
	// rserve와 연결하여 ml 측정값 받아오는 함수
	// 만든날짜 : 2023.1.11
	// 만든이 : 노현석
	// 수정날짜 : 2023.1.12
	// 수정자 : 권순형
	
	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	
	@RequestMapping("/quangjang")
	public JSONObject predictQuangjang(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		String name = request.getParameter("name");
		double area = Double.parseDouble(request.getParameter("area"));
		double floor = Double.parseDouble(request.getParameter("floor"));
		String weather = request.getParameter("weather");
		
		
		
		String[] apartNameArr = {"광장힐스테이트", "신동아파밀리에","워커힐푸르지오","현대3","현대홈타운12차"};
		List<String> nameOneHot = new ArrayList();
		
		for(String apartName : apartNameArr) {
			if(apartName == name) {
				nameOneHot.add("TRUE");
			}else {
				nameOneHot.add("FALSE");
			}
		}
		
		
		String[] apartWeatherArr = {"봄", "여름","가을","겨울"};
		List<String> WeatherOneHot = new ArrayList();
		
		for(String apartweather : apartWeatherArr) {
			if(apartweather == weather) {
				WeatherOneHot.add("TRUE");
			}else {
				WeatherOneHot.add("FALSE");
			}
		}
		
					
		RConnection conn = new RConnection();
		


		conn.voidEval("scaleAreaMat <- scale("+area+",center= 59.67,scale = 147.23 -59.67)");
		
		conn.voidEval("scaleArea<- scaleAreaMat[1,1]");
		
		conn.voidEval("scaleFloorMat <- scale("+floor+",center= 1,scale = 23 - 1)");
		
		conn.voidEval("scaleFloor<- scaleFloorMat[1,1]");
		

		conn.voidEval("library(nnet)");
		
		
		
		conn.voidEval("model.nnet <- readRDS(url('http://localhost:8080/show_rds?name=ml_gwangjangdong.rds','rb'))");

		
		conn.voidEval("result <- predict(model.nnet, (list("
				+ "광장힐스테이트=" + nameOneHot.get(0) 
				+ ", 신동아파밀리에=" + nameOneHot.get(1) 
				+ ", 워커힐푸르지오=" + nameOneHot.get(2) 
				+ ", 현대3=" + nameOneHot.get(3) 
				+ ", 현대홈타운12차=" + nameOneHot.get(4) 
				+ ", v2=" + conn.eval("scaleArea").asDouble() + ","
		+ "v1=" + conn.eval("scaleFloor").asDouble()
		+ ", 봄=" + WeatherOneHot.get(0) 
		+ ", 여름=" + WeatherOneHot.get(1) 
		+ ", 가을=" + WeatherOneHot.get(2) 
		+ ", 겨울=" + WeatherOneHot.get(3) 
		+ ")))");

		conn.voidEval("for (i in 1:ncol(result)) {" + 
				"if(result[i] == max(result)){" + 
				" ans <- colnames(result)[i] }}");
		
		String result = conn.eval("ans").asString();
		JSONObject jsonList = new JSONObject();
		jsonList.put("result", result);
		return jsonList;
	}
	
	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	
	@RequestMapping("/dorim")
	public JSONObject predictDorim(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		String name = request.getParameter("name");
		double area = Double.parseDouble(request.getParameter("area"));
		double floor = Double.parseDouble(request.getParameter("floor"));
		String weather = request.getParameter("weather");
		
		
		
		String[] apartNameArr = {"도림청구", "동아에코빌","영등포아트자이"};
		List<String> nameOneHot = new ArrayList();
		
		for(String apartName : apartNameArr) {
			if(apartName == name) {
				nameOneHot.add("TRUE");
			}else {
				nameOneHot.add("FALSE");
			}
		}
		
		
		String[] apartWeatherArr = {"봄", "여름","가을","겨울"};
		List<String> WeatherOneHot = new ArrayList();
		
		for(String apartweather : apartWeatherArr) {
			if(apartweather == weather) {
				WeatherOneHot.add("TRUE");
			}else {
				WeatherOneHot.add("FALSE");
			}
		}
		
		RConnection conn = new RConnection();
		
		conn.voidEval("scaleAreaMat <- scale("+area+",center= 36.44,scale = 143.59 -36.44)");
		
		conn.voidEval("scaleArea<- scaleAreaMat[1,1]");
		
		conn.voidEval("scaleFloorMat <- scale("+floor+",center= 1,scale = 29 - 1)");
		
		conn.voidEval("scaleFloor<- scaleFloorMat[1,1]");
		
		conn.voidEval("library(nnet)");
		
		conn.voidEval("model.nnet <- readRDS(url('http://localhost:8080/show_rds?name=ml_dorimdong.rds','rb'))");

		
		conn.voidEval("result <- predict(model.nnet, (list("
				+ "도림청구=" + nameOneHot.get(0)
				+ ", 동아에코빌=" + nameOneHot.get(1)
				+ ", 영등포아트자이=" + nameOneHot.get(2)
				+ ", v2=" + conn.eval("scaleArea").asDouble() + ","
		+ "v1=" + conn.eval("scaleFloor").asDouble() 
		+", 봄=" + WeatherOneHot.get(0) 
		+", 여름=" + WeatherOneHot.get(1) 
		+", 가을=" + WeatherOneHot.get(2) 
		+", 겨울=" + WeatherOneHot.get(3) 
		+ ")))");
		
		conn.voidEval("for (i in 1:ncol(result)) {" + 
				"if(result[i] == max(result)){" + 
				" ans <- colnames(result)[i] }}");
		
		String result = conn.eval("ans").asString();
		JSONObject jsonList = new JSONObject();
		jsonList.put("result", result);
		return jsonList;
	}
	
	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	
	@RequestMapping("/ogum")
	public JSONObject predictOgum(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		String name = request.getParameter("name");
		double area = Double.parseDouble(request.getParameter("area"));
		double floor = Double.parseDouble(request.getParameter("floor"));
		String weather = request.getParameter("weather");
		
		
		
		String[] apartNameArr = {"상아2차아파트", "송파레미니스2단지","송파호반베르디움더퍼스트"};
		List<String> nameOneHot = new ArrayList();
		
		for(String apartName : apartNameArr) {
			if(apartName == name) {
				nameOneHot.add("TRUE");
			}else {
				nameOneHot.add("FALSE");
			}
		}
		
		
		String[] apartWeatherArr = {"봄", "여름","가을","겨울"};
		List<String> WeatherOneHot = new ArrayList();
		
		for(String apartweather : apartWeatherArr) {
			if(apartweather == weather) {
				WeatherOneHot.add("TRUE");
			}else {
				WeatherOneHot.add("FALSE");
			}
		}
		
					
		RConnection conn = new RConnection();
		


		

		conn.voidEval("library(randomForest)");
		
		
		
		conn.voidEval("rf <- readRDS(url('http://localhost:8080/show_rds?name=ml_ohguemdong.rds','rb'))");

		
		conn.voidEval("result <- as.character(predict(rf, (list("
				+ "상아2차아파트=" + nameOneHot.get(0)
				+ ", 송파레미니스2단지=" + nameOneHot.get(1)
				+ ", 송파호반베르디움더퍼스트=" + nameOneHot.get(2)
				+ ", 임대면적=" + area + ","
		+ "층=" + floor 
		+ ", 봄=" + WeatherOneHot.get(0)
		+ ", 여름=" + WeatherOneHot.get(1)
		+ ", 가을=" + WeatherOneHot.get(2)
		+ ", 겨울=" + WeatherOneHot.get(3)
		+ "))))");

		String result = conn.eval("result").asString();
		JSONObject jsonList = new JSONObject();
		jsonList.put("result", result);
		return jsonList;
	}
	
	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	
	@RequestMapping("/sinjung")
	public JSONObject predictSinjung(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		String name = request.getParameter("name");
		double area = Double.parseDouble(request.getParameter("area"));
		double floor = Double.parseDouble(request.getParameter("floor"));
		String weather = request.getParameter("weather");
		
		
		
		String[] apartNameArr = {"롯데캐슬", "목동2차우성","목동힐스테이트","신트리2단지","유원목동"};
		List<String> nameOneHot = new ArrayList();
		
		for(String apartName : apartNameArr) {
			if(apartName == name) {
				nameOneHot.add("TRUE");
			}else {
				nameOneHot.add("FALSE");
			}
		}
		
		
		String[] apartWeatherArr = {"봄", "여름","가을","겨울"};
		List<String> WeatherOneHot = new ArrayList();
		
		for(String apartweather : apartWeatherArr) {
			if(apartweather == weather) {
				WeatherOneHot.add("TRUE");
			}else {
				WeatherOneHot.add("FALSE");
			}
		}
		
					
		RConnection conn = new RConnection();

		conn.voidEval("library(randomForest)");
		
		
		
		conn.voidEval("rf <- readRDS(url('http://localhost:8080/show_rds?name=ml_singeongdong.rds','rb'))");

		
		conn.voidEval("result <- as.character(predict(rf, (list("
				+ "롯데캐슬=" + nameOneHot.get(0)
				+ ", 목동2차우성=" + nameOneHot.get(1)
				+ ", 목동힐스테이트=" + nameOneHot.get(2)
				+ ", 신트리2단지=" + nameOneHot.get(3)
				+ ", 유원목동=" + nameOneHot.get(4)
				+ ", 층=" + floor + ","
		+ "임대면적=" + area
		+ ", 봄=" + WeatherOneHot.get(0)
		+ ", 여름=" + WeatherOneHot.get(1)
		+ ", 가을=" + WeatherOneHot.get(2)
		+ ", 겨울=" + WeatherOneHot.get(3)
		+ "))))");

		String result = conn.eval("result").asString();
		JSONObject jsonList = new JSONObject();
		jsonList.put("result", result);
		return jsonList;
	}
	
	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	
	@RequestMapping("/sincheon")
	public JSONObject predictSincheon(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		String name = request.getParameter("name");
		double area = Double.parseDouble(request.getParameter("area"));
		double floor = Double.parseDouble(request.getParameter("floor"));
		String weather = request.getParameter("weather");
		
		
		
		String[] apartNameArr = {"롯데캐슬골드", "잠실푸르지오월드마크","한신코아"};
		List<String> nameOneHot = new ArrayList();
		
		for(String apartName : apartNameArr) {
			if(apartName == name) {
				nameOneHot.add("TRUE");
			}else {
				nameOneHot.add("FALSE");
			}
		}
		
		
		String[] apartWeatherArr = {"봄", "여름","가을","겨울"};
		List<String> WeatherOneHot = new ArrayList();
		
		for(String apartweather : apartWeatherArr) {
			if(apartweather == weather) {
				WeatherOneHot.add("TRUE");
			}else {
				WeatherOneHot.add("FALSE");
			}
		}
		
					
		RConnection conn = new RConnection();
		


		
		conn.voidEval("library(randomForest)");
		
		
		
		conn.voidEval("rf <- readRDS(url('http://localhost:8080/show_rds?name=ml_sincheondong.rds','rb'))");

		
		conn.voidEval("result <- as.character(predict(rf, (list("
				+ "롯데캐슬골드=" + nameOneHot.get(0)
				+ ", 잠실푸르지오월드마크=" + nameOneHot.get(1)
				+ ", 한신코아=" + nameOneHot.get(2)
				+ ", 임대면적=" + area + ","
		+ "층=" + floor 
		+ ", 봄=" + WeatherOneHot.get(0)
		+ ", 여름=" + WeatherOneHot.get(1)
		+ ", 가을=" + WeatherOneHot.get(2)
		+ ", 겨울=" + WeatherOneHot.get(3)
		+ "))))");

		String result = conn.eval("result").asString();
		JSONObject jsonList = new JSONObject();
		jsonList.put("result", result);
		return jsonList;
	}
	
	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	//-----------------------------------------------------------------------------------------------------------------------------
	
	@RequestMapping("/galock")
	public JSONObject predictGalock(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		String name = request.getParameter("name");
		double area = Double.parseDouble(request.getParameter("area"));
		double floor = Double.parseDouble(request.getParameter("floor"));
		String weather = request.getParameter("weather");
		String[] apartNameArr = {"가락미륭아파트", "롯데캐슬","한화오벨리스크"};
		List<String> nameOneHot = new ArrayList();
		
		for(String apartName : apartNameArr) {
			if(apartName == name) {
				nameOneHot.add("TRUE");
			}else {
				nameOneHot.add("FALSE");
			}
		}
		
		
		String[] apartWeatherArr = {"봄", "여름","가을","겨울"};
		List<String> WeatherOneHot = new ArrayList();
		
		for(String apartweather : apartWeatherArr) {
			if(apartweather == weather) {
				WeatherOneHot.add("TRUE");
			}else {
				WeatherOneHot.add("FALSE");
			}
		}
		
					
		RConnection conn = new RConnection();
		

		conn.voidEval("library(randomForest)");
		
		
		
		conn.voidEval("rf <- readRDS(url('http://localhost:8080/show_rds?name=ml_garakdong.rds','rb'))");

		
		conn.voidEval("result <- as.character(predict(rf, (list("
				+ "가락미륭아파트=" + nameOneHot.get(0) 
				+ ", 롯데캐슬=" + nameOneHot.get(1) 
				+ ", 한화오벨리스크=" + nameOneHot.get(2) 
				+ ", 층=" + floor + ","
		+ "임대면적=" + area
		+ ", 봄=" + WeatherOneHot.get(0)
		+ ", 여름=" + WeatherOneHot.get(1)
		+ ", 가을=" + WeatherOneHot.get(2)
		+ ", 겨울=" + WeatherOneHot.get(3)
		+ "))))");

		String result = conn.eval("result").asString();
		JSONObject jsonList = new JSONObject();
		jsonList.put("result", result);
		return jsonList;
	}
	
	
	@RequestMapping("/siheung")
	public JSONObject predictSiheung(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		String name = request.getParameter("name");
		double area = Double.parseDouble(request.getParameter("area"));
		double floor = Double.parseDouble(request.getParameter("floor"));
		String weather = request.getParameter("weather");
		
		
		
		String[] apartNameArr = {"관악산신도브래뉴", "남서울건영아파트","남서울힐스테이트","시흥목련","시흥베르빌"};
		List<String> nameOneHot = new ArrayList();
		
		for(String apartName : apartNameArr) {
			if(apartName == name) {
				nameOneHot.add("TRUE");
			}else {
				nameOneHot.add("FALSE");
			}
		}
		
		
		String[] apartWeatherArr = {"봄", "여름","가을","겨울"};
		List<String> WeatherOneHot = new ArrayList();
		
		for(String apartweather : apartWeatherArr) {
			if(apartweather == weather) {
				WeatherOneHot.add("TRUE");
			}else {
				WeatherOneHot.add("FALSE");
			}
		}
		
					
		RConnection conn = new RConnection();
		


		conn.voidEval("scaleAreaMat <- scale("+area+",center= 53.39,scale = 150.72 -53.39)");
		
		conn.voidEval("scaleArea<- scaleAreaMat[1,1]");
		
		conn.voidEval("scaleFloorMat <- scale("+floor+",center= 1,scale = 26 - 1)");
		
		conn.voidEval("scaleFloor<- scaleFloorMat[1,1]");
		

		conn.voidEval("library(nnet)");
		
		
		
		conn.voidEval("model.nnet <- readRDS(url('http://localhost:8080/show_rds?name=ml_siheungdong.rds','rb'))");

		
		conn.voidEval("result <- predict(model.nnet, (list("
				+ "관악산신도브래뉴=" + nameOneHot.get(0) 
				+ ", 남서울건영아파트=" + nameOneHot.get(1) 
				+ ", 남서울힐스테이트=" + nameOneHot.get(2) 
				+ ", 시흥목련=" + nameOneHot.get(3) 
				+ ", 시흥베르빌=" + nameOneHot.get(4) 
				+ ", v2=" + conn.eval("scaleArea").asDouble() + ","
		+ "v1=" + conn.eval("scaleFloor").asDouble() 
		+ ", 봄=" + WeatherOneHot.get(0)
		+ ", 여름=" + WeatherOneHot.get(1)
		+ ", 가을=" + WeatherOneHot.get(2)
		+ ", 겨울=" + WeatherOneHot.get(3)
		+ ")))");
		
		conn.voidEval("for (i in 1:ncol(result)) {" + 
				"if(result[i] == max(result)){" + 
				" ans <- colnames(result)[i] }}");

		String result = conn.eval("ans").asString();
		JSONObject jsonList = new JSONObject();
		jsonList.put("result", result);
		return jsonList;
	}
	
	@RequestMapping("/pungnap")
	public JSONObject predictPungnap(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		String name = request.getParameter("name");
		double area = Double.parseDouble(request.getParameter("area"));
		double floor = Double.parseDouble(request.getParameter("floor"));
		String weather = request.getParameter("weather");
		
		
		
		String[] apartNameArr = {"송파현대힐스테이트", "신동아파밀리에","잠실올림픽공원아이파크"};
		List<String> nameOneHot = new ArrayList();
		
		for(String apartName : apartNameArr) {
			if(apartName == name) {
				nameOneHot.add("TRUE");
			}else {
				nameOneHot.add("FALSE");
			}
		}
		
		
		String[] apartWeatherArr = {"봄", "여름","가을","겨울"};
		List<String> WeatherOneHot = new ArrayList();
		
		for(String apartweather : apartWeatherArr) {
			if(apartweather == weather) {
				WeatherOneHot.add("TRUE");
			}else {
				WeatherOneHot.add("FALSE");
			}
		}
		
					
		RConnection conn = new RConnection();
		


		conn.voidEval("scaleAreaMat <- scale("+area+",center= 59.67,scale = 147.23 -59.67)");
		
		conn.voidEval("scaleArea<- scaleAreaMat[1,1]");
		
		conn.voidEval("scaleFloorMat <- scale("+floor+",center= 1,scale = 23 - 1)");
		
		conn.voidEval("scaleFloor<- scaleFloorMat[1,1]");
		

		conn.voidEval("library(randomForest)");
		
		
		
		conn.voidEval("rf <- readRDS(url('http://localhost:8080/show_rds?name=ml_poongnapdong.rds','rb'))");

		
		conn.voidEval("result <- as.character(predict(rf, (list("
				+ "송파현대힐스테이트=" + nameOneHot.get(0)
				+ ", 신동아파밀리에=" + nameOneHot.get(1)
				+ ", 잠실올림픽공원아이파크=" + nameOneHot.get(2)
				+ ", v2=" + conn.eval("scaleArea").asDouble() + ","
		+ "v1=" + conn.eval("scaleFloor").asDouble() 
		+ ", 봄=" + WeatherOneHot.get(0)
		+ ", 여름=" + WeatherOneHot.get(1)
		+ ", 가을=" + WeatherOneHot.get(2)
		+ ", 겨울=" + WeatherOneHot.get(3)
		+ "))))");

		String result = conn.eval("result").asString();
		JSONObject jsonList = new JSONObject();
		jsonList.put("result", result);
		return jsonList;
	}
}
