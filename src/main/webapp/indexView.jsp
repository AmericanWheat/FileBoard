<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<table>
		<tr>
			<td class="title" colspan="6">
				자료실 목록보기
			</td>
		</tr>
		<tr>
			<td class="sub_title" colspan="6">
				${pv.pageInfo }
			</td>
		</tr>
		<tr>
			<th>글번호</th>
			<th>작성자</th>
			<th style="width: 50%">제목</th>
			<th>조회수</th>
			<th>작성일</th>
			<th>IP</th>
		</tr>
		<c:if test="${pv.totalCount==0 }">
			<tr>
				<td colspan="6" style="text-align: center;">등록된 글이 존재하지 읺습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty pv.list }">
			<c:forEach var="vo" items="${pv.list }" varStatus="vs">
				<tr>
					<td>${vo.idx }</td>
					<td> <c:out value="${vo.name }"/> </td>
					<td>
						<a href="#"><c:out value="${vo.subject }"/> </a>
						&nbsp; 
						<%-- 첨부파일 개수만큼 디스트이름으로 링크를 걸자 --%>
						<c:if test="${not empty vo.uploadList }">
							<c:forEach var="f" items="${vo.uploadList }">
								<a href="download.jsp?of=${f.ofile }&sf=${f.sfile}" title="${f.ofile }"><i class="axi axi-attach-file"></i></a>
							</c:forEach>
						</c:if>
					</td>
					<td>${vo.readCount }</td>
					<td>
						<fmt:formatDate value="${vo.regDate }" pattern="MM-dd hh:mm"/>
					</td>
					<td>${vo.ip }</td>
				</tr>
			</c:forEach>
			<%-- 페이지 목록 --%>
			<tr>
				<td colspan="6" style="border: none;"> ${pv.pageList } </td> 
			</tr>
		</c:if>
		<%-- 글쓰기 단추 --%>
		<tr>
			<td colspan="6" style="text-align: right;border: none;">
				<button type="button" class="btn btn-sm btn-outline-success" 
				        onclick="location.href='insert.jsp?p=${p }&s=${s }&b=${b }'">새글쓰기</button>
			</td>
		</tr>
	</table>
</body>
</html>