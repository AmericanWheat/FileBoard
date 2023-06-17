<%@page import="kr.human.fileboard.vo.PagingVO"%>
<%@page import="kr.human.fileboard.dao.FBoardDAO"%>
<%@page import="kr.human.fileboard.service.FBoardService"%>
<%@page import="kr.human.fileboard.vo.FBoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="include.jsp" %>
<%

	FBoardVO vo = FBoardService.getInstance().selectByIdx(idx);
	request.setAttribute("vo", vo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">	
<title>자료실 목록보기</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="./font/axicon/axicon.min.css" />	
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript">
$(function(){

});
</script>
<style type="text/css">
	table { width: 1000px; border: none; margin: auto;border-spacing: 2px;border-collapse: separate;}
	.title{text-align: center; font-size: 18pt;font-weight: bold;padding: 5px; border: none;}
	.sub_title{text-align: right; font-size: 10pt;font-weight: bold; border: none;}
	th { font-weight: bold; text-align: center; background-color: silver; border: 1px solid silver;padding:5px;}
	td { border: 1px solid silver; text-align: center;border: 1px solid silver;padding:5px;} 
</style>
</head>
<body>
		<input type="hidden" name="p" value="${p }"/> 
		<input type="hidden" name="s" value="${s }"/> 
		<input type="hidden" name="b" value="${b }"/> 
		<table>
			<tr>
				<td colspan="4" class="title">자료실 상세보기</td>
			</tr>
			<tr>
				<td style="text-align: right;">이름</td>
				<td style="text-align: left;"> 
					${vo.name }
				</td>
				<td style="text-align: right;">조회수</td>
				<td>${vo.readCount }</td>
			</tr>
			<tr>
				<td style="text-align: right;">제목</td>
				<td style="text-align: left;" colspan="3"> 
					${vo.subject }
				</td>
			</tr>
			<tr>
				<td style="text-align: right;vertical-align: top;">내용</td>
				<td style="text-align: left;" colspan="3"> 
					<textarea name="content" id="content" cols="122" rows="10" readonly="readonly">
					${vo.content }
					</textarea>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;vertical-align: top;">파일다운로드</td>
				<td style="text-align: left;" colspan="3"> 
					<div id="fileBox">
					<c:if test="${not empty vo.uploadList }">
							<c:forEach var="f" items="${vo.uploadList }">
								<a href="download.jsp?of=${f.ofile }&sf=${f.sfile}" title="${f.ofile }"><i class="axi axi-download"></i></a>
							</c:forEach>
						</c:if>
					</div>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;border: none;" colspan="4"> 
					<input type="button"  value="돌아가기" class="btn btn-outline-danger"
					 onclick="location.href='index.jsp?p=${p }&s=${s }&b=${b }'"/>
				</td>
			</tr>
		</table>
</body>
</html>