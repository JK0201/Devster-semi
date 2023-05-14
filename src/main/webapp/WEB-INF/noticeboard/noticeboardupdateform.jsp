<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<div>

    <img id="showimg" src="http://${imageUrl}/noticeboard/${dto.nb_photo}">

    <form action="noticeupdate" method="post" enctype="multipart/form-data">

        <!--hidden-->
        <input type="hidden" name="nb_idx" value="${dto.nb_idx}">
        <input type="hidden" name="m_state" value="${sessionScope.state}">
        <input type="hidden" name="currentPage" value="${currentPage}">

        <div>
            제목 : <input type="text" name="nb_subject" value="${dto.nb_subject}"><br>
            사진 : <input type="file" name="upload" id="myfile" multiple><br><br>
            내용 : <textarea name="nb_content" >${dto.nb_content}</textarea><br><br>

            <button type="submit">게시글수정</button>
            <button type="button" onclick="history.back()">뒤로가기</button>
        </div>

    </form>
</div>

<!-- 미리보기 -->
<script type="text/javascript">
    $("#myfile").change(function() {
        console.log("1:" + $(this)[0].files.length);
        console.log("2:" + $(this)[0].files[0]);
        //정규표현식
        var reg = /(.*?)\/(jpg|jpeg|png|bmp)$/;
        var f = $(this)[0].files[0];//현재 선택한 파일
        if (!f.type.match(reg)) {
            alert("확장자가 이미지파일이 아닙니다");
            return;
        }
        if ($(this)[0].files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $("#showimg").attr("src", e.target.result);
            }
            reader.readAsDataURL($(this)[0].files[0]);
        }
    });
</script>