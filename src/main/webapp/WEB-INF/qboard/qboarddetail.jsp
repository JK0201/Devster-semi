<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>


    <style>

        .already-added {
            background-color: #0D3EA3;
            color: white;
        }
    </style>

    <script>
<%--        버튼 상태 관련 이벤트  --%>
        $(document).ready(function() {
            <!-- jsp 실행 이전의 리액션 여부 체크 및 버튼 색상 표현 -->
                checkAddRpBefore();
                answer();

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
                        url : "/qboard/increaseGoodRp",
                        type : "POST",
                        data : {
                            "qb_idx" : ${dto.qb_idx},
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
                        url : "/qboard/decreaseGoodRp",
                        type : "POST",
                        data : {
                            "qb_idx" : ${dto.qb_idx},
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
                        url : "/qboard/increaseBadRp",
                        type : "POST",
                        data : {
                            "qb_idx" : ${dto.qb_idx},
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
                        url : "/qboard/decreaseBadRp",
                        type : "POST",
                        data : {
                            "qb_idx" : ${dto.qb_idx},
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

    function message(nickname) {
        window.open("other_profile?other_nick="+nickname, 'newwindow', 'width=700,height=700');
    }
    </script>

<div class="qb_detail_wrap clear">
    <div class="qb_detail_content">
        <div class="article_view_head">
            <a href="/">홈</a>
            <a href="./list?currentPage=${currentPage}" class="qboard_link">질문게시판</a>
            <h2>${dto.qb_subject}</h2>
            <b style="font-size: 15px; color: black;" margin-bottom: 10px;>
                <img src="${profilePhoto}" class="memberimg" width="50px">&nbsp;
                ${nickname}
            </b>

            <div class="wrap_info clear">
                <div class="icon_time"></div>
                <span class="qb_writeday">${qb_writeday}</span>


                <span>
                    <div class="icon_read"></div>${dto.qb_readcount}
                </span>
                <span id="commentCnt">
                    <div class="icon_comment"></div>${commentCnt}
                </span>
            </div>

        </div>

        <div class="article_view_content">
            <c:if test="${dto.qb_dislike > 19}">
                <p class="blind" style="color: red; font-size: 30px; cursor: pointer">블라인드 처리된 게시글 입니다.</p>
                <div class="content" hidden="hidden">
                    <div class="content_txt">
                            ${dto.qb_content}<br>
                    </div>
                    <c:choose>
                        <c:when test="${list[0] == 'n' || list[0] == 'no'}">
                            <!-- 이미지가 없을 때는 아무것도 출력하지 않음 -->
                        </c:when>
                        <c:otherwise>
                            <div class="qb_detail_img">
                                <c:forEach items="${list}" var="images">
                                    <img src="http://${imageUrl}/qboard/${images}" style="">
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>


            <c:if test="${dto.qb_dislike < 20}">
                <div class="content_txt">
                        ${dto.qb_content}<br>
                </div>
                <c:choose>
                    <c:when test="${list[0] == 'n' || list[0] == 'no'}">
                        <!-- 이미지가 없을 때는 아무것도 출력하지 않음 -->
                    </c:when>
                    <c:otherwise>
                        <div class="qb_detail_img">
                            <c:forEach items="${list}" var="images">
                                <img src="http://${imageUrl}/qboard/${images}" style="">
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:if>

            <div class="clear" style="margin-top: 20px;border-bottom: 1px solid #eee; padding-bottom: 40px;">
                <%-- 좋아요 / 싫어요 버튼--%>
                <div class="footbox">
                    <span id="add-goodRp-btn" class="btn btn-outline" >
                          <div class="icon_thumbup"></div>
                          <span class="add-goodRp ml-2">좋아요</span>
                        </span>
                    <span id="add-badRp-btn" class="ml-5 btn btn-outline">
                          <div class="icon_thumbdown"></div>
                          <span class="add-badRp ml-2">별로에요</span>
                    </span>
                </div>
                <div class="util_btns">
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
                    <c:if test="${sessionScope.memstate == 100}">
                        <button class="btn btn-outline-dark" type="button"
                                onclick="deletePost(${dto.qb_idx})">
                            삭제
                        </button>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="commentwrite clear" style="margin-bottom: 30px; margin-top: 20px;">
            <form name="aboardInsert">
                <%--<h3>Answer</h3--%>
                <p style="font-size: 16px; font-weight: bold;color: #222;">댓글 ${commentCnt}</p>
                <input type="text" id="aboardContent" class="form-control" name="ab_content" placeholder="댓글을 남겨주세요">

                <label for="aboardPhoto" class="upload-label" style="padding: 10px;cursor: pointer;"><i class="bi bi-camera" style="font-size: 20px;"></i></label>
                <input id="aboardPhoto" class="custom-file-upload" type="file" multiple name="upload" style="display: none;">
                <button type="button" id="submit" class="btn btn-outline-dark" style="">작성</button>
            </form>

        </div>
        <div class="answerPrintBox" style="margin-left: 100px; width: 600px; border: 3px solid black">

        </div>

    </div>


</div>


<script>
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
        <p style="cursor:pointer;" onclick=message("\${item.nickname}")>\${item.nickname}</p></h4>
    <h6>\${item.ab_writeday}</h6>
    <h2>\${item.ab_content}</h2>`;

                    $.each(item.photo, function (index2, photos) {
                        if (${photos == no}) {
                            s += `<img src="http://${imageUrl}/aboard/\${photos}" style="width:400px;"><br>`;
                        };
                    });
                    if (item.m_idx == ${sessionScope.memidx}) {
                        s += `
    <button class="btn btn-outline-dark" type="button" onclick="deleteComment(\${item.ab_idx})">
        삭제
    </button>
    <button class="btn btn-outline-dark" type="button" data-abidx="\${item.ab_idx}" onclick="updateCommentForm(\${item.ab_idx}, \${index})">
        수정
    </button>`;
                    } else if(${sessionScope.memstate == 100}){
                        s += `
    <button class="btn btn-outline-dark" type="button" onclick="deleteComment(\${item.ab_idx})">
        삭제
    </button>
    `;
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

        // 먼저 textarea의 값이 있는지 확인합니다.
        let textarea = $("#aboardContent")[0];
        if(textarea.value.trim() === '') {
            alert("내용을 입력해주세요.");
            return; // 내용이 없다면 함수를 종료합니다.
        }

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
                <textarea id="aboardContent" class="form-control" name="ab_content" required>\${response.ab_content}</textarea>
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
        if(confirm("정말 삭제하시겠다?? ")) {
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

