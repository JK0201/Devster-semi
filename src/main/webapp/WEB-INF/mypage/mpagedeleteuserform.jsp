<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
<h1>
    이메일을 입력하세요.
</h1><br>
<input type="text" id="email_input" placeholder="이메일을 입력하세요.">
<button class="btn btn-outline-danger" onclick="deleteUser()">
    회원 탈퇴하기
</button>
</body>
<script>
    function deleteUser() {
        let email_input = $("#email_input").val();
        if(confirm("정말 회원을 탈퇴하시겠습니까?")){
            $.ajax({
                type : "get",
                url : "deleteuser",
                data : {"email":email_input},
                dataType : "text",
                success : function (res){
                    if(res == "yes") {
                        alert("회원 탈퇴가 완료되었습니다. \n 그동안 저희 서비스를 이용해주셔서 감사합니다 :)")
                        location.href='/member/outtest'
                    } else if(res == "no") {
                        alert("입력하신 이메일이 올바르지않습니다. 다시 입력해주세요.");
                        $("#email_input").val("");
                    } else {
                        alert("에러가 발생했습니다.");
                    }
                }
            })
        }
    }
</script>
</html>