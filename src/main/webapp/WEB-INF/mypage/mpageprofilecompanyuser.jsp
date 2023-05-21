<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>
<style>
    .my_page_companyUser_info{
        padding: 0 30px;
        height: 450px;
    }

    .my_page_companyUser_info .title{
        font-weight: 700;
        font-size: 30px;
        color: #222;
    }

    .my_page_companyUser_info .information_box{
        border-top: 1px solid rgb(34, 34, 34);
        margin-top: 20px;
        padding-top: 40px;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        justify-items: center;
        grid-row-gap: 36px;
    }

    .my_page_companyUser_info .information_box div{
        font-weight: 700;
        font-size: 17px;
        /*float: left;*/
        margin-left: 20px;
        width: 200px;
    }

    .my_page_companyUser_info .information_box p{
        font-size: 13px;
        color: rgb(68, 68, 68);
        margin-top: 8px;
        font-weight: normal;
        margin-bottom: 24px;
        /*width: 300px;*/
    }

</style>


<div class="my_page_companyUser_info" style="">

    <h1 class="title">회사 정보</h1>

    <div class="information_box clear">


        <div>이메일<p>${dto.cm_email}</p></div>
        <div>회사 이름<p>${dto.cm_compname}</p></div>
        <div>회사 전화번호<p>${dto.cm_tele}</p></div>
        <div>회사 주소<p>${dto.cm_addr}</p></div>
        <div>회사 우편번호<p>${dto.cm_post}</p></div>
        <div>담당자 이름<p>${dto.cm_name}</p></div>
        <div>담당자 번호<p>${dto.cm_cp}</p></div>


    </div>

</div>

