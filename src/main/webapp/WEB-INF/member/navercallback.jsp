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
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
            charset="utf-8"></script>
    <style>
    </style>
</head>
<body>
<script type="text/javascript">
    var naver_id_login = new naver_id_login("Qr3pEkAiiIBJ_L9HaGiY", "http://localhost:9000/member/navercallback");
    // 접근 토큰 값 출력
    console.log(naver_id_login.oauthParams.access_token);
    // 네이버 사용자 프로필 조회
    naver_id_login.get_naver_userprofile("naverSignInCallback()");

    // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
    function naverSignInCallback() {
        console.log(naver_id_login.getProfileData("email"));
        console.log(naver_id_login.getProfileData("profile_image"));
        console.log(naver_id_login);

        let m_email = naver_id_login.getProfileData("email");
        let m_photo = naver_id_login.getProfileData("profile_image");

        alert(m_email);
        $.ajax({
            type: "get",
            url: "emailchk",
            dataType: "json",
            data: {"m_email": m_email},
            success: function (res) {
                if (res.result == "no") {
                    alert("ㅎㅇ 출석포인트 +10점");
                    window.close();
                    window.opener.redirectToMainPage();
                } else {
                    alert("계정 없음");
                    window.close();
                    window.opener.redirectToSignUp();
                }
            }
        });
    }

    function redirectToMain() {
        window.location.href = "../";
    }
</script>
</body>
</html>

