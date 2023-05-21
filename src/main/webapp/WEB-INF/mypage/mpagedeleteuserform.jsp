<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<style>
    .user_taltoe{
        padding: 0 30px;
    }

    .user_taltoe .title{
        font-weight: 700;
        font-size: 30px;
        color: #222;
    }

    .user_taltoe .wrapped{
        border-top: 1px solid rgb(34, 34, 34);
        margin-top: 20px;
        padding-top: 40px;
        /*padding: 40px 60px;*/
        padding-left: 40px;
    }

    .user_taltoe .wrapped h3{
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 20px;
    }

    .user_taltoe .wrapped h5{
        font-size: 17px;
        font-weight: bold;
    }

    .user_taltoe .wrapped p{
        font-size: 15px;
    }

    .user_taltoe .wrapped #email_input{
        width: 400px;
        padding: 12px 16px;
        border-radius: 4px;
        box-sizing: border-box;
        border: 1px solid rgb(212, 212, 212);
    }

    .user_taltoe .wrapped button{
        height: 48px;
        margin-left: 3px;
    }
</style>

<div class="user_taltoe">

    <h1 class="title">계정 탈퇴</h1>

    <div class="wrapped">

        <div style="margin-bottom: 32px;">
            <h3>회원 탈퇴 전,안내 사항을 꼭 확인해주세요.</h3>

            <h5>1) 탈퇴 아이디 복구 불가</h5>
            <p>탈퇴 후에는 아이디와 데이터 복구가 불가능합니다.<br>
                신중하게 선택해주세요.</p>

            <h5>2) 서비스 이용 기록 삭제</h5>
            <p>서비스 이용 기록이 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.<br>
                필요한 데이터는 미리 백업을 해두시기 바랍니다.</p>

        </div>

        <div style="border-top:1px solid rgb(228, 228, 228); padding-top: 30px;">
            <input type="text" id="email_input" placeholder="이메일을 입력하세요.">

            <button class="btn btn-outline-secondary" onclick="deleteUser()">탈퇴하기</button>
        </div>

    </div>

</div>



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
