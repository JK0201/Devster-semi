<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

    <style>
        .my_page_myinfo{
            padding: 0 30px;
            height: 500px;
        }

        .my_page_myinfo .title{
            font-weight: 700;
            font-size: 30px;
            color: #222;
        }

        .my_page_myinfo .information_box{
            /*background-color: rgb(251, 251, 253);*/
            margin-top: 24px;

        }

        .my_page_myinfo .information_box ul.first_ul{
            border-top: 1px solid rgb(34, 34, 34);
            margin-top: 20px;
            padding-top: 40px;
            /*padding: 40px 60px;*/
            padding-left: 40px;
            /*float: left;*/
            position: relative;
        }

        .my_page_myinfo .information_box ul.second_ul{
            padding-left: 40px;
        }


        .my_page_myinfo .information_box ul{
            border-top: 0px;
        }

        .my_page_myinfo .information_box ul li{
            font-weight: 700;
            font-size: 17px;
            float: left;
            margin-left: 20px;
            width: 200px;
        }
        .my_page_myinfo .information_box ul li:first-child{
            margin-left: 0px;
        }

        .my_page_myinfo .information_box ul li p{
            font-size: 13px;
            color: rgb(68, 68, 68);
            margin-top: 8px;
            font-weight: normal;
            margin-bottom: 24px;
        }

        .my_page_myinfo .information_box h6{
            font-weight: 700;
            font-size: 17px;
            margin-left: 20px;
            width: 200px;
            margin-left: 40px;
            margin-top: 24px;
        }

        .my_page_myinfo .information_box img{
            margin-top: 10px;
            /*margin-left: 6px;*/
        }

        .first_ul li:nth-child(3){

        }
        .second_ul li:nth-child(3){
            margin-left: 30px;
        }


    </style>


    <div class="my_page_myinfo">

        <h1 class="title">나의 정보</h1>

        <div class="information_box clear">
            <ul class="first_ul clear">
                <li>이름<p>${dto.m_name}</p></li>
                <li>이메일<p>${dto.m_email}</p></li>
                <li style="margin-left: 90px;">전화번호<p>${dto.m_tele}</p></li>

            </ul>
            <ul class="second_ul clear">
                <li>소속<p>${dto.ai_name}</p></li>
                <li>별명<p>${dto.m_nickname}</p></li>
                <li style="margin-left: 90px;">프로필 사진<div id="imgbox"></div></li>
            </ul>
            <%--<h6>프로필 사진</h6><div id="imgbox"></div>--%>

        </div>



    </div>

    <script>
        let s = '<img src="http://${imageUrl}/member/${dto.m_photo}" style="width: 80px">';
        if(${dto.m_photo != 'no'}) {
            $("#imgbox").html(s);
        }

        window.onload = function() {
            var listItems = document.querySelectorAll("ul li");

            for (var i = 0; i < listItems.length; i++) {
                if ((i + 1) % 3 === 0) {
                    listItems[i].innerHTML += '<br>';
                }
            }
        }
    </script>


