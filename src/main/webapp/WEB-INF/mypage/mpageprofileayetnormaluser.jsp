<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
        body, body * {
            font-family: 'Jua'
        }
    </style>
    <script>
        $(document).ready(function () {
            checkAcaPhoto();
        })
    </script>
</head>
<body>
    <div style="border: 3px solid black; width: 600px; margin-left: 400px">
        <h1> 학원 인증을 완료하시지 않으면 자유 게시판의 읽기만 가능합니다.<br> 다른 기능을 이용하고 싶으시다면, 학원 인증을 완료해주세요!
        </h1>
        <form name="photoUpload">
            <input type="file" id="upload" name="upload">
            <button type="button" name="btnPhoto" onclick="updatePhoto()">사진 업로드</button>
        </form>



    </div>
    <br>
    <h1 id="checkAcaPhoto">

    </h1>
</body>
<script>

    function updatePhoto(){
        // 먼저 textarea의 값이 있는지 확인합니다.
        let input = $("#upload");
        if(input.val() == "") {
            alert("사진을 업로드 해주세요.");
            return; // 내용이 없다면 함수를 종료합니다.
        }
        let form = $("form[name=photoUpload]")[0];

        let formData = new FormData(form);
        formData.append("m_idx", ${sessionScope.memidx});

        $.ajax({
            type: "post",
            url: "/mypage/updateacaphoto",
            data: formData,
            processData: false, // 필수: FormData를 사용할 때는 processData를 false로 설정해야 함
            contentType: false, // 필수: FormData를 사용할 때는 contentType을 false로 설정해야 함
            success: function (response) {
                alert("사진이 업로드 되었습니다.");
                location.href="/mypage/";
            },
            error: function (xhr, status, error) {
                // 에러 처리를 여기에서 처리합니다.
            }
        });
    }

    function checkAcaPhoto() {
        $.ajax({
            type: "get",
            url: "/mypage/checkacaphoto",
            dataType : "text",
            success: function (response) {
                if(response == "true") {
                    $("#checkAcaPhoto").text("학원 인증 사진이 업로드 되어있습니다. 운영진이 확인 후 승인이 되면 활동이 가능합니다.").css("color","green");
                } else {
                    $("#checkAcaPhoto").text("아직 학원 인증 사진이 업로드 되지않았습니다.").css("color","red");
                }
            },
            error: function (xhr, status, error) {
                // 에러 처리를 여기에서 처리합니다.
            }
        })
    }
</script>
</html>
