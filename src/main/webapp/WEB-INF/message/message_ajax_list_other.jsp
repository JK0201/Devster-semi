<%--
  Created by IntelliJ IDEA.
  User: JuminManeul
  Date: 2023-05-11
  Time: 오후 12:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<link href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Single+Day&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<style>

    .col-1{
        margin-top: 10px;
    }

    .col-10 p{
        color: #aaaaaa;
        margin-left: 3px;
    }

    .col-11{
        height: 150px;
    }

    .chat_list_box .chat_list .chat_people .chat_img img{
        width: 50px;
        height: 50px;
        border: 0px;
        border-radius: 50%;
        object-fit: cover;
    }
    .badge{
        /*margin-left: 15px;*/

    }

    .msg-container{
        /*max-width: 1140px;*/
        margin: 0 auto;
    }

    .inbox_people{
        background: #f8f8f8 none repeat scroll 0 0;
        float: left;
        overflow: hidden;
        width: 40%;
        border-right: 1px solid #f7f7f7;
    }
    .inbox_msg{
        border: 1px solid #f7f7f7;
        border-radius: 15px;
        clear: both;
        overflow: hidden;
    }
    .top_spac{
        margin: 20px 0 0;
    }

    .recent_heading{
        float: left;
        width: 40%;
    }
    .srch_bar{
        display: inline-block;
        text-align: right;
        width: 60%;
        /*padding: ;*/
    }
    .headind_srch{
        padding: 10px 29px 10px 20px;
        overflow: hidden;
        border-bottom: 1px solid #f7f7f7;
    }
    .recent_heading h4{
        color: #5fcf80;
        font-size: 30px;
        margin: 0 auto;
    }
    .srch_bar input{
        border: 1px solid #cdcdcd;
        border-width: 0 0 1px 0;
        width: 80%;
        padding: 2px 0 4px 6px;
        background: none;
        font-size: 25px;
    }
    .srch_bar .input-group-addon button{
        background:  rgba(0,0,0,0) none repeat scroll 0 0;
        border: medium none;
        padding: 0;
        color: #707070;
        font-size: 18px;
    }
    .srch_bar .input-group-addon{
        margin: 0 0 0 -27px;
    }

    .chat_ib h5{
        font-size: 20px;
        color: #464646;
        margin: 0 0 8px 0;
        float: left;
    }
    .chat_ib h5 span{
        font-size: 17px;
        float: right;
    }
    .chat_ib p{
        font-size: 14px;
        color: #989898;
        margin: auto;
    }
    .chat_img{
        float: left;
        /*width: 11%*/;
    }
    .chat_ib{
        float: left;
        /*padding: 0 0 0 15px;
        width: 88%;*/
        margin-left: 15px;
        width: 80%;
    }

    .chat_date{
        /*margin-left: 10px;*/
        float: right;
    }

    .chat_people{
        /*overflow: hidden;*/
        /*clear: both;*/
    }
    .chat_list{
        border-bottom: 1px solid #f7f7f7;
        margin: 0 auto;
        padding: 18px 16px 10px;
    }

   /* .chat_list_box :hover{
        background-color: #d6ead0;
    }*/

    .inbox_chat{
        height: 550px;
        overflow-y: scroll;
    }
    .active_chat{
        background: #ebebeb;
    }
    .incoming_msg_img{
        display: inline-block;
        width: 6%;
    }
    .received_msg{
        display: inline-block;
        padding: 0 0 0 10px;
        vertical-align: top;
        width: 92%;
    }
    .received_withd_msg p{
        background: #f4f4f4 none repeat scroll 0 0;
        border-radius: 7px;
        color: #646464;
        font-size: 14px;
        margin: 0;
        padding: 10px 10px 10px 12px;
        width: 100%;
    }
    .time_date{
        color: #747474;
        display: block;
        font-size: 12px;
        margin: 5px 0 8px;
    }
    .received_withd_msg{
        width: 57%;
    }
    .mesgs{
        float: left;
        padding: 30px 15px 0 25px;
        width: 100%;
    }
    .sent_msg p {
        background: #97df93 none repeat scroll 0 0;
        border-radius: 7px;
        font-size: 14px;
        margin: 0;
        color: #fff;
        padding: 10px 10px 10px 12px;
        width: 100%;
    }
    .outgoing_msg{
        overflow: hidden;
        /*margin: 26px 0 26px;*/
    }
    .sent_msg{
        float: right;
        width: 46%;
    }
    .input_msg_write input{
        background: rgba(0,0,0,0) none repeat scroll 0 0;
        border: medium none;
        color: #4c4c4c;
        font-size: 15px;
        min-height: 48px;
        width: 100%;
    }

    .type_msg{
        border-top: 1px solid #dfdfdf;
        position: relative;
    }
    .msg_send_btn{
        background: #97df93 none repeat scroll 0 0;
        border: medium none;
        border-radius: 50%;
        color: #fff;
        cursor: pointer;
        font-size: 17px;
        height: 33px;
        position: absolute;
        right: 0;
        top: 11px;
        width: 33px;

    }

    .msg_send_btn:hover{
        background: #5fcd58 none repeat scroll 0 0;
    }
    .messaging{
        padding: 0 0 50px 0;
    }
    .msg_history{
        height: 516px;
        overflow-y: auto;
    }
</style>
</head>
<body>


<h1>프로필 사진에서 쪽지창 열기</h1>
<%--<c:forEach var="tmp" items="${list}">
</c:forEach>--%>


<div class="msg-container">
    <div class="messaging">
        <div class="inbox_msg">


            <!-- 메세지 내용 영역 -->
            <div class="mesgs">
                <!--메세지 내용 목록 -->
                <div class="msg_history" name="contentList">
                    <!-- 메세지 내용이 올 자리 -->

                    <c:forEach var="tmp" items="${list}">
                        <c:if test="${sessionScope.memnick == null && sessionScope.cmname != null}">
                            <c:choose>
                                <c:when test="${sessionScope.cmname ne tmp.send_nick}">
                                    <!--받은 메세지 -->
                                    <div class="incoming_msg">

                                        <div class="incoming_msg_img">
                                                <img src="http://${imageUrl}/member/${tmp.profile}" width="50px">
                                        </div>

                                        <div class="received_msg">
                                            <div class="received_withd_msg">
                                                <span>${tmp.send_nick}</span>
                                                <pre>${tmp.content}</pre>
                                                <span class="time_date">${tmp.send_time}</span>
                                            </div>
                                        </div>

                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <%--<img src="http://${imageUrl}/member/${tmp.m_photo}" width="50px">--%>
                                    <!-- 보낸 메세지 -->
                                    <div class="outgoing_msg">
                                        <div class="sent_msg">
                                            <span>${tmp.send_nick}</span>
                                            <pre>${tmp.content}</pre>
                                            <span class="time_date">${tmp.send_time}</span>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        <c:if test="${sessionScope.memnick != null && sessionScope.cmname == null}">
                            <c:choose>
                                <c:when test="${sessionScope.memnick ne tmp.send_nick}">
                                    <!--받은 메세지 -->
                                    <div class="incoming_msg">
                                        <div class="incoming_msg_img">
                                                <img src="http://${imageUrl}/member/${tmp.profile}" width="50px">
                                        </div>
                                        <div class="received_msg">
                                            <div class="received_withd_msg">
                                                <span>${tmp.send_nick}</span>
                                                <pre>${tmp.content}</pre>
                                                <span class="time_date">${tmp.send_time}</span>
                                            </div>
                                        </div>

                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <%--<img src="http://${imageUrl}/member/${tmp.m_photo}" width="50px">--%>
                                    <!-- 보낸 메세지 -->
                                    <div class="outgoing_msg">
                                        <div class="sent_msg">
                                            <span>${tmp.send_nick}</span>
                                            <pre>${tmp.content}</pre>
                                            <span class="time_date">${tmp.send_time}</span>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:if>

                    </c:forEach>

                </div>
                <div class="send_message">

                    <div class='type_msg'>
                        <div class='input_msg_write row'>
                            <div class="col-11">
                                <textarea class="write_msg form-control" placeholder="메세지를 입력..."></textarea>
                            </div>
                            <div class='col-1'>
                               <button class='msg_send_btn_other' type='button'><i class='bi bi-send-fill'></i></button>
                           </div>
                        </div>
                    </div>


                </div>
                <!--메세지 입력란이 올자리-->
            </div>

        </div>

    </div>
</div>

<script>
    //메세지를 전송하는 함수


    const SendMessage_other = function(room, other_nick){

        let content = $('.write_msg').val();
        //alert("content: "+ content);

        content = content.trim();

        if(content == ""){
            alert("메세지를 입력하세요!");
        }else{
            $.ajax({
                url:"message_send_inlist.do",
                method:"GET",
                data:{
                    room : room,
                    other_nick: other_nick,
                    content: content
                },
                success:function(data){
                    console.log("메세지 전송 성공");

                    //메세지 입력 칸 비우기
                    $('.write_msg').val("");

                    //메세지 내용 리로드
                    //MessageContentList(room);

                    //메세지 리스트 리로드
                    //MessageList();
                    location.reload();

                    // 페이지의 가장 아래로 스크롤
                    //window.scrollTo(0,document.body.scrollHeight);
                },
                error : function() {
                    alert('서버에러');
                }
            });
        }
    };

    $('.msg_send_btn_other').on('click', function() {
        var room = ${room};
        var other_nick = "${other_nick}";

        //alert(room);

        SendMessage_other(room, other_nick);


    });

    /*$(document).ready(function() {
        window.scrollTo(0,document.body.scrollHeight);
    });*/

    $(document).ready(function(){
        var msgHistory = $(".msg_history");
        msgHistory.scrollTop(msgHistory.prop("scrollHeight"));
    });



</script>

</body>
</html>