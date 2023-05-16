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

        .head {
            margin-top : 10px;
            text-align : center;
        }
        .head_sentence{
            color : black;
            font-weight : bold;
            font-size: 30px;
        }

        .outerBox {
            width: 1140px;
            margin-top: 100px;
            position : relative;
            border : 1px solid #cccccc;
            margin : 0 auto;
            margin-top : 100px;
        }
        .subject_div {
            border : none;
            border-bottom : 1px solid lightgray;
            width : 90%;
            height : 70px;
            margin : 10px auto;
        }
        .subject {
            border : none;
            font-size : 30px;
        }

        input::-webkit-input-placeholder {
            color: lightgray;
        }
        input:-ms-input-placeholder {
            color: lightgray;
        }

        .content_div {
            border : none;
            width : 90%;
            height : 800px;
            margin : 10px auto;
        }
        .content {
            border : none;
            width : 90%;
            height : 800px;
            font-size : 20px;
            resize : none;
            outline : none;
        }

        textarea::-webkit-input-placeholder {
            color: lightgray;
        }
        textarea:-ms-input-placeholder {
            color: lightgray;
        }

        .file_select {
            display : none;
        }

        .footer {
            background-color : #f6f7fa;
            width: 1135px;
            height : 100px;
        }

        #clickableImage {
            cursor:pointer;
            font-size : 30px;
            margin-left : 20px;
        }

        .buttons {
            position : relative;
            margin-left: 900px;
        }

        .btn_write {
            border : none;
            font-weight : bold;
            font-size : 20px;
            margin-right : 10px;
            background-color : transparent;
        }

        .btn_cancle {
            border : none;
            font-weight : bold;
            font-size : 20px;
            margin-right : 10px;
            background-color : transparent;
        }
    </style>
</head>
<body>

<div class = "outerBox">
    <div class="head">
        <p class = "head_sentence">글쓰기<p>
    </div>
    <hr>
    <form action="insert" enctype="multipart/form-data" method="post">
        <input type="hidden" name="m_idx" value="${sessionScope.memidx}">
        <div class="subject_div">
            <input class="subject" type="text" name="qb_subject" value="" placeholder="제목을 입력해주세요." required>
        </div>
        <div class="content_div">
            <textarea name="qb_content" class="content" placeholder="토픽에 맞지 않는 글로 판단되어 다른 유저로부터 일정 수 이상의 신고를 받는 경우 글이 자동으로 블라인드처리 될 수 있습니다." required></textarea>
        </div>
        <div class="footer">
            <input class="file_select" type="file" name="upload" multiple><br>
            <i class="bi bi-images" id="clickableImage"></i>
            <span class ="buttons">
        <button type="submit" class="btn_write">등록</button>
        <button type="button" class="btn_cancle" onclick="history.back()">취소</button>
          </span>
        </div>
    </form>
</div>
</body>

</html>
