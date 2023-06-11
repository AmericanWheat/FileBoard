<%
// 모든 페이지에 공통으로 들어가는 코드는 별도로 만들어 놓고 include 시키자!!!
request.setCharacterEncoding("UTF-8"); // 한글처리

// 현재 페이지 번호 받기
int currentPage = 1;
try{
	currentPage = Integer.parseInt(request.getParameter("p"));
}catch(Exception e) { ; }

// 페이지당 글수 받기
int sizeOfPage = 10;
try{
	sizeOfPage = Integer.parseInt(request.getParameter("s"));
}catch(Exception e) { ; }

// 페이지 목록 개수 받기
int sizeOfBlock = 10;
try{
	sizeOfBlock = Integer.parseInt(request.getParameter("b"));
}catch(Exception e) { ; }

// 글번호 받기
int idx = -1;
try{
	idx = Integer.parseInt(request.getParameter("idx"));
}catch(Exception e) { ; }

// 조회수 증가여부를 판단할 변수 받기
int mode = 0;
try{
	mode = Integer.parseInt(request.getParameter("m"));
}catch(Exception e) { ; }

request.setAttribute("p", currentPage);
request.setAttribute("s", sizeOfPage);
request.setAttribute("b", sizeOfBlock);
request.setAttribute("m", mode);
request.setAttribute("idx", idx);
// 줄바꿈 처리를 위해
request.setAttribute("newLine", "\n");
request.setAttribute("br", "<br>");
%>