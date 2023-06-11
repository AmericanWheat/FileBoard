<%@page import="com.ibatis.common.resources.Resources"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.human.fileboard.mybatis.MybatisApp"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="org.apache.ibatis.session.SqlSessionFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	SqlSession sqlSession = null;

try{
	sqlSession = MybatisApp.getSqlSessionFactory().openSession(false);
	
	out.print(" DB시간 : "+ new SimpleDateFormat("yyyy-MM-dd(EEE) hh:mm:ss").format(sqlSession.selectOne("test.selectToday")));
	out.print("<hr>");
	out.print("총 개수 : "+sqlSession.selectOne("fboard.selectCount"));
	out.print("<hr>");
	out.print("총 개수 : "+sqlSession.selectOne("upload.selectfileList"));
	
	
	sqlSession.close();
} catch (Exception e) {
	
} finally{
	sqlSession.close();
}


	


%>


</body>
</html>