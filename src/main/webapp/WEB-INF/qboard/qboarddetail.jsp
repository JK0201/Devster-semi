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
</head>
<body>
    <div style="border: 3px solid black; margin-top: 60px; margin-left: 100px; width: 600px">
        <h1>
            제목 : ${dto.qb_subject}
        </h1>
        <h6 style="color: #94969B">
            조회 ${dto.qb_readcount}
        </h6>
        <br>
        <h2>
            작성자 : ${nickname}
        </h2>
        <br>
        <h2>
            작성일자 : ${dto.qb_writeday}
        </h2>
        <br>
        <c:if test="${dto.qb_dislike > 19}">
            <p class="blind" style="color: red; font-size: 30px; cursor: pointer">블라인드 처리된 게시글 입니다.</p>
        <div class="content" style="visibility: hidden">
            <h3>
                내용 : ${dto.qb_content}
            </h3>
            <br>
            <c:forEach items="${list}" var="images">
                <img src="http://${imageUrl}/qboard/${images}" style="float: left; width: 300px">
            </c:forEach>
        </div>
        </c:if>

        <div style="clear: both">
            <c:if test="${dto.m_idx == sessionScope.memidx}">
                <button class="btn btn-outline-dark" type="button"
                        onclick="location.href='delete?qb_idx=${dto.qb_idx}'">
                    삭제
                </button>
                <button class="btn btn-outline-dark" type="button"
                        onclick="location.href='updateform?qb_idx=${dto.qb_idx}&currentPage=${currentPage}'">
                    수정
                </button>
            </c:if>
            <button type="button" onclick="like()" id="btnlike" class="btn btn-success">좋아요 <span id="likeCount">${dto.qb_like}</span></button>
            <button type="button" onclick="dislike()" id="btndislike" class="btn btn-danger">싫어요 <span id="dislikeCount">${dto.qb_dislike}</span></button>
            <button class="btn btn-warning" type="button" onclick="location.href='./list?currentPage=${currentPage}'">
                목록
            </button>
            <button class="btn btn-warning" type="button" onclick="location.href='./writeform'">
                글쓰기
            </button>
        </div>
    </div>
    </div>


<script>
    function like() {
        let qb_idx = ${dto.qb_idx};

        $.ajax({
            type: "post",
            url: "./like",
            data: {"qb_idx":qb_idx},
            dataType: "json",
            success: function(response) {
                // 새로고침 없이 좋아요 카운터 업데이트
                let currentLikeCount = parseInt($("#likeCount").text(), 10);
                let updatedLikeCount = currentLikeCount + 1;
                $("#likeCount").text(updatedLikeCount);

                $("#btnlike").prop("disabled", true);
                $("#btndislike").prop("disabled", true);

                alert("좋아요를 눌렀어요.");
            }
        });
    }



    function dislike() {
        let qb_idx = ${dto.qb_idx}

            $.ajax({
                type: "post",
                url: "./dislike",
                data: {"qb_idx": qb_idx},
                dataType: "json",
                success: function(response) {
                    // 새로고침 없이 싫어요 카운터 업데이트
                    let currentDislikeCount = parseInt($("#dislikeCount").text(), 10);
                    let updatedDislikeCount = currentDislikeCount + 1;
                    $("#dislikeCount").text(updatedDislikeCount);

                    $("#btnlike").prop("disabled", true);
                    $("#btndislike").prop("disabled", true);

                    alert("싫어요를 눌렀어요.");
                }
            });
    }



    $(".blind").click(function (){
        $(".content").css("visibility","visible");
    })
</script>
</body>
</html>
