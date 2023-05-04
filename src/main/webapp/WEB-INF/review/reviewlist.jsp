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
        .star-rb_star {

            display:flex;
            flex-direction: row-reverse;
            /*font-size:1.5em;*/
            justify-content:space-around;
            padding:0 .2em;
            text-align:right;
            width:5em;

        }

        .star-rb_star input {
            display:none;
        }
        .star-rb_star label {
            color: #ccc;
            cursor: pointer;
        }
        .star-rb_star label {
            color: rgb(246, 235, 7);
            cursor:pointer;
        }
        .clear:after{    /* 자식이 모두 float 을 사용할때 부모가 높이를 갖게하기 위함 */
            content:"";
            display:block;
            clear:both;

        }
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

<c:forEach var="dto" items="${listp}" varStatus="i">
    <div class="review" data-type="${dto.rb_type}">
    <div class="rb_listc">
        <p>
            <a class="rb_imgSelect">클릭1</a>
        </p>
    </div>

    <div class="rb_listm">
    게시글 번호 : ${i.count}
    </div>
<div class="star-rb_star">

    <c:choose>
    <c:when test="${dto.rb_star == 1}">
    <input type="radio" id="1-stars" name="rb_star" value="1"  checked="checked" />
    <label for="1-stars" class="star">&#9733;</label>
        <input type="radio" id="2-stars" name="rb_star" value="2" />
        <label for="2-stars" class="star">&#9733;</label>
        <input type="radio" id="3-stars" name="rb_star" value="3" />
        <label for="3-stars" class="star">&#9733;</label>
        <input type="radio" id="4-stars" name="rb_star" value="4" />
        <label for="4-stars" class="star">&#9733;</label>
        <input type="radio" id="5-stars" name="rb_star" value="5" />
        <label for="5-stars" class="star">&#9733   </label>
    </c:when>
    <c:when test="${dto.rb_star == 2}">
        <input type="radio" id="1-stars" name="rb_star" value="1"   />
        <label for="1-stars" class="star">&#9733;</label>
        <input type="radio" id="2-stars" name="rb_star" value="2" checked="checked"/>
        <label for="2-stars" class="star">&#9733;</label>
        <input type="radio" id="3-stars" name="rb_star" value="3" />
        <label for="3-stars" class="star">&#9733;</label>
        <input type="radio" id="4-stars" name="rb_star" value="4" />
        <label for="4-stars" class="star">&#9733;</label>
        <input type="radio" id="5-stars" name="rb_star" value="5" />
        <label for="5-stars" class="star">&#9733   </label>
    </c:when>
    <c:when test="${dto.rb_star == 3}">
    <input type="radio" id="1-stars" name="rb_star" value="1" checked="checked" />
    <label for="1-stars" class="star">&#9733;</label>
    <input type="radio" id="2-stars" name="rb_star" value="2" />
    <label for="2-stars" class="star">&#9733;</label>
    <input type="radio" id="3-stars" name="rb_star" value="3" />
    <label for="3-stars" class="star">&#9733;</label>
    </c:when>
    <c:when test="${dto.rb_star == 4}">
    <input type="radio" id="1-stars" name="rb_star" value="1" checked="checked" />
    <label for="1-stars" class="star">&#9733;</label>
    <input type="radio" id="2-stars" name="rb_star" value="2" />
    <label for="2-stars" class="star">&#9733;</label>
    <input type="radio" id="3-stars" name="rb_star" value="3" />
    <label for="3-stars" class="star">&#9733;</label>
    <input type="radio" id="4-stars" name="rb_star" value="4" />
    <label for="4-stars" class="star">&#9733;</label>
    </c:when>
        <c:when test="${dto.rb_star == 5}">
    <input type="radio" id="1-star" name="rb_star" value="1"  />
    <label for="1-star" class="star">&#9733;</label>
    <input type="radio" id="2-stars" name="rb_star" value="2" />
    <label for="2-stars" class="star">&#9733;</label>
    <input type="radio" id="3-stars" name="rb_star" value="3" />
    <label for="3-stars" class="star">&#9733;</label>
    <input type="radio" id="4-stars" name="rb_star" value="4" />
    <label for="4-stars" class="star">&#9733;</label>
    <input type="radio" id="5-stars" name="rb_star" value="5" checked="checked"/>
    <label for="5-stars" class="star">&#9733   </label>
        </c:when>
    </c:choose>
</div>
    작성일 :${dto.rb_writeday}<br>
    타입 :${dto.rb_type == 1 ? "면접" : dto.rb_type == 2 ? "코딩테스트": dto.rb_type == 3 ? "합격" : ""}<br>
    내용 : <br><b>${dto.rb_content}</b><br>
    <button type="button" class="btn btn-sm btn-outline-primary"
            onclick="location.href='./updateform?rb_idx=${dto.rb_idx}'" style="margin-bottom: 10px">글 수정</button>
        <button type="button" class="btn btn-sm btn-outline-primary"
               onclick="delreview(${dto.rb_idx})" style="margin-bottom: 10px" >글 삭제</button>

        <%--삭제 이벤트--%>
        <script>
            function delreview(rb_idx) {
                if (confirm("삭제하시겠습니까?")) {
                    location.href = "./delete?rb_idx=" + rb_idx;
                }
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