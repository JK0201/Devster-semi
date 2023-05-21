<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>


    <style>

        .yet_normalUser_check{
            padding-left: 30px;
            height: 440px;
        }

        .yet_normalUser_check .title{
            font-weight: 700;
            font-size: 30px;
            color: #222;
            padding-bottom: 12px;
            border-bottom: 1px solid rgb(34, 34, 34);
        }

        .yet_normalUser_check .wrapped{
            /*border-top: 1px solid rgb(34, 34, 34);*/
           /* margin-top: 20px;*/
            padding-top: 40px;
            /*padding: 40px 60px;*/
            padding-left: 40px;
        }
        #checkAcaPhoto{
            font-size: 20px;
            font-weight: bold;
            margin-top: 36px;
        }

        .yet_normalUser_check .wrapped h1{
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 36px;
        }

    </style>

    <script>
        $(document).ready(function () {
            checkAcaPhoto();
        })
    </script>

    <div class="yet_normalUser_check">

        <h1 class="title">학원 인증 받기</h1>

        <div class="wrapped">

            <h1> 학원 인증을 완료하시지 않으면 자유 게시판의 읽기만 가능합니다.<br> 다른 기능을 이용하고 싶으시다면, 학원 인증을 완료해주세요</h1>

            <form name="photoUpload" style="display: flex;">
                <input type="file" id="upload" name="upload" class="form-control" style="width: 454px; margin-right: 6px;">
                <button type="button" name="btnPhoto" onclick="updatePhoto()"
                        class="btn btn-sm btn-outline-secondary">사진 업로드</button>
            </form>

        </div>

        <h1 id="checkAcaPhoto"></h1>

    </div>
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
                    $(".yet_normalUser_check .wrapped").css("display","none");
                    $("#checkAcaPhoto").text("학원 인증 사진이 업로드 되어있습니다. 운영진이 확인 후 승인이 되면 활동이 가능합니다.");
                } else {
                    $(".yet_normalUser_check .wrapped").css("display","block");
                    //$("#checkAcaPhoto").text("아직 학원 인증 사진이 업로드 되지않았습니다.").css("color","red");
                }
            },
            error: function (xhr, status, error) {
                // 에러 처리를 여기에서 처리합니다.
            }
        })
    }
</script>

