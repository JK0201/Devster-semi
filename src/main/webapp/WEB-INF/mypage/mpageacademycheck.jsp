<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../commonvar.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
    .gaip_check{
        padding: 0 30px;
    }

    .gaip_check .title{
        font-weight: 700;
        font-size: 30px;
        color: #222;
    }

    .gaip_check .wrapper{
        width: 820px;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        justify-items: center;
        border-top: 1px solid #000;
        margin-top: 20px;
        padding-top: 40px;
        grid-row-gap: 36px;
    }

    .gaip_check .wrapper h3{
        margin-top: 6px;
        /*overflow: hidden;
        text-overflow: ellipsis;*/
        width: 250px;
        font-size: 17px;
        font-weight: 500;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    /*기업 정보 텍스트들*/

    .companyUser_check_contents{
        color: gray;
        font-size: 12px;
    }

    .gaip_check .wrapper h4{
        /*margin-top: 6px;*/
        /*overflow: hidden;
        text-overflow: ellipsis;*/
        width: 250px;
        font-size: 15px;
        font-weight: 500;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        color: #222;
    }

    .gaip_check .wrapper h6{
        font-size: 14px;
        color: rgb(68, 68, 68);
        margin-top: 12px;
    }

    .gaip_check img{
        cursor: pointer;
    }

    .gaip_check #printBox h1{
        font-weight: 700;
        font-size: 30px;
        color: #222;
    }


</style>

<script>
    $(document).ready(function (){
        if(${iscomp==1}) {
            compConfirmList();
        } else {
            normalConfirmList();
        }
    })
</script>

<!--============================= 이미지 클릭시 모달 ==========================-->

<!-- The Modal -->
<div class="modal" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title" style="font-weight: bold;">가입 승인 이미지</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal body -->
            <div class="modal-body" style="margin: 0 auto; apdd">
                <img src="http://${imageUrl}/member_academy/" style="width: 400px;">
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
            </div>

        </div>
    </div>
</div>



<div class="gaip_check">
    <div id="printBox"></div>
</div>




<script>
    function normalConfirmList() {
        $.ajax({
            type : "post",
            url : "./normalacademycheck",
            dataType : "json",
            success : function (res) {
                let s = "";
                if(res.length == 0) {
                    s+= `<h1 class="title">일반회원 가입 승인</h1>`;
                    s+= `<div class="wrapper">`;
                    s+= "<h1 style='width: 800px;font-size: 24px;'>회원가입 승인을 요청한 회원이 없습니다.</h1>";
                } else {

                    s+= `<h1 class="title">일반회원 가입 승인</h1>`;
                    s+= `<div class="wrapper">`;
                    $.each(res,function (idx,dto) {
                        s+=
                            `
                            <div style="width: 250px;">
                                <img src="http://${imageUrl}/member_academy/\${dto.m_filename}" style="width: 250px; border: 1px solid rgba(0, 0, 0, 0.1);"
                                data-bs-toggle="modal" data-bs-target="#myModal" onclick="showModalImage('http://${imageUrl}/member_academy/\${dto.m_filename}')">
                                <h6>\${dto.m_name}</h6>
                                <h3>\${dto.ai_name}</h3>
                                <div>
                                <button type="button" class="btn btn-outline-success btn-sm" onclick="normalUpgradeState(\${dto.m_idx})">승인</button>
                                <button type="button" class="btn btn-outline-danger btn-sm" onclick="normalRejectUpgrade(\${dto.m_idx})">반려</button>
                                </div>
                            </div>
                        `;
                    })
                    s+= `</div>`;
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
                    s+= `<h1 class="title">기업회원 가입 승인</h1>`;
                    s+= `<div class="wrapper">`;
                    s+= "<h1 style='width: 800px; font-size: 24px;'>회원가입 승인을 요청한 기업 회원이 없습니다.</h1></div>";
                } else {

                    s+= `<h1 class="title">기업회원 가입 승인</h1>`;
                    s+= `<div class="wrapper">`;

                    $.each(res,function (idx,dto) {
                        s+=
                            `
                            <div style="width: 250px;" class='companyUser_check_contents'>
                                <img src="http://${imageUrl}/member/\${dto.cm_filename}" style="width: 250px; border: 1px solid rgba(0, 0, 0, 0.1);"
                                data-bs-toggle="modal" data-bs-target="#myModal" onclick="showModalImage('http://${imageUrl}/company_member/\${dto.cm_filename}')">
                                <div style='margin-top: 12px;'>기업명<h4>\${dto.cm_compname}</h4></div>
                                <div>기업 주소<h4>\${dto.cm_addr}</h4></div>
                                <div>기업 연락처<h4>\${dto.cm_tele}</h4></div>
                                <div>담당자 이름<h4>\${dto.cm_name}</h4></div>
                                <div>담당자 연락처<h4>\${dto.cm_cp}</h4></div>
                                <button type="button" class="btn btn-outline-success btn-sm" onclick="compUpgradeState(\${dto.cm_idx})">승인</button>
                                <button type="button" class="btn btn-outline-danger btn-sm" onclick="compRejectUpgrade(\${dto.cm_idx})">반려</button>
                            </div>

                        `;

                    });
                    s+= `</div>`;


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

    function showModalImage(imageSrc) {
        $('#myModal .modal-body img').attr('src', imageSrc);
    }


</script>

