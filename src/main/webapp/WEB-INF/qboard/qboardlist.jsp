<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../commonvar.jsp" %>


<script>
    // 검색 여부 전역변수
    var isSearch = false;

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
        if (betweenTimeDay < 8) {
            return `\${betweenTimeDay}일전`;
        }

        const month = String(timeValue.getMonth() + 1).padStart(2, '0');
        const day = String(timeValue.getDate()).padStart(2, '0');
        const formattedDate = `\${month}-\${day}`;

        return `\${formattedDate}`;
    };

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
                        data: { currentPage: nextPage },
                        beforeSend: function () {
                            $("#loading").show();
                        },
                        complete: function () {
                            isLoading = false;
                        },
                        success: function (res) {
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
                                    $.each(res, function (idx,dto) {
                                        if (dto.qb_dislike > 19) {
                                            if(idx % 2 == 1) {
                                                s += `<div class="blurbox" style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;">`;
                                            } else {
                                                s += `<div class="blurbox">`;
                                            }
                                        } else {
                                            if(idx % 2 == 1) {
                                                s += `<div class="box" style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;">`;
                                            } else {
                                                s += `<div class="box">`;
                                            }
                                        }
                                        s += `<span class="qb_writeday">\${dto.qb_writeday}</span>`
                                        s += `<span class="qb_readcount"><div class="icon_read"></div>\${dto.qb_readcount}</span><br><br>`;
                                        s += `<span class="nickName" style="cursor: pointer" onclick=message(\${dto.nickName})><img src="\${dto.photo}" class="memberimg">&nbsp;\${dto.nickName}</span>`;
                                        s += `<div class="mainbox">`
                                        s += `<h3 class="qb_subject"><a href="detail?qb_idx=\${dto.qb_idx}"><b>\${dto.qb_subject}</b></a></h3>`;
                                        if (dto.qb_photo == 'n') {
                                            var content = dto.qb_content.substring(0, 120);
                                            if (dto.qb_content.length >= 120) {
                                                content += ".....";
                                            }
                                            s += `<h5 class="qb_content" style="width: 90%"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span>\${content}</span></a></h5>`;
                                        } else {
                                            var content = dto.qb_content.substring(0, 80);
                                            if (dto.qb_content.length >= 80) {
                                                content += ".....";
                                            }
                                            s += `<h5 class="qb_content" style="width:80%"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span class="photocontent">\${content}</span></a></h5>`;
                                            s += `<div style="position:relative; right:0; top: -80px;"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span class="qb_photo"><img src="http://${imageUrl}/qboard/\${dto.qb_photo.split(",")[0]}" id="qb_photo"></span></a></div>`;
                                        }
                                        s += `<div class="hr_tag"><div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;\${dto.qb_like}&nbsp;&nbsp;<i class="bi bi-hand-thumbs-down"></i>&nbsp;\${dto.qb_dislike}</div><div class="hr_tag_2"><i class="bi bi-chat"></i>&nbsp;\${dto.count}</div></div>`;
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

<style>
    div, ul, li {
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
        padding: 0;
        margin: 0
    }

    a {
        text-decoration: none;
    }

    /* 서치바 */
    .searchdiv {
        /*position: absolute;*/
        position: relative;
    }

    .searchbar {
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
</style>

<div class="qb_wrap">
    <!--=============================================================================-->

    <div class="noticeboard_part" style="border: 1px solid red">
        <h1>공지</h1>
        <ul class="clear">
            <c:if test="${NoticeBoardTotalCount>0}">
            <c:forEach var="dto" items="${nblist}">


            <li>
                <a href="../noticeboard/noticeboarddetail?nb_idx=${dto.nb_idx}&currentPage=${currentPage}"
                   style="color: #000;">
                        ${dto.nb_subject}
                    <c:if test="${dto.nb_photo!='n'}">
                        &nbsp; <i class="bi bi-images"></i>
                    </c:if>
                </a>
            </li>

        </ul>
        </c:forEach>
        </c:if>
        </ul>
    </div>
    <!--=============================================================================-->
    <!-- 검색창 -->
    <div class="searchdiv">
        <input id="searchinput" name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off"
               class="searchbar">
        <i class="bi bi-search"></i>

        <select id="searchOption">
            <option id="all" value="all">전체검색</option>
            <option id="searchnickname" value="m_nickname">작성자 검색</option>
            <option id="searchsubject" value="qb_subject">제목 검색</option>
        </select>
    </div>

    <script>


        $("#searchinput").keydown(function (e) {

            // 일단은 엔터 눌러야 검색되는걸로 -> 나중에 뭐 클릭해도 검색되게 바꿔도될듯?
            if (e.keyCode == 13) {
                isSearch = true;
                console.log(isSearch);

                // 검색내용
                var keyword = $(this).val();
                var searchOption = $("#searchOption").val();

                var currentpage = 1;
                var isLoading = false;
                var noMoreData = false;

                console.log(keyword);
                console.log(searchOption);

                // null 값 검색시 -> 아무일도 안일어남
                if (keyword == '') {
                    alert("검색하실 내용을 입력해주세요.")
                    return
                } else {
                    //alert("검색결과출력.");

                    if (!isLoading && !noMoreData) {
                        isLoading = true;
                        var nextPage = currentpage + 1;
                        $.ajax({
                            type: "post",
                            url: "./qboardsearchlist",
                            data: {"keyword": keyword, "searchOption": searchOption, "currentpage": nextPage},
                            dataType: "json",
                            beforeSend: function () {
                                $("#loading").show();
                            },
                            complete: function () {
                                isLoading = false;
                            },
                            success: function (res) {
                                if (res.searchCount == 0) {
                                    $(".listbox").html(`<h2 class="alert alert-outline-secondary">등록된 게시글이 없습니다..</h2>`);
                                    $("#loading").hide();
                                } else {
                                    if (res.length == 0) {
                                        alert("검색 결과가 없습니다.");
                                        noMoreData = true;
                                        $("#loading").hide();
                                    } else {
                                        setTimeout(function () {
                                            currentpage++;
                                            var s = '';

                                            $.each(res, function (idx, dto) {
                                                if (dto.qb_dislike > 19) {
                                                    if(idx % 2 == 1) {
                                                        s += `<div class="blurbox" style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;">`;
                                                    } else {
                                                        s += `<div class="blurbox">`;
                                                    }
                                                } else {
                                                    if(idx % 2 == 1) {
                                                        s += `<div class="box" style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;">`;
                                                    } else {
                                                        s += `<div class="box">`;
                                                    }
                                                }
                                                s += `<span class="qb_writeday">\${dto.qb_writeday}</span>`
                                                s += `<span class="qb_readcount"><div class="icon_read"></div>\${dto.qb_readcount}</span><br><br>`;
                                                s += `<span class="nickName" style="cursor: pointer" onclick=message(\${dto.nickName})><img src="http://${imageUrl}/member/\${dto.m_photo}" class="memberimg" style="width: 20px; height: 20px; border-radius: 100px;">&nbsp;\${dto.nickName}</span>`;
                                                s += `<div class="mainbox">`
                                                s += `<h3 class="qb_subject"><a href="detail?qb_idx=\${dto.qb_idx}"><b>\${dto.qb_subject}</b></a></h3>`;
                                                if (dto.qb_photo == 'n') {
                                                    var content = dto.qb_content.substring(0, 120);
                                                    if (dto.qb_content.length >= 120) {
                                                        content += ".....";
                                                    }
                                                    s += `<h5 class="qb_content" style="width: 90%"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span>\${content}</span></a></h5>`;
                                                } else {
                                                    var content = dto.qb_content.substring(0, 80);
                                                    if (dto.qb_content.length >= 80) {
                                                        content += ".....";
                                                    }
                                                    s += `<h5 class="qb_content" style="width:80%"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span class="photocontent">\${content}</span></a></h5>`;
                                                    s += `<div style="position:relative; right:0; top: -80px;"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span class="qb_photo"><img src="http://${imageUrl}/qboard/\${dto.qb_photo.split(",")[0]}" id="qb_photo"></span></a></div>`;
                                                }
                                                s += `<div class="hr_tag"><div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;\${dto.qb_like}&nbsp;&nbsp;<i class="bi bi-hand-thumbs-down"></i>&nbsp;\${dto.qb_dislike}</div><div class="hr_tag_2"><i class="bi bi-chat"></i>&nbsp;\${dto.count}</div></div>`;
                                                s += `</div>`;
                                                s += `</div>`;
                                            })
                                            $(".listbox").html(s);
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
            }
        });

    </script>
    <!--=============================================================================-->

    <!--================HEADBOX================================-->

    <div class="headbox">
        <h4 style="color: black; font-weight: bold;"><img src="/photo/icon_question.png" style="width: 40px;">질문게시판
            <button class="btn btn-secondary" type="button"
                    style="float: right; margin-right: 150px; margin-top: 30px;"
                    onclick="location.href='./writeform'"><i class="bi bi-pen"></i>&nbsp;글쓰기
            </button>
        </h4>
        <b>총 ${totalCount}개의 게시글</b><br>
    </div>

    <!--=============================================================================-->

    <!--=============================================================================-->
    <!-- listbox -->
    <div class="listbox">
        <c:if test="${totalCount==0}">
            <h2 class="alert alert-outline-secondary">등록된 게시글이 없습니다..</h2>
        </c:if>

        <c:if test="${totalCount>0}">
            <c:forEach var="dto" items="${list}" varStatus="i">
                <!-- blurbox-->
                <c:if test="${dto.qb_dislike > 19}">
                    <div class="blurbox"
                         <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>>

                        <span class="qb_writeday" id="writeday-${dto.qb_idx}"></span>
                        <script>
                            var writedayElement = document.getElementById("writeday-${dto.qb_idx}");
                            var formattedWriteday = timeForToday("${dto.qb_writeday}");
                            writedayElement.textContent = formattedWriteday;
                        </script>

                        <span class="qb_readcount"><div class="icon_read"></div>
                                ${dto.qb_readcount}</span><br><br>

                        <span class="nickName"><img src="${dto.photo}" class="memberimg">&nbsp;${dto.nickName}</span>

                        <div class="mainbox">
                            <h3 class="qb_subject">
                                <a href="detail?qb_idx=${dto.qb_idx}"><b>${dto.qb_subject}</b></a>
                            </h3>
                            <c:if test="${dto.qb_photo=='n'}">
                                <h5 class="qb_content" style="width: 90%">
                                    <a href="detail?qb_idx=${dto.qb_idx}"
                                       style="color: #000;">
                                <span>
                                    <c:set var="length" value="${fn:length(dto.qb_content)}"/>
                                    ${fn:substring(dto.qb_content, 0, 120)}

                                    <c:if test="${length>=120}">
                                        .....
                                    </c:if>
                                   </span></a>
                                </h5>
                            </c:if>
                            <c:if test="${dto.qb_photo!='n'}">
                                <h5 class="qb_content" style="width: 80%;">
                                    <a href="detail?qb_idx=${dto.qb_idx}"
                                       style="color: #000;">
                                    <span class="photocontent">
                                        <c:set var="length" value="${fn:length(dto.qb_content)}"/>
                                        ${fn:substring(dto.qb_content, 0, 80)}
                                        <c:if test="${length>=80}">
                                            .....
                                        </c:if>
                                   </span>
                                    </a>
                                </h5>
                                <div style="position:relative; right:0; top: -80px;">
                                    <a href="detail?qb_idx=${dto.qb_idx}">
                                        <span class="qb_photo">
                                            <img src="http://${imageUrl}/qboard/${dto.qb_photo.split(",")[0]}" id="qb_photo">
                                        </span>
                                    </a>
                                </div>
                            </c:if>
                            <div class="hr_tag">
                                <div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;${dto.qb_like}&nbsp;&nbsp;<i
                                        class="bi bi-hand-thumbs-down"></i>&nbsp;${dto.qb_dislike}</div>
                                <div class="hr_tag_2"><i class="bi bi-chat"></i>&nbsp;${dto.count}</div>
                            </div>
                        </div>
                    </div>

                </c:if>
                <!-- box-->
                <c:if test="${dto.qb_dislike < 20}">
                    <div class="box"
                         <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>>

                        <span class="qb_writeday" id="writeday-${dto.qb_idx}"></span>
                        <script>
                            var writedayElement = document.getElementById("writeday-${dto.qb_idx}");
                            var formattedWriteday = timeForToday("${dto.qb_writeday}");
                            writedayElement.textContent = formattedWriteday;
                        </script>

                        <span class="qb_readcount"><div class="icon_read"></div>
                                ${dto.qb_readcount}</span><br><br>

                        <span class="nickName" style="cursor:pointer;" onclick=message("${dto.nickName}")><img src="${dto.photo}"
                                                    class="memberimg">&nbsp;${dto.nickName}</span>
                        <div class="mainbox">
                            <h3 class="qb_subject">
                                <a href="detail?qb_idx=${dto.qb_idx}"><b>${dto.qb_subject}</b></a>
                            </h3>
                            <c:if test="${dto.qb_photo=='n'}">
                                <h5 class="qb_content" style="width: 90%">
                                    <a href="detail?qb_idx=${dto.qb_idx}"
                                       style="color: #000;">
                                <span>
                                    <c:set var="length" value="${fn:length(dto.qb_content)}"/>
                                    ${fn:substring(dto.qb_content, 0, 120)}

                                    <c:if test="${length>=120}">
                                        .....
                                    </c:if>
                                   </span></a>
                                </h5>
                            </c:if>
                            <c:if test="${dto.qb_photo!='n'}">
                                    <h5 class="qb_content" style="width: 80%;">
                                        <a href="detail?qb_idx=${dto.qb_idx}"
                                           style="color: #000;">
                                    <span class="photocontent">
                                        <c:set var="length" value="${fn:length(dto.qb_content)}"/>
                                        ${fn:substring(dto.qb_content, 0, 80)}
                                        <c:if test="${length>=80}">
                                            .....
                                        </c:if>
                                   </span>
                                        </a>
                                    </h5>
                                <div style="position:relative; right:0; top: -80px;">
                                    <a href="detail?qb_idx=${dto.qb_idx}">
                                        <span class="qb_photo">
                                            <img src="http://${imageUrl}/qboard/${dto.qb_photo.split(",")[0]}" id="qb_photo">
                                        </span>
                                    </a>
                                </div>
                            </c:if>
                            <div class="hr_tag">
                                <div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;${dto.qb_like}&nbsp;&nbsp;<i
                                        class="bi bi-hand-thumbs-down"></i>&nbsp;${dto.qb_dislike}</div>
                                <div class="hr_tag_2"><i class="bi bi-chat"></i>&nbsp;${dto.count}</div>
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
    <!--=============================================================================-->

</div>

<button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>

<script>

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
    // 쪽지보내기 메서드.
    function message(nickname) {
        window.open("other_profile?other_nick="+nickname, 'newwindow', 'width=700,height=700');
    }



</script>

