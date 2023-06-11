<%@page import="kr.human.fileboard.service.FBoardService"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.human.fileboard.vo.UploadVO"%>
<%@page import="kr.human.fileboard.vo.FBoardVO"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
//1. 일반폼인지 파일 전송인지를 판단한다.
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
//파일 전송이 아니라면 파일 전송 폼으로 보낸다.
if(!isMultipart){
	response.sendRedirect("index.jsp");
	return;
}
//2. 넘어온 파일을 파싱한다.
//DiskFileItemFactory객체 생성
DiskFileItemFactory factory = new DiskFileItemFactory();
//DiskFileItemFactory객체를 이용하여 ServletFileUpload객체 생성
ServletFileUpload upload = new ServletFileUpload(factory);
//3. 넘어온 모든 내용을 FileItem객체 리스트로 받습니다.
List<FileItem> items = upload.parseRequest(request);
//4. 이제 각각의 파일 처리를 한다.
FBoardVO vo = new FBoardVO();
List<UploadVO> uploadList = new ArrayList<>();
int currentPage=1, sizeOfPage=5, sizeOfBlock=5;
if(items!=null && items.size()>0){ // 넘어온 값이 있다면
	for(FileItem item : items){ // 반복 처리
		if(item.isFormField()){ // 일반 폼인지 파일인지를 판단한다.
			// 일반 폼이라면
			// 각각의 이름에 맞춰서 받아야 한다,
			switch(item.getFieldName()){
			case "name":
				vo.setName(item.getString("UTF-8"));
				break;
			case "password":
				vo.setPassword(item.getString("UTF-8"));
				break;
			case "subject":
				vo.setSubject(item.getString("UTF-8"));
				break;
			case "content":
				vo.setContent(item.getString("UTF-8"));
				break;
			case "p":
				currentPage = Integer.parseInt(item.getString("UTF-8"));
				break;
			case "s":
				sizeOfPage = Integer.parseInt(item.getString("UTF-8"));
				break;
			case "b":
				sizeOfBlock = Integer.parseInt(item.getString("UTF-8"));
				break;
			}
		}else{
			// 파일이 넘어오지 않았다면 아무일도 하지 말아야 한다.
			if(item.getSize()>0){
				// 파일이라면
				String fileName = item.getName(); // 원본 파일 이름
				
				// IE의 경우 원본이름에 경로를 포함한다. 이때 경로를 지워줘야 한다.
				if(fileName.indexOf("\\")!=-1){ // 파일이름에 경로 구분자가 들어있다. 
					// 맨뒤의 이름만 취해야 한다.
					fileName = fileName.substring(fileName.lastIndexOf("\\")+1);
				}
				
				String path = application.getRealPath("upload"); // 저장될 장소
				// 시간_난수_원본이름
				String saveFileName = System.nanoTime() + "_"
				  + String.format("%03d",new Random().nextInt(101)) + "_" + fileName;
				
				File file = new File(path + "/" + saveFileName);
				item.write(file); // 파일 복사
				
				// 객체 만들어 
				UploadVO uploadVO = new UploadVO();
				uploadVO.setOfile(fileName);
				uploadVO.setSfile(saveFileName);
				// 리스트에 추가
				uploadList.add(uploadVO);
			}// end if
		} // end if
	}// end for
	vo.setUploadList(uploadList);
	vo.setIp(request.getRemoteAddr());

	out.println(vo);
}
	// 서비스를 호출하여 저장을 수행한다.
	FBoardService.getInstance().insert(vo);
	// 그리고 목록으로 돌아간다.
	response.sendRedirect("index.jsp?p=1&s=" + sizeOfPage + "&b=" + sizeOfBlock);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br />
	<hr />
	currentPage : ${p } <br />
	sizeOfPage : ${s } <br />
	sizeOfBlock : ${b } <br />
	idx : ${idx } <br />
	mode : ${m } <br />
	newLine : ${newLine } <br />
	br : ${br } <br />
</body>
</html>