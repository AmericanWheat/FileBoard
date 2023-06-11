<%@page import="kr.human.fileboard.vo.FBoardVO"%>
<%@page import="kr.human.fileboard.service.FBoardService"%>
<%@page import="kr.human.fileboard.vo.PagingVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include.jsp" %>
<%
	PagingVO<FBoardVO> pagingVO = FBoardService.getInstance().selectList(currentPage, sizeOfPage, sizeOfBlock);
	request.setAttribute("pv", pagingVO);
	pageContext.forward("indexView.jsp");

%>