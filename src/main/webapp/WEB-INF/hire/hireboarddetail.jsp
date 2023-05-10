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

        .divparent{
            margin-left:350px;
        }


        .already-added {
            color: red;

        }

        #add-bkmk-btn:hover{
            cursor:pointer;
        }

    </style>

    <script>
        <%--        버튼 상태 관련 이벤트  --%>
        $(document).ready(function() {
            <!-- jsp 실행 이전의 리액션 여부 체크 및 버튼 색상 표현 -->
            $(function() {
                checkAddBkmkBefore();
            });
            <!-- 좋아요 버튼 클릭 이벤트 및 ajax 실행 -->
            $("#add-bkmk-btn").click(function() {
                <!-- 북마크가 눌려 있지 않은 경우  추가 -->
                if (isAlreadyAddBkmk == false) {
                    $.ajax({
                        url : "/hire/increaseBkmk",
                        type : "POST",
                        data : {
                            "m_idx" : ${sessionScope.memidx},
                            "hb_idx" : ${dto.hb_idx}
                        },
                        success : function(goodReactionPoint) {
                            $("#add-bkmk-btn").addClass("already-added");
                            // $(".add-bookMark").html(goodReactionPoint);
                            isAlreadyAddBkmk = true;
                        },
                        error : function() {
                            alert('서버 에러, 다시 시도해주세요.');
                        }
                    });

                    <!-- 이미 북마크가 눌려 있는 경우 북마크 취소 -->
                } else if (isAlreadyAddBkmk == true){
                    $.ajax({
                        url : "/hire/decreaseBkmk",
                        type : "POST",
                        data : {
                            "m_idx" : ${sessionScope.memidx},
                            "hb_idx" : ${dto.hb_idx}
                        },
                        success : function(goodReactionPoint) {
                            $("#add-bkmk-btn").removeClass("already-added");
                            // $(".add-bookMark").html(goodReactionPoint);
                            isAlreadyAddBkmk = false;
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
<%--로그인 : ${sessionScope.logstat}--%>
<%--<br>--%>
<%--m_idx : ${sessionScope.memidx}--%>
<%--<br>--%>
<%--nickname : ${sessionScope.memnick}--%>
<%--<br>--%>
<%--state : ${sessionScope.memstate}--%>
<%--<br>--%>
<%--ai_idx : ${sessionScope.acaidx}--%>

<div class="divparent">
<div>
    <br style="clear: both;"><br>
    제목 : ${dto.hb_subject}<br>
    내용 : ${dto.hb_content}<br>
    작성자 (hb_idx) : ${dto.hb_idx}<br>
    조회수: ${dto.hb_readcount}<br>
    작성일 :  <fmt:formatDate value="${dto.fb_writeday}" pattern="yyyy.MM.dd"/><br>

<%--    <c:if test="${dto.hb_photo!='no'}">--%>
<%--        사진 주소 : ${dto.hb_photo}--%>
        <c:forEach items="${list}" var="images">
        <img src="http://${imageUrl}/hire/${images}" style="float: left">
        <br style="clear: both;"><br>
        </c:forEach>
<%--    </c:if><br><hr>--%>
</div>
<div>
<%--    <c:if test="${sessionScope.memdix==dto.hb_idx}">--%>
    <button type="button" class="btn btn-sm btn-outline-success" onclick="location.href='./hireupdateform?hb_idx=${dto.hb_idx}&currentPage=${currentPage}'">수정</button>
    <button type="button" class="btn btn-sm btn-outline-success" onclick="del(${dto.hb_idx})">삭제</button>
<%--    </c:if>--%>
    <button type="button" class="btn btn-sm btn-outline-success" onclick="location.href='./list?currentPage=${currentPage}'">목록</button>

<%--    <c:if test="${bdto.hb_idx}">--%>
    &nbsp;
<%--    <i class="bi bi-bookmark bookmark"  style=" width:25px;" id="add-bkmk-btn" ></i>--%>
    <span id="add-bkmk-btn" class="btn btn-outline" >
                  북마크👍
                </span>
<%--    </c:if>--%>
<%--    <c:if test="${bdto.list}">&nbsp;--%>
<%--    <i class="bi bi-bookmark bookmark-fill" id="bookmark-icon2" style="" hb_idx="${dto.hb_idx}"></i>--%>
<%--    </c:if>--%>


</div>
</div>

<script>
    function del(hb_idx) {
        if (confirm("삭제하시겠습니까?")) {
            location.href = "./hireboarddelete?hb_idx=" + hb_idx
        }
    }

    <%--    현재 버튼이 눌려있는지 확인해서 상태에 따라 버튼에 색상표시  --%>
    var isAlreadyAddBkmk = ${isAlreadyAddBkmk};

    function checkAddBkmkBefore() {
        <!-- 변수값에 따라 각 id가 부여된 버튼에 클래스 추가(이미 눌려있다는 색상 표시) -->
        if (isAlreadyAddBkmk == true) {
            $("#add-bkmk-btn").addClass("already-added");
        } else {
            return;
        }
        $(function() {
            checkAddBkmkBefore();
        });
    };



    <%--    $(function(){--%>
    <%--    $(document).on("click",".bookmark",function(e){--%>

    <%--        let b=confirm("해당 글을 북마크하시겠습니까?");--%>
    <%--        if(b) {--%>
    <%--            let hb_idx=$(this).attr("hb_idx");--%>
    <%--            $.ajax({--%>
    <%--                type:"get",--%>
    <%--                url:"./bookmarkhireboard",--%>
    <%--                data:{"m_idx":${sessionScope.memidx}, "hb_idx":hb_idx},--%>
    <%--                dataType:"text",--%>
    <%--                success:function(){--%>
    <%--                    alert("북마크되었습니다");--%>


    <%--                }--%>
    <%--            });--%>
    <%--        }--%>

    <%--    });--%>
    <%--});--%>

</script>

</body>
</html>
