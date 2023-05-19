<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../commonvar.jsp" %>


<div class="fb_wrap">

    <!--===============================Headbox==============================================-->

    <div class="headbox">
        <h4 class="boardname">
            <div class="yellowbar">&nbsp;</div>&nbsp;&nbsp;일반게시판
        </h4>

        <!-- 검색창 -->
        <div class="searchdiv">
            <input id="searchinput" name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off"
                   class="searchbar">
            <i class="bi bi-search"></i>

            <select id="searchOption">
                <option id="all" value="all">전체검색</option>
                <option id="searchnickname" value="m_nickname">작성자 검색</option>
                <option id="searchsubject" value="fb_subject">제목 검색</option>
            </select>
        </div>
    </div>

    <!--=============================================================================-->

    <!--=============================================================================-->

    <div class="noticeboard_part">
        <ul class="clear noticelist">
            <c:if test="${NoticeBoardTotalCount>0}">
                <c:forEach var="dto" items="${nblist}">


                    <li>
                        <b class="noticetitle">Devster 공지사항</b>
                        <a href="../noticeboard/noticeboarddetail?nb_idx=${dto.nb_idx}&currentPage=${currentPage}">
                                ${dto.nb_subject}
                            <c:if test="${dto.nb_photo!='n'}">
                                &nbsp; <i class="bi bi-images"></i>
                            </c:if>
                        </a>
                    </li>
                </c:forEach>
            </c:if>
        </ul>
    </div>

    <!--=============================================================================-->

    <style>
        /*notice*/
        .noticeboard_part {
            margin-bottom: 10px;
        }

        .noticeboard_part ul {
            padding: 0 !important;
            margin: 0 !important;
        }

        .noticeboard_part li .noticetitle {
            background-color: #cdcdcd;
            border-radius: 5px;
            margin-right: 20px;
            width: 50px;
            height: 13px;
            padding-left: 20px;
            padding-right: 20px;
            padding-bottom: 7px;
            padding-top: 7px;
            font-weight: bold;
            font-size: 13px;
        }

        .noticeboard_part li {

            background-color: #e3e3e3;
            border-radius: 5px;

            padding-top: 15px;
            padding-bottom: 15px;
            padding-left: 20px;

            color: #000;
            margin-bottom: 5px;
            font-size: 16px;
        }


        /*headbox*/
        .headbox {
            display: flex;
            margin-bottom: 10px;
        }

        .yellowbar {
            display: inline-block;
            background-color: #e3da50;
            width: 8px;
            height: 100%;
        }

        .headbox .boardname {
            color: black;
            font-weight: bold;
            display: inline-block;
        }

        .writebtn {
            margin-left: 30px;
        }

        /* 서치바 */
        .searchdiv {
            /*position: absolute;*/
            position: relative;
            display: inline-block;
            float: right;
            margin-left: 600px;
        }

        .searchbar {
            width: 270px;
            height: 40px;
            padding: 0 0 0 50px;
            border: 2px solid #222;
            border-radius: 30px;
            font-size: 15px;
            box-sizing: border-box;
        }

        .bi-search {
            position: absolute;
            right: 10px; /* 아이콘과 입력란 사이의 공간을 조절합니다. */
            top: 20px;
            left: 20px;
            transform: translateY(-50%); /* 아이콘을 입력란의 정중앙에 배치합니다. */
            pointer-events: none; /* 입력란 위에서 클릭이나 기타 동작이 가능하게 합니다. */
            font-size: 15px;
        }

        #myBtn {
            display: none; /* Hidden by default */
            position: fixed; /* Fixed/sticky position */
            bottom: 20px; /* Place the button at the bottom of the page */
            right: 30px; /* Place the button 30px from the right */
            z-index: 99; /* Make sure it does not overlap */
            border: none; /* Remove borders */
            outline: none; /* Remove outline */
            background-color: #7f07ac; /* Set a background color */
            color: white; /* Text color */
            cursor: pointer; /* Add a mouse pointer on hover */
            padding: 15px; /* Some padding */
            border-radius: 10px; /* Rounded corners */
            font-size: 18px; /* Increase font size */
        }

        #myBtn:hover {
            background-color: #530871; /* Add a dark-grey background on hover */
        }

        #myWriteBtn {
            /*display: none; !* Hidden by default *!*/
            position: fixed; /* Fixed/sticky position */
            bottom: 20px; /* Place the button at the bottom of the page */
            right: 30px; /* Place the button 30px from the right */
            z-index: 99; /* Make sure it does not overlap */
            border: none; /* Remove borders */
            outline: none; /* Remove outline */
            background-color: #7f07ac; /* Set a background color */
            color: white; /* Text color */
            cursor: pointer; /* Add a mouse pointer on hover */
            padding: 15px; /* Some padding */
            border-radius: 10px; /* Rounded corners */
            font-size: 18px; /* Increase font size */
            margin-bottom: 70px;
        }

        #myWriteBtn:hover {
            background-color: #530871; /* Add a dark-grey background on hover */
        }

    </style>

    <script>

        // 몇시간전글인지
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


        // 검색 여부 전역변수
        var isSearch = false;

        $(document).ready(function () {

            var currentpage = 1;
            var isLoading = false;
            var noMoreData = false;

            $(window).scroll(function () {
                // 무한스크롤
                if (Math.floor($(window).scrollTop()) == $(document).height() - $(window).height()) {

                    if (!isLoading && !noMoreData && !isSearch) {
                        isLoading = true;
                        var nextPage = currentpage + 1;

                        $.ajax({
                            type: "GET",
                            url: "./listajax",
                            data: {currentPage: nextPage},
                            beforeSend: function () {
                                $("#loading").show();
                            },
                            complete: function () {
                                isLoading = false;
                            },
                            success: function (res) {
                                console.log(currentpage);
                                console.log("총 게시물수 : "+res.searchCount);
                                console.log(noMoreData);
                                console.log(res.length);
                                if (res.totalCount == 0) {
                                    $(".listbox").append(`<h2 class="alert alert-outline-secondary">등록된 게시글이 없습니다..</h2>`);
                                    $("#loading").hide();
                                } else {
                                    if (res.length == 0) {
                                        noMoreData = true;
                                        $("#loading").hide();
                                    } else {
                                        setTimeout(function () {
                                            currentpage++;
                                            var s = '';
                                            $.each(res, function (idx, dto) {
                                                if (dto.fb_dislike > 19) {
                                                    if (idx % 2 == 1) {
                                                        s += `<div class="blurbox" style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;">`;
                                                    } else {
                                                        s += `<div class="blurbox">`;
                                                    }
                                                } else {
                                                    if (idx % 2 == 1) {
                                                        s += `<div class="box" style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;">`;
                                                    } else {
                                                        s += `<div class="box">`;
                                                    }
                                                }
                                                s += `<span class="fb_writeday">\${dto.fb_writeday}</span>`
                                                s += `<span class="fb_readcount"><div class="icon_read"></div>\${dto.fb_readcount}</span><br><br>`;
                                                s += `<span class="nickName" style="cursor:pointer;" onclick=message("\${dto.nickName}")><img src="\${dto.m_photo}" class="memberimg">&nbsp;
\${dto.nickName}</span>`;
                                                s += `<div class="mainbox">`
                                                s += `<h3 class="fb_subject"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}"><b>\${dto.fb_subject}</b></a></h3>`;
                                                if (dto.fb_photo == 'n') {
                                                    var content = dto.fb_content.substring(0, 120);
                                                    if (dto.fb_content.length >= 120) {
                                                        content += ".....";
                                                    }
                                                    s += `<h5 class="fb_content" style="width: 90%"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}" style="color: #000;"><span>\${content}</span></a></h5>`;
                                                } else {
                                                    var content = dto.fb_content.substring(0, 80);
                                                    if (dto.fb_content.length >= 80) {
                                                        content += ".....";
                                                    }
                                                    s += `<h5 class="fb_content" style="width:80%"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}" style="color: #000;"><span class="photocontent">\${content}</span></a></h5>`;
                                                    s += `<div style="position:relative; right:0; top: -80px;"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}" style="color: #000;"><span class="fb_photo"><img src="http://${imageUrl}/freeboard/\${dto.fb_photo.split(",")[0]}" id="fb_photo"></span></a></div>`;
                                                }
                                                s += `<div class="hr_tag"><div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;\${dto.fb_like}&nbsp;&nbsp;<i class="bi bi-hand-thumbs-down"></i>&nbsp;\${dto.fb_dislike}</div><div class="hr_tag_2"><i class="bi bi-chat"></i>&nbsp;\${dto.commentCnt}</div></div>`;
                                                s += `</div>`;
                                                s += `</div>`;
                                            })
                                            $(".listbox").append(s);
                                            $("#loading").hide();
                                        }, 1000);  // 1초 후에 실행
                                    }
                                }
                            },
                            error: function (xhr, status, error) {
                                console.log("Error:", error);
                                $("#loading").hide();
                            }

                        })
                    }
                }


            });


        });


    </script>

    <!--=============================================================================-->

    <!-- 검색 -->
    <script>

        $("#searchinput").keydown(function (e) {

            // 일단은 엔터 눌러야 검색되는걸로 -> 나중에 뭐 클릭해도 검색되게 바꿔도될듯?
            if (e.keyCode == 13) {

                isSearch = true;

                // 검색내용
                var keyword = $(this).val();
                var searchOption = $("#searchOption").val();

                var currentpage = 1;
                var isLoading = false;
                var noMoreData = false;

                // null 값 검색시 -> 아무일도 안일어남
                if (keyword == '') {
                    alert("검색하실 내용을 입력해주세요.")
                    return
                } else { // 검색 내용 있을때
                    // 기본 출력
                    $.ajax({
                        type: "post",
                        url: "./freeboardsearchlist",
                        data: {"keyword": keyword, "searchOption": searchOption, "currentpage": currentpage},
                        dataType: "json",
                        beforeSend: function () {
                            $("#loading").show();
                        },
                        complete: function () {
                            isLoading = false;
                        },
                        success: function (res) {
                            console.log(currentpage);
                            console.log(noMoreData);

                                if (res.length == 0) {
                                    alert("검색 결과가 없습니다.");
                                    noMoreData = true;
                                    $("#loading").hide();
                                } else {
                                    setTimeout(function () {
                                        currentpage++;
                                        var s = '';
                                        $.each(res, function (idx, dto) {
                                            if (dto.fb_dislike > 19) {
                                                if (idx % 2 == 1) {
                                                    s += `<div class="blurbox" style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;">`;
                                                } else {
                                                    s += `<div class="blurbox">`;
                                                }
                                            } else {
                                                if (idx % 2 == 1) {
                                                    s += `<div class="box" style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;">`;
                                                } else {
                                                    s += `<div class="box">`;
                                                }
                                            }
                                            s += `<span class="fb_writeday">\${dto.fb_writeday}</span>`
                                            s += `<span class="fb_readcount"><div class="icon_read"></div>\${dto.fb_readcount}</span><br><br>`;
                                            s += `<span class="m_nickname"style="cursor:pointer;" onclick=message("\${dto.nickName}")><img src="\${dto.m_photo}" class="memberimg" style="width: 20px; height: 20px; border-radius: 100px;">&nbsp;
\${dto.nickName}</span>`;
                                            s += `<div class="mainbox">`
                                            s += `<h3 class="fb_subject"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}"><b>\${dto.fb_subject}</b></a></h3>`;
                                            if (dto.fb_photo == 'n') {
                                                var content = dto.fb_content.substring(0, 120);
                                                if (dto.fb_content.length >= 120) {
                                                    content += ".....";
                                                }
                                                s += `<h5 class="fb_content" style="width: 90%"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}" style="color: #000;"><span>\${content}</span></a></h5>`;
                                            } else {
                                                var content = dto.fb_content.substring(0, 80);
                                                if (dto.fb_content.length >= 80) {
                                                    content += ".....";
                                                }
                                                s += `<h5 class="fb_content" style="width:80%"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}" style="color: #000;"><span class="photocontent">\${content}</span></a></h5>`;
                                                s += `<div style="position:relative; right:0; top: -80px;"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}" style="color: #000;"><span class="fb_photo"><img src="http://${imageUrl}/freeboard/\${dto.fb_photo.split(",")[0]}" id="fb_photo"></span></a></div>`;
                                            }
                                            s += `<div class="hr_tag"><div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;\${dto.fb_like}&nbsp;&nbsp;<i class="bi bi-hand-thumbs-down"></i>&nbsp;\${dto.fb_dislike}</div><div class="hr_tag_2"><i class="bi bi-chat"></i>&nbsp;\${dto.commentCnt}</div></div>`;
                                            s += `</div>`;
                                            s += `</div>`;
                                        })
                                        s += ``;

                                        $(".listbox").html(s);
                                        $("#loading").hide();

                                    }, 1000);  // 1초 후에 실행
                                }

                        },

                        error: function (xhr, status, error) {
                            // 요청이 실패했을 때의 처리 로직
                            console.log("Error:", error);
                        }
                    });

                    // 추가 리스트 출력 (스크롤)
                    $(window).scroll(function () {

                        if (Math.floor($(window).scrollTop()) == $(document).height() - $(window).height()) {

                            if (!isLoading && !noMoreData) {
                                isLoading = true;
                                let nextPage = currentpage;
                                $.ajax({
                                    type: "post",
                                    url: "./freeboardsearchlist",
                                    data: {"keyword": keyword, "searchOption": searchOption, "currentpage": nextPage},
                                    dataType: "json",
                                    beforeSend: function () {
                                        $("#loading").show();
                                    },
                                    complete: function () {
                                        isLoading = false;
                                    },
                                    success: function (res) {
                                        console.log(currentpage);
                                        console.log(noMoreData);
                                        console.log(res.length);
                                        if (res.searchCount == 0) {
                                            noMoreData = true;
                                            $("#loading").hide();
                                        } else {
                                            if (res.length == 0) {
                                                noMoreData = true;
                                                $("#loading").hide();
                                            } else {
                                                setTimeout(function () {
                                                    currentpage++;
                                                    var s = '';

                                                    $.each(res, function (idx, dto) {
                                                        if (dto.fb_dislike > 19) {
                                                            if (idx % 2 == 1) {
                                                                s += `<div class="blurbox" style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;">`;
                                                            } else {
                                                                s += `<div class="blurbox">`;
                                                            }
                                                        } else {
                                                            if (idx % 2 == 1) {
                                                                s += `<div class="box" style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;">`;
                                                            } else {
                                                                s += `<div class="box">`;
                                                            }
                                                        }
                                                        s += `<span class="fb_writeday">\${dto.fb_writeday}</span>`
                                                        s += `<span class="fb_readcount"><div class="icon_read"></div>\${dto.fb_readcount}</span><br><br>`;
                                                        s += `<span class="m_nickname"style="cursor:pointer;" onclick=message("\${dto.nickName}")><img src="\${dto.m_photo}" class="memberimg" style="width: 20px; height: 20px; border-radius: 100px;">&nbsp;
\${dto.nickName}</span>`;
                                                        s += `<div class="mainbox">`
                                                        s += `<h3 class="fb_subject"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}"><b>\${dto.fb_subject}</b></a></h3>`;
                                                        if (dto.fb_photo == 'n') {
                                                            var content = dto.fb_content.substring(0, 120);
                                                            if (dto.fb_content.length >= 120) {
                                                                content += ".....";
                                                            }
                                                            s += `<h5 class="fb_content" style="width: 90%"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}" style="color: #000;"><span>\${content}</span></a></h5>`;
                                                        } else {
                                                            var content = dto.fb_content.substring(0, 80);
                                                            if (dto.fb_content.length >= 80) {
                                                                content += ".....";
                                                            }
                                                            s += `<h5 class="fb_content" style="width:80%"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}" style="color: #000;"><span class="photocontent">\${content}</span></a></h5>`;
                                                            s += `<div style="position:relative; right:0; top: -80px;"><a href="freeboarddetail?fb_idx=\${dto.fb_idx}" style="color: #000;"><span class="fb_photo"><img src="http://${imageUrl}/freeboard/\${dto.fb_photo.split(",")[0]}" id="fb_photo"></span></a></div>`;
                                                        }
                                                        s += `<div class="hr_tag"><div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;\${dto.fb_like}&nbsp;&nbsp;<i class="bi bi-hand-thumbs-down"></i>&nbsp;\${dto.fb_dislike}</div><div class="hr_tag_2"><i class="bi bi-chat"></i>&nbsp;\${dto.commentCnt}</div></div>`;
                                                        s += `</div>`;
                                                        s += `</div>`;
                                                    })
                                                    s += ``;

                                                    $(".listbox").append(s);
                                                    $("#loading").hide();

                                                }, 1000);  // 1초 후에 실행
                                            }
                                        }
                                    },

                                    error: function (xhr, status, error) {
                                        // 요청이 실패했을 때의 처리 로직
                                        console.log("Error:", error);
                                    }
                                });
                            }
                        }
                    })
                }
            }
        });

    </script>


    <!-- listbox -->
    <div class="listbox">
        <c:if test="${totalCount==0}">
            <h2 class="alert alert-outline-secondary">등록된 게시글이 없습니다..</h2>
        </c:if>

        <c:if test="${totalCount>0}">
            <c:forEach var="dto" items="${list}" varStatus="i">
                <!-- blurbox-->
                <c:if test="${dto.fb_dislike > 19}">
                    <div class="blurbox"
                         <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>>

                        <span class="fb_writeday" id="writeday-${dto.fb_idx}"></span>
                        <script>
                            var writedayElement = document.getElementById("writeday-${dto.fb_idx}");
                            var formattedWriteday = timeForToday("${dto.fb_writeday}");
                            writedayElement.textContent = formattedWriteday;
                        </script>

                        <span class="fb_readcount"><div class="icon_read"></div>
                                ${dto.fb_readcount}</span><br><br>

                        <span class="nickName" style="cursor:pointer;" onclick=message("${dto.nickName}")><img
                                src="${dto.m_photo}"
                                class="memberimg">&nbsp;&nbsp;${dto.nickName}</span>

                        <div class="mainbox">
                            <h3 class="fb_subject">
                                <a href="freeboarddetail?fb_idx=${dto.fb_idx}"><b>${dto.fb_subject}</b></a>
                            </h3>

                            <c:if test="${dto.fb_photo=='n'}">
                                <h5 class="fb_content" style="width: 90%">
                                    <a href="freeboarddetail?fb_idx=${dto.fb_idx}"
                                       style="color: #000;">
                                <span>
                                    <c:set var="length" value="${fn:length(dto.fb_content)}"/>
                                    ${fn:substring(dto.fb_content, 0, 120)}

                                    <c:if test="${length>=120}">
                                        .....
                                    </c:if>
                                   </span></a>
                                </h5>
                            </c:if>
                            <c:if test="${dto.fb_photo!='n'}">
                                <h5 class="fb_content" style="width: 80%;">
                                    <a href="freeboarddetail?fb_idx=${dto.fb_idx}"
                                       style="color: #000;">
                                <span class="photocontent">
                                    <c:set var="length" value="${fn:length(dto.fb_content)}"/>
                                    ${fn:substring(dto.fb_content, 0, 80)}

                                    <c:if test="${length>=80}">
                                        .....
                                    </c:if>
                                   </span>
                                    </a>
                                </h5>
                                <div style="position:relative; right:0; top: -80px;">
                                    <a href="freeboarddetail?fb_idx=${dto.fb_idx}">
                                    <span class="fb_photo">
                    <img src="http://${imageUrl}/freeboard/${dto.fb_photo.split(",")[0]}" id="fb_photo">
                        </span>
                                    </a>
                                </div>

                            </c:if>

                            <div class="hr_tag">
                                <div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;${dto.fb_like}&nbsp;&nbsp;<i
                                        class="bi bi-hand-thumbs-down-"></i>&nbsp;${dto.fb_dislike}</div>
                                <div class="hr_tag_2"><i class="bi bi-chat"></i>&nbsp;${dto.commentCnt}</div>
                            </div>

                        </div>

                    </div>


                </c:if>
                <!-- blurbox-->
                <!-- box-->
                <c:if test="${dto.fb_dislike < 20}">
                    <div class="box"
                         <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>>

                        <span class="fb_writeday" id="writeday-${dto.fb_idx}"></span>
                        <script>
                            var writedayElement = document.getElementById("writeday-${dto.fb_idx}");
                            var formattedWriteday = timeForToday("${dto.fb_writeday}");
                            writedayElement.textContent = formattedWriteday;
                        </script>

                        <span class="fb_readcount"><div class="icon_read"></div>
                                ${dto.fb_readcount}</span><br><br>

                        <span class="nickName" style="cursor:pointer;" onclick=message("${dto.nickName}")><img
                                src="${dto.m_photo}"
                                class="memberimg">&nbsp;${dto.nickName}</span>

                        <div class="mainbox">
                            <h3 class="fb_subject">
                                <a href="freeboarddetail?fb_idx=${dto.fb_idx}"><b>${dto.fb_subject}</b></a>
                            </h3>

                            <c:if test="${dto.fb_photo=='n'}">
                                <h5 class="fb_content" style="width: 90%">
                                    <a href="freeboarddetail?fb_idx=${dto.fb_idx}"
                                       style="color: #000;">
                                <span>
                                    <c:set var="length" value="${fn:length(dto.fb_content)}"/>
                                    ${fn:substring(dto.fb_content, 0, 120)}

                                    <c:if test="${length>=120}">
                                        .....
                                    </c:if>
                                   </span></a>
                                </h5>
                            </c:if>
                            <c:if test="${dto.fb_photo!='n'}">
                                <h5 class="fb_content">
                                    <a href="freeboarddetail?fb_idx=${dto.fb_idx}"
                                       style="color: #000;">
                                <span class="photocontent">
                                    <c:set var="length" value="${fn:length(dto.fb_content)}"/>
                                    ${fn:substring(dto.fb_content, 0, 80)}

                                    <c:if test="${length>=80}">
                                        .....
                                    </c:if>
                                   </span>
                                    </a>
                                </h5>
                                <div style="position:relative; right:0; top: -80px;">
                                    <a href="freeboarddetail?fb_idx=${dto.fb_idx}">
                                <span class="fb_photo">
                    <img src="http://${imageUrl}/freeboard/${dto.fb_photo.split(",")[0]}" id="fb_photo">
            </span>
                                    </a>
                                </div>

                            </c:if>

                            <div class="hr_tag">
                                <div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;${dto.fb_like}&nbsp;&nbsp;<i
                                        class="bi bi-hand-thumbs-down"></i>&nbsp;${dto.fb_dislike}</div>
                                <div class="hr_tag_2"><i class="bi bi-chat"></i>&nbsp;${dto.commentCnt}</div>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- box-->
            </c:forEach>
        </c:if>
    </div>
    <!-- listbox -->


    <div id="loading"
         style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 9999;">
        <img src="${root}/photo/loading.gif" alt="Loading..."
             style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">
        <!-- 로딩 이미지의 경로를 설정하세요 -->
    </div>

    <button id="myWriteBtn" type="button" onclick="location.href='./freewriteform'">글쓰기</button>
    <br>
    <button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
    <script>
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
    <div class="num">\${index+1} \${item.fb_subject}</div>
    </div>
    </a>
    </li>
    `
                });
                s +=
                    `
    <button type="button" onclick="window.scrollTo({top:0});">
    <i class="bi bi-arrow-up-square-fill"></i>
    </button>
    `;
                $(".quickmenu ul").append(s);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log("Error: " + textStatus + " - " + errorThrown);
            }
        });


        // When the user scrolls down 20px from the top of the document, show the button
        window.onscroll = function () {
            scrollFunction()
        };

        function scrollFunction() {
            if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                document.getElementById("myBtn").style.display = "block";
            } else {
                document.getElementById("myBtn").style.display = "none";
            }
        }


        // When the user clicks on the button, scroll to the top of the document
        function topFunction() {
            document.body.scrollTop = 0; // For Safari
            document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
        }

        // 프로필 클릭
        function message(nickname) {
            window.open("other_profile?other_nick=" + nickname, 'newwindow', 'width=700,height=700');
        }

    </script>

