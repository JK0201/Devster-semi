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
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
        body, body * {
            font-family: 'Jua'
        }

        /*리뷰 별점 css*/
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

        /*회사 별점*/
        .star-ci_star {
            /*   border: solid 1px #ccc;*/
            display: flex;
            /*  flex-direction: row-reverse;*/
            font-size: 1.5em;
            justify-content: space-around;
            padding: 0 .2em;
            text-align: center;
            width: 5em;
        }

        .star-ci_star input {
            display: none;
        }

        .star-ci_star label {
            color: #ccc;
            /* cursor: pointer;*/
        }

        .star-ci_star :checked ~ label {
            color: #f90;
        }
        .star-ci_star_list{
            display: flex;
            /*  flex-direction: row-reverse;*/
            font-size: 1.5em;
            justify-content: space-around;
            padding: 0 .2em;
            text-align: center;
            width: 5em;
        }

        .star-ci_star_list input {
            display: none;
        }

        .star-ci_star_list label {
            color: #ccc;
            cursor: pointer;
            font-size: 1.5em;
        }

        .star-ci_star_list :checked ~ label {
            color: #f90;
        }


        .clear:after { /* 자식이 모두 float 을 사용할때 부모가 높이를 갖게하기 위함 */
            content: "";
            display: block;
            clear: both;

        }

        /*회사 정보 css*/
        .rb_listc {
            border: 1px solid black;
            width: 200px;
            height: 250px;
            float: left;

        }

        .imgSelect {
            cursor: pointer;
        }

        .popupLayer {
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
        onclick="location.href='./reviewriterform'" style="margin-bottom: 10px">상품등록
</button>

<select id="rb_typelist" onchange="rb_typelist()">
    <option value="0">전체보기</option>
    <option value="1">면접</option>
    <option value="2">코딩테스트</option>
    <option value="3">합격</option>
</select>

<h5 class="alert alert-success">
    총 ${totalCount}개의 글이 등록되어있습니다</h5><br>

<div class="rb_listmain clear">

    <c:forEach var="dto" items="${list}" varStatus="i">
        <div class="review" data-type="${dto.rb_type}">

            <div class="rb_listc">
                <p>
                    <img class="imgSelect" src="${dto.ci_photo}" data-ci-idx="${dto.ci_idx}"
                         onclick="showCompanyInfo('${dto.ci_idx}')"/>

                </p>

                <span> ${dto.ci_star}</span> &nbsp;
                <span class="star-ci_star">
                    <c:forEach var="i" begin="1" end="5">
                        <input type="radio" id="rating${i}" name="rating" value="${i}"
                               <c:if test="${i eq dto.ci_star}">checked="checked"</c:if> />
                        <label for="rating${i}" class="star"
                               <c:if test="${i le dto.ci_star}">style="color: orange;"</c:if>>★</label>
                    </c:forEach>
                </span>


            </div>

            <div class="rb_listm">

                게시글 번호 : ${i.count}<br>
                <p id="like-${dto.rb_idx}">좋아요:${dto.rb_like}</p>
                <p id="dislike-${dto.rb_idx}">싫어요: ${dto.rb_dislike}</p>

                    <%--별점: ${dto.rb_star}--%>
                <div class="star-rb_star">
                    <c:forEach var="i" begin="1" end="5">
                        <input type="radio" id="rating${i}" name="rating" value="${i}"
                               <c:if test="${i eq dto.rb_star}">checked="checked"</c:if> />
                        <label for="rating${i}" class="star"
                               <c:if test="${i le dto.rb_star}">style="color: orange;"</c:if>>★</label>
                    </c:forEach>
                </div>
                작성자 : ${dto.nickName}<br>
                작성일 :${dto.rb_writeday}<br>
                타입 :${dto.rb_type == 1 ? "면접" : dto.rb_type == 2 ? "코딩테스트": dto.rb_type == 3 ? "합격" : ""}<br>
                내용 : <br>
                <b>
                    <pre>${dto.rb_content}</pre>
                </b><br>
            </div>
            <c:set var="m_idx" value="${sessionScope.memidx}"/>
            <c:if test="${dto.m_idx eq m_idx}">
                <button type="button" class="btn btn-sm btn-outline-primary"
                        onclick="location.href='./updateform?rb_idx=${dto.rb_idx}'" style="margin-bottom: 10px">글 수정
                </button>
                <button type="button" class="btn btn-sm btn-outline-primary"
                        onclick="delreview(${dto.rb_idx})" style="margin-bottom: 10px">글 삭제
                </button>
            </c:if>
            <button type="button" onclick="like(${dto.rb_idx},${dto.rb_like})" id="btnlike">좋아요</button>
            <button type="button" onclick="dislike(${dto.rb_idx},${dto.rb_dislike})" id="btndislike">싫어요</button>
            <hr>

        </div>
    </c:forEach>
</div>

<!-- 폼 레이어  -->
<div class="popupLayer">
    <div onClick="closeLayer(this)" style="cursor:pointer;font-size:1.5em" title="닫기">X</div>
    <div class="alist" style="float: left; margin-right: 200px" ;>

    </div>

</div>


<script>
    <%--삭제 이벤트--%>

    function delreview(rb_idx) {
        if (confirm("삭제하시겠습니까?")) {
            location.href = "./delete?rb_idx=" + rb_idx;
        }
    }

    function like(rb_idx, rb_like) {


        $.ajax({
            type: "post",
            url: "./like",
            data: {"rb_idx": rb_idx},
            dataType: "json",
            success: function (response) {
                $("#btnlike").prop("disabled", true);
                $("#btndislike").prop("disabled", true);

                alert("좋아요를 눌렀어요.");
            }
        });
        $("#like-" + rb_idx).text("좋아요 : " + (rb_like + 1));


    }

    function dislike(rb_idx, rb_dislike) {


        $.ajax({
            type: "post",
            url: "./dislike",
            data: {"rb_idx": rb_idx},
            dataType: "json",
            success: function (response) {
                $("#btnlike").prop("disabled", true);
                $("#btndislike").prop("disabled", true);


                alert("싫어요를 눌렀어요.");
            }
        });
        $("#dislike-" + rb_idx).text("좋아요 : " + (rb_dislike + 1));


    }

    /*popup 레이어 */
    function closeLayer(obj) {
        $(obj).parent().hide();
    }

    $(function () {
        /* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
        $('.imgSelect').click(function (e) {
            var sWidth = window.innerWidth;
            var sHeight = window.innerHeight;
            var oWidth = $('.popupLayer').width();
            var oHeight = $('.popupLayer').height();

            // 현재 스크롤 위치까지 더해진 클릭 위치를 구합니다.
            var divLeft = e.clientX + window.scrollX + 10;
            var divTop = e.clientY + window.scrollY + 5;

            // 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치합니다.
            if (divLeft + oWidth > sWidth) divLeft -= oWidth;
            if (divTop + oHeight > sHeight) divTop -= oHeight;

            // 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치합니다.
            if (divLeft < 0) divLeft = 0;
            if (divTop < 0) divTop = 0;

            $('.popupLayer').css({
                "top": divTop,
                "left": divLeft,
                "position": "absolute"
            }).show();
        });
    });

    //레이어에 출력 함수

    function showCompanyInfo(ci_idx) {
        $.ajax({
            url: "getCompanyInfo",
            type: "GET",
            dataType: "JSON",
            data: {"ci_idx": ci_idx},
            success: function (res) {
                let s = "";
                const formatter = new Intl.NumberFormat('ko-KR', {
                    style: 'currency',
                    currency: 'KRW',
                });
                $.each(res, function (idx, ele) {
                    const ciSaleFormatted = formatter.format(ele.ci_sale);
                    const ciSalFormatted = formatter.format(ele.ci_sal);

                    s += `
                   <pre>
    회사이름: \${ele.ci_name}
    사원수: \${ele.ci_ppl} 명
    매출액: \${ciSaleFormatted}
    연봉: \${ciSalFormatted}
    별점:
    <span class="star-ci_star_list">
      <c:forEach var="i" begin="1" end="5">
        <input type="radio" id="rating${i}" name="rating" value="${i}" <c:if test="${i} eq ${ele.ci_star}">checked="checked"</c:if> />
        <label for="rating${i}" class="star" <c:if test="${i} le ${ele.ci_star}">style="color: orange;"</c:if>>★</label>
      </c:forEach>

    </span>
  </pre>
                  `
                });
                $("div.alist").html(s);
            }
        });
    };


    //리뷰 select 결과만 출력

    function rb_typelist() {
        // 선택한 리뷰 유형 가져오기
        var selectedType = document.getElementById("rb_typelist").value;

        // 모든 리뷰 div 요소 가져오기
        var reviewDivs = document.querySelectorAll(".review");

        // 각 리뷰 div 요소를 반복하며 필터링
        reviewDivs.forEach(function (reviewDiv) {
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


<%--페이징 처리--%>
<div style="width: 700px; text-align: center; font-size: 20px">
    <!-- 이전 -->
    <c:if test="${startPage > 1}">
        <a style="color: black; text-decoration: none; cursor: pointer;" href="list?currentPage=${startPage-1}">이전</a>
    </c:if>
    <c:if test="${startPage <= 1}">
        <a style="color: black; text-decoration: none; cursor: pointer; visibility: hidden;"
           href="list?currentPage=${startPage-1}">이전</a>
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
        <a style="color: black; text-decoration: none; cursor: pointer; visibility: hidden;"
           href="list?currentPage=${endPage+1}">다음</a>
    </c:if>
</div>

</body>
</html>