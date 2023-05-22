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
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&family=Roboto&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', 'Roboto';
            background: white;
        }

        .container {
            display: block;
            max-width: 680px;
            width: 80%;
            margin: -60px auto;
        }

        .logo {
            font-size: 20px;
            text-align: center;
            margin: 120px 0 40px 0;
            transition: .2s linear;
        }

        .inputdiv {
            width: 100%;
            max-width: 680px;
            margin: 40px auto 10px;
            box-shadow: 4px 4px 14px 7px #bdbebd;
            padding-top: 5vh;
            padding-bottom: 5vh;
        }

        .inputdiv .input__block {
            margin: 20px auto;
            display: block;
            position: relative;
        }

        .inputdiv .input__block input {
            display: block;
            width: 90%;
            max-width: 680px;
            height: 50px;
            margin: 0 auto;
            border-radius: 8px;
            border: 2px solid rgba(15, 19, 42, .2);
            background: rgba(15, 19, 42, .1);
            color: rgba(15, 19, 42, .5);
            padding: 0 0 0 15px;
            font-size: 18px;
            font-family: 'Noto Sans KR', 'Roboto';
            transition: .2s linear;
        }

        .inputdiv .input__block input:focus,
        .inputdiv .input__block input:active {
            outline: none;
            border-color: #8007AD;
            color: rgba(15, 19, 42, 1);
        }

        .inputdiv .input__block b {
            margin-left: 40px;
        }

        .inputdiv .input__block span {
            margin-left: 40px;
            color: #808080;
        }

        .inputdiv .signin__btn {
            background: #8007AD;
            color: white;
            display: block;
            width: 92.5%;
            max-width: 680px;
            height: 50px;
            border-radius: 8px;
            margin: 0 auto;
            border: none;
            cursor: pointer;
            font-size: 19px;
            font-family: 'Noto Sans KR', 'Roboto';
            box-shadow: 0 15px 30px rgba(114, 30, 166, .36);
            transition: .2s linear;
            font-weight: bold;
        }

        .inputdiv .signin__btn:hover {
            box-shadow: 0 0 0 rgba(233, 30, 99, 0);
        }

        .memberlayout footer {
            margin-top: 200px;
        }

        .inputdiv .membermail {
            margin-bottom: 20px;
            display: block;
            position: relative;
        }

        .inputdiv .membermail input {
            float: left;
            display: block;
            width: 70%;
            max-width: 680px;
            height: 50px;
            margin-left: 33px;
            border-radius: 8px;
            border: 2px solid rgba(15, 19, 42, .2);
            background: rgba(15, 19, 42, .1);
            color: rgba(15, 19, 42, .5);
            padding: 0 0 0 15px;
            font-size: 18px;
            font-family: 'Noto Sans KR', 'Roboto';
            transition: .2s linear;
        }

        .inputdiv .membermail b {
            margin-left: 40px;
        }

        .inputdiv .membermail span {
            margin-left: 40px;
            color: #808080;
        }

        .inputdiv .membermail input:focus,
        .inputdiv .membermail input:active {
            outline: none;
            border-color: #8007AD;
            color: rgba(15, 19, 42, 1);
        }

        .inputdiv .memberbtn {
            background: #8007AD;
            color: white;
            display: block;
            width: 20%;
            height: 50px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 2vh;
            font-family: 'Noto Sans KR', 'Roboto';
            font-weight: bold;
            opacity: 0.85;
            transition: .2s linear;
        }

        .inputdiv .memberbtn:hover {
            opacity: 1;
        }

        #timer {
            position: absolute;
            right: 28%;
            top: 38%;
            color: #8007AD;
        }

        #reseticon {
            display: none;
            position: absolute;
            right: 29.5%;
            color: #8007AD;
            font-size: 3vh;
            top: 28%;
            cursor: pointer;
            z-index: 1;
        }

        #ai_name {
            cursor: default;
        }

        #acaname {
            cursor: pointer;
            text-decoration: underline transparent;
            width: 70%;
            margin-bottom: 2px;
            transition: .1s linear;
            font-size: 1.7vh;
            margin: 0.2vh auto;
        }

        #acaname:hover {
            color: #8007AD;
            text-decoration: underline #8007AD;
        }

        .emailreg {
            display: none;
        }

        /*upload*/
        #uploadpopupbox {
            color: #bdbebd;
            font-size: 23px;
            font-weight: bold;
            width: 90%;
            margin: 0 auto;
            height: 60px;
            border: 2px dashed #808080;
            border-radius: 8px;
            line-height: 55px;
            cursor: pointer;
            text-align: center;

        }

        #uploadpopupbox:hover {
            color: #8007AD;
            opacity: 1;
            transition: .2s linear;
        }

        #dropbox {
            width: 90%;
            height: 100%;
            cursor: default;
        }

        .uploadbox {
            width: 100%;
            height: 430px;
            border: 2px dashed #808080;
            border-radius: 8px;
        }

        #dndtext {
            text-align: center;
            background-color: #8007AD;
            font-size: 30px;
            width: 220px;
            height: 50px;
            color: white;
            border-radius: 10px;
            font-weight: bold;
            margin: 0 auto;
            border: 1px solid gray;
        }

        #sizetxt {
            font-size: 23px;
            float: left;
            margin-left: 15px;
            font-weight: bold;
            color: #bdbebd;
            cursor: pointer;
        }

        #sizetxt:hover {
            color: #8007AD;
            opacity: 1;
            transition: .2s linear;
        }

        .btnupload {
            font-size: 25px;
            float: right;
            margin-right: 15px;
            font-weight: bold;
            cursor: pointer;
            color: #bdbebd;
        }

        .btnupload:hover {
            color: #8007AD;
            opacity: 1;
            transition: .2s linear;
        }

        .alldelbtn {
            font-size: 25px;
            float: right;
            margin-right: 20px;
            font-weight: bold;
            cursor: pointer;
            color: #bdbebd;
        }

        .alldelbtn:hover {
            color: #8007AD;
            opacity: 1;
            transition: .2s linear;
        }

        #preview {
            margin: 0 auto;
            width: 50%;
            height: 50%;
            text-align: center;
        }

        #divimgbox {
            margin: 0 auto;
        }

        .imgpreview {
            width: 35vw;
            height: 31vh;
        }

        .previewdelbtn {
            width: 120px;
            color: red;
            opacity: 60%;
            font-size: 90px;
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            display: none;
        }

        .agreementbox {
            display: block;
            width: 90%;
            max-width: 680px;
            height: 100%;
            margin: 0 auto;
            border-radius: 8px;
            border: 2px solid rgba(15, 19, 42, .2);
            background: rgba(15, 19, 42, .1);
            color: rgba(15, 19, 42, .5);
            padding: 0 0 0 15px;
            font-size: 18px;
            font-family: 'Noto Sans KR', 'Roboto';
            transition: .2s linear;
        }

        .separator {
            display: block;
            margin: 5px auto 10px;
            text-align: center;
            height: 7px;
            position: relative;
            background: transparent;
            color: rgba(15, 19, 42, .5);
            font-size: 13px;
            width: 95%;
            max-width: 680px;
        }

        .separator::before {
            content: "";
            position: absolute;
            top: 8px;
            left: 0;
            background: rgba(15, 19, 42, .2);
            height: 1px;
            width: 100%;
        }

        /*modal*/
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: #fefefe;
            border: 1px solid #888;
            width: 50%;
        }

        .close {
            color: #bdbebd;
            font-size: 40px;
            cursor: pointer;
            font-weight: bold;
        }

        .close:hover {
            color: #8007AD;
        }

        .searchbox {
            width: 70%;
            height: 37vh;
            border: 3px dashed #808080;
            border-radius: 10px;
            margin: 0 auto;
            padding-top: 1.5vh;
        }

        #countbox {
            font-weight: bold;
            width: 70%;
            margin: 0 auto;
            padding-top: 1vh;
        }

        #uploadbtn {
            text-align: center;
            background-color: #bdbebd;
            font-size: 25px;
            width: 140px;
            height: 55px;
            color: white;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
            border: 1px solid #bdbebd;
            transition: 0.2s linear;
        }

        #uploadbtn:hover {
            background-color: #8007AD;
        }

        .progress {
            margin: 0 auto;
            position: relative;
            width: 50%;
            border: 1px solid #bdbebd;
            padding: 1px;
            border-radius: 5px;
            display: none;
        }

        .bar {
            background-color: #8007AD;
            width: 0%;
            height: 20px;
            border-radius: 3px;
        }

        .percent {
            position: absolute;
            display: inline-block;
            top: -3px;
            left: 48%;
            font-weight: bold;
        }

        #agreementall, #chkbtnone, #chkbtntwo {
            cursor: pointer;
            width: 86%;
        }

        #acceptall, #acceptone, #accepttwo {
            display: none;
        }

        #detailone, #detailtwo {
            cursor: pointer;
        }

        textarea {
            padding: 20px;
            width: 100%;
            height: 300px;
            background: #fff;
            border: 1px solid #d8d9df;
            font-size: 12px;
            color: #98989f;
            line-height: 1.6em;
            overflow: auto;
            resize: none;
            display: block;
        }
    </style>
</head>
<body>
<input type="hidden" id="m_type" value="0">
<div class="container">
    <!-- Heading -->
    <div class="logo">
        <a href="${root}/" style="text-decoration: none;"> <img src="/photo/logo.png" class="logotext">
            <span><img src="/photo/logoimage.png" class="logoimage"></span>
        </a>
        <div style="color:#0f132a; opacity: 0.6; font-weight: bold">회&nbsp;원&nbsp;가&nbsp;입</div>
    </div>

    <div class="inputdiv">
        <div class="membermail">
            <b>이&nbsp;메&nbsp;일</b>
            <i class="bi bi-arrow-clockwise" style="cursor: pointer" id="reseticon"></i>
            <div class="input-group">
                <input type="email" placeholder="Email@example.com" id="m_email">
                <button class="memberbtn" id="sendemail" disabled>인&nbsp;증&nbsp;요&nbsp;청</button>
            </div>
            <span id="emailchkicon">　　</span>
        </div>
        <div class="membermail">
            <div class="emailreg">
                <b>인&nbsp;증&nbsp;번&nbsp;호</b>
                <label id="timer">03:00</label>
                <div class="input-group">
                    <input type="text" id="eregnumber" required>
                    <button class="memberbtn" id="eregbtn">확&nbsp;인</button>
                </div>
                <span>　</span>
            </div>
        </div>
        <div class="input__block">
            <b>비&nbsp;밀&nbsp;번&nbsp;호</b>
            <input type="password" placeholder="Password" class="input" id="m_pass" required/>
            <span id="passokicon">　　</span>
        </div>
        <div class="input__block">
            <b>비&nbsp;밀&nbsp;번&nbsp;호&nbsp;확&nbsp;인</b>
            <input type="password" placeholder="Password" class="input" id="passchk" required/>
            <span id="passchkicon">　　</span>
        </div>
        <div class="input__block">
            <b>이&nbsp;름</b>
            <input type="text" placeholder="Name" class="input" id="m_name" required/>
            <span id="namechkicon">　　</span>
        </div>
        <div class="input__block">
            <b>휴&nbsp;대&nbsp;폰</b>
            <input type="tel" placeholder="Cellphone" class="input" id="m_tele" required/>
            <span id="telechkicon">　　</span>
        </div>
        <div class="input__block">
            <b>닉&nbsp;네&nbsp;임</b>
            <input type="text" placeholder="Nickname" class="input" id="m_nickname" required/>
            <span id="nicknamechkicon">　　</span>
        </div>
        <div class="input__block">
            <b>학&nbsp;원</b>
            <input type="text" placeholder="Academy" class="input" id="ai_name" readonly required/>
            <span id="acachkicon">　　</span>
        </div>
        <div class="input__block">
            <b>프&nbsp;로&nbsp;필&nbsp;사&nbsp;진&nbsp;(선&nbsp;택)</b>
            <!-- upload -->
            <div id="uploadpopupbox">사진 등록하기&nbsp;<i class="bi bi-plus-circle"></i></div>
            <section id="dropbox" style="margin:0 auto; display: none;">
                <div class="uploadbox">
                    <input type="file" accept=".jpg, .jpeg, .png" id="filebtn" class="btn-file d-none">
                    <div style="width:100%; height:70px; line-height: 60px;">
                            <span id="sizetxt" style="height:45px; font-size:23px; margin-left:36%;">사진 등록하기&nbsp;<i
                                    class="bi bi-dash-circle"></i></span>
                        <i class="bi bi-recycle alldelbtn" style="height:45px;"></i>
                        <i class="bi bi-plus-circle btnupload" style="height:45px;"></i>
                    </div>
                    <div id="preview">
                        <div id="divimgbox" style="margin:0 auto; width:100%;">
                            <div style="padding-top:40px;">
                                <i class="bi bi-cloud-upload" style="color:#bdbebd; font-size: 55px;"></i>
                                <div style="color:#bdbebd; font-size: 20px; font-weight: bold; margin-bottom: 25px;">
                                    나만의 멋진 프로필<br>사진을 올려보세요!
                                </div>
                                <div id="dndtext">Drag & Drop</div>
                            </div>
                        </div>
                    </div>
                    <div style="width:100%; height:60px; padding-top:15px;">
                        <div class="progress">
                            <div class="bar progress-bar-striped progress-bar-animated"></div>
                            <div class="percent">0%</div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <div class="input__block">
            <b>약&nbsp;관</b>
            <div class="agreementbox">
                <div style="padding-top: 10px; padding-bottom: 10px;">
                    <div id="agreementall">
                        <strong>
                            <i class="bi bi-check-square-fill" id="acceptall"></i>
                            <i class="bi bi-square" id="denyall"></i>
                            전체 동의
                        </strong>
                    </div>
                    <div class="separator"></div>

                    <div style="display: flex;">
                        <div id="chkbtnone" style="margin-bottom: 7px">
                            <strong>
                                <i class="bi bi-check-square-fill" id="acceptone"></i>
                                <i class="bi bi-square" id="denyone"></i>
                                <strong style="color:red; opacity: 0.7;">(필수)</strong> 이용약관 동의
                            </strong>

                        </div>
                        <div>
                            <strong style="float:right;" id="detailone">
                                자세히 >
                            </strong>
                        </div>
                    </div>

                    <div style="display: flex;">
                        <div id="chkbtntwo">
                            <strong>
                                <i class="bi bi-check-square-fill" id="accepttwo"></i>
                                <i class="bi bi-square" id="denytwo"></i>
                                <strong style="color:red; opacity: 0.7;">(필수)</strong> 개인정보 수집 및 이용 동의
                            </strong>
                        </div>
                        <div>
                            <strong style="float:right;" id="detailtwo">
                                자세히 >
                            </strong>
                        </div>
                    </div>
                </div>
            </div>
            <span id="">　　</span>
        </div>
        <div style="width:100%; height:60px; padding-top: 15px; text-align:center;">
            <button type=button id="uploadbtn">가&nbsp;입&nbsp;하&nbsp;기</button>
        </div>
    </div>
    <!-- Academy Modal -->
    <div id="myUploadModal" class="modal">
        <div class="modal-content" style="width:40%">
            <div class="inputdiv" style="box-shadow: none; padding-bottom: 0; padding-top:0;">
                <div style="width:35px; margin:0 auto; width: 100%; text-align: center; padding-bottom: 10px;">
                    <i class="bi bi-x-circle close"></i>
                    <div class="membermail">
                        <b style="float: left; margint-left:40px; padding-left: 35px;">학&nbsp;원&nbsp;검&nbsp;색</b>
                        <div class="input-group" style="width:90%; margin:0 auto">
                            <input type="text" placeholder="검색하실 학원명을 입력해주세요" id="modalname">
                            <button class="memberbtn" id="acanamebtn">등&nbsp;록</button>
                        </div>
                        <div style="margin: 0 auto; width: 76%; text-align: left; font-size: 1.5vh; color:#bdbebd; margin-bottom: 1vh">
                            <sapn>tip.찾으시는 학원명이 없으시다면 학원명 입력후 등록을 눌러주세요!</sapn>
                        </div>
                        <div class="searchbox">
                            <div id="searchbox"></div>
                            <div id="loadingbox"
                                 style="display: inline-block; margin-top: 30%;font-size: 3vh; color:#8007AD; opacity: .8;"></div>
                        </div>
                        <div id="countbox"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="myAgreementModalOne" class="modal">
        <div class="modal-content" style="width:40%">
            <div class="inputdiv" style="box-shadow: none; padding-bottom: 0; padding-top:0;">
                <div style="width:35px; margin:0 auto; width: 100%; text-align: center; padding-bottom: 10px;">
                    <i class="bi bi-x-circle close"></i>
                    <div class="membermail">
                        <strong style="float: left; padding-left: 5px; padding-bottom: 10px;"><strong
                                style="color:red; opacity: 0.7;">(필수)</strong> 이용약관 동의</strong>
                        <textarea readonly>제1조(목적) 이 약관은 업체 회사(전자상거래 사업자)가 운영하는 업체 SNS(이하 "Devster"이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 SNS과 이용자의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.

  ※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다.」

제2조(정의)

  ① "Devster"이란 업체 회사가 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 SNS을 운영하는 사업자의 의미로도 사용합니다.

  ② “이용자”란 "Devster"에 접속하여 이 약관에 따라 "Devster"이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.

  ③ ‘회원’이라 함은 "Devster"에 회원등록을 한 자로서, 계속적으로 "Devster"이 제공하는 서비스를 이용할 수 있는 자를 말합니다.

  ④ ‘비회원’이라 함은 회원에 가입하지 않고 "Devster"이 제공하는 서비스를 이용하는 자를 말합니다.

제3조 (약관 등의 명시와 설명 및 개정)

  ① "Devster"은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호․모사전송번호․전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보관리책임자 등을 이용자가 쉽게 알 수 있도록 00 SNS의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.

  ② “Devster은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회․배송책임․환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.

  ③ "Devster"은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.

  ④ "Devster"이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 Devster의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다.  이 경우 "Devster“은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.

  ⑤ "Devster"이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 "Devster"에 송신하여 "Devster"의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.

  ⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 「전자상거래 등에서의 소비자 보호지침」 및 관계법령 또는 상관례에 따릅니다.

제4조(서비스의 제공 및 변경)

  ① "Devster"은 다음과 같은 업무를 수행합니다.

    1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결
    2. 구매계약이 체결된 재화 또는 용역의 배송
    3. 기타 "Devster"이 정하는 업무

  ② "Devster"은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.

  ③ "Devster"이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화 등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.

  ④ 전항의 경우 "Devster"은 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, "Devster"이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.

제5조(서비스의 중단)

  ① "Devster"은 컴퓨터 등 정보통신설비의 보수점검․교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.

  ② "Devster"은 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, "Devster"이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.

  ③ 사업종목의 전환, 사업의 포기, 업체 간의 통합 등의 이유로 서비스를 제공할 수 없게 되는 경우에는 "Devster"은 제8조에 정한 방법으로 이용자에게 통지하고 당초 "Devster"에서 제시한 조건에 따라 소비자에게 보상합니다. 다만, "Devster"이 보상기준 등을 고지하지 아니한 경우에는 이용자들의 마일리지 또는 적립금 등을 "Devster"에서 통용되는 통화가치에 상응하는 현물 또는 현금으로 이용자에게 지급합니다.

제6조(회원가입)

  ① 이용자는 "Devster"이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.

  ② "Devster"은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다.

    1. 가입신청자가 이 약관 제7조제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제7조제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 "Devster"의 회원재가입 승낙을 얻은 경우에는 예외로 한다.
    2. 등록 내용에 허위, 기재누락, 오기가 있는 경우
    3. 기타 회원으로 등록하는 것이 "Devster"의 기술상 현저히 지장이 있다고 판단되는 경우

  ③ 회원가입계약의 성립 시기는 "Devster"의 승낙이 회원에게 도달한 시점으로 합니다.

  ④ 회원은 회원가입 시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에 "Devster"에 대하여 회원정보 수정 등의 방법으로 그 변경사항을 알려야 합니다.

제7조(회원 탈퇴 및 자격 상실 등)

  ① 회원은 "Devster"에 언제든지 탈퇴를 요청할 수 있으며 "Devster"은 즉시 회원탈퇴를 처리합니다.

  ② 회원이 다음 각 호의 사유에 해당하는 경우, "Devster"은 회원자격을 제한 및 정지시킬 수 있습니다.

    1. 가입 신청 시에 허위 내용을 등록한 경우
    2. "Devster"을 이용하여 구입한 재화 등의 대금, 기타 "Devster"이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우
    3. 다른 사람의 "Devster" 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우
    4. "Devster"을 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우

  ③ "Devster"이 회원 자격을 제한․정지 시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 "Devster"은 회원자격을 상실시킬 수 있습니다.

  ④ "Devster"이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.

제8조(회원에 대한 통지)

  ① "Devster"이 회원에 대한 통지를 하는 경우, 회원이 "Devster"과 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다.

  ② "Devster"은 불특정다수 회원에 대한 통지의 경우 1주일이상 "Devster" 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.

제9조(구매신청)

  ① "Devster"이용자는 "Devster"상에서 다음 또는 이와 유사한 방법에 의하여 구매를 신청하며, "Devster"은 이용자가 구매신청을 함에 있어서 다음의 각 내용을 알기 쉽게 제공하여야 합니다.
      1. 재화 등의 검색 및 선택
      2. 받는 사람의 성명, 주소, 전화번호, 전자우편주소(또는 이동전화번호) 등의 입력
      3. 약관내용, 청약철회권이 제한되는 서비스, 배송료․설치비 등의 비용부담과 관련한 내용에 대한 확인
      4. 이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는 표시
         (예, 마우스 클릭)
      5. 재화 등의 구매신청 및 이에 관한 확인 또는 "Devster"의 확인에 대한 동의
      6. 결제방법의 선택

  ② "Devster"이 제3자에게 구매자 개인정보를 제공·위탁할 필요가 있는 경우 실제 구매신청 시 구매자의 동의를 받아야 하며, 회원가입 시 미리 포괄적으로 동의를 받지 않습니다. 이 때 "Devster"은 제공되는 개인정보 항목, 제공받는 자, 제공받는 자의 개인정보 이용 목적 및 보유‧이용 기간 등을 구매자에게 명시하여야 합니다. 다만 「정보통신망이용촉진 및 정보보호 등에 관한 법률」 제25조 제1항에 의한 개인정보 취급위탁의 경우 등 관련 법령에 달리 정함이 있는 경우에는 그에 따릅니다.


제10조 (계약의 성립)

  ①  "Devster"은 제9조와 같은 구매신청에 대하여 다음 각 호에 해당하면 승낙하지 않을 수 있습니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하여야 합니다.

    1. 신청 내용에 허위, 기재누락, 오기가 있는 경우
    2. 미성년자가 담배, 주류 등 청소년보호법에서 금지하는 재화 및 용역을 구매하는 경우
    3. 기타 구매신청에 승낙하는 것이 "Devster" 기술상 현저히 지장이 있다고 판단하는 경우

  ② "Devster"의 승낙이 제12조제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.

  ③ "Devster"의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매가능 여부, 구매신청의 정정 취소 등에 관한 정보 등을 포함하여야 합니다.

제11조(지급방법) "Devster"에서 구매한 재화 또는 용역에 대한 대금지급방법은 다음 각 호의 방법중 가용한 방법으로 할 수 있습니다. 단, "Devster"은 이용자의 지급방법에 대하여 재화 등의 대금에 어떠한 명목의 수수료도  추가하여 징수할 수 없습니다.

    1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체
    2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제
    3. 온라인무통장입금
    4. 전자화폐에 의한 결제
    5. 수령 시 대금지급
    6. 마일리지 등 "Devster"이 지급한 포인트에 의한 결제
    7. "Devster"과 계약을 맺었거나 "Devster"이 인정한 상품권에 의한 결제
    8. 기타 전자적 지급 방법에 의한 대금 지급 등

제12조(수신확인통지․구매신청 변경 및 취소)

  ① "Devster"은 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다.

  ② 수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 "Devster"은 배송 전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제15조의 청약철회 등에 관한 규정에 따릅니다.

제13조(재화 등의 공급)

  ① "Devster"은 이용자와 재화 등의 공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 청약을 한 날부터 7일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타의 필요한 조치를 취합니다. 다만, "Devster"이 이미 재화 등의 대금의 전부 또는 일부를 받은 경우에는 대금의 전부 또는 일부를 받은 날부터 3영업일 이내에 조치를 취합니다.  이때 "Devster"은 이용자가 재화 등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다.

  ② "Devster"은 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약 "Devster"이 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만 "Devster"이 고의․과실이 없음을 입증한 경우에는 그러하지 아니합니다.

제14조(환급) "Devster"은 이용자가 구매신청한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 취합니다.

제15조(청약철회 등)

  ① "Devster"과 재화등의 구매에 관한 계약을 체결한 이용자는 「전자상거래 등에서의 소비자보호에 관한 법률」 제13조 제2항에 따른 계약내용에 관한 서면을 받은 날(그 서면을 받은 때보다 재화 등의 공급이 늦게 이루어진 경우에는 재화 등을 공급받거나 재화 등의 공급이 시작된 날을 말합니다)부터 7일 이내에는 청약의 철회를 할 수 있습니다. 다만, 청약철회에 관하여 「전자상거래 등에서의 소비자보호에 관한 법률」에 달리 정함이 있는 경우에는 동 법 규정에 따릅니다.

  ② 이용자는 재화 등을 배송 받은 경우 다음 각 호의 1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다.

    1. 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를 할 수 있습니다)
    2. 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우
    3. 시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우
    4. 같은 성능을 지닌 재화 등으로 복제가 가능한 경우 그 원본인 재화 등의 포장을 훼손한 경우

  ③ 제2항제2호 내지 제4호의 경우에 "Devster"이 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회 등이 제한되지 않습니다.

  ④ 이용자는 제1항 및 제2항의 규정에 불구하고 재화 등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.

제16조(청약철회 등의 효과)

  ① "Devster"은 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을 환급합니다. 이 경우 "Devster"이 이용자에게 재화등의 환급을 지연한때에는 그 지연기간에 대하여 「전자상거래 등에서의 소비자보호에 관한 법률 시행령」제21조의2에서 정하는 지연이자율을 곱하여 산정한 지연이자를 지급합니다.

  ② "Devster"은 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화 등의 대금을 지급한 때에는 지체 없이 당해 결제수단을 제공한 사업자로 하여금 재화 등의 대금의 청구를 정지 또는 취소하도록 요청합니다.

  ③ 청약철회 등의 경우 공급받은 재화 등의 반환에 필요한 비용은 이용자가 부담합니다. "Devster"은 이용자에게 청약철회 등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화 등의 내용이 표시·광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회 등을 하는 경우 재화 등의 반환에 필요한 비용은 "Devster"이 부담합니다.

  ④ 이용자가 재화 등을 제공받을 때 발송비를 부담한 경우에 "Devster"은 청약철회 시 그 비용을  누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.

제17조(개인정보보호)

  ① "Devster"은 이용자의 개인정보 수집시 서비스제공을 위하여 필요한 범위에서 최소한의 개인정보를 수집합니다.

  ② "Devster"은 회원가입시 구매계약이행에 필요한 정보를 미리 수집하지 않습니다. 다만, 관련 법령상 의무이행을 위하여 구매계약 이전에 본인확인이 필요한 경우로서 최소한의 특정 개인정보를 수집하는 경우에는 그러하지 아니합니다.

  ③ "Devster"은 이용자의 개인정보를 수집·이용하는 때에는 당해 이용자에게 그 목적을 고지하고 동의를 받습니다.

  ④ "Devster"은 수집된 개인정보를 목적외의 용도로 이용할 수 없으며, 새로운 이용목적이 발생한 경우 또는 제3자에게 제공하는 경우에는 이용·제공단계에서 당해 이용자에게 그 목적을 고지하고 동의를 받습니다. 다만, 관련 법령에 달리 정함이 있는 경우에는 예외로 합니다.

  ⑤ "Devster"이 제3항과 제4항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보관리 책임자의 신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공 관련사항(제공받은자, 제공목적 및 제공할 정보의 내용) 등 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 제22조제2항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.

  ⑥ 이용자는 언제든지 "Devster"이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 "Devster"은 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 "Devster"은 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.

  ⑦ "Devster"은 개인정보 보호를 위하여 이용자의 개인정보를 취급하는 자를  최소한으로 제한하여야 하며 신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 동의 없는 제3자 제공, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.

  ⑧ "Devster" 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.

  ⑨ "Devster"은 개인정보의 수집·이용·제공에 관한 동의란을 미리 선택한 것으로 설정해두지 않습니다. 또한 개인정보의 수집·이용·제공에 관한 이용자의 동의거절시 제한되는 서비스를 구체적으로 명시하고, 필수수집항목이 아닌 개인정보의 수집·이용·제공에 관한 이용자의 동의 거절을 이유로 회원가입 등 서비스 제공을 제한하거나 거절하지 않습니다.

제18조("Devster"의 의무)

  ① "Devster"은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화․용역을 제공하는데 최선을 다하여야 합니다.

  ② "Devster"은 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.

  ③ "Devster"이 상품이나 용역에 대하여 「표시․광고의 공정화에 관한 법률」 제3조 소정의 부당한 표시․광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.

  ④ "Devster"은 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.

제19조(회원의 ID 및 비밀번호에 대한 의무)

  ① 제17조의 경우를 제외한 ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.

  ② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.

  ③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 "Devster"에 통보하고 "Devster"의 안내가 있는 경우에는 그에 따라야 합니다.

제20조(이용자의 의무) 이용자는 다음 행위를 하여서는 안 됩니다.

    1. 신청 또는 변경시 허위 내용의 등록
    2. 타인의 정보 도용
    3. "Devster"에 게시된 정보의 변경
    4. "Devster"이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시
    5. "Devster" 기타 제3자의 저작권 등 지적재산권에 대한 침해
    6. "Devster" 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위
    7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 Devster에 공개 또는 게시하는 행위

제21조(연결"Devster"과 피연결"Devster" 간의 관계)

  ① 상위 "Devster"과 하위 "Devster"이 하이퍼링크(예: 하이퍼링크의 대상에는 문자, 그림 및 동화상 등이 포함됨)방식 등으로 연결된 경우, 전자를 연결 "Devster"(웹 사이트)이라고 하고 후자를 피연결 "Devster"(웹사이트)이라고 합니다.

  ② 연결"Devster"은 피연결"Devster"이 독자적으로 제공하는 재화 등에 의하여 이용자와 행하는 거래에 대해서 보증 책임을 지지 않는다는 뜻을 연결"Devster"의 초기화면 또는 연결되는 시점의 팝업화면으로 명시한 경우에는 그 거래에 대한 보증 책임을 지지 않습니다.

제22조(저작권의 귀속 및 이용제한)

  ① "Devster"이 작성한 저작물에 대한 저작권 기타 지적재산권은 ”Devster“에 귀속합니다.

  ② 이용자는 "Devster"을 이용함으로써 얻은 정보 중 "Devster"에게 지적재산권이 귀속된 정보를 "Devster"의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.

  ③ "Devster"은 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다.

제23조(분쟁해결)

  ① "Devster"은 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치․운영합니다.

  ② "Devster"은 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해 드립니다.

  ③ "Devster"과 이용자 간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시·도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.

제24조(재판권 및 준거법)

  ① "Devster"과 이용자 간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.

  ② "Devster"과 이용자 간에 제기된 전자상거래 소송에는 한국법을 적용합니다.
 </textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="myAgreementModalTwo" class="modal">
        <div class="modal-content" style="width:40%">
            <div class="inputdiv" style="box-shadow: none; padding-bottom: 0; padding-top:0;">
                <div style="width:35px; margin:0 auto; width: 100%; text-align: center; padding-bottom: 10px;">
                    <i class="bi bi-x-circle close"></i>
                    <div class="membermail">
                        <strong style="float: left; padding-left: 10px; padding-bottom: 10px;"><strong
                                style="color:red; opacity: 0.7;">(필수)</strong> 개인정보 수집 및 이용
                            동의</strong>
                        <textarea readonly>개인정보처리방침
[차례]
1. 총칙
2. 개인정보 수집에 대한 동의
3. 개인정보의 수집 및 이용목적
4. 수집하는 개인정보 항목
5. 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항
6. 목적 외 사용 및 제3자에 대한 제공
7. 개인정보의 열람 및 정정
8. 개인정보 수집, 이용, 제공에 대한 동의철회
9. 개인정보의 보유 및 이용기간
10. 개인정보의 파기절차 및 방법
11. 아동의 개인정보 보호
12. 개인정보 보호를 위한 기술적 대책
13. 개인정보의 위탁처리
14. 의겸수렴 및 불만처리
15. 부 칙(시행일)

1. 총칙

본 업체 사이트는 회원의 개인정보보호를 소중하게 생각하고, 회원의 개인정보를 보호하기 위하여 항상 최선을 다해 노력하고 있습니다.
1) 회사는 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」을 비롯한 모든 개인정보보호 관련 법률규정을 준수하고 있으며, 관련 법령에 의거한 개인정보처리방침을 정하여 이용자 권익 보호에 최선을 다하고 있습니다.
2) 회사는 「개인정보처리방침」을 제정하여 이를 준수하고 있으며, 이를 인터넷사이트 및 모바일 어플리케이션에 공개하여 이용자가 언제나 용이하게 열람할 수 있도록 하고 있습니다.
3) 회사는 「개인정보처리방침」을 통하여 귀하께서 제공하시는 개인정보가 어떠한 용도와 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.
4) 회사는 「개인정보처리방침」을 홈페이지 첫 화면 하단에 공개함으로써 귀하께서 언제나 용이하게 보실 수 있도록 조치하고 있습니다.
5) 회사는  「개인정보처리방침」을 개정하는 경우 웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다.

2. 개인정보 수집에 대한 동의

귀하께서 본 사이트의 개인정보보호방침 또는 이용약관의 내용에 대해 「동의 한다」버튼 또는 「동의하지 않는다」버튼을 클릭할 수 있는 절차를 마련하여, 「동의 한다」버튼을 클릭하면 개인정보 수집에 대해 동의한 것으로 봅니다.

3. 개인정보의 수집 및 이용목적

본 사이트는 다음과 같은 목적을 위하여 개인정보를 수집하고 있습니다.
서비스 제공을 위한 계약의 성립 : 본인식별 및 본인의사 확인 등
서비스의 이행 : 상품배송 및 대금결제
회원 관리 : 회원제 서비스 이용에 따른 본인확인, 개인 식별, 연령확인, 불만처리 등 민원처리
기타 새로운 서비스, 신상품이나 이벤트 정보 안내
단, 이용자의 기본적 인권 침해의 우려가 있는 민감한 개인정보(인종 및 민족, 사상 및 신조, 출신지 및 본적지, 정치적 성향 및 범죄기록, 건강상태 등)는 수집하지 않습니다.

4. 수집하는 개인정보 항목

본 사이트는 회원가입, 상담, 서비스 신청 등을 위해 아래와 같은 개인정보를 수집하고 있습니다.
1) 개인정보 수집방법 : 홈페이지(회원가입)
2) 수집항목 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 전화번호 , 주소 , 휴대전화번호 , 이메일 , 주민등록번호 , 접속 로그 , 접속 IP 정보 , 결제기록


5. 개인정보 자동수집 장치의 설치, 운영 및 그 거부에 관한 사항

본 사이트는 귀하에 대한 정보를 저장하고 수시로 찾아내는 '쿠키(cookie)'를 사용합니다. 쿠키는 웹사이트가 귀하의 컴퓨터 브라우저(넷스케이프, 인터넷 익스플로러 등)로 전송하는 소량의 정보입니다. 귀하께서 웹사이트에 접속을 하면 본 사이트의 컴퓨터는 귀하의 브라우저에 있는 쿠키의 내용을 읽고, 귀하의 추가정보를 귀하의 컴퓨터에서 찾아 접속에 따른 성명 등의 추가 입력 없이 서비스를 제공할 수 있습니다.
1) 쿠키는 귀하의 컴퓨터는 식별하지만 귀하를 개인적으로 식별하지는 않습니다. 또한 귀하는 쿠키에 대한 선택권이 있습니다. 웹브라우저의 옵션을 조정함으로써 모든 쿠키를 다 받아들이거나, 쿠키가 설치될 때 통지를 보내도록 하거나, 아니면 모든 쿠키를 거부할 수 있는 선택권을 가질 수 있습니다.
2) 쿠키 등 사용 목적 : 이용자의 접속 빈도나 방문 시간 등을 분석, 이용자의 취향과 관심분야를 파악 및 자취 추적, 각종 이벤트 참여 정도 및 방문 회수 파악 등을 통한 타겟 마케팅 및 개인 맞춤 서비스 제공
3) 쿠키 설정 거부 방법 : 쿠키 설정을 거부하는 방법으로는 귀하가 사용하는 웹 브라우저의 옵션을 선택함으로써 모든 쿠키를 허용하거나 쿠키를 저장할 때마다 확인을 거치거나, 모든 쿠키의 저장을 거부할 수 있습니다. 설정방법 예시 : 인터넷 익스플로어의 경우 → 웹 브라우저 상단의 도구 > 인터넷 옵션 > 개인정보
단, 귀하께서 쿠키 설치를 거부하였을 경우 서비스 제공에 어려움이 있을 수 있습니다.

6 목적 외 사용 및 제3자에 대한 제공

본 사이트는 귀하의 개인정보를 "개인정보의 수집목적 및 이용목적"에서 고지한 범위 내에서 사용하며, 동 범위를 초과하여 이용하거나 타인 또는 타 기업·기관에 제공하지 않습니다.
그러나 보다 나은 서비스 제공을 위하여 귀하의 개인정보를 업체 자회사 또는 제휴사에게 제공하거나, 업체 자회사 또는 제휴사와 공유할 수 있습니다. 개인정보를 제공하거나 공유할 경우에는 사전에 귀하께 업체 자회사 그리고 제휴사가 누구인지, 제공 또는 공유되는 개인정보항목이 무엇인지, 왜 그러한 개인정보가 제공되거나 공유되어야 하는지, 그리고 언제까지 어떻게 보호·관리되는지에 대해 개별적으로 전자우편 및 서면을 통해 고지하여 동의를 구하는 절차를 거치게 되며, 귀하께서 동의하지 않는 경우에는 업체 자회사 그리고 제휴사에게 제공하거나 공유하지 않습니다. 또한 이용자의 개인정보를 원칙적으로 외부에 제공하지 않으나, 아래의 경우에는 예외로 합니다.
1) 이용자들이 사전에 동의한 경우
2) 법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우

7. 개인정보의 열람 및 정정

귀하는 언제든지 등록되어 있는 귀하의 개인정보를 열람하거나 정정하실 수 있습니다. 개인정보 열람 및 정정을 하고자 할 경우에는 "회원정보수정"을 클릭하여 직접 열람 또는 정정하거나, 개인정보 최고관리책임자에게 E-mail로 연락하시면 조치하겠습니다.
귀하가 개인정보의 오류에 대한 정정을 요청한 경우, 정정을 완료하기 전까지 당해 개인정보를 이용하지 않습니다.

8. 개인정보 수집, 이용, 제공에 대한 동의철회

회원가입 등을 통해 개인정보의 수집, 이용, 제공에 대해 귀하께서 동의하신 내용을 귀하는 언제든지 철회하실 수 있습니다. 동의철회는 "마이페이지"의 "회원탈퇴(동의철회)"를 클릭하거나 개인정보관리책임자에게 E-mail등으로 연락하시면 즉시 개인정보의 삭제 등 필요한 조치를 하겠습니다.
본 사이트는 개인정보의 수집에 대한 회원탈퇴(동의철회)를 개인정보 수집시와 동등한 방법 및 절차로 행사할 수 있도록 필요한 조치를 하겠습니다.

9. 개인정보의 보유 및 이용기간

원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.
1) 보존 항목 : 회원가입정보(로그인ID, 이름, 별명)
2) 보존 근거 : 회원 탈퇴 시 다른 회원이 기존 회원아이디로 재가입하여 활동하지 못하도록 하기 위함
3) 보존 기간 : 영구
그리고 상법 등 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 아래와 같이 관계법령에서 정한 일정한 기간 동안 거래 및 회원정보를 보관합니다.
⚪보존 항목 : 계약 또는 청약철회 기록, 대금 결제 및 재화공급 기록, 불만 또는 분쟁처리 기록
⚪보존 근거 : 전자상거래등에서의 소비자보호에 관한 법률 제6조 거래기록의 보존
⚪보존 기간 : 계약 또는 청약철회 기록(5년), 대금 결제 및 재화공급 기록(5년), 불만 또는 분쟁처리 기록(3년), 위 보유기간에도 불구하고 계속 보유하여야 할 필요가 있을 경우에는 귀하의 동의를 받겠습니다.
⚪회원이 1년간 서비스 이용기록이 없는 경우[정보통신망 이용촉진 및 정보보호 등에 관한 법률] 제 29조 '개인정보 유효 기간제'에 따라 회원에게 사전 통지하고 별도로 분리하여 저장합니다.
4) 개인정보의 국외 보관에 대한 내용
 회사는 이용자로부터 취득 또는 생성한 개인정보를 미리내가 보유하고 있는 데이터베이스 (물리적보관소: 한국)에 저장합니다. 미리내는 해당 서버의 물리적인 관리만을 행하고, 원칙적으로 회원님의 개인정보에 접근하지 않습니다.


⚪이전항목: 서비스 이용기록 또는 수집된 개인정보
⚪이전국가: 한국
⚪이전일시 및 방법: 전산 서버 수탁계약 이후 서비스 이용 시점에 네트워크를 통한 전송
⚪개인정보 보유 및 이용기간: 회원탈퇴시 혹은 위탁계약 종료시까지

10. 개인정보의 파기절차 및 방법

본 사이트는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.
파기절차 : 귀하가 회원가입 등을 위해 입력하신 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함) 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조) 일정 기간 저장된 후 파기되어집니다. 별도 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 보유되어지는 이외의 다른 목적으로 이용되지 않습니다.
파기방법 : 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.

11. 아동의 개인정보 보호

본 사이트는 만14세 미만 아동의 개인정보를 수집하는 경우 법정대리인의 동의를 받습니다.
만14세 미만 아동의 법정대리인은 아동의 개인정보의 열람, 정정, 동의철회를 요청할 수 있으며, 이러한 요청이 있을 경우 본 사이트는 지체 없이 필요한 조치를 취합니다.

12. 개인정보 보호를 위한 기술적 대책

본 사이트는 귀하의 개인정보를 취급함에 있어 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지 않도록 안전성 확보를 위하여 다음과 같은 기술적 대책을 강구하고 있습니다.
귀하의 개인정보는 비밀번호에 의해 보호되며, 파일 및 전송 데이터를 암호화하거나 파일 잠금기능(Lock)을 사용하여 중요한 데이터는 별도의 보안기능을 통해 보호되고 있습니다.
본 사이트는 백신프로그램을 이용하여 컴퓨터바이러스에 의한 피해를 방지하기 위한 조치를 취하고 있습니다. 백신프로그램은 주기적으로 업데이트되며 갑작스런 바이러스가 출현할 경우 백신이 나오는 즉시 이를 제공함으로써 개인정보가 침해되는 것을 방지하고 있습니다.
해킹 등에 의해 귀하의 개인정보가 유출되는 것을 방지하기 위해, 외부로부터의 침입을 차단하는 장치를 이용하고 있습니다.

13. 개인정보의 위탁처리
본 사이트는 서비스 향상을 위해서 귀하의 개인정보를 외부에 위탁하여 처리할 수 있습니다.
개인정보의 처리를 위탁하는 경우에는 미리 그 사실을 귀하에게 고지하겠습니다.
개인정보의 처리를 위탁하는 경우에는 위탁계약 등을 통하여 서비스제공자의 개인정보보호 관련 지시 엄수, 개인정보에 관한 비밀유지, 제3자 제공의 금지 및 사고시의 책임부담 등을 명확히 규정하고 당해 계약내용을 서면 또는 전자적으로 보관하겠습니다.

14. 의견수렴 및 불만처리
본 사이트는 개인정보보호와 관련하여 귀하가 의견과 불만을 제기할 수 있는 창구를 개설하고 있습니다. 개인정보와 관련한 불만이 있으신 분은 본 사이트의 개인정보 최고 관리책임자에게 의견을 주시면 접수 즉시 조치하여 처리결과를 통보해 드립니다.
1) 개인정보 최고 관리책임자는 회사의 대표가 직접 맡아서 개인정보에 대한 강조를 하고 있습니다. 개인정보를 보호하고 유출을 방지하는 책임자로서 이용자가 안심하고 회사가 제공하는 서비스를 이용할 수 있도록 도와드리며, 개인정보를 보호하는데 있어 이용자에게 고지한 사항들에 반하여 사고가 발생할 시에는 이에 관한 책임을 집니다.
2) 기술적인 보완조치를 취하였음에도 불구하고 악의적인 해킹 등 기본적인 네트워크상의 위험성에 의해 발생하는 예기치 못한 사고로 인한 정보의 훼손 및 멸실, 이용자가 작성한 게시물에 의한 각종 분쟁 등에 관해서는, 본 사이트 회사는 책임이 없습니다.
3) 회사는 정보통신망 이용촉진 및 정보보호 등에 관한 법률에서 규정한 관리책임자를 다음과 같이 지정합니다.
개인정보 최고 관리책임자 성명 :
전화번호 :
이메일 :

또는 개인정보침해에 대한 신고나 상담이 필요하신 경우에는 아래 기관에 문의하시기 바랍니다.
개인분쟁조정위원회 (www.1336.or.kr / 1336)
정보보호마크인증위원회 (www.eprivacy.or.kr / 02-580-0533~4)
대검찰청 인터넷범죄수사센터 (icic.sppo.go.kr / 02-3480-3600)
경찰청 사이버테러대응센터 (www.ctrc.go.kr / 02-392-0330)

15. 부 칙(시행일)

현 개인정보처리방침은 2017년 9월 22일에 제정되었으며, 정부 및 회사의 정책 또는 보안기술의 변경에 따라 내용의 추가, 삭제 및 수정이 있을 경우에는 개정 최소 7일 전부터 ‘공지사항’란을 통해 고지하며, 본 정책은 시행 일자에 시행됩니다.
1) 공고일자 : 2018년 05월 01일
2) 시행일자 : 2018년 05월 01일 </textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    //modal
    $(document).ready(function () {
        // Open modal
        $("#ai_name").click(function () {
            $("#myUploadModal").fadeIn();
            $("#modalname").val("");
            $("#loadingbox").html("");
            $("#searchbox").html("");
            $("#countbox").html("학원명을 입력해 주세요");
            $("#modalname").focus();
        });

        $("#detailone").click(function () {
            $("#myAgreementModalOne").fadeIn();
        });

        $("#detailtwo").click(function () {
            $("#myAgreementModalTwo").fadeIn();
        });

        //esc
        $(document).keyup(function (e) {
            if (e.keyCode == 27) {
                $(".close").click();
            }
        });

        // Close modal
        $(".close").click(function () {
            $("#myUploadModal").fadeOut();
            $("#myAgreementModalOne").fadeOut();
            $("#myAgreementModalTwo").fadeOut();
        });

        $("#uploadpopupbox").click(function () {
            $(this).hide();
            $("#dropbox").slideDown();
        });

        $("#sizetxt").click(function () {
            $("#dropbox").slideUp(function () {
                $("#uploadpopupbox").show();
            });
        });
    });

    let emailvalid = false;
    let emailcheck = false;
    let emailcode = false;
    let passvalid = false;
    let passcheck = false;
    let nickvalid = false;
    let nickname = false;
    let namevalid = false;
    let phonevalid = false;
    let acacheck = false;
    let chkbtnall = false;
    let chkbtnone = false;
    let chkbtntwo = false;

    //agreement
    $("#agreementall").click(function () {
        chkbtnall = !chkbtnall;
        $("#acceptall").toggle(chkbtnall);
        $("#denyall").toggle(!chkbtnall);

        if (chkbtnall) {
            chkbtnone = true;
            chkbtntwo = true;
            $("#acceptone").show();
            $("#denyone").hide();
            $("#accepttwo").show();
            $("#denytwo").hide();
        } else {
            chkbtnone = false;
            chkbtntwo = false;
            $("#acceptone").hide();
            $("#denyone").show();
            $("#accepttwo").hide();
            $("#denytwo").show();
        }
        console.log(chkbtnall);
    });

    $("#chkbtnone").click(function () {
        chkbtnone = !chkbtnone;
        $("#acceptone").toggle(chkbtnone);
        $("#denyone").toggle(!chkbtnone);

        if (chkbtnone && chkbtntwo) {
            chkbtnall = true;
            $("#acceptall").show();
            $("#denyall").hide();
        } else {
            chkbtnall = false;
            $("#acceptall").hide();
            $("#denyall").show();
        }
        console.log(chkbtnall);
    });

    $("#chkbtntwo").click(function () {
        chkbtntwo = !chkbtntwo;
        $("#accepttwo").toggle(chkbtntwo);
        $("#denytwo").toggle(!chkbtntwo);

        if (chkbtnone && chkbtntwo) {
            chkbtnall = true;
            $("#acceptall").show();
            $("#denyall").hide();
        } else {
            chkbtnall = false;
            $("#acceptall").hide();
            $("#denyall").show();
        }
        console.log(chkbtnall);
    });

    //emailcheck
    $("#m_email").keyup(function () {
        let m_email = $(this).val();
        if (!validEmail(m_email)) {
            $("#emailchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "이메일을 확인 해주세요");
            emailvalid = false;
        } else {
            $.ajax({
                type: "get",
                url: "emailchk",
                dataType: "json",
                data: {"m_email": m_email},
                success: function (res) {
                    if (res.result == "yes") {
                        $("#emailchkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                            "사용 가능한 Email 입니다");
                        emailcheck = true;
                    } else {
                        $("#emailchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                            "이미 사용중인 E-mail입니다");
                        $("#sendemail").prop("disabled", true);
                        emailcheck = false;
                    }
                }
            });
            emailvalid = true;
        }
    });

    //timer
    let timer = null;
    let proc = false;

    function startTimer(count, display) {
        let min, sec;
        timer = setInterval(function () {
            min = parseInt(count / 60, 10);
            sec = parseInt(count % 60, 10);

            min = min < 10 ? "0" + min : min; //0붙이기
            sec = sec < 10 ? "0" + sec : sec;

            display.html(min + ":" + sec);

            //타이머 끝
            if (--count < 0) {
                clearInterval(timer);
                display.html("시간초과");
                $("#eregbtn").prop("disabled", true);
                proc = false;
            }
        }, 1000);
        proc = true;
    }

    //setup
    let display = $("#timer");
    let timeleft = 180;

    //email check
    $(document).on("keyup", "#m_email", function () {
        let email = $("#m_email").val();
        if (!validEmail(email)) {
            $("#sendemail").prop("disabled", true);
        } else {
            $("#sendemail").prop("disabled", false);
        }
    });

    //reset email
    btncnt = 0;
    $(document).on("click", "#reseticon", function () {
        if (btncnt < 2) {
            $.ajax({
                type: "get",
                url: "resetcheck",
                cache: false,
                success: function (res) {
                    if (res == "yes") {
                        Swal.fire({
                            icon: "warning",
                            title: "이메일을 수정 하시겠어요?",
                            text: "기존에 발송된 인증번호는 더이상 사용하실 수 없습니다.",

                            showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
                            confirmButtonColor: '#8007AD', // confrim 버튼 색깔 지정
                            cancelButtonColor: '#bdbebd', // cancel 버튼 색깔 지정
                            confirmButtonText: '확인', // confirm 버튼 텍스트 지정
                            cancelButtonText: '취소', // cancel 버튼 텍스트 지정

                            reverseButtons: true // 버튼 순서 거꾸로
                        }).then(result => {
                            if (result.isConfirmed) {
                                clearInterval(timer);
                                display.html("03:00");
                                $("#eregnumber").val("");
                                $("#reseticon").hide();
                                $(".emailreg").hide();
                                $("#sendemail").html("인&nbsp;증&nbsp;요&nbsp;청");
                                $("#m_email").prop("readonly", false);
                                $("#eregbtn").prop("disabled", false);
                                ecnt = 0;
                                btncnt++;
                                emailcode = false;
                            }
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: '최대 수정 횟수를 초과했습니다',
                            text: '잠시 후 다시 시도해주세요',

                            confirmButtonText: '확인',
                            confirmButtonColor: '#8007AD'
                        });
                        return false;
                    }
                }
            });
        } else {
            Swal.fire({
                icon: 'error',
                title: '최대 수정 횟수를 초과했습니다',
                text: '잠시 후 다시 시도해주세요',

                confirmButtonText: '확인',
                confirmButtonColor: '#8007AD'
            });
            $.ajax({
                type: "get",
                url: "blockreset",
                cache: false,
                success: function (res) {
                }
            });
            return false;
        }
    });

    let ecode = "";
    let ecnt = 0;
    $(document).on("click", "#sendemail", function () {
        $("#m_email").prop("readonly", true);
        let email = $("#m_email").val();
        display = $("#timer");
        timeleft = 180;
        if (ecnt == 0) {
            $.ajax({
                type: "get",
                url: "blockcheck",
                cache: false,
                success: function (res) {
                    if (res == "yes") {
                        Swal.fire({
                            icon: 'success',
                            title: '인증번호가 발송되었습니다',
                            confirmButtonText: '확인',
                            confirmButtonColor: '#8007AD'
                        });
                        $.ajax({
                            type: "get",
                            url: "sendemail?email=" + email,
                            cache: false,
                            success: function (res) {
                                ecode = res;
                                ecnt++;
                            }
                        });
                        $("#reseticon").show();
                        $(".emailreg").show();
                        $("#sendemail").html("재&nbsp;발&nbsp;송");

                        if (proc) {
                            clearInterval(timer);
                            display.html("03:00");
                            startTimer(timeleft, display);
                        } else {
                            startTimer(timeleft, display);
                        }
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: '최대 발급 횟수를 초과했습니다',
                            text: '잠시 후 다시 시도해주세요',
                            confirmButtonText: '확인',
                            confirmButtonColor: '#8007AD'
                        });
                        return false;
                    }
                }
            });
        } else if (ecnt > 0 && ecnt < 3) {
            Swal.fire({
                icon: "warning",
                title: "인증번호를 재발급 받으시겠어요?",
                text: "기존에 발송된 인증번호는 더이상 사용하실 수 없습니다.",

                showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
                confirmButtonColor: '#8007AD', // confrim 버튼 색깔 지정
                cancelButtonColor: '#bdbebd', // cancel 버튼 색깔 지정
                confirmButtonText: '확인', // confirm 버튼 텍스트 지정
                cancelButtonText: '취소', // cancel 버튼 텍스트 지정

                reverseButtons: true // 버튼 순서 거꾸로
            }).then(result => {
                if (result.isConfirmed) {
                    $("#eregbtn").prop("disabled", false);
                    let email = $("#m_email").val();
                    Swal.fire({
                        icon: 'success',
                        title: '인증번호가 발송되었습니다',
                        confirmButtonText: '확인',
                        confirmButtonColor: '#8007AD'
                    });
                    $.ajax({
                        type: "get",
                        url: "sendemail?email=" + email,
                        cache: false,
                        success: function (res) {
                            ecnt++;
                            ecode = res;

                            if (proc) {
                                clearInterval(timer);
                                display.html("03:00");
                                startTimer(timeleft, display);
                            } else {
                                startTimer(timeleft, display);
                            }
                        }
                    });
                }
            });
        } else {
            Swal.fire({
                icon: 'error',
                title: '최대 발급 횟수를 초과했습니다',
                text: '잠시 후 다시 시도해주세요',
                confirmButtonText: '확인',
                confirmButtonColor: '#8007AD'
            });
            $.ajax({
                type: "get",
                url: "blocksend",
                cache: false,
                success: function (res) {
                }
            });
            return false;
        }
    });

    $(document).on("click", "#eregbtn", function () {
        if ($("#eregnumber").val() == "") {
            Swal.fire({
                icon: 'warning',
                title: '인증번호를 입력해 주세요',
                confirmButtonText: '확인',
                confirmButtonColor: '#8007AD'
            });
            return false;
        } else {
            if ($("#eregnumber").val() == ecode) {
                Swal.fire({
                    icon: 'success',
                    title: '인증 되었습니다',
                    confirmButtonText: '확인',
                    confirmButtonColor: '#8007AD'
                });
                clearInterval(timer);
                display.html("");
                $("#eregnumber").prop("readonly", true);
                $("#sendemail").prop("disabled", true);
                $("#sendemail").html("<i class='bi bi-check2'></i>")
                $("#eregbtn").prop("disabled", true);
                $("#reseticon").hide();
                emailcode = true;
            } else {
                Swal.fire({
                    icon: 'error',
                    title: '인증번호를 확인 해주세요',
                    confirmButtonText: '확인',
                    confirmButtonColor: '#8007AD'
                });
                $("#eregnumber").val("");
                $("#eregnumber").focus();
                emailcode = false;
            }
        }
    });

    //email pattern
    function validEmail(email) {
        let emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return emailPattern.test(email);
    }

    //pass check
    function updatePasswordStatus() {
        let pass = $("#m_pass").val();
        let passMatch = $("#passchk").val();
        let valid = validPass(pass);

        if (valid) {
            $("#passokicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                "사용 가능한 비밀번호에요");
            passvalid = true;
        } else {
            $("#passokicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "8~16자리 영문 대소문자, 숫자, 특수문자의 조합으로 만들어주세요");
            passvalid = false;
        }

        if (pass != passMatch) {
            $("#passchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "비밀번호와 일치하지 않아요");
            passcheck = false;
        } else {
            $("#passchkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                "비밀번호와 일치해요");
            passcheck = true;
        }

        if (pass == "" && passMatch == "") {
            $("#passchkicon").html("");
        }
    }

    $("#m_pass").keyup(function () {
        updatePasswordStatus();
    });

    $("#passchk").keyup(function () {
        updatePasswordStatus();
    });

    function validPass(pass) {
        let passPattern = /^[a-zA-Z0-9!@#$%^&*()_+\-=[\]{};':"\\|,.<>/?\s]+$/;
        return pass.length >= 8 && pass.length <= 16 && passPattern.test(pass);
    }

    //nickname check
    $("#m_nickname").keyup(function () {
        let m_nickname = $(this).val();

        if (!validNickname(m_nickname)) {
            $("#nicknamechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "2~10자의 한글,영문과 숫자만 사용해주세요");
            nickvalid = false;
        } else {
            $.ajax({
                type: "get",
                url: "nicknamechk",
                dataType: "json",
                data: {"m_nickname": m_nickname},
                success: function (res) {
                    if (res.result == "no") {
                        $("#nicknamechkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                            "멋진 닉네임이네요!");
                        nickname = true;
                    } else {
                        $("#nicknamechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                            "이미 사용중인 닉네임입니다");
                        nickname = false;
                    }
                }
            });
            nickvalid = true;
        }
    });

    function validNickname(nickname) {
        let nickNamePattern = /^[a-zA-Z0-9가-힣]{2,10}$/;
        return nickNamePattern.test(nickname);
    }

    //name check
    $("#m_name").keyup(function () {
        let m_name = $(this).val();
        if (!validName(m_name)) {
            $("#namechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "이름을 확인해 주세요");
            namevalid = false;
        } else {
            $("#namechkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                "멋진 이름이네요!");
            namevalid = true;
        }
    });

    function validName(name) {
        let namePattern = /^[가-힣]+$/;
        return namePattern.test(name);
    }

    //phone check
    $(document).on("keyup", "#m_tele", function () {
        let phonenum = $("#m_tele").val();
        if (!validPhone(phonenum)) {
            $("#telechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "휴대폰 번호를 확인해주세요");
            phonevalid = false;
        } else {
            $("#telechkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                "사용 가능한 휴대폰 번호입니다");
            phonevalid = true;
        }
    });

    function validPhone(phonenum) {
        let phoneNumPattern = /^(010|01[1-9][0-9])-?\d{3,4}-?\d{4}$/;
        return phoneNumPattern.test(phonenum);
    }

    //academy
    $(document).on("keyup", "#modalname", function () {
        let ai_name = $(this).val();
        $.ajax({
            type: "get",
            url: "searchai",
            dataType: "json",
            data: {"ai_name": ai_name},
            success: function (res) {
                let resultList = $("#searchbox");
                resultList.empty();

                if ($("#modalname").val() == "") {
                    $("#loadingbox").html("");
                    $("#countbox").html("");
                    $("#countbox").html("학원명을 입력해주세요");
                } else {
                    let s = "";
                    let count = 0;
                    $.each(res, function (idx, ele) {
                        if (ele.ai_name.includes(ai_name)) {
                            $("#loadingbox").html("");
                            if (count >= 0 && count <= 10) {
                                s += `
                                <div id="acaname">\${ele.ai_name}</div>
                                `;
                                count++;
                            } else {
                                count++;
                            }
                        }
                        if (!ele.ai_name.includes(ai_name) && count == 0) {
                            $("#loadingbox").html("<label><div class='spinner-border spinner-border text-mute'></div>" +
                                "&nbsp;Loading</label>");
                        }
                    });
                    if (count == 0) {
                        $("#countbox").html("검색결과가 없습니다");
                    } else if (count >= 0 && count <= 10) {
                        $("#countbox").html("총" + count + "개의 검색결과");
                    } else {
                        s += "...";
                        $("#countbox").html("총" + count + "개의 검색결과");
                    }
                    resultList.html(s);
                }
            }
        });
    });

    $(document).on("click", "#acaname", function () {
        let txt = $(this).text();
        $("#modalname").val(txt);
        $("#ai_name").val(txt);
        if ($("#ai_name").val() != "") {
            $("#acachkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                "어썸한 학원이군요!");
            acacheck = true;
        } else {
            $("#acachkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "학원 이름을 확인해주세요")
            acacheck = false;
        }
    });

    $(document).on("click", "#acanamebtn", function () {
        let txt = $("#modalname").val();
        $("#ai_name").val(txt);
        $("#myUploadModal").fadeOut();
        if ($("#ai_name").val() != "") {
            $("#acachkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
                "어썸한 학원 출신이시군요!");
            acacheck = true;
        } else {
            $("#acachkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "학원 이름을 확인해주세요")
            acacheck = false;
        }
    });

    // DB에 저장된 데이터 연마전까진 유효성 주석 acavalid=false; 필요

    // $(document).on("click", "#acaname, #acanamebtn", function () {
    //     let ai_name = $("#ai_name").val();
    //     if (!validAcaName(ai_name)) {
    //         $("#acachkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
    //             "학원 이름을 확인해주세요")
    //         acavalid = false;
    //     } else {
    //         $("#acachkicon").html("<i class='bi bi-check' style='color:green;'></i>" +
    //             "어썸한 학원 출신이시군요!");
    //         acavalid = true;
    //     }
    // });

    //academy valid
    // function validAcaName(acaname) {
    //     let acaNamePattern = /^[a-zA-Z0-9가-힣]+$/;
    //     return acaNamePattern.test(acaname);
    // }

    //DnD + Upload
    //upload
    var filesarr = [];

    $(".btnupload").click(function () {
        $("#filebtn").click();
    });

    $(document).on("change", "#filebtn", function (e) {
        var cnt = e.target.files.length;
        var data = e.target.files;

        if (!isValidBtn(data)) {
            return false
        } else {
            var file = Array.prototype.slice.call(data);
            imgpreview(file);
            filesarr = filesarr.concat(file);
            console.log(filesarr.length);
        }

        //유효성
        function isValidBtn(data) {
            //이미지인가?
            for (let i = 0; i < cnt; i++) {
                if (data[i].type.indexOf("image") < 0) {
                    Swal.fire({
                        icon: 'warning',
                        title: '이미지만 업로드 가능합니다',
                        confirmButtonText: '확인',
                        confirmButtonColor: '#8007AD'
                    });
                    return false;
                }
            }

            //클릭 업로드 개수
            if (filesarr.length + cnt > 1) {
                filesarr = [];
            }

            //파일의 사이즈는 20MB
            let totalsize = filestotalsize(filesarr) + filestotalsize(data);
            if (totalsize >= 1024 * 1024 * 50) {
                Swal.fire({
                    icon: 'warning',
                    title: '전체 파일 크기가 50Mb를 초과했습니다',
                    confirmButtonText: '확인',
                    confirmButtonColor: '#8007AD'
                });
                return false;
            }

            return true;
        }
    });

    //DnD
    var doc = document.querySelector("#dropbox");
    var btnupload = doc.querySelector(".btnupload");
    var inputfile = doc.querySelector("input[type='file']");
    var uploadbox = doc.querySelector(".uploadbox");

    //박스안에 drag 들어왔을 경우
    uploadbox.addEventListener("dragenter", function (e) {
        e.preventDefault();
    });

    //박스 안에 drag를 하고있을 경우
    uploadbox.addEventListener("dragover", function (e) {
        e.preventDefault();
        var vaild = e.dataTransfer.types.indexOf('Files') >= 0;
        if (!vaild) {
            this.style.borderColor = 'red';
        } else {
            $(this).css("border-color", "#8007AD");
            $("#dndtext").css("backgroundColor", "#bdbebd");
        }
    });

    //박스 밖으로 Drag가 나갈때
    uploadbox.addEventListener("dragleave", function (e) {
        e.preventDefault();
        $(this).css("border-color", "#bdbebd");
        $("#dndtext").css("backgroundColor", "#8007AD");
    });

    //박스안에서 drag를 drop했을떄
    uploadbox.addEventListener("drop", function (e) {
        e.preventDefault();
        $(this).css("border-color", "#808080");
        var data = e.dataTransfer;

        if (!isValid(data)) {
            return false;
        } else {
            var file = Array.prototype.slice.call(data.files);
            imgpreview(file);
            filesarr = filesarr.concat(file);
            console.log(filesarr.length);
        }
    });

    //preview
    var fileidx = 0;

    function imgpreview(file) {
        file.forEach(function (f) {
            if (!f.type.match("image.*")) {
                Swal.fire({
                    icon: 'warning',
                    title: '이미지만 업로드 가능합니다',
                    confirmButtonText: '확인',
                    confirmButtonColor: '#8007AD'
                });
                return;
            }

            if (filesarr.length == 0) {
                $("#divimgbox").html("");
            }
            var reader = new FileReader();
            var s = "";
            reader.onload = function (e) {
                f.index = fileidx
                s += "<div id='box" + fileidx + "' style='float:left; position: relative;'>";
                s += "<div class='imgbox'>";
                s += "<img src='" + e.target.result + "' class='img-thumbnail imgpreview'>";
                s += "<i class='bi bi-dash-circle previewdelbtn' onclick='deletefile(\"" + fileidx + "\")'></i>";
                s += "</div>"
                s += "</div>";
                $("#divimgbox").hide().fadeIn("fast");
                $("#divimgbox").append(s);
                fileidx++;
            }
            reader.readAsDataURL(f);
        });
    }

    //del btn anime
    $(document).ready(function () {
        $(document).on("mouseenter", ".imgbox", function () {
            $(this).find(".previewdelbtn").show();
        });

        $(document).on("mouseleave", ".imgbox", function () {
            $(this).find(".previewdelbtn").hide();
        });
    });

    //delete
    function deletefile(index) {
        $("#box" + index).fadeOut("fast", function () {
            $(this).remove();

            let indexToRemove;
            for (let i = 0; i < filesarr.length; i++) {
                if (filesarr[i].index == index) {
                    indexToRemove = i;
                    break;
                }
            }
            if (indexToRemove != undefined) {
                filesarr.splice(indexToRemove, 1);
            }
            console.log(filesarr.length);
            if (filesarr.length == 0) {
                $("#divimgbox").html('<div style="padding-top:40px;">' +
                    '<i class="bi bi-cloud-upload" style="color:#bdbebd; font-size: 55px;"></i>' +
                    '<div style="color:#bdbebd; font-size: 20px; font-weight: bold; margin-bottom: 25px;">' +
                    '나만의 멋진 프로필<br>사진을 올려보세요!</div>' +
                    '<div id="dndtext">Drag & Drop</div></div>').hide().fadeIn("fast");
            }
        });
    }

    //all del button
    $(".alldelbtn").click(function () {
        console.log(fileidx);

        filesarr = [];
        fileidx = 0;

        console.log(filesarr.length);
        if (filesarr.length == 0) {
            $("#divimgbox").html('<div style="padding-top:40px;">' +
                '<i class="bi bi-cloud-upload" style="color:#bdbebd; font-size: 55px;"></i>' +
                '<div style="color:#bdbebd; font-size: 20px; font-weight: bold; margin-bottom: 25px;">' +
                '나만의 멋진 프로필<br>사진을 올려보세요!</div>' +
                '<div id="dndtext">Drag & Drop</div></div>').hide().fadeIn("fast");
        }
    });

    //유효성 검사
    function isValid(data) {
        //파일인가?
        if (data.types.indexOf('Files') < 0)
            return false;

        //이미지인가?
        for (let i = 0; i < data.files.length; i++) {
            if (data.files[i].type.indexOf("image") < 0) {
                Swal.fire({
                    icon: 'warning',
                    title: '이미지만 업로드 가능합니다',
                    confirmButtonText: '확인',
                    confirmButtonColor: '#8007AD'
                });
                return false;
            }
        }

        //파일개수 최대 1개 (filesarr reset)
        if (filesarr.length + data.files.length > 1) {
            filesarr = [];
        }

        //파일의 사이즈는 총 20MB

        let totalsize = filestotalsize(filesarr) + filestotalsize(data.files);
        if (totalsize >= 1024 * 1024 * 50) {
            Swal.fire({
                icon: 'warning',
                title: '전체 파일 크기가 50Mb를 초과했습니다',
                confirmButtonText: '확인',
                confirmButtonColor: '#8007AD'
            });
            return false;
        }
        return true;
    }

    //filestotal size
    function filestotalsize(files) {
        let totalsize = 0;
        for (let i = 0; i < files.length; i++) {
            totalsize += files[i].size;
        }
        return totalsize
    }

    //trigger function
    $(document).on("mouseover keyup", function () {
        if (emailcheck && emailvalid && emailcode && passcheck && passvalid && nickname && nickvalid && namevalid && phonevalid && acacheck && chkbtnall) {
            console.log("true");
        } else {
            $("#submitbtn").prop("disabled", true);
        }
    });

    //submit
    $("#uploadbtn").click(function () {
        if (!emailcheck || !emailvalid) {
            $("#m_email").focus();
            $("#emailchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "이메일을 확인 해주세요");
            return false;
        } else if (!emailcode) {
            $("#m_email").focus();
            Swal.fire({
                icon: 'warning',
                title: '이메일 인증절차를 완료해 주세요',
                confirmButtonText: '확인',
                confirmButtonColor: '#8007AD'
            });
            return false;
        } else if (!passvalid) {
            $("#m_pass").focus();
            $("#passokicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "8~16자리 영문 대소문자, 숫자, 특수문자의 조합으로 만들어주세요");
            return false;
        } else if (!passcheck) {
            $("#passchk").focus();
            $("#passchkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "비밀번호와 일치하지 않아요");
            return false;
        } else if (!namevalid) {
            $("#m_name").focus();
            $("#namechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "이름을 확인해 주세요");
            return false;
        } else if (!phonevalid) {
            $("#m_tele").focus();
            $("#telechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "휴대폰 번호를 확인해주세요");
            return false;
        } else if (!nickname || !nickvalid) {
            $("#m_nickname").focus();
            $("#nicknamechkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "닉네임을 확인해주세요");
            return false;
        } else if (!acacheck) {
            $("#ai_name").focus();
            $("#acachkicon").html("<i class='bi bi-x' style='color:red;'></i>" +
                "학원 이름을 확인해주세요")
            return false;
        } else if (!chkbtnall) {
            Swal.fire({
                icon: 'warning',
                title: '모든 약관에 동의해주세요',
                confirmButtonText: '확인',
                confirmButtonColor: '#8007AD'
            });
            return false;
        } else {
            let formData = new FormData();
            console.log(filesarr);
            console.log(filesarr.length);

            for (i = 0; i < filesarr.length; i++) {
                console.log(filesarr[i]);
                formData.append("upload", filesarr[i]);
            }

            var bar = $('.bar');
            var percent = $('.percent');

            formData.append("m_type", $("#m_type").val());
            formData.append("ai_name", $("#ai_name").val());
            formData.append("m_email", $("#m_email").val());
            formData.append("m_pass", $("#m_pass").val());
            formData.append("m_nickname", $("#m_nickname").val());
            formData.append("m_name", $("#m_name").val());
            formData.append("m_tele", $("#m_tele").val());

            $.ajax({
                xhr: function () {
                    var xhr = new window.XMLHttpRequest();
                    xhr.upload.addEventListener('progress', function (e) {
                        if (e.lengthComputable) {
                            var percentComplete = Math.floor((e.loaded / e.total) * 100);

                            var percentVal = percentComplete + '%';
                            bar.width(percentVal);
                            percent.html(percentVal);
                        }
                    }, false);
                    return xhr;
                },
                type: "post",
                url: "signupform",
                dataType: "text",
                data: formData,
                processData: false,
                contentType: false,
                beforeSend: function () {
                    $("#uploadbtn").prop("disabled", true);
                    $(".progress").fadeIn('fast');
                    var percentVal = '0%';
                    bar.width(percentVal);
                    percent.html(percentVal);
                }, complete: function () {
                    $(".progress").fadeOut('fast');
                },
                success: function () {
                    $("#uploadbtn").prop("disabled", false);
                    location.replace("grats");
                }
            });
        }
    });
</script>
</body>
</html>