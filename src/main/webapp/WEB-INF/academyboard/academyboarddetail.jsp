<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>
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

            var currentPosition = parseInt($(".quickmenu").css("top"));
            $(window).scroll(function () {
                var position = $(window).scrollTop();
                $(".quickmenu").css("transform", "translateY(" + position + "px)");
            });

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
                            $("#add-goodRp-btn .icon_thumbup").css("background-position","-159px -486px");
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
                            $("#add-goodRp-btn .icon_thumbup").css("background-position","-130px -486px");

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
                            $("#add-badRp-btn .icon_thumbdown").css("background-position","-395px -486px");
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
                            $("#add-badRp-btn .icon_thumbdown").css("background-position","-424px -486px");
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

        function timeForToday(value) {
            const valueConv = value.slice(0, -2);
            const today = new Date();
            const timeValue = new Date(valueConv);

            const betweenTime = Math.floor((today.getTime() - timeValue.getTime()) / 1000 / 60);
            if (betweenTime < 1) return '방금전';
            if (betweenTime < 60) {
                return `\${betweenTime}분전`;
            }

            const betweenTimeHour = Math.floor(betweenTime / 60);
            if (betweenTimeHour < 24) {
                return `\${betweenTimeHour}시간전`;
            }

            const betweenTimeDay = Math.floor(betweenTime / 60 / 24);
            if (betweenTimeDay < 7) {
                return `\${betweenTimeDay}일전`;
            }

            const month = String(timeValue.getMonth() + 1).padStart(2, '0');
            const day = String(timeValue.getDate()).padStart(2, '0');
            const formattedDate = `\${month}-\${day}`;

            return `\${formattedDate}`;
        }
    </script>

<div class="ab_detail_wrap clear">

    <div class="ab_detail_content">

        <div class="article_view_head">
            <a href="/">홈</a>
            <a href="./list?currentPage=${currentPage}" class="academyboard_link">${sessionScope.memacademy}게시판</a>

            <h2>${dto.ab_subject}</h2>
            <b style="font-size: 15px; color: black; cursor:pointer;" margin-bottom: 10px; onclick=message("${nickname}")>
                <img src="${m_photo}" class="memberimg">&nbsp;
                ${nickname}
            </b>
            <div class="wrap_info clear">
                <div class="icon_time"></div>
                <div style="display: inline-block; color: #94969b;" class="ab_writeday" id="writedayMain"></div>
                <script>
                    $("#writedayMain").text(timeForToday("${dto.ab_writeday}"));ㅉ
                </script>

                <span>
                    <div class="icon_read"></div>${dto.ab_readcount}
                </span>
                <div class="icon_comment"></div><span id="commentCnt">${commentCnt}</span>
            </div>

        </div>

        <div class="article_view_content">
            <div class="content_txt">
                ${dto.ab_content}<br>
            </div>

            <div class="ab_detail_img">
                <c:forEach items="${list}" var="images">
                    <c:if test="${dto.ab_photo!='n'}">
                        <img src="http://${imageUrl}/freeboard/${images}" style="float: left">
                        <br style="clear: both;"><br>
                    </c:if>
                </c:forEach>
            </div>

            <div class="clear" style="margin-top: 20px;border-bottom: 1px solid #eee; padding-bottom: 40px;">
                <%--  좋아요 / 싫어요 버튼--%>
                <div class="footbox">
                    <span id="add-goodRp-btn" class="clear" style="display: inline-block; cursor: pointer">
                        <div class="icon_thumbup"></div>
                        <span class="add-goodRp ml-2">좋아요</span>
                    </span>
                    <span id="add-badRp-btn" class="clear" style="display: inline-block; cursor: pointer; margin-left: 10px;">
                        <div class="icon_thumbdown"></div>
                        <span class="add-badRp ml-2">별로에요</span>
                    </span>
                </div>

                <div class="util_btns">
                    <c:if test="${dto.m_idx == sessionScope.memidx}">
                        <button type="button" onclick="del(${dto.ab_idx})" class="btn btn-sm btn-outline-secondary"><i class="bi bi-trash"></i>&nbsp;삭제</button>
                        <button type="button" onclick="location.href='./list?currentPage=${currentPage}'" class="btn btn-sm btn-outline-secondary"><i class="bi bi-card-list"></i>&nbsp;목록</button>
                        <button type="button" onclick="location.href='./freeupdateform?ab_idx=${dto.ab_idx}&currentPage=${currentPage}'" class="btn btn-sm btn-outline-secondary"><i class="bi bi-pencil-square"></i>&nbsp;수정</button>
                    </c:if>
                    <c:if test="${sessionScope.memstate == 100}">

                        <button type="button" onclick="del(${dto.ab_idx})" class="btn btn-sm btn-outline-secondary"><i class="bi bi-trash"></i>&nbsp;삭제</button>
                        <button type="button" onclick="location.href='./list?currentPage=${currentPage}'" class="btn btn-sm btn-outline-secondary"><i class="bi bi-card-list"></i>&nbsp;목록</button>
                    </c:if>
                    <c:if test="${dto.m_idx != sessionScope.memidx}">
                        <button type="button" onclick="location.href='./list?currentPage=${currentPage}'" class="btn btn-sm btn-outline-secondary"><i class="bi bi-card-list"></i>&nbsp;목록</button>
                    </c:if>

                </div>
            </div>
        </div>

        <!--댓글출력-->
        <div class="commentwrite clear" style="margin-bottom: 30px; margin-top: 20px;">
            <%--    <form name="commentinsert" width="600">--%>
            <input type="hidden" name="ab_idx" value="${dto.ab_idx}">
            <p style="font-size: 16px; font-weight: bold;color: #222;" id="commentCnt2">댓글 ${commentCnt}</p>
            <input type="text" name="abc_content" id="commentContent" class="form-control" placeholder="댓글을 남겨주세요">
            <button type="button" id="writepost" class="btn btn-sm btn-secondary" style="">댓글쓰기</button>
            <%--    </form>--%>
        </div>
        <div id="commentBox" style=""></div>
    </div>

    <div class="ab_aside">
        <div class="quickmenu">
            <ul>
                <li class="quickmenu_head"><h2>일반게시판 추천글</h2></li>
            </ul>
        </div>
    </div>
</div>

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
                            <b style='cursor:pointer;' class="ab_nickname" onclick=message("\${ele.nickname}")>`;

                        if (ele.m_photo === null || ele.m_photo === 'no') {
                            s += `<img src="/photo/profile.jpg" style="width:20px; height: 20px; border:1px solid black; border-radius:100px;">`;
                        } else {
                            s += `<img src="http://${imageUrl}/member/\${ele.m_photo}" style="width:20px; height: 20px; border:1px solid black; border-radius:100px;">`;
                        }

                        s+=`&nbsp;\${ele.nickname}</b>
                            <h5 style='' class="ab_content">\${ele.abc_content}</h5>
                            <!--<span style='color: red; font-size: 13px;'>[\${ele.replyCnt}]</span>-->

                        `;



                        s += `
                                <div style="display: inline-block">
                                    <div class="icon_time"></div>
                                    <b style="" class="ab_writeday">\${ele.abc_writeday}</b>
                                    <!--<div class="icon_reply"></div>
                                    <b style="" class="ab_replyCnt">\${ele.replyCnt}</b>-->
                                </div>
                                   <span style='cursor: pointer;color: #94969b; font-size: 12px;' class='reCommentBtn' id="reCommentBtn_" data-index="\${idx}">
                                        <div class="icon_reply"></div>\${ele.replyCnt}
                                   </span>
                                   <span style='display:none; cursor: pointer;color: #94969b; font-size: 12px;' class='reCommentCloseBtn' id='reCommentCloseBtn_' data-index="\${idx}">
                                        <div class="icon_reply"></div>\${ele.replyCnt}
                                   </span>

                                   <!--<div class='mx-4 reCommentDiv' id='reCommentDiv_' data-index="\${idx}"></div>-->
                                   `;

                        if (ele.m_idx == ${sessionScope.memidx }) {
                            s += `<div style="" class="clear">
                                  <button class="btn btn-outline-dark btn-sm" type="button" onclick="deleteComment(\${ele.abc_idx})" style="float: right; margin-left: 3px;">삭제</button>
                                  <button class="btn btn-outline-dark btn-sm" type="button" data-abcidx="\${ele.abc_idx}" onclick="updateCommentForm(\${ele.abc_idx},\${idx})" style="float: right; ">수정</button></div>

                                  <div class='mx-4 reCommentDiv' id='reCommentDiv_' data-index="\${idx}"></div>

                                  </div>`;
                        }
                    });

                    var totalCount = res[0].totalCount;
                    document.getElementById("commentCnt").innerHTML = totalCount;
                    document.getElementById("commentCnt2").innerHTML ="댓글 " + totalCount;
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
                            <b style='margin-left: 10px; cursor:pointer;' onclick=message("\${ele.nickname}")>`;

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

                let html = `<form name='replyupdate'> <input style='width: 90%; margin-bottom: 30px;' id='reComment_`+abc_ref+`' class='reComment' name='abc_content' value="\${response.abc_content}" type='text'>`;

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
            $("#add-goodRp-btn .icon_thumbup").css("background-position","-159px -486px");
        } else if (isAlreadyAddBadRp == true) {
            $("#add-badRp-btn .icon_thumbdown").css("background-position","-395px -486px");
        } else {
            return;
        }
        $(function() {
            checkAddRpBefore();
        });
    };

    $.ajax({
        type: "post",
        url: "./bestPostsForBanner",
        dataType: "json",
        success: function (response) {
            let s = "";
            $.each(response, function (index, item) {
                s +=
                    `
                    <li>
                    <a href="../freeboard/freeboarddetail?fb_idx=\${item.fb_idx}&currentPage=1">
                    <div class="name">
                    <div class="num"><div style="width: 3px;height: 3px; border-radius: 50%; background-color: red; display: inline-block"></div><span style="vertical-align: middle; margin-left: 10px;">\${item.fb_subject}</span></div>
                    </div>
                    </a>
                    </li>
                    `
            });
            s +=
                `
               <!-- <button type="button" onclick="window.scrollTo({top:0});">
                <i class="bi bi-arrow-up-square-fill"></i>
                </button>-->

                <li class="view_all_li">
                    <a href="../freeboard/list">
                        <span class="view_all">전체보기</span>
                    </a>
                </li>
                `;
            $(".quickmenu ul").append(s);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error: " + textStatus + " - " + errorThrown);
        }
    });

    // 쪽지보내기 메서드.
    function message(nickname) {
        window.open("other_profile?other_nick=" + nickname, 'newwindow', 'width=700,height=700');
    }
</script>
