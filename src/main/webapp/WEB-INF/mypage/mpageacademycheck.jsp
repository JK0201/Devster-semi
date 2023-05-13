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
        confirmList();
    })
</script>
<body>
<div id="printBox"></div>
</body>
<script>
    function confirmList() {
        $.ajax({
            type : "post",
            url : "./academycheck",
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
                                <button type="button" class="btn btn-outline-success" onclick="upgradeState(\${dto.m_idx})">승인</button>
                                <button type="button" class="btn btn-outline-danger" onclick="rejectUpgrade(\${dto.m_idx})">반려</button>
                            </div>
                        `;
                    })
                }
                $("#printBox").html(s);
            }
        })
    }

    function upgradeState(m_idx) {
        $.ajax({
            type: "post",
            url : "./upgradestate",
            data : {"m_idx":m_idx},
            success : function (res){
                alert("승인 완료");
                confirmList();
            }
        })
    }

    function rejectUpgrade(m_idx) {
        $.ajax({
            type: "post",
            url : "./rejectupgrade",
            data : {"m_idx":m_idx},
            success : function (res){
                alert("반려 완료.");
                // admin 계정의 이름으로 해당 유저에게 승인이 반려되었다는 쪽지를 발송하는 ajax 처리 필요.

                confirmList();
            }
        })
    }

</script>
</html>
