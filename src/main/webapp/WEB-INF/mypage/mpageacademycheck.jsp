<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <style>
    </style>
</head>
<script>
    $(document).ready(function (){
        if(${iscomp==1}) {
            compConfirmList();
        } else {
            normalConfirmList();
        }
    })
</script>
<body>
<div id="printBox"></div>
</body>


<script>
    function normalConfirmList() {
        $.ajax({
            type : "post",
            url : "./normalacademycheck",
            dataType : "json",
            success : function (res) {
                let s = "";
                if(res.length == 0) {
                    s+= "<h1 style='width: 800px; margin-left: 400px;'>회원가입 승인을 요청한 회원이 없습니다.</h1>";
                } else {
                    $.each(res,function (idx,dto) {
                        s+=
                            `
                            <div style="border: 3px solid black; width: 800px; margin-left: 400px; text-align: center">
                                <img src="http://${imageUrl}/member_academy/\${dto.m_filename}" style="width: 600px; border: 3px solid black">
                                <h3>학원명 : \${dto.ai_name}</h3>
                                <h3>이름 : \${dto.m_name}</h3>
                                <button type="button" class="btn btn-outline-success" onclick="normalUpgradeState(\${dto.m_idx})">승인</button>
                                <button type="button" class="btn btn-outline-danger" onclick="normalRejectUpgrade(\${dto.m_idx})">반려</button>
                            </div>
                        `;
                    })
                }
                $("#printBox").html(s);
            }
        })
    }

    function normalUpgradeState(m_idx) {
        $.ajax({
            type: "post",
            url : "./normalupgradestate",
            data : {"m_idx":m_idx},
            success : function (res){
                alert("승인 완료");
                normalConfirmList()
            }
        })
    }

    function normalRejectUpgrade(m_idx) {
        $.ajax({
            type: "post",
            url : "./normalrejectupgrade",
            data : {"m_idx":m_idx},
            success : function (res){
                alert("반려 완료.");
                // admin 계정의 이름으로 해당 유저에게 승인이 반려되었다는 쪽지를 발송하는 ajax 처리 필요.
                alert("반려 메세지 발송완료.")
                normalConfirmList()
            }
        })
    }

    function compConfirmList() {
        $.ajax({
            type : "post",
            url : "./companycheck",
            dataType : "json",
            success : function (res) {
                let s = "";
                if(res.length == 0) {
                    s+= "<h1 style='width: 800px; margin-left: 400px;'>회원가입 승인을 요청한 기업 회원이 없습니다.</h1>";
                } else {
                    $.each(res,function (idx,dto) {
                        s+=
                            `
                            <div style="border: 3px solid black; width: 800px; margin-left: 400px; text-align: center">
                                <img src="http://${imageUrl}/company_member/\${dto.cm_filename}" style="width: 600px; border: 3px solid black">
                                <h3>기업명 : \${dto.cm_compname}</h3>
                                <h3>기업 주소 : \${dto.cm_addr}</h3>
                                <h3>기업 연락처 : \${dto.cm_tele}</h3>
                                <h3>담당자 이름 : \${dto.cm_name}</h3>
                                <h3>담당자 연락처 : \${dto.cm_cp}</h3>
                                <button type="button" class="btn btn-outline-success" onclick="compUpgradeState(\${dto.cm_idx})">승인</button>
                                <button type="button" class="btn btn-outline-danger" onclick="compRejectUpgrade(\${dto.cm_idx})">반려</button>
                            </div>
                        `;
                    })
                }
                $("#printBox").html(s);
            }
        })
    }

    function compUpgradeState(cm_idx) {
        $.ajax({
            type: "post",
            url : "./companyupgradestate",
            data : {"cm_idx":cm_idx},
            success : function (res){
                alert("승인 완료");
                compConfirmList();
            }
        })
    }

    function compRejectUpgrade(cm_idx) {
        $.ajax({
            type: "post",
            url : "./companyrejectupgrade",
            data : {"cm_idx":cm_idx},
            success : function (res){
                alert("반려 완료.");
                // admin 계정의 이름으로 해당 유저에게 승인이 반려되었다는 쪽지를 발송하는 ajax 처리 필요.

                compConfirmList();
            }
        })
    }

</script>
</html>
