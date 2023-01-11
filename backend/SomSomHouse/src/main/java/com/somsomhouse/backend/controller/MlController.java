package com.somsomhouse.backend.controller;

import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;

@RestController
public class MlController {
	
	@RequestMapping("/dongname")
	public String predictDongName(HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("utf-8");

		double sepalLength = Double.parseDouble(request.getParameter("sepalLength"));
		double sepalWidth = Double.parseDouble(request.getParameter("sepalWidth"));
		double petalLength = Double.parseDouble(request.getParameter("petalLength"));
		double petalWidth = Double.parseDouble(request.getParameter("petalWidth"));
		
		RConnection conn = new RConnection();
		
		conn.voidEval("library(#######)");
		conn.voidEval("rf <- readRDS(url('http://localhost:8080/show_rds?name=######','rb'))");

		conn.voidEval("result <- as.character(predict(rf, (list(Sepal.Length=" + sepalLength + ", Sepal.Width=" + sepalWidth + ","
		+ "Petal.Length=" + petalLength + ", Petal.Width=" + petalWidth + "))))");

		String result = conn.eval("result").asString();
		return result;
	}
}
