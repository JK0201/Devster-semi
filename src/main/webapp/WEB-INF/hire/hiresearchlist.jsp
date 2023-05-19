<%--
  Created by IntelliJ IDEA.
  User: hyunohsmacbook
  Date: 2023/05/02
  Time: 10:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../commonvar.jsp" %>

<script>
    $(document).ready(function () {

        var currentpage = 1;
        var isLoading = false;
        var noMoreData = false;
        var keyword = "${keyword}";
        console.log(keyword);

        $(window).scroll(function () {
            console.log(Math.floor($(window).scrollTop()) == $(document).height() - $(window).height());

            // 무한스크롤
            if (Math.floor($(window).scrollTop()) == $(document).height() - $(window).height()) {

                if (!isLoading && !noMoreData) {
                    isLoading = true;
                    var nextPage = currentpage + 1;

                    $.ajax({
                        type: "GET",
                        url: "./searchlistajax",
                        data: {"keyword": keyword, "currentpage": nextPage},
                        beforeSend: function () {
                            $("#loading").show();
                        },
                        complete: function () {
                            isLoading = false;
                        },
                        success: function (res) {

                            if (res.searchCount == 0) {
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
                                            var date = new Date(ele.hb_writeday);
                                            var formattedDate = date.toLocaleDateString("en-US", {month: '2-digit', day: '2-digit'});
                                            s += `<div class="box">`;
                                            s += `<span class="hb_writeday">\${formattedDate}</span>`;
                                            s += `<span class="hb_readcount"><div class="icon_read"></div>\${ele.hb_readcount}</span>`;
                                            s += `<span class="hb_photo"><a href="hireboarddetail?hb_idx=\${ele.hb_idx}"><img src="http://${imageUrl}/hire/\${ele.hb_photo.split(",")[0]}" id="photo"></a></span>`;
                                            s += `<h3 class="hb_subject"><a href="hireboarddetail?hb_idx=\${ele.hb_idx}"><b>\${ele.hb_subject}</b></a></h3>`;
                                            s += `<div class="hr_tag"><div class="hr_tag_1">이직시200만원</div><div class="hr_tag_2">유연근무</div></div>`;
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

   /* // 프로필 클릭
    function message(nickname) {
        window.open("other_profile?other_nick=" + nickname, 'newwindow', 'width=700,height=700');
    }*/



</script>

<div class="hb_wrap clear">

    <!--===============================Headbox==============================================-->

    <div class="headbox" style="display: unset">
        <h4 class="boardname">
            <div class="yellowbar">&nbsp;</div>&nbsp;&nbsp;채용정보
        </h4><br><br>

        <!-- 검색결과 -->
        <div class="searchres">
            <h5>&nbsp;<b>${keyword}</b>&nbsp;검색결과 : 전체 (${searchCount})</h5>
        </div>
    </div>


    <!--=============================================================================-->
    <div class="listbox">
        <c:forEach var="dto" items="${list}" varStatus="i">
            <div class="box" <c:if test="${i.index % 2 == 1}">style="border-left: 1px solid #eee;padding-right: 0px;padding-left: 20px;"</c:if>>
                <span class="hb_writeday"><fmt:formatDate value="${dto.hb_writeday}" pattern="MM/dd"/></span>
                <span class="hb_readcount"><div class="icon_read"></div> ${dto.hb_readcount}</span>
                <span class="hb_photo">
                <a href="hireboarddetail?hb_idx=${dto.hb_idx}">
                    <img src="http://${imageUrl}/hire/${dto.hb_photo.split(",")[0]}" id="photo">
                </a>
            </span>
                <h3 class="hb_subject">
                    <a href="hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=${currentPage}"><b>${dto.hb_subject}</b></a>
                </h3>
                <div class="hr_tag">
                    <div class="hr_tag_1">이직시200만원</div>
                    <div class="hr_tag_2">유연근무</div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 글쓰기 버튼 -->
    <button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
    <br>
    <c:if test="${sessionScope.cmidx!=null || sessionScope.memstate==100}">
    <button type="button" id="myWriteBtn" onclick="location.href='form'">글쓰기</button>
    </c:if>






