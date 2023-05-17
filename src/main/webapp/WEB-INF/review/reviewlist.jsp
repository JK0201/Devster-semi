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
            /*flex-direction: row-reverse;*/
            font-size: 1.5em;
            justify-content: space-around;
            /*  padding: 0 .2em;*/
            /*      text-align: center;*/
            width: 5em;
            float: left;
            padding-left: 90px;
        }

        .star-ci_star_list input {
            display: none;
        }

        /* .star-ci_star_list label {
             color: #ccc;
             cursor: pointer;
             font-size: 1.5em;
         }

         .star-ci_star_list :checked ~ label {
             color: #f90;
         }
 */

        .clear:after { /* 자식이 모두 float 을 사용할때 부모가 높이를 갖게하기 위함 */
            content: "";
            display: block;
            clear: both;

        }

        /*회사 정보 css*/
        .rb_listc {
            border: 0px;
            width: 200px;
            height: 250px;
            float: left;
            margin-right:2px;
            /*margin-left: 4px;*/
            /*text-align: left;*/

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

        .already-added {
            background-color: #0D3EA3;
            color: white;
        }

        .star_listc{
            margin-left: 35px;
        }
#quanbu{
    width: 1400px;
    padding-left: 230px;}

        /* 서치바 */
        .searchdiv{
            /*position: absolute;*/
            position: relative;
        }
        .searchbar{
            width: 736px;
            height: 60px;
            padding: 0 10px 0 62px;
            border: 2px solid #222;
            border-radius: 30px;
            font-size: 18px;
            box-sizing: border-box;
        }

        .bi-search {
            position: absolute;
            right: 5px; /* 아이콘과 입력란 사이의 공간을 조절합니다. */
            top: 31px;
            left: 27px;
            transform: translateY(-50%); /* 아이콘을 입력란의 정중앙에 배치합니다. */
            pointer-events: none; /* 입력란 위에서 클릭이나 기타 동작이 가능하게 합니다. */
            font-size: 24px;
        }

        .review{
            width:775px;
            height:330px;
            border-top: 1px solid lightgray;
            border-radius: 0px;
            float: left;
            /*margin-right: 30px;*/
            /*padding-left: 20px;*/
            padding-top: 24px;
            padding-right: 20px;
        }

        .custom-btn{
            color: gray ;
            border-color: gray ;

        }

        .custom-btn:hover{
            background-color: gray;
            border-color: gray;
        }

    </style>
    </head>

<body>
<!-- 검색창 -->
<div class="searchdiv">
    <input id="searchinput" name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off" class="searchbar">
    <i class="bi bi-search"></i>

    <select id="searchOption">
        <option id="all" value="all">전체검색</option>
        <option id="searchnickname" value="m_nickname">작성자 검색</option>
        <option id="searchsubject" value="rb_content">내용 검색</option>
    </select>
</div>
<br><br>

<script>

    $("#searchinput").keydown(function (e){

        // 일단은 엔터 눌러야 검색되는걸로 -> 나중에 뭐 클릭해도 검색되게 바꿔도될듯?
        if(e.keyCode==13){
            // 검색내용
            var keyword = $(this).val();
            var searchOption = $("#searchOption").val();
            console.log(keyword);
            console.log(searchOption);

            // null 값 검색시 -> 아무일도 안일어남
            if(keyword==''){
                alert("검색하실 내용을 입력해주세요.")
                return
            } else {
                //alert("검색결과출력.");

                $.ajax({
                    type: "post",
                    url: "./reviewboardsearchlist",
                    data: {"keyword":keyword, "searchOption":searchOption},
                    dataType: "json",
                    success: function (res) {
                        let s = '';

                        $.each(res, function (idx, ele) {

                            s += `번호 : \${ele.rb_idx}<br>`;
                            s += `작성자 : \${ele.m_nickname}<br>`;
                            s += `ci_idx : \${ele.ci_idx}<br>`;

                            s += `내용 : \${ele.rb_content}<br>`;
                            s += `타입 : \${ele.rb_type}<br>`;
                            s += `검색한내용 : \${ele.keyword}<br>`;
                            s += `검색 카테고리 : \${ele.searchOption}<br>`;
                            s += `작성일 : \${ele.rb_writeday}<br>`;

                            s += `좋아요 : \${ele.rb_like}<br>`;
                            s += `싫어요 : \${ele.rb_dislike}<br>`;
                            s += `별점 : \${ele.rb_star}<br><hr>`;



                        })
                        $("#quanbu").html(s);
                    },
                    error: function (xhr, status, error) {
                        // 요청이 실패했을 때의 처리 로직
                        console.log("Error:", error);
                    }
                });
            }
        }
    });

</script>

<div id="quanbu">
<%--<button type="button" class="btn btn-sm btn-outline-danger"--%>
<%--        onclick="location.href='./reviewriterform'" style="margin-bottom: 10px">상품등록--%>
<%--</button>--%>



<%--<h5 class="alert alert-success">--%>
<%--    총 ${totalCount}개의 글이 등록되어있습니다</h5><br>--%>

<div class="rb_listmain clear">
    <div class="headbox">
        <h4 style="color: black; font-weight: bold;"><i class="bi bi-journal-code" style="font-size: 25px;"></i>&nbsp;리뷰게시판
            <button class="btn btn-secondary" type="button"
                    style="float: right; margin-right: 150px; "
                    onclick="location.href='./reviewriterform'"><i class="bi bi-pen"></i>&nbsp;글쓰기
            </button>
        </h4>
                <b>총 ${totalCount}개의 게시글</b><br>
    </div>
    <select id="rb_typelist" onchange="rb_typelist()">
        <option value="0">전체보기</option>
        <option value="1">면접</option>
        <option value="2">코딩테스트</option>
        <option value="3">합격</option>
    </select>
    <br>
    <br>

    <c:forEach var="dto" items="${list}" varStatus="i">
        <script>
            <%--    현재 버튼이 눌려있는지 확인해서 상태에 따라 버튼에 색상표시  --%>
            function checkAddRpBefore() {
                <!-- 변수값에 따라 각 id가 부여된 버튼에 클래스 추가(이미 눌려있다는 색상 표시) -->
                if (isAlreadyAddGoodRp${dto.rb_idx} == true) {
                    $("#add-goodRp-btn"+${dto.rb_idx}).addClass("already-added");
                } else if (isAlreadyAddBadRp${dto.rb_idx} == true) {
                    $("#add-badRp-btn"+${dto.rb_idx}).addClass("already-added");
                } else {
                    return;
                }
                $(function() {
                    checkAddRpBefore();
                });
            };
        </script>
        <div class="review" data-type="${dto.rb_type}">

            <div class="rb_listc">
                <p>
                    <img class="imgSelect" src="${dto.ci_photo}" data-ci-idx="${dto.ci_idx}"
                         onclick="showCompanyInfo('${dto.ci_idx}')"/>

                </p>
                <div class="star_listc">
                &nbsp;<span> ${dto.ci_star}</span> &nbsp;
                <span class="star-ci_star">
                    <c:forEach var="i" begin="1" end="5">
                        <input type="radio" id="rating${i}" name="rating" value="${i}"
                               <c:if test="${i eq dto.ci_star}">checked="checked"</c:if> />
                        <label for="rating${i}" class="star"
                               <c:if test="${i le dto.ci_star}">style="color: orange;"</c:if>>★</label>
                    </c:forEach>
                </div>
                </span>


            </div>

            <div class="rb_listm">

                게시글 번호 : ${i.count}<br>
                    ${dto.rb_idx}

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
                </b>
<%--                <br>--%>
                <div class="fncbtn" style="text-align:right;">
                <c:set var="m_idx" value="${sessionScope.memidx}"/>
                <c:if test="${dto.m_idx eq m_idx}">
                    <button type="button" class="btn btn-sm btn-outline-primary custom-btn"
                            onclick="location.href='./updateform?rb_idx=${dto.rb_idx}'" style="margin-bottom: 10px">글 수정
                    </button>
                    <button type="button" class="btn btn-sm btn-outline-primary custom-btn"
                            onclick="delreview(${dto.rb_idx})" style="margin-bottom: 10px">글 삭제
                    </button>
                </c:if>
                    <%--            좋아요 / 싫어요 버튼--%>
                <span id="add-goodRp-btn${dto.rb_idx}" class="btn btn-outline" style="margin-bottom: 10px" >
                   👍
                  <span class="add-goodRp${dto.rb_idx} ml-2" style="margin-bottom: 10px">${dto.rb_like}</span>
                </span>
                <span id="add-badRp-btn${dto.rb_idx}" class="ml-5 btn btn-outline" style="margin-bottom: 10px">
                   👎
                  <span class="add-badRp${dto.rb_idx} ml-2" style="margin-bottom: 10px">${dto.rb_dislike}</span>
                </span>
                </div>
            </div>

<%--            <hr>--%>

        </div>
        <script>
            var isAlreadyAddGoodRp${dto.rb_idx} = ${dto.isAlreadyAddGoodRp};
            var isAlreadyAddBadRp${dto.rb_idx} = ${dto.isAlreadyAddBadRp};
            checkAddRpBefore();
        </script>
        <script>
            <%--        버튼 상태 관련 이벤트  --%>
            $(document).ready(function() {

                <!-- 좋아요 버튼 클릭 이벤트 및 ajax 실행 -->
                $("#add-goodRp-btn${dto.rb_idx}").click(function() {

                    <!-- 이미 싫어요가 눌려 있는 경우 반려 -->
                    if (isAlreadyAddBadRp${dto.rb_idx} == true) {
                        alert('이미 싫어요를 누르셨습니다.');
                        return;
                    }

                    <!-- 좋아요가 눌려 있지 않은 경우 좋아요 1 추가 -->
                    if (isAlreadyAddGoodRp${dto.rb_idx} == false) {
                        $.ajax({
                            url : "/review/increaseGoodRp",
                            type : "POST",
                            data : {
                                "rb_idx" : ${dto.rb_idx},
                                "m_idx" : ${sessionScope.memidx}
                            },
                            success : function(goodReactionPoint) {
                                $("#add-goodRp-btn${dto.rb_idx}").addClass("already-added");
                                $(".add-goodRp${dto.rb_idx}").html(goodReactionPoint);
                                isAlreadyAddGoodRp${dto.rb_idx} = true;
                            },
                            error : function() {
                                alert('서버 에러, 다시 시도해주세요.');
                            }
                        });

                        <!-- 이미 좋아요가 눌려 있는 경우 좋아요 1 감소 -->
                    } else if (isAlreadyAddGoodRp${dto.rb_idx} == true){
                        $.ajax({
                            url : "/review/decreaseGoodRp",
                            type : "POST",
                            data : {
                                "rb_idx" : ${dto.rb_idx},
                                "m_idx" : ${sessionScope.memidx}
                            },
                            success : function(goodReactionPoint) {
                                $("#add-goodRp-btn${dto.rb_idx}").removeClass("already-added");
                                $(".add-goodRp${dto.rb_idx}").html(goodReactionPoint);
                                isAlreadyAddGoodRp${dto.rb_idx} = false;
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
                $("#add-badRp-btn${dto.rb_idx}").click(function() {

                    <!-- 이미 좋아요가 눌려 있는 경우 반려 -->
                    if (isAlreadyAddGoodRp${dto.rb_idx} == true) {
                        alert('이미 좋아요를 누르셨습니다.');
                        return;
                    }

                    <!-- 싫어요가 눌려 있지 않은 경우 싫어요 1 추가 -->
                    if (isAlreadyAddBadRp${dto.rb_idx} == false) {
                        $.ajax({
                            url : "/review/increaseBadRp",
                            type : "POST",
                            data : {
                                "rb_idx" : ${dto.rb_idx},
                                "m_idx" : ${sessionScope.memidx}
                            },
                            success : function(badReactionPoint) {
                                $("#add-badRp-btn${dto.rb_idx}").addClass("already-added");
                                $(".add-badRp${dto.rb_idx}").html(badReactionPoint);
                                isAlreadyAddBadRp${dto.rb_idx} = true;
                            },
                            error : function() {
                                alert('서버 에러, 다시 시도해주세요.');
                            }
                        });

                        <!-- 이미 싫어요가 눌려 있는 경우 싫어요 1 감소 -->
                    } else if (isAlreadyAddBadRp${dto.rb_idx} == true) {
                        $.ajax({
                            url : "/review/decreaseBadRp",
                            type : "POST",
                            data : {
                                "rb_idx" : ${dto.rb_idx},
                                "m_idx" : ${sessionScope.memidx}
                            },
                            success : function(badReactionPoint) {
                                $("#add-badRp-btn${dto.rb_idx}").removeClass("already-added");
                                $(".add-badRp${dto.rb_idx}").html(badReactionPoint);
                                isAlreadyAddBadRp${dto.rb_idx} = false;
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
    </c:forEach>
</div>
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

                    const ciSalFormatted = formatter.format(ele.ci_sal);
                    let stars = '';
                    for(let i = 1; i <= 5; i++){
                        stars += `<input type="radio" id="rating${i}" name="rating" value="${i}" \${(i === ele.ci_star) ? 'checked="checked"' : ''} />
                    <label for="rating${i}" class="star" \${(i <= ele.ci_star) ? 'style="color: orange;"' : 'style="color: #ccc;"'}>★</label>`;
                    }
                    s += `
          <pre>
            회사이름: \${ele.ci_name}
            사원수: \${ele.ci_ppl} 명
            매출액: \${ele.ci_sale}
            연봉: \${ciSalFormatted}
            별점:
            <span class="star-ci_star_list" style="float: left">
              \${stars}
            </span>
          </pre>
        `;
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

<script>
    <%--    현재 버튼이 눌려있는지 확인해서 상태에 따라 버튼에 색상표시  --%>
    function checkAddRpBefore(rb_idx,isAlreadyAddGoodRp,isAlreadyAddBadRp) {
        <!-- 변수값에 따라 각 id가 부여된 버튼에 클래스 추가(이미 눌려있다는 색상 표시) -->
        if (isAlreadyAddGoodRp == true) {
            $("#add-goodRp-btn"+rb_idx).addClass("already-added");
        } else if (isAlreadyAddBadRp == true) {
            $("#add-badRp-btn"+rb_idx).addClass("already-added");
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