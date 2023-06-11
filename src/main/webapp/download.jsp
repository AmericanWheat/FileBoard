<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.File"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	// 서버의 저장된 실제 경로
	String path = application.getRealPath("./upload/");
	// 원본 파일 이름 
	String of = request.getParameter("of");
	// 실제 저장된 파일 이름
	String sf = request.getParameter("sf");
	InputStream  is = null;
	OutputStream os = null;
	File file = null;
	try{
		file = new File(path, sf);
		is = new FileInputStream(file); // 입력스트림 얻기
		
		// 파일이름의 한글이나 공백이 들어갔을 경우 처리를 반드시 해줘야 한다.
		
		String agent = request.getHeader("user-Agent");
		System.out.println(agent);
		if(agent.indexOf("Trident")==-1){ // IE가 아니라면
			of = new String(of.getBytes("UTF-8"),"iso-8859-1"); // 인코딩 타입 변경
		}else{ // IE라면
			of = URLEncoder.encode(of, "UTF-8").replaceAll("\\+", "%20");
		}
		
		// 헤더 변경
		response.reset();
		response.setContentType("application/octet-stream"); // 파일 타입
		response.setHeader("Content-Disposition", "attachment; filename=\""	+ of + "\""); // 저장이름
		response.setHeader("Content-Type", "application/octet-stream;charset=utf-8"); // 스트림으로 변경
		response.setHeader ("Content-Length", ""+file.length() ); // 파일 길이
		//JSP는 서블릿으로 변할때 out객체를 자동으로 생성하므로 out객체를 초기화하고 생성한다.
		out.clear();
		out = pageContext.pushBody();
		os = response.getOutputStream(); // 출력스트림 얻기
		byte[] b = new byte[(int)file.length()]; // 바이트 배열
		int len = 0; // 읽은 글자수
		while((len = is.read(b))>0){ // 읽기
			os.write(b, 0, len); // 저장
			os.flush(); // 버퍼 내용 보내기
		}
	}catch(FileNotFoundException e){
		e.printStackTrace();
	} finally{
		is.close(); // 닫기
		os.close();
	}
%>