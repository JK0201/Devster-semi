<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
        body, body *{
            font-family: 'Jua'
        }
    </style>
</head>
<body>

<img id="showimg">


<div style="width: 450px;">
    <form action="insertHireBoard" method="post" enctype="multipart/form-data">

        <!--hidden-->
        <input type="hidden" name="hb_idx" value="${hb_idx}">
        <input type="hidden" name="currentPage" value="${currentPage}">

        <table  class="table table-bordered">
            <tr>
                <th style="width: 100px;background-color: #ddd">제목</th>
                <td>
                    <input type="text" class="form-control" name="hb_subject" required="required">
                </td>
            </tr>
            <tr>

                <th style="width: 100px;background-color: #ddd">회사로고사진</th>

                <td>
                    <input type="file" class="form-control" name="upload" id="myfile" required="required">
                </td>
            </tr>
            <tr>
                <th style="width: 100px;background-color: #ddd">내용</th>
                <td>
                    <input type="text" class="form-control" name="hb_content" id="content" required="required">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <button type="submit" class="btn btn-outline-success">등록</button>
                    <button type="button" class="btn btn-outline-success"
                            onclick="location.href='list'">취소</button>
                </td>
            </tr>
        </table>
    </form>
</div>

<!-- 미리보기 -->
<script type="text/javascript">
    $("#myfile").change(function() {
        console.log("1:" + $(this)[0].files.length);
        console.log("2:" + $(this)[0].files[0]);
        //정규표현식
        var reg = /(.*?)\/(jpg|jpeg|png|bmp)$/;
        var f = $(this)[0].files[0];//현재 선택한 파일
        if (!f.type.match(reg)) {
            alert("확장자가 이미지파일이 아닙니다");
            return;
        }
        if ($(this)[0].files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $("#showimg").attr("src", e.target.result);
            }
            reader.readAsDataURL($(this)[0].files[0]);
        }
    });
</script>

</body>
</html>
