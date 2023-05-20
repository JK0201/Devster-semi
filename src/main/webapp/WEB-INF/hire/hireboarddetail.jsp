<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<style>
    .already-added {
        color: red;

    }

    #add-bkmk-btn:hover {
        cursor: pointer;
    }

</style>

<script>
    <%--        버튼 상태 관련 이벤트  --%>
    $(document).ready(function () {

        var currentpage = 1;
        var isLoading = false;
        var noMoreData = false;

        var currentPosition = parseInt($(".quickmenu").css("top"));
        $(window).scroll(function () {
            var position = $(window).scrollTop();
            /*$(".quickmenu").stop().animate({"top": position + currentPosition + "px"}, 700);*/
            $(".quickmenu").css("transform", "translateY(" + position + "px)");
        });

        <!-- jsp 실행 이전의 리액션 여부 체크 및 버튼 색상 표현 -->
        $(function () {
            checkAddBkmkBefore();
        });
        <!-- 좋아요 버튼 클릭 이벤트 및 ajax 실행 -->
        $("#add-bkmk-btn").click(function () {
            <!-- 북마크가 눌려 있지 않은 경우  추가 -->
            if (isAlreadyAddBkmk == false) {
                $.ajax({
                    url: "/hire/increaseBkmk",
                    type: "POST",
                    data: {
                        "m_idx": ${sessionScope.memidx},
                        "hb_idx": ${dto.hb_idx}
                    },
                    success: function (goodReactionPoint) {
                        $("#add-bkmk-btn").addClass("already-added");
                        // $(".add-bookMark").html(goodReactionPoint);
                        isAlreadyAddBkmk = true;
                    },
                    error: function () {
                        alert('서버 에러, 다시 시도해주세요.');
                    }
                });

                <!-- 이미 북마크가 눌려 있는 경우 북마크 취소 -->
            } else if (isAlreadyAddBkmk == true) {
                $.ajax({
                    url: "/hire/decreaseBkmk",
                    type: "POST",
                    data: {
                        "m_idx": ${sessionScope.memidx},
                        "hb_idx": ${dto.hb_idx}
                    },
                    success: function (goodReactionPoint) {
                        $("#add-bkmk-btn").removeClass("already-added");
                        // $(".add-bookMark").html(goodReactionPoint);
                        isAlreadyAddBkmk = false;
                    },
                    error: function () {
                        alert('서버 에러, 다시 시도해주세요.');
                    }
                });
            } else {
                return;
            }
        });



    });
</script>


<div class="hb_detail_wrap clear">

    <div class="hb_detail_content">
        <div class="article_view_head">
            <a href="/">홈</a>
            <a href="./list?currentPage=${currentPage}" class="hireboard_link">회사후기</a>
            <div class="show_tag">
                <span class="tag_dday">마감 D-23</span>
                <span class="tag_career">경력무관</span>
            </div>
            <h2>${dto.hb_subject}</h2>
            <%--<div>${dto.hb_idx}</div>--%>
<%--            <div>${cm_name}</div>--%>
            <div class="wrap_info clear">
                <div class="icon_time"></div><div style="display: inline-block; color: #94969b;"><fmt:formatDate value="${dto.fb_writeday}" pattern="MM/dd"/></div>
                <span><div class="icon_read"></div>${dto.hb_readcount}</span>
                <c:if test="${sessionScope.memstate!=null}">
                <span id="add-bkmk-btn" class="btn btn-outline">북마크</span>
                </c:if>
            </div>

        </div>

        <div class="article_view_content">

            <div class="hr_tag">
                <div class="hr_tag_1">이직시200만원</div>
                <div class="hr_tag_2">유연근무</div>
            </div>

            <div class="hr_detail_img">
                <c:forEach items="${list}" var="images">
                    <img src="http://${imageUrl}/hire/${images}" style="float: left">
                    <br style="clear: both;"><br>
                </c:forEach>
            </div>

            <div class="content_txt">
                <pre>${dto.hb_content}</pre>
            </div>

            <div class="util_btns">
                <%--    <c:if test="${sessionScope.memdix==dto.hb_idx}">--%>
                <c:if test="${sessionScope.cmidx==dto.cm_idx || sessionScope.memstate==100}">
                <button type="button" class="btn btn-sm btn-outline-success"
                        onclick="location.href='./hireupdateform?hb_idx=${dto.hb_idx}&currentPage=${currentPage}'">수정
                </button>
                <button type="button" class="btn btn-sm btn-outline-success" onclick="del(${dto.hb_idx})">삭제</button>
                </c:if>
                        <%--    </c:if>--%>
                <button type="button" class="btn btn-sm btn-outline-success"
                        onclick="location.href='./list?currentPage=${currentPage}'">목록
                </button>
            </div>
        </div>

    </div>

    <div class="hb_aside">
        <div class="quickmenu">
            <ul>
                <li class="quickmenu_head"><h2>인기 채용정보</h2></li>
            </ul>
        </div>
    </div>

</div>

<%--<div class="quickmenu">
    <ul>
        <li class="quickmenu_head"><p style="font-size: 30px">베스트 게시글</p></li>
    </ul>
</div>--%>


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
        $(function () {
            checkAddBkmkBefore();
        });
    };


    $.ajax({
        type: "post",
        url: "./bestPostsForBanner",
        dataType: "json",
        success: function(response) {
            let s = "";
            $.each(response, function(index, item) {
                s +=
                    `
                        <li>
                            <a href="../hire/hireboarddetail?hb_idx=\${item.hb_idx}&currentPage=1">
                                <div class="name">
                                    <span><img src="http://${imageUrl}/hire/\${item.hb_photo}" width='34'></span>
                                    <div class="num"><strong>\${item.hb_subject}</strong></div>
                                </div>
                            </a>
                        </li>
                    `
            });
            s+=
                `
                       <!-- <button type="button" onclick="window.scrollTo({top:0});">
                         <i class="bi bi-arrow-up-square-fill"></i>
                        </button>-->

                        <li class="view_all_li">
                            <a href="../hire/list">
                                <span class="view_all">전체보기</span>
                            </a>
                        </li>
                    `;
            $(".quickmenu ul").append(s);
        },
        error: function(jqXHR, textStatus, errorThrown) {
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

</script>


