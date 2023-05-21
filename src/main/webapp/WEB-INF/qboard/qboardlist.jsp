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
                                        s += `<span class="qb_readcount" style="margin-left: 5px"><div class="icon_read"></div>\${dto.qb_readcount}</span><br><br>`;
                                        s += `<span class="nickName" style="cursor: pointer" onclick=message("\${dto.nickName}")><img src="\${dto.photo}" class="memberimg">&nbsp;\${dto.nickName}</span>`;
                                        s += `<div class="mainbox">`
                                        if (dto.qb_photo == 'n') {
                                            s += `<h3 class="qb_subject text-block-subject-2-nophoto"><a href="detail?qb_idx=\${dto.qb_idx}"><b>\${dto.qb_subject}</b></a></h3>`;
                                            s += `<h5 class="qb_content text-block-content-2-nophoto"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span>\${dto.qb_content}</span></a></h5>`;
                                        } else {
                                            s += `<h3 class="qb_subject text-block-subject-2-photo"><a href="detail?qb_idx=\${dto.qb_idx}"><b>\${dto.qb_subject}</b></a></h3>`;
                                            s += `<h5 class="qb_content text-block-content-2-photo" style="width:80%"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span class="photocontent">\${dto.qb_content}</span></a></h5>`;
                                            s += `<div style="position:relative; right:0; top: -80px;"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span class="qb_photo"><img src="http://${imageUrl}/qboard/\${dto.qb_photo.split(",")[0]}" id="qb_photo"></span></a></div>`;
                                        }
                                        s += `<div class="hr_tag"><div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;\${dto.qb_like}&nbsp;&nbsp;<i class="bi bi-hand-thumbs-down"></i>&nbsp;\${dto.qb_dislike}</div><div class="hr_tag_2" style="margin-left: 3px"><i class="bi bi-chat"></i>&nbsp;\${dto.count}</div></div>`;
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



<div class="qb_wrap">

    <div class="headbox">
        <h4 class="boardname">
            <div class="yellowbar">&nbsp;</div>&nbsp;&nbsp;질문게시판
        </h4>

        <!-- 검색창 -->
        <div class="searchdiv">
            <select id="searchOption" class="form-select">
                <option id="all" value="all">전체검색</option>
                <option id="searchnickname" value="m_nickname">작성자 검색</option>
                <option id="searchsubject" value="qb_subject">제목 검색</option>
            </select>
            <input id="searchinput" name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off"
                   class="searchbar">
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

                console.log(keyword);
                console.log(searchOption);

                // null 값 검색시 -> 아무일도 안일어남
                if (keyword == '') {
                    alert("검색하실 내용을 입력해주세요.")
                    isSearch = false;
                    return
                } else {
                    // 기본출력
                    $.ajax({
                        type: "post",
                        url: "./qboardsearchlist",
                        data: {"keyword": keyword, "searchOption": searchOption, "currentpage": currentpage},
                        dataType: "json",
                        beforeSend: function () {
                            $("#loading").show();
                        },
                        complete: function () {
                            isLoading = false;
                        },
                        success: function (res) {
                                if (res.length == 0) {
                                    alert("검색 결과가 없습니다.");
                                    isSearch = false;
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
                                            s += `<span class="qb_readcount" style="margin-left: 5px"><div class="icon_read"></div>\${dto.qb_readcount}</span><br><br>`;
                                            s += `<span class="nickName" style="cursor: pointer" onclick=message("\${dto.nickName}")><img src="\${dto.photo}" class="memberimg">&nbsp;\${dto.nickName}</span>`;
                                            s += `<div class="mainbox">`
                                            if (dto.qb_photo == 'n') {
                                                s += `<h3 class="qb_subject text-block-subject-2-nophoto"><a href="detail?qb_idx=\${dto.qb_idx}"><b>\${dto.qb_subject}</b></a></h3>`;
                                                s += `<h5 class="qb_content text-block-content-2-nophoto"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span>\${dto.qb_content}</span></a></h5>`;
                                            } else {
                                                s += `<h3 class="qb_subject text-block-subject-2-photo"><a href="detail?qb_idx=\${dto.qb_idx}"><b>\${dto.qb_subject}</b></a></h3>`;
                                                s += `<h5 class="qb_content text-block-content-2-photo" style="width:80%"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span class="photocontent">\${dto.qb_content}</span></a></h5>`;
                                                s += `<div style="position:relative; right:0; top: -80px;"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span class="qb_photo"><img src="http://${imageUrl}/qboard/\${dto.qb_photo.split(",")[0]}" id="qb_photo"></span></a></div>`;
                                            }
                                            s += `<div class="hr_tag"><div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;\${dto.qb_like}&nbsp;&nbsp;<i class="bi bi-hand-thumbs-down"></i>&nbsp;\${dto.qb_dislike}</div><div class="hr_tag_2" style="margin-left: 3px"><i class="bi bi-chat"></i>&nbsp;\${dto.commentCnt}</div></div>`;
                                            s += `</div>`;
                                            s += `</div>`;
                                        })
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


                    // 추가 스크롤 출력
                    $(window).scroll(function () {

                        if (Math.floor($(window).scrollTop()) == $(document).height() - $(window).height()) {
                            if (!isLoading && !noMoreData) {
                                isLoading = true;
                                var nextPage = currentpage;
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
                                                        s += `<span class="qb_readcount" style="margin-left: 5px"><div class="icon_read"></div>\${dto.qb_readcount}</span><br><br>`;
                                                        s += `<span class="nickName" style="cursor: pointer" onclick=message("\${dto.nickName}")><img src="\${dto.photo}" class="memberimg">&nbsp;\${dto.nickName}</span>`;
                                                        s += `<div class="mainbox">`
                                                        if (dto.qb_photo == 'n') {
                                                            s += `<h3 class="qb_subject text-block-subject-2-nophoto"><a href="detail?qb_idx=\${dto.qb_idx}"><b>\${dto.qb_subject}</b></a></h3>`;
                                                            s += `<h5 class="qb_content text-block-content-2-nophoto"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span>\${dto.qb_content}</span></a></h5>`;
                                                        } else {
                                                            s += `<h3 class="qb_subject text-block-subject-2-photo"><a href="detail?qb_idx=\${dto.qb_idx}"><b>\${dto.qb_subject}</b></a></h3>`;
                                                            s += `<h5 class="qb_content text-block-content-2-photo" style="width:80%"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span class="photocontent">\${dto.qb_content}</span></a></h5>`;
                                                            s += `<div style="position:relative; right:0; top: -80px;"><a href="detail?qb_idx=\${dto.qb_idx}" style="color: #000;"><span class="qb_photo"><img src="http://${imageUrl}/qboard/\${dto.qb_photo.split(",")[0]}" id="qb_photo"></span></a></div>`;
                                                        }
                                                        s += `<div class="hr_tag"><div class="hr_tag_1"><i class="bi bi-hand-thumbs-up"></i>&nbsp;\${dto.qb_like}&nbsp;&nbsp;<i class="bi bi-hand-thumbs-down"></i>&nbsp;\${dto.qb_dislike}</div><div class="hr_tag_2" style="margin-left: 3px"><i class="bi bi-chat"></i>&nbsp;\${dto.commentCnt}</div></div>`;
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
                            <c:if test="${dto.qb_photo=='n'}">
                                <h3 class="qb_subject text-block-subject-2-nophoto">
                                    <a href="detail?qb_idx=${dto.qb_idx}"><b>${dto.qb_subject}</b></a>
                                </h3>
                                <h5 class="qb_content text-block-content-2-nophoto">
                                    <a href="detail?qb_idx=${dto.qb_idx}"
                                       style="color: #000;">
                                        <span>
                                        ${dto.qb_content}
                                       </span>
                                    </a>
                                </h5>
                            </c:if>
                            <c:if test="${dto.qb_photo!='n'}">
                                <h3 class="qb_subject text-block-subject-2-photo">
                                    <a href="detail?qb_idx=${dto.qb_idx}"><b>${dto.qb_subject}</b></a>
                                </h3>
                                <h5 class="qb_content text-block-content-2-photo" style="width: 80%;">
                                    <a href="detail?qb_idx=${dto.qb_idx}"
                                       style="color: #000;">
                                        <span class="photocontent">
                                            ${dto.qb_content}
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
                            <c:if test="${dto.qb_photo=='n'}">
                                <h3 class="qb_subject text-block-subject-2-nophoto">
                                    <a href="detail?qb_idx=${dto.qb_idx}"><b>${dto.qb_subject}</b></a>
                                </h3>
                                <h5 class="qb_content text-block-content-2-nophoto">
                                    <a href="detail?qb_idx=${dto.qb_idx}"
                                       style="color: #000;">
                                        <span>
                                                ${dto.qb_content}
                                        </span>
                                    </a>
                                </h5>
                            </c:if>
                            <c:if test="${dto.qb_photo!='n'}">
                                <h3 class="qb_subject text-block-subject-2-photo">
                                    <a href="detail?qb_idx=${dto.qb_idx}"><b>${dto.qb_subject}</b></a>
                                </h3>
                                <h5 class="qb_content text-block-content-2-photo" style="width: 80%;">
                                    <a href="detail?qb_idx=${dto.qb_idx}"
                                       style="color: #000;">
                                        <span class="photocontent">
                                                ${dto.qb_content}
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
<br>
<button id="myWriteBtn" type="button" onclick="location.href='./writeform'">글쓰기</button>

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

