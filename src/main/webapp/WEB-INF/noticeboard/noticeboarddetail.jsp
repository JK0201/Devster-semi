<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<style>
    .nb_detail_wrap{
        width: 1140px;
        /*background: palevioletred;*/
        margin: 0 auto;
    }
    .nb_detail_wrap .nb_detail_content{
        width: 736px;
        /*background: palegreen;*/
        padding-top: 40px;
        float: left;
    }

    .nb_detail_wrap .nb_detail_content .wrap_info{
        margin-top: 10px;
        /*height: 30px;*/
    }

    .nb_detail_wrap .nb_detail_content .article_view_head{
        border-bottom: 1px solid #eee;
        padding-bottom: 29px;
    }

    .nb_detail_wrap .nb_detail_content .article_view_head img{
        width: 23px;
        height: 23px;
        border-radius: 100px;
    }


    .nb_detail_wrap .nb_detail_content .article_view_head .nboard_link:before {
        background: url(https://static.teamblind.com/img/www_kr/sp-kr.png) no-repeat;
        background-size: 600px 900px;
        background-position: -10px -626px;
        display: inline-block;
        width: 16px;
        height: 16px;
        margin: -2px 4px 0;
        vertical-align: middle;
        content: '';
    }


    .nb_detail_wrap .nb_detail_content .article_view_head a{
        margin-left: 2px;
    }

    .nb_detail_wrap .nb_detail_content .article_view_head h2{
        font-size: 24px;
        margin-top: 18px;
        font-weight: bold;
    }

    .nb_detail_wrap .nb_detail_content .article_view_head a{
        color: #222;
        font-size: 14px;
        font-weight: bold;
    }

    .nb_detail_wrap .nb_detail_content .article_view_head .wrap_info span{
        /*float: left;*/
        color: #94969b;
        /*margin-left: 14px;*/
    }

    
    .nb_detail_wrap .nb_detail_content .article_view_head .wrap_info span .icon_read{
        display: inline-block;
        background: url(https://d2u3dcdbebyaiu.cloudfront.net/img/www_kr/sp-kr.png?time=dec2022) no-repeat;
        background-size: 590px 907px;
        background-position: -10px -595px;
        /*content: '';*/
        width: 16px;
        height: 23px;
        /* float: left;*/
        margin-left: 10px;
    }

    .nb_detail_wrap .nb_detail_content .article_view_content{
        padding-top: 32px;
        /*border: 1px solid black;*/
    }
    .nb_detail_wrap .nb_detail_content .article_view_content .nb_detail_img{
        margin-top: 46px;
    }
    .nb_detail_wrap .nb_detail_content .article_view_content .nb_detail_img img{
        width: 600px;
        margin-top: 3px;
    }

    .nb_detail_wrap .nb_detail_content .article_view_content .content_txt{
        line-height: 1.75em;
        font-size: 16px;
    }

    .nb_detail_wrap .nb_detail_content .article_view_content .util_btns{
        /*margin-top: 40px;*/
        float: right;

    }

    .nb_detail_wrap .nb_detail_content .article_view_content .util_btns button{
        background: #4c7bc9;
        color: #fff;
        text-align: center;
        margin-right: 6px;
        width: 90px;
        margin-top: 30px;
    }

</style>


<div class="nb_detail_wrap clear">
    <div class="nb_detail_content">
        <div class="article_view_head">
            <a href="/">홈</a>
            <a href="./list?currentPage=${currentPage}" class="nboard_link">공지사항</a>
            <h2>${dto.nb_subject}</h2>

            <div class="wrap_info clear">
                <div class="icon_time"></div>
                <span class="nb_writeday"><fmt:formatDate value="${dto.nb_writeday}" pattern="yyyy.MM.dd"/></span>


                <span>
                    <div class="icon_read"></div>${dto.nb_readcount}
                </span>

            </div>

        </div>

        <div class="article_view_content">
                <div class="content_txt">
                    <pre>${dto.nb_content}</pre>
                </div>
                <c:choose>
                    <c:when test="${list[0] == 'n' || list[0] == 'no'}">
                        <!-- 이미지가 없을 때는 아무것도 출력하지 않음 -->
                    </c:when>
                    <c:otherwise>
                        <div class="nb_detail_img">
                            <c:forEach items="${list}" var="images">
                                <c:if test="${images!='n'}">
                                    <img src="http://${imageUrl}/noticeboard/${images}" style="float: left">
                                </c:if>
                            </c:forEach>

                        </div>
                    </c:otherwise>
                </c:choose>


            <div class="clear" style="margin-top: 40px;border-bottom: 1px solid #eee; padding-bottom: 40px;">
                <div class="util_btns">
                    <c:if test="${sessionScope.memstate == 100}">
                        <button class="btn btn-outline-dark" type="button" onclick="location.href='../noticeboard/noticeupdateform?nb_idx=${dto.nb_idx}&currentPage=${currentPage}'">수정</button>
                        <button class="btn btn-outline-dark" type="button"
                                onclick="del(${dto.nb_idx})">삭제</button>
                    </c:if>
                </div>
            </div>
        </div>


    </div>

</div>



<script>
    function del(nb_idx) {
        if (confirm("삭제하시겠습니까?")) {
            location.href = "../noticeboard/noticedelete?nb_idx=" + nb_idx;
        }
    }

</script>