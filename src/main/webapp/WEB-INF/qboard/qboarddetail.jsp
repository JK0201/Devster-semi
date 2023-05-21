<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>

        .already-added {
            background-color: #0D3EA3;
            color: white;
        }

        /*모달 CSS*/

        #dropbox {
            width: 800px;
            height: 500px;
            cursor: default;
        }

        .uploadbox {
            width: 800px;
            height: 430px;
            border: 3px dashed #808080;
            border-radius: 10px;
        }

        #dndtext {
            text-align: center;
            background-color: #8007AD;
            font-size: 30px;
            width: 220px;
            height: 50px;
            color: white;
            border-radius: 10px;
            font-weight: bold;
            margin: 0 auto;
            border: 1px solid gray;
        }

        #sizetxt {
            font-size: 23px;
            float: left;
            margin-left: 15px;
            font-weight: bold;
            color: #bdbebd;
        }

        .btnupload {
            font-size: 25px;
            float: right;
            margin-right: 15px;
            font-weight: bold;
            cursor: pointer;
            color: #bdbebd;
        }

        .btnupload:hover {
            color: #8007AD;
        }

        .alldelbtn {
            font-size: 25px;
            float: right;
            margin-right: 20px;
            font-weight: bold;
            cursor: pointer;
            color: #bdbebd;
        }

        .alldelbtn:hover {
            color: #8007AD;
        }

        #preview {
            margin: 0 auto;
            width: 800px;
            height: 300px;
            text-align: center;
        }

        #divimgbox {
            margin: 0 auto;
            width: 750px;
        }

        .imgpreview {
            width: 140px;
            height: 140px;
            margin-right: 10px;
            margin-bottom: 10px;
        }

        .previewdelbtn {
            width: 120px;
            color: red;
            opacity: 60%;
            font-size: 90px;
            position: absolute;
            left: 47%;
            top: 47%;
            transform: translate(-50%, -50%);
            display: none;
        }

        /*modal*/
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fefefe;
            padding: 20px;
            border: 1px solid #888;
            width: 63%;
        }

        .close {
            color: #bdbebd;
            font-size: 40px;
            cursor: pointer;
            font-weight: bold;
        }

        .close:hover {
            color: #8007AD;
        }

        #uploadbtn {
            text-align: center;
            background-color: #bdbebd;
            font-size: 25px;
            width: 120px;
            height: 45px;
            color: white;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
            border: 1px solid gray
        }

        #uploadbtn:hover {
            background-color: #8007AD;
        }

        .progress {
            margin: 0 auto;
            position: relative;
            width: 50%;
            border: 1px solid #bdbebd;
            padding: 1px;
            border-radius: 5px;
            display: none;
        }

        .bar {
            background-color: #8007AD;
            width: 0%;
            height: 20px;
            border-radius: 3px;
        }

        .percent {
            position: absolute;
            display: inline-block;
            top: -3px;
            left: 48%;
            font-weight: bold;
        }

        #uploadmodal {
            z-index: 0;
        }
    </style>

    <script>
<%--        버튼 상태 관련 이벤트  --%>
        $(document).ready(function() {

            var currentPosition = parseInt($(".quickmenu").css("top"));
            $(window).scroll(function () {
                var position = $(window).scrollTop();
                /*$(".quickmenu").stop().animate({"top": position + currentPosition + "px"}, 700);*/
                $(".quickmenu").css("transform", "translateY(" + position + "px)");
            });
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
                            // $("#add-goodRp-btn").addClass("already-added");
                            $("#add-goodRp-btn .icon_thumbup").css("background-position","-159px -486px");
                            // $(".add-goodRp").html(goodReactionPoint);
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
                            // $("#add-goodRp-btn").removeClass("already-added");
                            // $(".add-goodRp").html(goodReactionPoint);
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
                        url : "/qboard/increaseBadRp",
                        type : "POST",
                        data : {
                            "qb_idx" : ${dto.qb_idx},
                            "m_idx" : ${sessionScope.memidx}
                        },
                        success : function(badReactionPoint) {
                            // $("#add-badRp-btn").addClass("already-added");
                            // $(".add-badRp").html(badReactionPoint);
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
                        url : "/qboard/decreaseBadRp",
                        type : "POST",
                        data : {
                            "qb_idx" : ${dto.qb_idx},
                            "m_idx" : ${sessionScope.memidx}
                        },
                        success : function(badReactionPoint) {
                            // $("#add-badRp-btn").removeClass("already-added");
                            // $(".add-badRp").html(badReactionPoint);
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
            <b style="font-size: 15px; cursor:pointer; color: black;" margin-bottom: 10px; onclick=message("${nickname}")>
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
                        <pre>${dto.qb_content}</pre>
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
                    <pre>${dto.qb_content}</pre>
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

            <div class="clear" style="margin-top: 40px;border-bottom: 1px solid #eee; padding-bottom: 40px;">
                <%-- 좋아요 / 싫어요 버튼--%>
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
                        <button type="button" onclick="location.href='updateform?qb_idx=${dto.qb_idx}&currentPage=${currentPage}'" class="btn btn-sm btn-outline-secondary"><i class="bi bi-pencil-square"></i>&nbsp;수정</button>
                        <button type="button" onclick="deletePost(${dto.qb_idx})" class="btn btn-sm btn-outline-secondary"><i class="bi bi-trash"></i>&nbsp;삭제</button>
                    </c:if>
                    <c:if test="${sessionScope.memstate == 100}">
                        <button type="button" onclick="deletePost(${dto.qb_idx})" class="btn btn-sm btn-outline-secondary"><i class="bi bi-trash"></i>&nbsp;삭제</button>
                    </c:if>
                    <button type="button" onclick="location.href='./list?currentPage=${currentPage}'" class="btn btn-sm btn-outline-secondary"><i class="bi bi-card-list"></i>&nbsp;목록</button>

                </div>
            </div>
        </div>

        <div class="commentwrite clear" style="margin-bottom: 30px; margin-top: 20px;">
            <form name="aboardInsert" class="aboardInsert">
                <%--<h3>Answer</h3--%>

                <p style="font-size: 16px; font-weight: bold;color: #222;" id="qb_commentCnt">답글 ${commentCnt}</p>
                    <label for="uploadmodal" class="upload-label" style="padding: 10px;cursor: pointer;"><i class="bi bi-camera" style="font-size: 20px;"></i>
                        <button type="button" id="uploadmodal" class="btn btn-outline-secondary d-none">파일 선택</button>
                    </label>
                    <input accept=".jpg, .jpeg, .png, .gif" class="file_select btn-file d-none" id="fileInput" type="file"
                           name="upload" style="padding-top: 10px;" multiple>
<%--                    <input id="aboardPhoto" class="custom-file-upload" type="file" multiple name="upload" style="display: none;">--%>
                <input type="text" id="aboardContent" class="form-control aboard_content_input" name="ab_content" placeholder="답글을 남겨주세요">


                <button type="button" id="submit" class="btn btn-outline-dark" style="">답글작성</button>
            </form>

        </div>
        <div class="answerPrintBox" style="">

        </div>

    </div>

    <div class="qb_aside">
        <div class="quickmenu">
            <ul>
                <li class="quickmenu_head"><h2>질문게시판 추천글</h2></li>
            </ul>
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
            // $("#add-goodRp-btn").addClass("already-added");
            $("#add-goodRp-btn .icon_thumbup").css("background-position","-159px -486px");
        } else if (isAlreadyAddBadRp == true) {
            // $("#add-badRp-btn").addClass("already-added");
            $("#add-badRp-btn .icon_thumbdown").css("background-position","-395px -486px");
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
                        <h4 class="answerWriter clear">`;

                    if (item.m_photo === null || item.m_photo === 'no') {
                        s += `<img src="/photo/profile.jpg" style="">`;
                    } else {
                        s += `<img src="http://${imageUrl}/member/\${item.m_photo}" style="">`;
                    }

                    s += `
                            <p style="cursor:pointer;" onclick=message("\${item.nickname}")>\${item.nickname}</p></h4>
                            <h2 style="margin-top: 10px;font-size: 16px;">\${item.ab_content}</h2>
                        `;
                    $.each(item.photo, function (index2, photos) {
                        if (${photos == no}) {
                            s += `<img src="http://${imageUrl}/aboard/\${photos}" style="width:400px;"><br>`;
                        };
                    });
                    s += `<div class="icon_time"></div><h6 style="color: #94969b;font-size: 12px;display: inline">\${item.ab_writeday}</h6>`;
                    if (item.m_idx == ${sessionScope.memidx}) {
                        s += `
    <button class="btn btn-outline-dark btn-sm" type="button" onclick="deleteComment(\${item.ab_idx})" style="float:right; margin-left: 3px;">
        삭제
    </button>
    <button class="btn btn-outline-dark btn-sm" type="button" data-abidx="\${item.ab_idx}" onclick="updateCommentForm(\${item.ab_idx}, \${index})" style="float:right;">
        수정
    </button>`;
                    } else if(${sessionScope.memstate == 100}){
                        s += `
    <button class="btn btn-outline-dark btn-sm" type="button" onclick="deleteComment(\${item.ab_idx})" style="float:right;">
        삭제
    </button>
    `;
                    }
                    s += "<!--<hr>--></div>";
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
                alert("답글이 작성되었습니다.");
                $("#qb_commentCnt").text("댓글 " + response);
                $("#commentCnt").html("<div class='icon_comment'></div>" +response);
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
                    alert("답글이 삭제되었습니다.");
                    $("#qb_commentCnt").text("댓글 " + response);
                    $("#commentCnt").html("<div class='icon_comment'></div>" +response);
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
                alert("답글이 수정되었습니다.")
                answer();
            },
            error: function (xhr, status, error) {
                // 에러 처리를 여기에서 처리합니다.
            }
        });
    }

    function deletePost(qb_idx) {
        if(confirm("정말 삭제하시겠습니까? ")) {
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
                    <a href="../qboard/detail?qb_idx=\${item.qb_idx}&currentPage=1">
                    <div class="name">
                    <div class="num"><div style="width: 3px;height: 3px; border-radius: 50%; background-color: red; display: inline-block"></div><span style="vertical-align: middle; margin-left: 10px;">\${item.qb_subject}</span></div>
                    </div>
                    </a>
                    </li>
                    `
        });
        s +=
            `
                <li class="view_all_li">
                    <a href="/qboard/list">
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
</script>

<!-----------------------------Modal------------------------------->


<div id="myUploadModal" class="modal">
    <div class="modal-content">
        <div style="width:35px; margin:0 auto; width: 100%; text-align: center; padding-bottom: 10px;">
            <i class="bi bi-x-circle close"></i>
        </div>
        <section id="dropbox" style="margin:0 auto;">
            <div class="uploadbox">
                <div style="width:800px; height:70px; line-height: 60px;">
                    <span id="sizetxt" style="height:45px;"><span id="mbsize">0.0</span> / 50Mb</span>
                    <i class="bi bi-recycle alldelbtn" style="height:45px;"></i>
                    <i class="bi bi-plus-circle btnupload" style="height:45px;"></i>
                </div>
                <div id="preview">
                    <div id="divimgbox" style="margin:0 auto; width:750px;">
                        <div style="padding-top:40px;">
                            <i class="bi bi-cloud-upload" style="color:#bdbebd; font-size: 55px;"></i>
                            <div style="color:#bdbebd; font-size: 20px; font-weight: bold; margin-bottom: 25px;">
                                최대 10장이내의 jpeg, jpg, png, gif 파일만 업로드 가능
                            </div>
                            <div id="dndtext">Drag & Drop</div>
                        </div>
                    </div>
                </div>
                <div style="width:800px; height:60px; padding-top:15px;">
                    <div class="progress">
                        <div class="bar progress-bar-striped progress-bar-animated"></div>
                        <div class="percent">0%</div>
                    </div>
                </div>
            </div>
            <div style="width:800px; height:60px; padding-top: 15px; text-align:center;">
                <button type=button id="uploadbtn">확인</button>
            </div>
        </section>
    </div>
</div>


<!-------------------------Drag and Drop------------------------>
<script>
    //uploadbtn for paging
    $("#uploadbtn").click(function () {
        Swal.fire({
            title: '변경 내용을 저장하시겠습니까?',
            text: '확인 버튼을 누르면 파일이 저장됩니다',
            icon: 'warning',

            showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
            confirmButtonColor: '#8007AD', // confrim 버튼 색깔 지정
            cancelButtonColor: '#bdbebd', // cancel 버튼 색깔 지정
            confirmButtonText: '확인', // confirm 버튼 텍스트 지정
            cancelButtonText: '취소', // cancel 버튼 텍스트 지정

            reverseButtons: true // 버튼 순서 거꾸로
        }).then(result => {
            if (result.isConfirmed) {
                $("#uploadbtn").prop("disabled", true);
                var fileList = new DataTransfer();
                for (var i = 0; i < filesarr.length; i++) {
                    fileList.items.add(filesarr[i]);
                }

                var inputElement = $("#fileInput")[0];
                inputElement.files = fileList.files;

                if (filesarr.length == 0) {
                    $("#uploadfilesnum").html("업로드할 사진을 선택해주세요. (10장 이하)");
                } else {
                    $("#uploadfilesnum").html(filesarr.length + "장의 파일이 선택되었습니다")
                }

                Swal.fire({
                    title: '저장을 완료했습니다',
                    icon: 'success',
                    confirmButtonText: '확인',
                    confirmButtonColor: '#8007AD'
                }).then(result => {
                    $("#uploadbtn").prop("disabled", false);
                    $("#myUploadModal").fadeOut();
                });
            } else {
                return false;
            }
        });
    });

    $(".close").click(function () {
        Swal.fire({
            title: '종료 하시겠습니까?',
            text: '변경 내용은 자동으로 저장됩니다',
            icon: 'warning',

            showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
            confirmButtonColor: '#8007AD', // confrim 버튼 색깔 지정
            cancelButtonColor: '#bdbebd', // cancel 버튼 색깔 지정
            confirmButtonText: '확인', // confirm 버튼 텍스트 지정
            cancelButtonText: '취소', // cancel 버튼 텍스트 지정

            reverseButtons: true // 버튼 순서 거꾸로
        }).then(result => {
            if (result.isConfirmed) {
                var fileList = new DataTransfer();
                for (var i = 0; i < filesarr.length; i++) {
                    fileList.items.add(filesarr[i]);
                }

                var inputElement = $("#fileInput")[0];
                inputElement.files = fileList.files;
                $("#myUploadModal").fadeOut();
            } else {
                return false;
            }
        });
    });

    //modal
    $(document).ready(function () {
        // Open modal
        $("#uploadmodal").click(function () {
            $("#myUploadModal").fadeIn();
        });
    });

    //upload
    var filesarr = [];

    $(".btnupload").click(function () {
        $("#fileInput").click();
    });

    $(document).on("change", "#fileInput", function (e) {
        var cnt = e.target.files.length;
        var data = e.target.files;

        if (!isValidBtn(data)) {
            return false
        } else {
            var file = Array.prototype.slice.call(data);
            imgpreview(file);
            filesarr = filesarr.concat(file);
            console.log(filesarr.length);
            updatetotalsize();
        }

        //유효성
        function isValidBtn(data) {
            //이미지인가?
            for (let i = 0; i < cnt; i++) {
                if (data[i].type.indexOf("image") < 0) {
                    alert("이미지만 업로드 가능합니다");
                    return false;
                }
            }

            //클릭 업로드 개수
            if (filesarr.length + cnt > 10) {
                alert("이미지는 최대 10개까지 업로드 가능합니다");
                return false;
            }

            //파일의 사이즈는 20MB
            let totalsize = filestotalsize(filesarr) + filestotalsize(data);
            if (totalsize >= 1024 * 1024 * 50) {
                alert("전체 업로드 파일의 크기가 50Mb를 초과하였습니다");
                return false;
            }

            return true;
        }
    });

    //DnD
    var doc = document.querySelector("#dropbox");
    var btnupload = doc.querySelector(".btnupload");
    var inputfile = doc.querySelector("input[type='file']");
    var uploadbox = doc.querySelector(".uploadbox");

    //박스안에 drag 들어왔을 경우
    uploadbox.addEventListener("dragenter", function (e) {
        e.preventDefault();
    });

    //박스 안에 drag를 하고있을 경우
    uploadbox.addEventListener("dragover", function (e) {
        e.preventDefault();
        var vaild = e.dataTransfer.types.indexOf('Files') >= 0;
        if (!vaild) {
            this.style.borderColor = 'red';
        } else {
            $(this).css("border-color", "#8007AD");
            $("#dndtext").css("backgroundColor", "#bdbebd");
        }
    });

    //박스 밖으로 Drag가 나갈때
    uploadbox.addEventListener("dragleave", function (e) {
        e.preventDefault();
        $(this).css("border-color", "#bdbebd");
        $("#dndtext").css("backgroundColor", "#8007AD");
    });

    //박스안에서 drag를 drop했을떄
    uploadbox.addEventListener("drop", function (e) {
        e.preventDefault();
        $(this).css("border-color", "#808080");
        var data = e.dataTransfer;

        if (!isValid(data)) {
            return false;
        } else {
            var file = Array.prototype.slice.call(data.files);
            imgpreview(file);
            filesarr = filesarr.concat(file);
            console.log(filesarr.length);
            updatetotalsize();
        }
    });

    //preview
    var fileidx = 0;

    function imgpreview(file) {
        file.forEach(function (f) {
            if (!f.type.match("image.*")) {
                alert("이미지만 업로드 가능합니다");
                return;
            }

            if (filesarr.length == 0) {
                $("#divimgbox").html("");
            }
            var reader = new FileReader();
            var s = "";
            reader.onload = function (e) {
                f.index = fileidx
                s += "<div id='box" + fileidx + "' style='float:left; position: relative;'>";
                s += "<div class='imgbox'>";
                s += "<img src='" + e.target.result + "' class='img-thumbnail imgpreview'>";
                s += "<i class='bi bi-dash-circle previewdelbtn' onclick='deletefile(\"" + fileidx + "\")'></i>";
                s += "</div>"
                s += "</div>";
                $("#divimgbox").hide().fadeIn("fast");
                $("#divimgbox").append(s);
                fileidx++;
            }
            reader.readAsDataURL(f);
        });
    }

    //del btn anime
    $(document).ready(function () {
        $(document).on("mouseenter", ".imgbox", function () {
            $(this).find(".previewdelbtn").show();
        });

        $(document).on("mouseleave", ".imgbox", function () {
            $(this).find(".previewdelbtn").hide();
        });
    });

    //delete
    function deletefile(index) {
        $("#box" + index).fadeOut("fast", function () {
            $(this).remove();

            let indexToRemove;
            for (let i = 0; i < filesarr.length; i++) {
                if (filesarr[i].index == index) {
                    indexToRemove = i;
                    break;
                }
            }
            if (indexToRemove != undefined) {
                filesarr.splice(indexToRemove, 1);
            }
            console.log(filesarr.length);
            if (filesarr.length == 0) {
                $("#divimgbox").html('<div style="padding-top:40px;">' +
                    '<i class="bi bi-cloud-upload" style="color:#bdbebd; font-size: 55px;"></i>' +
                    '<div style="color:#bdbebd; font-size: 20px; font-weight: bold; margin-bottom: 25px;">' +
                    '최대 10장이내의 jpeg, jpg, png, gif 파일만 업로드 가능</div>' +
                    '<div id="dndtext">Drag & Drop</div></div>').hide().fadeIn("fast");
            }
            updatetotalsize();
        });
    }

    //all del button
    $(".alldelbtn").click(function () {
        console.log(fileidx);

        filesarr = [];
        fileidx = 0;

        console.log(filesarr.length);
        if (filesarr.length == 0) {
            $("#divimgbox").html('<div style="padding-top:40px;">' +
                '<i class="bi bi-cloud-upload" style="color:#bdbebd; font-size: 55px;"></i>' +
                '<div style="color:#bdbebd; font-size: 20px; font-weight: bold; margin-bottom: 25px;">' +
                '최대 10장이내의 jpeg, jpg, png, gif 파일만 업로드 가능</div>' +
                '<div id="dndtext">Drag & Drop</div></div>').hide().fadeIn("fast");
        }
        updatetotalsize();
    });

    //유효성 검사
    function isValid(data) {
        //파일인가?
        if (data.types.indexOf('Files') < 0)
            return false;

        //이미지인가?
        for (let i = 0; i < data.files.length; i++) {
            if (data.files[i].type.indexOf("image") < 0) {
                alert("이미지만 업로드 가능합니다");
                return false;
            }
        }

        //파일개수 최대 3개
        if (filesarr.length + data.files.length > 10) {
            alert("파일은 최대 10개까지 업로드 가능합니다");
            return false;
        }

        //파일의 사이즈는 총 20MB

        let totalsize = filestotalsize(filesarr) + filestotalsize(data.files);
        if (totalsize >= 1024 * 1024 * 50) {
            alert("전체 업로드 파일의 크기가 50MB를 초과하였습니다");
            return false;
        }
        return true;
    }

    //filestotal size
    function filestotalsize(files) {
        let totalsize = 0;
        for (let i = 0; i < files.length; i++) {
            totalsize += files[i].size;
        }
        return totalsize
    }

    //update total size
    function updatetotalsize() {
        let totalsize = filestotalsize(filesarr);
        let mbsize = (totalsize / (1024 * 1024)).toFixed(1);
        $("#mbsize").html(mbsize);
    }


</script>


