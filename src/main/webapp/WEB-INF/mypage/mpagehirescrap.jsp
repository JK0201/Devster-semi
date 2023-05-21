<%--
  Created by IntelliJ IDEA.
  User: hyunohsmacbook
  Date: 2023/05/02
  Time: 10:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<style>
    .hb_bookmark_list{
        padding: 0 30px;
    }

    .hb_bookmark_list .title{
        font-weight: 700;
        font-size: 30px;
        color: #222;
    }

    .hb_bookmark_list .hb_bookmark_list_wrap{
        width: 820px;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        justify-items: center;
        border-top: 1px solid #000;
        margin-top: 20px;
        padding-top: 40px;
                grid-row-gap: 36px;
    }

    .hb_bookmark_list .hb_bookmark_list_wrap .box{
        width: 200px;
    }

    .hb_bookmark_list .hb_bookmark_list_wrap .box div.hb_photo{
        border: 1px solid rgba(0, 0, 0, 0.1);
        width: 200px;
        display: inline-block;
        overflow: hidden;
        position: relative;
    }

    .hb_bookmark_list .hb_bookmark_list_wrap .box img{

        /*width: 200px;*/
        transition: all 0.3s ease;
        width: 180px;
        margin: 0 auto;
        margin-left: 10px;
    }


    .hb_bookmark_list .hb_bookmark_list_wrap .box img:hover {
       /* transform: scale(1.1);
        opacity: 0.7;
        background-color: #000;*/
        width: 100%;
        transition: all 0.3s ease;
    }

    .darken-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0);
        transition: background-color 0.3s ease;
    }

    .hb_bookmark_list .hb_bookmark_list_wrap .box div.hb_photo:hover .darken-overlay {
        background-color: rgba(0, 0, 0, 0.1);
    }

    .hb_bookmark_list .hb_bookmark_list_wrap .box div.hb_photo:hover #photo {
        transform: scale(1.1);
    }

    .hb_bookmark_list .hb_bookmark_list_wrap .hb_subject{
        margin-top: 6px;
        font-size: 14px;
        /*overflow: hidden;
        text-overflow: ellipsis;*/
        width: 200px;
    }

    .hb_bookmark_list .hb_bookmark_list_wrap .hr_tag_1{
        font-size: 12px;
        border: 1px solid rgb(19, 191, 159);
        display: inline-block;
        padding: 1px 8px 0px 7px;
        margin-left: -2px;
        color: rgb(19, 191, 159);
    }
    .hb_bookmark_list .hb_bookmark_list_wrap .hr_tag_2{
        font-size: 12px;
        border: 1px solid rgb(119, 101, 255);
        display: inline-block;
        padding: 1px 8px 0px 7px;
        color: rgb(119, 101, 255);
    }

    /*.hb_bookmark_list .hb_bookmark_list_wrap .hb_photo #photo{

    }*/



</style>

<div class="hb_bookmark_list clear">

    <h1 class="title">채용정보 북마크</h1>
    <div class="hb_bookmark_list_wrap">
        <c:forEach var="dto" items="${list}" varStatus="i">

                <div class="box">

                    <%--<span class="hb_writeday"><fmt:formatDate value="${dto.fb_writeday}" pattern="MM/dd"/></span>
                    <span class="hb_readcount"><div class="icon_read"></div> ${dto.hb_readcount}</span>--%>

                    <div class="hb_photo">
                        <a href="../hire/hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=1">
                            <img src="http://${imageUrl}/hire/${dto.hb_photo}" id="photo" width="200px">
                            <div class="darken-overlay"></div>
                        </a>
                    </div>

                    <h3 class="hb_subject">
                        <a href="../hire/hireboarddetail?hb_idx=${dto.hb_idx}&currentPage=1"><b>${dto.hb_subject}</b></a>
                    </h3>

                    <%--<p class="hb_writeday" style="font-size: 12px; color: #999; margin: 0px;"><fmt:formatDate value="${dto.fb_writeday}" pattern="MM/dd"/></p>--%>


                    <div class="hr_tag">
                        <div class="hr_tag_1">이직시200만원</div>
                        <div class="hr_tag_2">유연근무</div>
                    </div>
                </div>

        </c:forEach>
    </div>

</div>






