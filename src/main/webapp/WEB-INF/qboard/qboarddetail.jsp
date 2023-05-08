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
        $(document).ready(function (){
            answer();
        })
    </script>
</head>
<body>
<div class="fullOutLine">
    <div class="questionBox" style="border: 3px solid black; margin-top: 60px; margin-left: 100px; width: 600px">
        <h1>
            제목 : ${dto.qb_subject}
        </h1>
        <h6 style="color: #94969B">
            조회 ${dto.qb_readcount}
        </h6>
        <br>
        <h2 class="userInfo">
            <img src="${profilePhoto}" style="width:50px; height: 50px; border:3px solid black; border-radius:100px;">
            작성자 : ${nickname}
        </h2>
        <br>
        <h2>
            작성일자 : ${dto.qb_writeday}
        </h2>
        <br>
        <c:if test="${dto.qb_dislike > 19}">
            <p class="blind" style="color: red; font-size: 30px; cursor: pointer">블라인드 처리된 게시글 입니다.</p>
            <div class="content" hidden="hidden">
                <h3>
                    내용 : ${dto.qb_content}
                </h3>
                <br>
                <c:choose>
                    <c:when test="${list[0] == 'n'}">
                        <!-- 이미지가 없을 때는 아무것도 출력하지 않음 -->
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${list}" var="images">
                            <img src="http://${imageUrl}/qboard/${images}" style="float: left; width: 300px">
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
        <c:if test="${dto.qb_dislike < 20}">
                <h3>
                    내용 : ${dto.qb_content}
                </h3>
                <br>
            <c:choose>
                <c:when test="${list[0] == 'n'}">
                    <!-- 이미지가 없을 때는 아무것도 출력하지 않음 -->
                </c:when>
                <c:otherwise>
                    <c:forEach items="${list}" var="images">
                        <img src="http://${imageUrl}/qboard/${images}" style="float: left; width: 300px">
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </c:if>
        <br>

        <div class="buttons" style="clear: both">
            <c:if test="${dto.m_idx == sessionScope.memidx}">
                <button class="btn btn-outline-dark" type="button"
                        onclick="deletePost(${dto.qb_idx})">
                    삭제
                </button>
                <button class="btn btn-outline-dark" type="button"
                        onclick="location.href='updateform?qb_idx=${dto.qb_idx}&currentPage=${currentPage}'">
                    수정
                </button>
            </c:if>
            <button type="button" onclick="like()" id="btnlike" class="btn btn-success">좋아요 <span
                    id="likeCount">${dto.qb_like}</span></button>
            <button type="button" onclick="dislike()" id="btndislike" class="btn btn-danger">싫어요 <span
                    id="dislikeCount">${dto.qb_dislike}</span></button>
            <button class="btn btn-warning" type="button" onclick="location.href='./list?currentPage=${currentPage}'">
                목록
            </button>
            <button class="btn btn-warning" type="button" onclick="location.href='./writeform'">
                글쓰기
            </button>
        </div>
    </div>
    <div class="answerInsertBox" style="margin-left: 100px; width: 600px; border: 3px solid black">
        <form name="aboardInsert">
            <h3>Answer</h3>
            <textarea id="aboardContent" class="form-control" name="ab_content"></textarea>
            <input id="aboardPhoto" class="form-control" type="file" multiple name="upload"><br>
            <button type="button" id="submit" class="btn btn-outline-dark" style="position: relative; right: -91%">작성</button>
        </form>
    </div>
    <div class="answerPrintBox" style="margin-left: 100px; width: 600px; border: 3px solid black">

    </div>
</div>



</body>

<script>
    function like() {
        let qb_idx = ${dto.qb_idx};

        $.ajax({
            type: "post",
            url: "./like",
            data: {"qb_idx": qb_idx},
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
        let qb_idx = ${dto.qb_idx}

            $.ajax({
                type: "post",
                url: "./dislike",
                data: {"qb_idx": qb_idx},
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

    //댓글 불러오기
    function answer() {
        $.ajax({
            type: "post",
            url: "/aboard/list",
            data: { "qb_idx": ${dto.qb_idx} },
            dataType: "json",
            success: function (response) {
                let s = "";
                // 답변 리스트 출력.
                $.each(response, function (index, item) {
                    s += `
<div class="answerBox" data-index="\${index}">
    <h4 class="answerWriter">`;

                    if (item.m_photo === null || item.m_photo === 'no') {
                        s += `<img src="/photo/profile.jpg" style="width:50px; height: 50px; border:3px solid black; border-radius:100px;">`;
                    } else {
                        s += `<img src="http://${imageUrl}/member/\${item.m_photo}" style="width:50px; height: 50px; border:3px solid black; border-radius:100px;">`;
                    }

                    s += `
        \${item.nickname}</h4>
    <h6>\${item.ab_writeday}</h6>
    <h2>\${item.ab_content}</h2>`;

                    $.each(item.photo, function (index2, photos) {
                        s += `<img src="http://${imageUrl}/aboard/\${photos}" style="width:400px;"><br>`;
                    });
                    if (item.m_idx == ${sessionScope.memidx}) {
                        s += `
    <button class="btn btn-outline-dark" type="button" onclick="deleteComment(\${item.ab_idx})">
        삭제
    </button>
    <button class="btn btn-outline-dark" type="button" data-abidx="\${item.ab_idx}" onclick="updateCommentForm(\${item.ab_idx}, \${index})">
        수정
    </button>`;
                    }
                    s += "<hr></div>";
                });

                // answerPrintBox 클래스를 사용하는 div 안에 s 값을 삽입
                $(".answerPrintBox").html(s);
            }
        });
    }



    // 댓글 작성
    function insert() {
        let form = $("form[name=aboardInsert]")[0];
        let formData = new FormData(form);

        formData.append("qb_idx", ${dto.qb_idx});
        formData.append("m_idx", ${sessionScope.memidx});

        $.ajax({
            type: "post",
            url: "/aboard/insert",
            data: formData,
            processData: false, // 필수: FormData를 사용할 때는 processData를 false로 설정해야 함
            contentType: false, // 필수: FormData를 사용할 때는 contentType을 false로 설정해야 함
            success: function (response) {
                alert("댓글이 작성되었습니다.");
                answer();
            },
            error: function (xhr, status, error) {
                // 에러 처리를 여기에서 처리합니다.
            }
        });
    }

    function deleteComment(ab_idx) {
        if(confirm("정말 삭제하시겠습니까? ")) {
            $.ajax({
                type: "get",
                url: "/aboard/delete",
                data: {"ab_idx":ab_idx},
                success: function (response) {
                    alert("댓글이 삭제되었습니다.");
                    answer();
                },
                error: function (xhr, status, error) {
                    // 에러 처리를 여기에서 처리합니다.
                }
            });
        }
    }

    function updateCommentForm(ab_idx, index) {
        let $targetAnswerBox = $(`.answerBox[data-index="\${index}"]`);

        $.ajax({
            type: "get",
            url: "/aboard/updateform",
            data: {"ab_idx": ab_idx},
            dataType : "json",
            success: function (response) {
                let s =
                    `
            <h3>수정</h3>
            <form name="aboardUpdate">
                <textarea id="aboardContent" class="form-control" name="ab_content">\${response.ab_content}</textarea>
                <input id="aboardPhoto" class="form-control" type="file" multiple name="upload"><br>
                <button type="button" id="submit" class="btn btn-outline-dark" style="position: relative; right: -91%">수정</button>
            </form>
            <hr>
            `;
                $targetAnswerBox.html(s);

                $targetAnswerBox.find('#submit').on('click', function() {
                    // 이벤트 리스너 내부에서 수정을 처리하는 코드를 작성합니다.
                    updateComment(ab_idx, index);
                });
            },
            error: function (xhr, status, error) {
                // 에러 처리를 여기에서 처리합니다.
            }
        });
    }

    function updateComment(ab_idx, index) {
        let $targetAnswerBox = $(`.answerBox[data-index="\${index}"]`);
        let formData = new FormData($targetAnswerBox.find('form')[0]);

        formData.append("ab_idx",ab_idx);

        $.ajax({
            type: "post",
            url: "/aboard/update",
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                alert("댓글이 수정되었습니다.")
                answer();
            },
            error: function (xhr, status, error) {
                // 에러 처리를 여기에서 처리합니다.
            }
        });
    }

    function deletePost(qb_idx) {
        if(confirm("정말 삭제하시겠습니다? ")) {
            location.href="delete?qb_idx=" + qb_idx;
        }
    }

    $(".blind").click(function () {
        $(".content").removeAttr("hidden");
        $(this).text("");
    });

    $("#submit").click(function (){
        insert();
        $("#aboardContent").val("");
        $('#aboardPhoto').val('');
    })
</script>

</html>
