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
            commentList();



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
        <button type="button" onclick="location.href='./academyupdateform?ab_idx=${dto.ab_idx}'" class="btn btn-sm btn-outline-secondary"><i class="bi bi-pencil-square"></i>&nbsp;수정</button>
        <button type="button" onclick="del(${dto.ab_idx})" class="btn btn-sm btn-outline-secondary"><i class="bi bi-trash"></i>&nbsp;삭제</button>
    </c:if>

    <button type="button" onclick="location.href='./list?'" class="btn btn-sm btn-outline-secondary"><i class="bi bi-card-list"></i>&nbsp;목록</button>
</div>

<hr>

<div class="commentwrite" style="margin-bottom: 30px; margin-top: 50px; height: 50px;">
    <%--    <form name="commentinsert" width="600">--%>
    <input type="hidden" name="ab_idx" value="${dto.ab_idx}">

    <input type="text" name="abc_content" id="commentContent" class="form-control" style="width: 500px; float: left">
    <button type="button" id="writepost" class="btn btn-sm btn-secondary" style="width: 100px; float: left; margin-left: 5px;"><i class="bi bi-pencil"></i>&nbsp;댓글쓰기</button>
    <%--    </form>--%>
</div>
<div id="commentBox" style="margin-left: 100px; width: 800px; border: 1px solid gray"></div><hr>


<script>

    function insert(){
        let ab_idx = ${dto.ab_idx};
        let m_idx = ${sessionScope.memidx};
        let abc_content = $('#commentContent').val();

        $.ajax({
            type: "post",
            url: "/academycomment/insert",
            data: {"ab_idx" : ab_idx, "m_idx" : m_idx, "abc_content":abc_content},

            success: function (response) {
                // alert("댓글이 작성되었습니다.");

                let abc_ref = response.abc_ref;
                let abc_step = response.abc_step;

                $("#writepost").attr("abc_ref", abc_ref);
                $("#writepost").attr("abc_step", abc_step);
                commentList();
            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "error: " + error);
            }

        });
    }

    $("#writepost").click(function (){
        insert();
        $("#commentContent").val("");
    })

    // 댓글 리스트 가져오는 사용자 함수
    function commentList(){
        let ab_idx = ${dto.ab_idx}
            $.ajax({
                type: "post",
                url: "/academycomment/commentlist",
                data:{"ab_idx":ab_idx},
                dataType:"json",
                success: function(res) {
                    // const count = res.list.length;
                    // if (res.length > 0) {
                    let s = "";
                    $.each(res, function (idx, ele) {
                        s += `
                            <div class='answerBox' data-index="\${idx}"><input type="hidden" name="abc_idx" value="\${ele.abc_idx}">
                            <b style='margin-left: 10px;'>`;

                        if (ele.m_photo === null || ele.m_photo === 'no') {
                            s += `<img src="/photo/profile.jpg" style="width:20px; height: 20px; border:1px solid black; border-radius:100px;">`;
                        } else {
                            s += `<img src="http://${imageUrl}/member/\${ele.m_photo}" style="width:20px; height: 20px; border:1px solid black; border-radius:100px;">`;
                        }

                        s+=`&nbsp;\${ele.nickname}</b><br><br>
                            <b style="color: #999; float:right; font-size: 15px; font-weight: lighter; margin-right: 15px;" align='right'>\${ele.abc_writeday}</b>
                            <h5 style='display: inline; margin-left: 10px; font-size: 18px;'>\${ele.abc_content}</h5>
                            <span style='color: red; font-size: 13px;'>[\${ele.replyCnt}]</span><br><br>`;

                        if (ele.m_idx == ${sessionScope.memidx}) {
                            s += `<button class="btn btn-outline-dark btn-sm" type="button" onclick="deleteComment(\${ele.abc_idx})" style="margin-left: 10px;">삭제</button>
                                <button class="btn btn-outline-dark btn-sm" type="button" data-abcidx="\${ele.abc_idx}" onclick="updateCommentForm(\${ele.abc_idx},\${idx})">수정</button>`;
                        }

                        s += `
                                   <span style='cursor: pointer; color: blue; font-size: 15px;' class='reCommentBtn' id="reCommentBtn_" data-index="\${idx}">답글 달기 </span>
<span style='display:none; cursor: pointer; color: blue; font-size: 15px;' class='reCommentCloseBtn' id='reCommentCloseBtn_' data-index="\${idx}">답글 닫기 </span>
                                    <hr><div class='mx-4 reCommentDiv' id='reCommentDiv_' data-index="\${idx}"></div>
</div>`;
                    });

                    var totalCount = res[0].totalCount;
                    document.getElementById("commentCnt").innerHTML = totalCount;
                    $("#commentBox").html(s);
                    // } else {
                    //     let html = "<div class='mb-2'>";
                    //     html += "<h6><strong>등록된 댓글이 없습니다.</strong></h6>";
                    //     html += "</div>";
                    //     $("#commentCnt").html(0);
                    //     $("#commentBox").html(html);
                    // }
                }
            });
    }

    function deleteComment(abc_idx) {

        if(confirm("댓글을 삭제하시겠습니까? ")) {
            $.ajax({
                type: "get",
                url: "/academycomment/delete",
                data: {"abc_idx":abc_idx},
                success: function (response) {
                    alert("댓글이 삭제되었습니다.");
                    commentList()
                },
                error: function (xhr, status, error) {
                    // 에러 처리를 여기에서 처리합니다.
                }
            });
        }
    }

    function updateCommentForm(abc_idx, idx) {
        let $targetAnswerBox = $(`.answerBox[data-index="\${idx}"]`);

        $.ajax({
            type: "get",
            url: "/academycomment/updateform",
            data: {"abc_idx": abc_idx},
            dataType : "json",
            success: function (response) {
                let s =
                    `
            <form name="commentupdate">
        <input type="hidden" name="ab_idx" value="\${response.ab_idx}">

        <input type="text" name="abc_content" id="commentContent" class="form-control" style="width: 500px; float: left" value="\${response.abc_content}">
        <button type="button" id="writepost" class="btn btn-sm btn-secondary" style="width: 100px; float: left; margin-left: 5px;"><i class="bi bi-pencil"></i>&nbsp;댓글수정</button>
    </form>
            <hr>
            `;
                $targetAnswerBox.html(s);

                $targetAnswerBox.find('#writepost').on('click', function() {
                    // 이벤트 리스너 내부에서 수정을 처리하는 코드를 작성합니다.
                    updateComment(abc_idx, idx);
                });

            },
            error: function (xhr, status, error) {
                // 에러 처리를 여기에서 처리합니다.
            }
        });
    }

    function updateComment(abc_idx, idx) {
        let $targetAnswerBox = $(`.answerBox[data-index="\${idx}"]`);
        let formData = new FormData($targetAnswerBox.find('form')[0]);

        formData.append("abc_idx",abc_idx);

        $.ajax({
            type: "post",
            url: "/academycomment/update",
            data: formData,
            processData: false,
            contentType: false,
            success: function () {
                alert("댓글이 수정되었습니다.")
                commentList();
            },
            error: function (xhr, status, error) {
                // 에러 처리를 여기에서 처리합니다.
            }
        });
    }

    function del(ab_idx) {
        if (confirm("삭제하시겠습니까?")) {
            location.href = "./academydelete?ab_idx=" + ab_idx;
        }
    }


    /*답글 버튼 클릭*/
    $(document).on("click",".reCommentBtn",function (){
        const _this = $(this);
        //const cid = reComment.find("#commentId").val();
        const abc_ref = $(this).siblings('input').val();
        //
        // console.log(fbc_ref);

        //replyList(fbc_ref);

        _this.siblings('.reCommentDiv').show();
        _this.hide();
        _this.siblings('.reCommentCloseBtn').show();



        $.ajax({
            type: "get",
            url: "/academycomment/recommentlist",
            data: {"abc_ref": abc_ref},
            success: function (res) {
                let html = "";
                $.each(res, function (idx, ele) {
                    html += `
                            <div class='replyBox' data-index="\${idx}" style="margin-bottom: 30px;">
                            <input type="hidden" name="abc_idx" value="\${ele.abc_idx}">
                            <b style='margin-left: 10px;'>`;

                    if (ele.m_photo === null || ele.m_photo === 'no') {
                        html += `<i class="bi bi-arrow-return-right" style="color: #94969B"></i>&nbsp;<img src="/photo/profile.jpg" style="width:20px; height: 20px; border:1px solid black; border-radius:100px;">`;
                    } else {
                        html += `<i class="bi bi-arrow-return-right" style="color: #94969B"></i>&nbsp;<img src="http://${imageUrl}/member/\${ele.m_photo}" style="width:20px; height: 20px; border:1px solid black; border-radius:100px;">`;
                    }

                    html+=`&nbsp;\${ele.nickname}</b><br><br>
                            <b style="color: #999; float:right; font-size: 15px; font-weight: lighter; margin-right: 15px;" align='right'>\${ele.abc_writeday}</b>
                            <h5 style='display: inline; margin-left: 10px; font-size: 18px;'>\${ele.abc_content}</h5>
                            <br><br>`;

                    if (ele.m_idx == ${sessionScope.memidx}) {
                        html += `<button class="btn btn-outline-dark btn-sm" type="button" onclick="deleteComment(\${ele.abc_idx})" style="margin-left: 10px;">답글삭제</button>
                                <button class="btn btn-outline-dark btn-sm" type="button" data-abcidx="\${ele.abc_idx}" onclick="updateReplyForm(\${ele.abc_idx},\${idx})">답글수정</button>`;
                    }
                    html+= "<hr></div>";
                });


                html += "<input style='width: 90%; margin-bottom: 30px;' id='reComment_"+abc_ref+"' class='reComment' name='reComment' placeholder='댓글을 입력해 주세요' type='text'>";
                html += `<button type='button' class='btn btn-primary btn-sm reCommentSubmit' onclick='insertReply(\${abc_ref})'>등록</button>`;

                _this.siblings(".reCommentDiv").html(html);

            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "error: " + error);
            }
        });

    });

    $(document).on("click",".reCommentCloseBtn",function (){
        const _this = $(this);
        _this.siblings('.reCommentDiv').hide();
        _this.hide();
        _this.siblings('.reCommentBtn').show();
    });

    function insertReply(abc_ref){

        let m_idx = ${sessionScope.memidx};
        let abc_content = $(`#reComment_\${abc_ref}`).val();
        console.log(abc_ref);
        $.ajax({
            type: "post",
            url: "/academycomment/insertreply",
            data: {"m_idx" : m_idx, "abc_content":abc_content, "abc_ref":abc_ref, "ab_idx":${dto.ab_idx}},

            success: function (response) {
                alert("답글이 작성되었습니다.");
                commentList();

            },
            error: function (request, status, error) {
                alert("code: " + request.status + "\n" + "error: " + error);
            }

        });

    }

    function updateReplyForm(abc_idx, idx) {
        let $targetReplyBox = $(`.replyBox[data-index="\${idx}"]`);
        const abc_ref = $(".reCommentBtn").siblings('input').val();

        $.ajax({
            type: "get",
            url: "/academycomment/updateform",
            data: {"abc_idx": abc_idx},
            dataType : "json",
            success: function (response) {

                let html = `<form name='replyupdate'> <input style='width: 90%; margin-bottom: 30px;' id='reComment_`+abc_ref+`' class='reComment' name='abc_content' value="\${response.fbc_content}" type='text'>`;

                html += `<button type='button' class='btn btn-primary btn-sm reCommentSubmit' id="updatereply">수정</button></form>`;

                $targetReplyBox.html(html);

                $targetReplyBox.find('#updatereply').on('click', function() {
                    // 이벤트 리스너 내부에서 수정을 처리하는 코드를 작성합니다.

                    updateReply(abc_idx, idx);
                });

            },
            error: function (xhr, status, error) {
                // 에러 처리를 여기에서 처리합니다.
            }
        });
    }
    function updateReply(abc_idx, idx) {
        let $targetReplyBox = $(`.replyBox[data-index="\${idx}"]`);
        let formData = new FormData($targetReplyBox.find('form')[0]);

        formData.append("abc_idx",abc_idx);

        $.ajax({
            type: "post",
            url: "/academycomment/update",
            data: formData,
            processData: false,
            contentType: false,
            success: function () {
                alert("답글이 수정되었습니다.")
                commentList();

            },
            error: function (xhr, status, error) {
                // 에러 처리를 여기에서 처리합니다.
            }
        });
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
