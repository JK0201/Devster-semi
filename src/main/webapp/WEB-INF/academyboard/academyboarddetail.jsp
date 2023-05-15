<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Gothic+A1&family=Gowun+Batang&family=Hahmlet&family=Song+Myung&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
        body, body * {
            font-family: 'Gowun Batang'
        }

        img{
            width: 100px;
        }

        .headbox{
            margin-bottom: 30px;
        }
        .bodybox{
            margin-bottom: 30px;
            height: 100%;
        }
        .footbox{
            margin-bottom: 20px;
            margin-top: 10px;
            font-size: 18px;
        }
        .btnbox{
            margin-left: 130px;
        }

        .thumbsup,.thumbsdown{
            cursor: pointer;
        }

        .thumbsup:hover{
            color:cornflowerblue;
        }

        .thumbsdown:hover{
            color: crimson;
        }

        .commentwrite{
            margin-left: 100px;
            width: 80%;
            margin-bottom: 50px;
            text-align: center;
        }

        .memberimg{
            width: 23px;
            height: 23px;
            border-radius: 100px;
        }

        .already-added {
            background-color: grey;
            color: white;
        }
    </style>
    <script>
        $(document).ready(function (){
            // commentList();



            <!-- jsp 실행 이전의 리액션 여부 체크 및 버튼 색상 표현 -->
            $(function() {
                checkAddRpBefore();
            });

            <!-- 좋아요 버튼 클릭 이벤트 및 ajax 실행 -->
            $("#add-goodRp-btn").click(function() {

                <!-- 이미 싫어요가 눌려 있는 경우 반려 -->
                if (isAlreadyAddBadRp == true) {
                    alert('이미 싫어요를 누르셨습니다.');
                    return;
                }

                <!-- 좋아요가 눌려 있지 않은 경우 좋아요 1 추가 -->
                if (isAlreadyAddGoodRp == false) {
                    $.ajax({
                        url : "/academyboard/increaseGoodRp",
                        type : "POST",
                        data : {
                            "ab_idx" : ${dto.ab_idx},
                            "m_idx" : ${sessionScope.memidx}
                        },
                        success : function(goodReactionPoint) {
                            $("#add-goodRp-btn").addClass("already-added");
                            $(".add-goodRp").html(goodReactionPoint);
                            isAlreadyAddGoodRp = true;
                        },
                        error : function() {
                            alert('서버 에러, 다시 시도해주세요.');
                        }
                    });

                    <!-- 이미 좋아요가 눌려 있는 경우 좋아요 1 감소 -->
                } else if (isAlreadyAddGoodRp == true){
                    $.ajax({
                        url : "/academyboard/decreaseGoodRp",
                        type : "POST",
                        data : {
                            "ab_idx" : ${dto.ab_idx},
                            "m_idx" : ${sessionScope.memidx}
                        },
                        success : function(goodReactionPoint) {
                            $("#add-goodRp-btn").removeClass("already-added");
                            $(".add-goodRp").html(goodReactionPoint);
                            isAlreadyAddGoodRp = false;
                        },
                        error : function() {
                            alert('서버 에러, 다시 시도해주세요.');
                        }
                    });
                } else {
                    return;
                }
            });

            <!-- 싫어요 버튼 클릭 이벤트 및 ajax 실행 -->
            $("#add-badRp-btn").click(function() {

                <!-- 이미 좋아요가 눌려 있는 경우 반려 -->
                if (isAlreadyAddGoodRp == true) {
                    alert('이미 좋아요를 누르셨습니다.');
                    return;
                }

                <!-- 싫어요가 눌려 있지 않은 경우 싫어요 1 추가 -->
                if (isAlreadyAddBadRp == false) {
                    $.ajax({
                        url : "/academyboard/increaseBadRp",
                        type : "POST",
                        data : {
                            "ab_idx" : ${dto.ab_idx},
                            "m_idx" : ${sessionScope.memidx}
                        },
                        success : function(badReactionPoint) {
                            $("#add-badRp-btn").addClass("already-added");
                            $(".add-badRp").html(badReactionPoint);
                            isAlreadyAddBadRp = true;
                        },
                        error : function() {
                            alert('서버 에러, 다시 시도해주세요.');
                        }
                    });

                    <!-- 이미 싫어요가 눌려 있는 경우 싫어요 1 감소 -->
                } else if (isAlreadyAddBadRp == true) {
                    $.ajax({
                        url : "/academyboard/decreaseBadRp",
                        type : "POST",
                        data : {
                            "ab_idx" : ${dto.ab_idx},
                            "m_idx" : ${sessionScope.memidx}
                        },
                        success : function(badReactionPoint) {
                            $("#add-badRp-btn").removeClass("already-added");
                            $(".add-badRp").html(badReactionPoint);
                            isAlreadyAddBadRp = false;
                        },
                        error : function() {
                            alert('서버 에러, 다시 시도해주세요.');
                        }
                    });
                } else {
                    return;
                }
            });



        });

    </script>
</head>
<body>


<div class="container">
    <div class="headbox">
        <b style="font-size: 15px; color: #94969B; margin-bottom: 20px;">no.${dto.ab_idx}</b><br>
        <h4 style="font-family: 'Hahmlet'; color: black; font-weight: bolder; margin-top: 5px;margin-bottom: 20px;">${dto.ab_subject}</h4>

        <b style="font-size: 15px; color: black;" margin-bottom: 10px;>
            <img src="http://${imageUrl}/member/${m_photo}" class="memberimg">&nbsp;
            ${nickname}&nbsp;</b><br>

        <b style="font-size: 13px; color: #94969B;"><fmt:formatDate value="${dto.ab_writeday}" pattern="MM/dd HH:mm"/>&nbsp;&nbsp;</b>
        <b style="font-size: 13px; color: #94969B;"><i class="bi bi-eye"></i>&nbsp;${dto.ab_readcount}&nbsp;&nbsp;</b>
        <b style="font-size: 13px; color: #94969B;"><i class="bi bi-chat-right"></i>&nbsp;<b id="commentCnt">0</b></b>
    </div>
    <div class="bodybox">
        <p style="margin-bottom: 50px;">${dto.ab_content}</p>

        <c:forEach items="${list}" var="images">
            <c:if test="${images!='n'}">
                <img src="http://${imageUrl}/academyboard/${images}"><br>
            </c:if>
        </c:forEach>
    </div>


<%--    &lt;%&ndash;  좋아요 / 싫어요 버튼&ndash;%&gt;--%>
<%--    <div class="footbox">--%>
<%--    <span id="add-goodRp-btn" class="btn btn-outline btn-sm">--%>
<%--                  <i class="bi bi-hand-thumbs-up thumbsup"></i>&nbsp;좋아요--%>
<%--                  <span class="add-goodRp ml-2">${dto.fb_like}</span>--%>
<%--                </span>--%>
<%--        <span id="add-badRp-btn" class="ml-5 btn btn-outline btn-sm">--%>
<%--                  <i class="bi bi-hand-thumbs-down thumbsdown"></i>&nbsp;싫어요--%>
<%--                  <span class="add-badRp ml-2">${dto.fb_dislike}</span>--%>
<%--            </span>--%>
<%--    </div>--%>

    <%--  좋아요 / 싫어요 버튼--%>
    <div class="footbox">
    <span id="add-goodRp-btn" class="btn btn-outline btn-sm">
                  <i class="bi bi-hand-thumbs-up thumbsup"></i>&nbsp;좋아요
                  <span class="add-goodRp ml-2">${dto.ab_like}</span>
                </span>
        <span id="add-badRp-btn" class="ml-5 btn btn-outline btn-sm">
                  <i class="bi bi-hand-thumbs-down thumbsdown"></i>&nbsp;싫어요
                  <span class="add-badRp ml-2">${dto.ab_dislike}</span>
            </span>
    </div>
</div>

<div class="btnbox">
    <c:if test="${dto.m_idx == sessionScope.memidx}">
        <button type="button" onclick="location.href='./academyupdateform?ab_idx=${dto.ab_idx}&currentPage=${currentPage}'" class="btn btn-sm btn-outline-secondary"><i class="bi bi-pencil-square"></i>&nbsp;수정</button>
        <button type="button" onclick="del(${dto.ab_idx})" class="btn btn-sm btn-outline-secondary"><i class="bi bi-trash"></i>&nbsp;삭제</button>
    </c:if>

    <button type="button" onclick="location.href='./list?currentPage=${currentPage}'" class="btn btn-sm btn-outline-secondary"><i class="bi bi-card-list"></i>&nbsp;목록</button>
</div>




<script>
    function del(ab_idx) {
        if (confirm("삭제하시겠습니까?")) {
            location.href = "./academydelete?ab_idx=" + ab_idx;
        }
    }

    // 좋아요 싫어요...
    <%--    현재 버튼이 눌려있는지 확인해서 상태에 따라 버튼에 색상표시  --%>
    var isAlreadyAddGoodRp = ${isAlreadyAddGoodRp};
    var isAlreadyAddBadRp = ${isAlreadyAddBadRp};

    function checkAddRpBefore() {
        <!-- 변수값에 따라 각 id가 부여된 버튼에 클래스 추가(이미 눌려있다는 색상 표시) -->
        if (isAlreadyAddGoodRp == true) {
            $("#add-goodRp-btn").addClass("already-added");
        } else if (isAlreadyAddBadRp == true) {
            $("#add-badRp-btn").addClass("already-added");
        } else {
            return;
        }
        $(function() {
            checkAddRpBefore();
        });
    };

</script>

</body>
</html>

