<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자료실 글쓰기</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script type="text/javascript">
	let maxFile = 5, minfile=1, index=2;
	$(function(){
		$("#appendFile").click(function() {
			if(index==maxFile){
				alert('최대 ' + maxFile + "개 까지만 등록가능합니다.");
				return;
			}
			++index;
			$("<div id='file" + index + "'><input type='file' name='upload'></div>").appendTo("#fileBox");
		});
		$("#removeFile").click(function() {
			if(index==minfile){
				alert('최소 ' + minfile + "개는 등록해야 합니다.");
				return;
			}
			$("#file"+index).remove();
			--index;
		});
		
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
	<form action="insertOk.jsp" method="post" id="insertForm" enctype="multipart/form-data">
		<input type="hidden" name="p" value="${p }"/> 
		<input type="hidden" name="s" value="${s }"/> 
		<input type="hidden" name="b" value="${b }"/> 
		<table>
			<tr>
				<td colspan="4" class="title">자료실 글쓰기</td>
			</tr>
			<tr>
				<td style="text-align: right;">이름</td>
				<td style="text-align: left;"> 
					<input type="text" name="name" id="name" required="required" size="14"/> 
				</td>
				<td style="text-align: right;">비번</td>
				<td style="text-align: left;"> 
					<input type="password" name="password" id="password" required="required" size="14"/> 
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">제목</td>
				<td style="text-align: left;" colspan="3"> 
					<input type="text" name="subject" id="subject" required="required" size="120"/> 
				</td>
			</tr>
			<tr>
				<td style="text-align: right;vertical-align: top;">내용</td>
				<td style="text-align: left;" colspan="3"> 
					<textarea name="content" id="content" cols="122" rows="10"></textarea>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;vertical-align: top;">파일첨부</td>
				<td style="text-align: left;" colspan="3"> 
					<input type="button" id="appendFile" value=" + " />
					<input type="button" id="removeFile" value=" - " /><br />
					<div id="fileBox">
						<div id="file1"><input type="file" name="upload" /></div>
						<div id="file2"><input type="file" name="upload" /></div>
					</div>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;border: none;" colspan="4"> 
					<input type="submit"  value="저장하기" class="btn btn-outline-danger"/>
					<input type="reset"  value="다시쓰기" class="btn btn-outline-danger"/>
					<input type="button"  value="돌아가기" class="btn btn-outline-danger"
					 onclick="location.href='index.jsp?p=${p }&s=${s }&b=${b }'"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>