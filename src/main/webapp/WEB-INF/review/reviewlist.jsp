<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2023-05-03
  Time: PM 1:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
        body, body *{
        font-family: 'Jua'
        }
        /*별점 css*/
        .star-rb_star {
         /*   border: solid 1px #ccc;*/
            display: flex;
          /*  flex-direction: row-reverse;*/
            font-size: 1.5em;
            justify-content: space-around;
            padding: 0 .2em;
            text-align: center;
            width: 5em;
        }

        .star-rb_star input {
            display: none;
        }

        .star-rb_star label {
            color: #ccc;
           /* cursor: pointer;*/
        }

        .star-rb_star :checked ~ label {
            color: #f90;
        }

        .clear:after{    /* 자식이 모두 float 을 사용할때 부모가 높이를 갖게하기 위함 */
            content:"";
            display:block;
            clear:both;

        }
        /*회사 정보 css*/
        .rb_listc{
            border: 1px solid black;
            width: 200px;
            height: 150px;
            float: left;

        }
        .rb_imgSelect {
            cursor: pointer;
        }

        .rb_popupLayer {
            position: absolute;
            display: none;
            background-color: #ffffff;
            border: solid 2px #d0d0d0;
            width: 350px;
            height: 150px;
            padding: 10px;
        }
        .popupLayer div {
            position: absolute;
            top: 5px;
            right: 5px
        }

    </style>
<body>
<button type="button" class="btn btn-sm btn-outline-danger"
        onclick="location.href='./reviewriterform'" style="margin-bottom: 10px">상품등록</button>

<select id="rb_typelist" onchange="rb_typelist()">
    <option value="0">전체보기</option>
    <option value="1">면접</option>
    <option value="2">코딩테스트</option>
    <option value="3">합격</option>
</select>

<script>
    function rb_typelist() {
        // 선택한 리뷰 유형 가져오기
        var selectedType = document.getElementById("rb_typelist").value;

        // 모든 리뷰 div 요소 가져오기
        var reviewDivs = document.querySelectorAll(".review");

        // 각 리뷰 div 요소를 반복하며 필터링
        reviewDivs.forEach(function(reviewDiv) {
            // 현재 리뷰의 유형 가져오기
            var reviewType = reviewDiv.getAttribute("data-type");

            // 선택한 유형과 현재 리뷰의 유형이 일치하는 경우 보여주기
            if (reviewType === selectedType || selectedType === "0") {
                reviewDiv.style.display = "block";
            } else {
                reviewDiv.style.display = "none";
            }
        });
    }
</script>

<h5 class="alert alert-success">
    총 ${totalCount}개의 글이 등록되어있습니다</h5><br>

<div class="rb_listmain clear">

<c:forEach var="dto" items="${list}" varStatus="i">
    <div class="review" data-type="${dto.rb_type}">
        <%--회사 정보 입력 div--%>
    <div class="rb_listc">
        <p>
            <a class="rb_imgSelect">클릭1</a>
        </p>
    </div>

    <div class="rb_listm">
    </div>
    게시글 번호 : ${i.count}<br>

            <p>좋아요:${dto.rb_like}</p>
            <p>싫어요: ${dto.rb_dislike}</p>
           별점: ${dto.rb_star}
            <%--별점 div--%>
            <div class="star-rb_star">
                <c:forEach var="i" begin="1" end="5">
                    <input type="radio" id="rating${i}" name="rating" value="${i}" <c:if test="${i eq dto.rb_star}">checked="checked"</c:if> />
                    <label for="rating${i}" class="star" <c:if test="${i le dto.rb_star}">style="color: orange;"</c:if>>★</label>
                </c:forEach>
            </div>
        작성자 :  ${dto.nickName}<br>
    작성일 :${dto.rb_writeday}<br>
    타입 :${dto.rb_type == 1 ? "면접" : dto.rb_type == 2 ? "코딩테스트": dto.rb_type == 3 ? "합격" : ""}<br>
        내용 : <br><b><pre>${dto.rb_content}</pre></b><br>

        <c:set var="m_idx" value="${sessionScope.memidx}"/>
        <c:if test="${dto.m_idx eq m_idx}">
    <button type="button" class="btn btn-sm btn-outline-primary"
            onclick="location.href='./updateform?rb_idx=${dto.rb_idx}'" style="margin-bottom: 10px">글 수정</button>
        <button type="button" class="btn btn-sm btn-outline-primary"
               onclick="delreview(${dto.rb_idx})" style="margin-bottom: 10px" >글 삭제</button>
        </c:if>
            <button type="button" onclick="like()" id="btnlike" class="btn btn-success">좋아요 <span
                    id="likeCount">${dto.rb_like}</span></button>
            <button type="button" onclick="dislike()" id="btndislike" class="btn btn-danger">싫어요 <span
                    id="dislikeCount">${dto.rb_dislike}</span></button>


        <%--삭제 이벤트--%>
        <script>
            function delreview(rb_idx) {
                if (confirm("삭제하시겠습니까?")) {
                    location.href = "./delete?rb_idx=" + rb_idx;
                }
            }
            function like() {
                let rb_idx = ${dto.rb_idx};

                $.ajax({
                    type: "post",
                    url: "./like",
                    data: {"rb_idx": rb_idx},
                    dataType: "json",
                    success: function (response) {
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
                let rb_idx = ${dto.rb_idx}

                    $.ajax({
                        type: "post",
                        url: "./dislike",
                        data: {"rb_idx": rb_idx},
                        dataType: "json",
                        success: function (response) {
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
        </script>
    <hr>
    </div>
</c:forEach>
    <div style="width: 700px; text-align: center; font-size: 20px">
        <!-- 이전 -->
        <c:if test="${startPage > 1}">
            <a style="color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${startPage-1}">이전</a>
        </c:if>
        <c:if test="${startPage <= 1}">
            <a style="color: black; text-decoration: none; cursor: pointer; visibility: hidden;" href="list?currentPage=${startPage-1}">이전</a>
        </c:if>
        <!-- 페이지 번호 출력 -->
        <c:forEach var="pp" begin="${startPage}" end="${endPage}">
            <c:if test="${currentPage == pp }">
                <a style="color: green; text-decoration: none; cursor: pointer;" href="list?currentPage=${pp}">${pp}</a>
            </c:if>
            <c:if test="${currentPage != pp }">
                <a style="color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${pp}">${pp}</a>
            </c:if>
            &nbsp;
        </c:forEach>
        <!-- 다음 -->
        <c:if test="${endPage < totalPage}">
            <a style="color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${endPage+1}">다음</a>
        </c:if>
        <c:if test="${endPage >= totalPage}">
            <a style="color: black; text-decoration: none; cursor: pointer; visibility: hidden;" href="list?currentPage=${endPage+1}">다음</a>
        </c:if>
    </div>
</body>
</div>
<div class="rb_popupLayer">
    <div>
        <span onClick="closeLayer(this)" style="cursor:pointer;font-size:1.5em" title="닫기">X</span>
    </div>
    여긴 레이어~</br>
    클릭하면 바로 나타나는 레이어에요^^
</div>
<script>
    function closeLayer( obj ) {
        $(obj).parent().parent().hide();
    }

    $(function(){

        /* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
        $('.rb_imgSelect').click(function(e)
        {
            var sWidth = window.innerWidth;
            var sHeight = window.innerHeight;

            var oWidth = $('.rb_popupLayer').width();
            var oHeight = $('.rb_popupLayer').height();

            // 레이어가 나타날 위치를 셋팅한다.
            var divLeft = e.clientX + 10;
            var divTop = e.clientY + 5;

            // 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
            if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
            if( divTop + oHeight > sHeight ) divTop -= oHeight;

            // 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
            if( divLeft < 0 ) divLeft = 0;
            if( divTop < 0 ) divTop = 0;

            $('.rb_popupLayer').css({
                "top": divTop,
                "left": divLeft,
                "position": "absolute"
            }).show();
        });

    });




</script>

</html>