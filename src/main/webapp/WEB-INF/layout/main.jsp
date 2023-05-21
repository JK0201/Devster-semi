<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="wrap clear">
    <div class="container">
        <div class="searchdiv">
            <input id="searchinput" name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off" value="" class="searchbar">
            <%--<i class="bi bi-search"></i>--%>
            <select id="boardSearchOption" class="form-select">
                <option id="freesearch" value="freeboard">일반게시판</option>
                <option id="qnasearch" value="qboard">질문게시판</option>
                <option id="hiresearch" value="hireboard">채용정보</option>
                <%--<option id="reviewsearch" value="reviewboard">회사후기</option>--%>
            </select>
        </div>
        <script>

            $("#searchinput").keydown(function (e){

                if(e.keyCode==13){ //엔터누르면

                    var keyword = $(this).val(); // 검색내용
                    var boardsearchOption = $("#boardSearchOption").val(); //검색 게시판

                    if(boardsearchOption == "freeboard"){ // 1. 일반게시판 검색

                        location.href="${root}/freeboard/searchlist?keyword="+keyword;
                       // alert("freeboard 검색");

                    }
                    if(boardsearchOption == "qboard"){ // 2. 질문게시판 검색

                        location.href="${root}/qboard/searchlist?keyword="+keyword;
                        //alert("qboard 검색");
                    }
                    if(boardsearchOption == "hireboard"){ // 3. 채용정보게시판 검색

                        location.href="${root}/hire/searchlist?keyword="+keyword;
                       // alert("hireboard 검색");

                    }
                    if(boardsearchOption == "reviewboard"){ // 5. 회사 후기 검색

                        location.href="${root}/review/searchlist?keyword="+keyword;
                        //alert("reviewboard 검색");

                    }

                    if(keyword==''){
                        alert("검색 내용을 입력해주세요.")
                        return false;
                    }

                }

            });

        </script>


        <div class="maincontent clear">

            <!-- ========================= 공지사항 ===========================-->

            <table class="noticeboard_table">

                <caption align="top" class="clear">
                    <h2>
                        <img src="/photo/icon_notice.png">공지사항
                        <span><a href="mypage/list" class="btn-more">더보기<i class="bi bi-chevron-right"></i></a></span>
                    </h2>
                </caption>

                <tbody>
                <c:if test="${NoticeBoardTotalCount == 0}">
                    <h2>등록된 게시글이 없습니다..</h2>
                </c:if>

                <c:if test="${NoticeBoardTotalCount>0}">
                    <c:forEach var="dto" items="${nblist}">
                        <tr>
                            <td class="nb_subject clear">
                                <a href="noticeboard/noticeboarddetail?nb_idx=${dto.nb_idx}&currentPage=${currentPage}"
                                   style="color: #000;"><div class="notice_box">공지</div>
                                        ${dto.nb_subject}
                                    <c:if test="${dto.nb_photo!='n'}">
                                        <div class="icon_img"><img></div>
                                    </c:if>
                                </a>
                            </td>


                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>

            <!-- ========================= 일반게시판 ===========================-->
            <table class="freeboard_table">
                <caption align="top" class="clear">

                    <h2>
                        <img src="/photo/icon_fb.png">일반게시판
                        <span><a href="freeboard/list" class="btn-more">더보기<i
                                class="bi bi-chevron-right"></i></a></span>
                    </h2>

                </caption>


                <tbody>
                <c:if test="${totalCount==0}">
                    <h2>등록된 게시글이 없습니다..</h2>
                </c:if>

                <c:if test="${totalCount>0}">
                    <c:forEach var="dto" items="${fblist}">
                        <tr>
                                <%-- <td>${dto.fb_idx}번</td>

                                 <td>${dto.m_idx}(번호)</td>--%>

                            <td class="fb_subject clear">
                                <a href="freeboard/freeboarddetail?fb_idx=${dto.fb_idx}&currentPage=${currentPage}"
                                   style="color: #000;">
                                        ${dto.fb_subject}
                                    <c:if test="${dto.fb_photo!='n'}">
                                        &nbsp; <%--<i class="bi bi-images"></i>--%>
                                        <div class="icon_img"><img></div>
                                    </c:if>
                                </a>
                            </td>
                            <td class="fb_readcount clear">
                                <div class="icon_read"><img></div>
                                <span>${dto.fb_readcount}</span>
                            </td>

                            <td class="fb_like">
                                <div class="icon_like"><img></div>
                                <span>${dto.fb_like}</span>
                            </td>

                                <%--   <td>${dto.fb_dislike}</td>

                                   <td>
                                       <fmt:formatDate value="${dto.fb_writeday}" pattern="yyyy.MM.dd"/>
                                   </td>--%>
                        </tr>

                    </c:forEach>
                </c:if>
                </tbody>
                <%--<tfoot>
                <tr>
                    <td>총 ${totalCount}개의 게시글
                        <button type="button" onclick="location.href='./freewriteform'">글쓰기</button>
                    </td>
                </tr>
                </tfoot>--%>
            </table>

            <!-- ==================================== 질문게시판 =================================-->

            <table class="qboard_table">

                <caption align="top" class="clear">
                    <h2>
                        <img src="/photo/icon_question.png">질문게시판
                        <span><a href="qboard/list" class="btn-more">더보기<i class="bi bi-chevron-right"></i></a></span>
                    </h2>
                </caption>

                <tbody>
                <c:if test="${qboardTotalCount == 0}">
                    <h2>등록된 게시글이 없습니다..</h2>
                </c:if>

                <c:if test="${qboardTotalCount>0}">
                    <c:forEach var="dto" items="${qblist}">
                        <tr>
                            <td class="qb_subject clear">
                                <a href="qboard/detail?qb_idx=${dto.qb_idx}&currentPage=${currentPage}"
                                   style="color: #000;">
                                        ${dto.qb_subject}
                                    <c:if test="${dto.qb_photo!='n'}">
                                        &nbsp; <%--<i class="bi bi-images"></i>--%>
                                        <div class="icon_img"><img></div>
                                    </c:if>
                                </a>
                            </td>

                            <td class="qb_readcount clear">
                                <div class="icon_read"><img></div>
                                <span>${dto.qb_readcount}</span>
                            </td>

                            <td class="qb_like">
                                <div class="icon_like"><img></div>
                                <span>${dto.qb_like}</span>
                            </td>


                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>

            <!-- ========================= 채용정보 게시판 ===========================-->

            <table class="hireboard_table">
                <caption align="top" class="clear">

                    <h2>
                        <img src="/photo/icon_job.png">채용정보
                        <span><a href="hire/list" class="btn-more">더보기<i class="bi bi-chevron-right"></i></a></span>
                    </h2>

                </caption>


                <tbody>
                <c:if test="${hireboardtotalCount==0}">
                    <h2>등록된 게시글이 없습니다..</h2>
                </c:if>

                <c:if test="${hireboardtotalCount>0}">
                    <c:forEach var="dto" items="${hirelist}">
                        <tr>
                            <td class="hb_subject clear">
                                <a href="hire/hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=${currentPage}"
                                   style="color: #000;">
                                        ${dto.hb_subject}</a>
                                    <c:if test="${dto.hb_photo!='n'}">
                                        &nbsp; <%--<i class="bi bi-images"></i>--%>
                                        <div class="icon_img"><img></div>
                                    </c:if>

                            </td>

                            <td class="hb_readcount clear">
                                <div class="icon_read"><img></div>
                                <span>${dto.hb_readcount}</span>
                            </td>
                        </tr>

                    </c:forEach>
                </c:if>
                </tbody>
            </table>

            <!-- ========================= 학원별 게시판 ===========================-->

            <table class="academyboard_table">
                <caption align="top" class="clear">

                    <h2>
                        <img src="/photo/icon_job.png">학원별 게시판
                        <span><a href="academyboard/list" class="btn-more">더보기<i class="bi bi-chevron-right"></i></a></span>
                    </h2>

                </caption>


                <tbody>
                    <c:if test="${sessionScope.acaidx==null}">
                        <tr>
                            <td align="center">로그인 후 이용 가능합니다</td>
                        </tr>
                    </c:if>
                    <c:if test="${sessionScope.acaidx!=null}">
                        <c:if test="${academyboardTotalCount==0}">
                            <tr><td>등록된 게시글이 없습니다..</td></tr>
                        </c:if>

                        <c:if test="${academyboardTotalCount>0}">
                            <c:forEach var="dto" items="${ablist}">
                                <tr>
                                    <td class="ab_subject clear">
                                        <a href="academyboard/academyboarddetail?ab_idx=${dto.ab_idx}&currentPage=${currentPage}"
                                           style="color: #000;">
                                                ${dto.ab_subject}</a>
                                        <c:if test="${dto.ab_photo!='n'}">
                                            &nbsp; <%--<i class="bi bi-images"></i>--%>
                                            <div class="icon_img"><img></div>
                                        </c:if>

                                    </td>

                                    <td class="ab_readcount clear">
                                        <div class="icon_read"><img></div>
                                        <span>${dto.ab_readcount}</span>
                                    </td>
                                </tr>

                            </c:forEach>

                        </c:if>

                    </c:if>

                </tbody>
            </table>



        </div>
    </div>
    <!--=========================================aside=====================================-->
    <div class="aside">
        <div class="aside_content_1">
            <img src="photo/aside_banner_1.png">
        </div>
        <div class="aside_content_2">
            <%--quickmenu--%>
            <div class="quickmenu">
                <ul>
                    <li class="quickmenu_head"><h2>실시간 인기글</h2></li>
                </ul>
            </div>
        </div>

    </div>

</div>

<script>
    // 비로그인 상태 (sessionScope.logstat != yes) 디테일 못들어가게/ 검색 안되게
    if(${sessionScope.logstat!='yes'}){

        $(".freeboard_table a").click(function (){
            alert("로그인 후 이용가능한 기능입니다.");
            location.href='../member/signin';
            return false;
        });
        $(".qboard_table a").click(function (){
            alert("로그인 후 이용가능한 기능입니다.");
            location.href='../member/signin';
            return false;
        });
        $(".hireboard_table a").click(function (){
            alert("로그인 후 이용가능한 기능입니다.");
            location.href='../member/signin';
            return false;
        });
        $(".noticeboard_table a").click(function (){
            alert("로그인 후 이용가능한 기능입니다.");
            location.href='../member/signin';
            return false;
        });

        $(".academyboard_table a").click(function (){
            alert("로그인 후 이용가능한 기능입니다.");
            location.href='../member/signin';
            return false;
        });

        $("#searchinput").click(function (){
            alert("로그인 후 이용가능한 기능입니다.");
            location.href='../member/signin';
            return false;
        });

    }

    // 인증 안된 회원 (sessionScope.memstate == 0)
    if(${sessionScope.memstate==0}){

        $(".qboard_table a").click(function (){
            alert("인증 후 이용가능한 기능입니다.");
            history.back();
            return false;
        });
        $(".hireboard_table a").click(function (){
            alert("인증 후 이용가능한 기능입니다.");
            history.back();
            return false;
        });

        $("#searchinput").click(function (){
            alert("인증 후 이용가능한 기능입니다.");
            history.back();
            return false;
        });


    }

    $(document).on("click",".bestposts",function () {
        if(${sessionScope.logstat!='yes'}) {
            alert("로그인 후 이용가능한 기능입니다.");
            location.href='../member/signin';
            return false;
        }
    })

    //실시간 인기 글 ajax
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
                        <a href="../freeboard/freeboarddetail?fb_idx=\${item.fb_idx}&currentPage=1" class="bestposts" >
                            <div class="name">
                                <div class="num"><span style="color: #94969b">\${index+1}</span> \${item.fb_subject}</div>
                            </div>
                        </a>
                    </li>
                    `
            });
           /* s +=
                `
                <button type="button" onclick="window.scrollTo({top:0});">
                    <i class="bi bi-arrow-up-square-fill"></i>
                </button>
                `;*/

                $(".quickmenu ul").append(s);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log("Error: " + textStatus + " - " + errorThrown);
        }
    });


   /* // When the user scrolls down 20px from the top of the document, show the button
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
    }*/

    function checkLogin() {
        if(${sessionScope.logstat!='yes'}) {

        }
    }


</script>



