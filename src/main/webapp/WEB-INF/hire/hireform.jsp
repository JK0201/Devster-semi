<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>


    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
        .post .contact form .input-group {
            display: inline-block;
            margin-left: 10px;
            margin-bottom: 15px;
            position: relative;
        }

        .col-lg-6 {
            width: 50%;
        }

        .post .contact {
            display: inline-block;
            width: 100%;
            text-align: center;
        }

        .post .contact .title {
            display: inline-block;
            width: 100%;
        }

        .post .contact form {
            display: table;
            margin: 0 auto;
        }

        .post .contact form .input-group {
            display: inline-block;
            margin-left: 10px;
            margin-bottom: 15px;
            position: relative;
        }

        .post .contact form .input-group label {
            color: #8e8e8e;
        }


        .post .contact form .input-group input[type="text"] {
            background: #ebebeb;
            border: 0;
            outline: 0;
            height: 50px;
            border-radius: 5px;
            padding: 0 15px;
            font-size: 16px;
            width: 60%;
            margin-top: 10px;
        }
        .post .contact form .input-group input[type="file"] {
            background: #ebebeb;
            border: 0;
            outline: 0;
            height: 50px;
            border-radius: 5px;
            padding: 0 15px;
            font-size: 16px;
            width: 60%;
        }

        .post .contact form .input-group input#file-upload-btn{
            height: 40px;
        }

        .post .contact form .input-group textarea {
            background: #ebebeb;
            border: 0;
            outline: 0;
            border-radius: 5px;
            padding: 15px;
            font-size: 16px;

            width: 60%;
            margin-top: 20px;
        }

        .post .contact form .post {
            width: 100%;
            background: #8007ad;
            color: #fff;
            font-size: 16px;
            border-radius: 5px;
            display: inline-block;
        }

        .post .contact form .full {
            width: 100%;
        }

        .post .contact form .half {
            width: 100%;
        }

        .post .contact form .half input[type="text"] {
            width: 90%;
        }

        .post .contact form .name input[type="text"] {
            float: left;
        }


        .post .btn-block{
            width: 15%;
            background-color: #7f07ac;
            margin-bottom: 100px;
            margin-top: 30px;
            height: 50px;
        }

    </style>
</head>
<body>

<div class="post">
    <div class="contact col-lg-6">
        <div class="title" style="margin-top: 30px;">
            <img src="/photo/logoimage.png" style="width: 100px;">
            <h2>Hire Board</h2>
        </div>

        <form action="insertHireBoard" enctype="multipart/form-data" method="post">
            <!--hidden-->
            <input type="hidden" name="hb_idx" value="${hb_idx}">
            <input type="hidden" name="currentPage" value="${currentPage}">

            <div class="input-group">
                <%--<label>Question</label>--%>
                <input class="subject" type="text" name="hb_subject" value="" placeholder="제목을 입력해주세요." required maxlength="200">
            </div>
            <div class="input-group message">
                <label>토픽에 맞지 않는 글로 판단되어 다른 유저로부터 일정 수 이상의 신고를 받는 경우 글이 자동으로 블라인드처리 될 수 있습니다.</label>
                <textarea name="hb_content" class="content"
                          placeholder="자세한 채용 공고를 입력해주세요." cols="47"
                          rows="7" required maxlength="10000"></textarea>
            </div>
            <div class="input-group fileupload">
                <input class="file_select" id="fileInput" type="file" name="upload" style="padding-top: 10px;" multiple>
                <%--<i class="bi bi-images" id="clickableImage"></i>--%>
            </div>
            <div class="col-md-12 form-group">
                <button type="submit" class="btn_write btn btn-block btn-primary">등록</button>
                <button type="button" class="btn_cancle btn btn-block btn-primary" onclick="history.back()">취소
                </button>
            </div>

        </form>
    </div>
</div>
</body>

<script>
    document.getElementById('clickableImage').addEventListener('click', function () {
        document.getElementById('fileInput').click();
    });
</script>



<!------------------------------------------------------>

</body>
</html>


