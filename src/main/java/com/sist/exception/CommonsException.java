package com.sist.exception;

import java.io.IOException;
import java.sql.SQLException;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice("com.sist.web")
public class CommonsException {
	@ExceptionHandler(RuntimeException.class)
	public void runtimeHandler(RuntimeException ex) {
		System.out.println("===== RuntimeException 에러 발생 ======");
		System.out.println(ex.getMessage());
		ex.printStackTrace();
	}
	@ExceptionHandler(SQLException.class)
	public void sqlHandler(SQLException ex) {
		System.out.println("===== SQLException 에러 발생 ======");
		System.out.println(ex.getMessage());
		ex.printStackTrace();
	}
	@ExceptionHandler(IOException.class)
	public void ioHandler(IOException ex) {
		System.out.println("===== IOException 에러 발생 ======");
		System.out.println(ex.getMessage());
		ex.printStackTrace();
	}
	@ExceptionHandler(ClassNotFoundException.class)
	public void classNotFoundHandler(ClassNotFoundException ex) {
		System.out.println("===== ClassNotFoundException 에러 발생 ======");
		System.out.println(ex.getMessage());
		ex.printStackTrace();
	}
	@ExceptionHandler(Exception.class)
	public void exceptionHandler(Exception ex) {
		System.out.println("===== Exception 에러 발생 ======");
		System.out.println(ex.getMessage());
		ex.printStackTrace();
	}
}
