<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

    <style>
        .my_page_myinfo{
            padding: 0 30px;
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

        .my_page_myinfo .information_box ul{
            border-top: 1px solid rgb(34, 34, 34);
            margin-top: 20px;
            padding-top: 20px;
            float: left;
        }

        .my_page_myinfo .information_box ul li{
            font-weight: 700;
            font-size: 17px;
        }

        .my_page_myinfo .information_box ul li p{
            font-size: 13px;
            color: rgb(68, 68, 68);
            margin-top: 8px;
            font-weight: normal;
        }

        .my_page_myinfo #imgbox{
            float: right;

        }

    </style>


    <div class="my_page_myinfo">

        <h1 class="title">나의 정보</h1>

        <div class="information_box clear">
            <ul>
                <li>이메일<p>${dto.m_email}</p></li>
                <li>이름<p>${dto.m_name}</p></li>
                <li>전화번호<p>${dto.m_tele}</p></li>
                <li>소속<p>${dto.ai_name}</p></li>
                <li>별명<p>${dto.m_nickname}</p></li>
            </ul>
            <div id="imgbox"></div>
        </div>



    </div>

    <script>
        let s = '<img src="http://${imageUrl}/member/${dto.m_photo}" style="width: 300px">';
        if(${dto.m_photo != 'no'}) {
            $("#imgbox").html(s);
        }
    </script>


