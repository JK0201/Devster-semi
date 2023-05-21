
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <style>
        #quanbu{
            width: 1100px;
            margin: 32px auto;
            /*background-color: palegreen;*/
            /*position: relative;*/
        }
        .headbox{
            margin-top: 30px;
        }
        .review_box {
            width: 1100px;
            height: 220px;
            border-radius: 0px;
            float: left;
            /*margin-right: 30px;*/
            /*padding-left: 20px;*/
            padding-top: 24px;
            padding-right: 20px;
        }
        sec
        /*리뷰 별점 css*/
        .star-rb_star {
            /*   border: solid 1px #ccc;*/
            display: flex;
            /*  flex-direction: row-reverse;*/
            font-size: 1.5em;
            justify-content: space-around;
            padding: 0 .2em;
            text-align: center;
            width: 5em;
        }

        .star-rb_star input {
            display: none;
        }

        .star-rb_star label {
            color: #ccc;
            /* cursor: pointer;*/
        }

        .star-rb_star :checked ~ label {
            color: #f90;
        }

        /*회사 별점*/
        .star-ci_star {
            /*   border: solid 1px #ccc;*/
            display: flex;
            /*  flex-direction: row-reverse;*/
            font-size: 1.5em;
            justify-content: space-around;
            padding: 0 .2em;
            text-align: center;
            width: 5em;
        }

        .star-ci_star input {
            display: none;
        }

        .star-ci_star label {
            color: #ccc;
            /* cursor: pointer;*/
        }

        .star-ci_star :checked ~ label {
            color: #f90;
        }

        .star-ci_star_list {
            display: flex;
            /*flex-direction: row-reverse;*/
            font-size: 1.5em;
            justify-content: space-around;
            /*  padding: 0 .2em;*/
            /*      text-align: center;*/
            width: 5em;
            float: left;
            padding-left: 180px;

            margin-top: -25px;

        }

        .star-ci_star_list input {
            display: none;
        }

        /* .star-ci_star_list label {
             color: #ccc;
             cursor: pointer;
             font-size: 1.5em;
         }

         .star-ci_star_list :checked ~ label {
             color: #f90;
         }
 */

        .clear:after { /* 자식이 모두 float 을 사용할때 부모가 높이를 갖게하기 위함 */
            content: "";
            display: block;
            clear: both;

        }

        /*회사 정보 css*/
        .rb_listc {
            border: 0px;
            width: 200px;
            height: 250px;
            float: left;
            margin-right: 20px;
            /*margin-left: 4px;*/
            /*text-align: left;*/

        }


        .imgSelect {
            cursor: pointer;
            width: 150px;
        }

        .popupLayer {
            position: absolute;
            display: none;
            background-color: #ffffff;
            border: solid 2px #d0d0d0;
            width: 350px;
            height: 150px;
            padding: 10px;


        }

        .popupLayer div {
            position: absolute;
            top: 5px;
            right: 5px
        }

        .already-added {
            background-color: lightgrey;
            color: white;

        }

        .star_listc {
            margin-left: 15px;
        }


        .review {
            width: 775px;
            height: auto;
            border-top: 1px solid lightgray;
            border-radius: 0px;
            float: left;
            /*margin-right: 30px;*/
            /*padding-left: 20px;*/
            padding-top: 24px;
            padding-right: 20px;
        }

        .custom-btn {
            color: darkgrey;
            border-color: darkgray;
            height:25px;
            line-height:0.8;
            font-size: 12px;
            border-radius:0%;
        }

        .custom-btn:hover {
            background-color: gray;
            border-color: gray;
        }

        .yetadded {
            border-color: darkgrey;
            color: darkgrey;
            height: 25px;
            padding-bottom: 5px;
            width: 130px;
            font-size: 12px;
            border-radius: 0%;
            line-height:0.8;
        }
        .yetadded:hover{
            background-color: gray;
            border-color:gray;
            color:white;
        }

        .paging {
            margin-left: 220px;
        }


        .memberimg{
            width: 20px;
            height: 20px;
            border-radius: 100px;
        }



    </style>

<script>
    let dynamicVars = {};


    function showCompanyInfo(ci_idx) {
        $.ajax({
            url: "getCompanyInfo",
            type: "GET",
            dataType: "JSON",
            data: {"ci_idx": ci_idx},
            success: function (res) {
                let s = "";
                const formatter = new Intl.NumberFormat('ko-KR', {
                    style: 'currency',
                    currency: 'KRW',
                });
                $.each(res, function (idx, ele) {

                    const ciSalFormatted = formatter.format(ele.ci_sal);
                    let stars = '';
                    for (let i = 1; i <= 5; i++) {
                        stars += `<input type="radio" id="rating${i}" name="rating" value="${i}" \${(i === ele.ci_star) ? 'checked="checked"' : ''} />
                    <label for="rating${i}" class="star" \${(i <= ele.ci_star) ? 'style="color: orange;"' : 'style="color: #ccc;"'}>★</label>`;
                    }
                    s += `
                                  <pre>
                                    회사이름: \${ele.ci_name}
                                    사원수: \${ele.ci_ppl} 명
                                    매출액: \${ele.ci_sale}
                                    평균연봉: \${ciSalFormatted}
                                    Devster 평균별점:
                                    <span class="star-ci_star_list" style="float: left;">
                                      \${stars}
                                    </span>
                                  </pre>
                                `;


                });
                $("div.alist").html(s);
            }
        });
    };

    function closeLayer(obj) {
        $(obj).parent().hide();
    }

    $(function () {
        $('body').on('click', '.imgSelect', function (e) {
            var sWidth = window.innerWidth;
            var sHeight = window.innerHeight;
            var oWidth = $('.popupLayer').width();
            var oHeight = $('.popupLayer').height();

            // 현재 스크롤 위치까지 더해진 클릭 위치를 구합니다.
            var divLeft = e.clientX + window.scrollX + 10;
            var divTop = e.clientY + window.scrollY + 5;

            // 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치합니다.
            if (divLeft + oWidth > sWidth) divLeft -= oWidth;
            if (divTop + oHeight > sHeight) divTop -= oHeight;

            // 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치합니다.
            if (divLeft < 0) divLeft = 0;
            if (divTop < 0) divTop = 0;

            $('.popupLayer').css({
                "top": divTop,
                "left": divLeft,
                "position": "absolute"
            }).show();
        });
    });

</script>


<script>


    <%--삭제 이벤트--%>

    function delreview(rb_idx) {
        if (confirm("삭제하시겠습니까?")) {
            location.href = "./delete?rb_idx=" + rb_idx;
        }
    }

    /*popup 레이어 */

    $(function () {
        /* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
        $('.imgSelect').click(function (e) {
            var sWidth = window.innerWidth;
            var sHeight = window.innerHeight;
            var oWidth = $('.popupLayer').width();
            var oHeight = $('.popupLayer').height();

            // 현재 스크롤 위치까지 더해진 클릭 위치를 구합니다.
            var divLeft = e.clientX + window.scrollX + 10;
            var divTop = e.clientY + window.scrollY + 5;

            // 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치합니다.
            if (divLeft + oWidth > sWidth) divLeft -= oWidth;
            if (divTop + oHeight > sHeight) divTop -= oHeight;

            // 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치합니다.
            if (divLeft < 0) divLeft = 0;
            if (divTop < 0) divTop = 0;

            $('.popupLayer').css({
                "top": divTop,
                "left": divLeft,
                "position": "absolute"
            }).show();
        });
    });


    //리뷰 select 결과만 출력

    function rb_typelist() {
        // 선택한 리뷰 유형 가져오기
        var selectedType = document.getElementById("rb_typelist").value;

        // 모든 리뷰 div 요소 가져오기
        var reviewDivs = document.querySelectorAll(".review");

        // 각 리뷰 div 요소를 반복하며 필터링
        reviewDivs.forEach(function (reviewDiv) {
            // 현재 리뷰의 유형 가져오기
            var reviewType = reviewDiv.getAttribute("data-type");

            // 선택한 유형과 현재 리뷰의 유형이 일치하는 경우 보여주기
            if (reviewType === selectedType || selectedType === "0") {
                reviewDiv.style.display = "block";
            } else {
                reviewDiv.style.display = "none";
            }
        });
    }


</script>



<script>
    <%--    현재 버튼이 눌려있는지 확인해서 상태에 따라 버튼에 색상표시  --%>

    function checkAddRpBefore(rb_idx, isAlreadyAddGoodRp, isAlreadyAddBadRp) {
        <!-- 변수값에 따라 각 id가 부여된 버튼에 클래스 추가(이미 눌려있다는 색상 표시) -->
        if (isAlreadyAddGoodRp == true) {
            $("#add-goodRp-btn" + rb_idx).addClass("already-added");
        } else if (isAlreadyAddBadRp == true) {
            $("#add-badRp-btn" + rb_idx).addClass("already-added");
        } else {
            return;
        }
        $(function () {
            checkAddRpBefore();
        });
    };

    function message(nickname) {
        window.open("other_profile?other_nick=" + nickname, 'newwindow', 'width=700,height=700');
    }
</script>



<div id="quanbu">

    <div class="rb_listmain clear">
        <!--===============================Headbox==============================================-->

        <div class="headbox">
            <h4 class="boardname">
                <div class="yellowbar">&nbsp;</div>&nbsp;&nbsp;리뷰게시판
            </h4>

            <!-- 검색창 -->
            <div class="searchdiv">
                <select id="searchOption" class="form-select">
                    <option id="all" value="all">전체검색</option>
                    <option id="searchnickname" value="m_nickname">작성자 검색</option>
                    <option id="searchsubject" value="rb_subject">제목 검색</option>
                    <option id="searchtype" value="rb_type">(면접/코딩/합격)</option>
                </select>
                <input id="searchinput" name="keyword" type="search" placeholder="관심있는 내용을 검색해보세요!" autocomplete="off"
                       class="searchbar">
            </div>
        </div>

        <!--=============================================================================-->

        <!--=============================================================================-->

        <div class="noticeboard_part">
            <ul class="clear noticelist">
                <c:if test="${NoticeBoardTotalCount>0}">
                    <c:forEach var="dto" items="${nblist}">

                        <li>
                            <b class="noticetitle">Devster 공지사항</b>
                            <a href="../noticeboard/noticeboarddetail?nb_idx=${dto.nb_idx}&currentPage=${currentPage}">
                                    ${dto.nb_subject}
                                <c:if test="${dto.nb_photo!='n'}">
                                    &nbsp; <i class="bi bi-images"></i>
                                </c:if>
                            </a>
                        </li>
                    </c:forEach>
                </c:if>
            </ul>
        </div>

        <!--=============================================================================-->
        <%--검색--%>

        <script>
            // 검색 여부 전역변수
            var isSearch = false;


            $("#searchinput").keydown(function (e) {


                if (e.keyCode == 13) {

                    isSearch = true;

                    // 검색내용
                    var keyword = $(this).val();
                    var searchOption = $("#searchOption").val();

                    // 타입 select시 값 변환 (전체에서도 검색할수있어서 일단 어쩔수없음)
                    if(keyword == "면접"){
                        keyword = 1;
                    } else if (keyword == "코딩"){
                        keyword = 2;
                    } else if (keyword == "합격"){
                        keyword = 3;
                    }

                    console.log(keyword);
                    console.log(searchOption);

                    var currentpage = 1;
                    var isLoading = false;
                    var noMoreData = false;


                    // null 값 검색시 -> 아무일도 안일어남
                    if (keyword == '') {
                        alert("검색하실 내용을 입력해주세요.")
                        isSearch = false;
                        return
                    } else {
                       // 기본출력
                        $.ajax({
                            type: "post",
                            url: "./reviewboardsearchlist",
                            data: {"keyword": keyword, "searchOption": searchOption, "currentpage": currentpage},
                            dataType: "json",
                            beforeSend: function () {
                                $("#loading").show();
                            },
                            complete: function () {
                                isLoading = false;
                            },
                            success: function (res) {
                                console.log(currentpage);
                                console.log(noMoreData);

                                if (res.length == 0) {
                                    alert("검색 결과가 없습니다.");
                                    isSearch = false;
                                    noMoreData = true;
                                    $("#loading").hide();
                                } else {
                                    setTimeout(function () {
                                        currentpage++;
                                        var s = '';
                                        $.each(res, function (idx, dto) {
                                            s += `<div class="review" data-type="\${dto.rb_type}">`;
                                            s += `<div class="rb_listc">`;
                                            s += `<p><img class="imgSelect" src="\${dto.ci_photo}" data-ci-idx="\${dto.ci_idx}" onclick="showCompanyInfo('\${dto.ci_idx}')"/></p>`;
                                            s += `<div class="star_listc">&nbsp;<span> 별점 : \${dto.rb_star} . 0 </span>`;
                                            s += `<div class="star-rb_star">`;
                                            for (let i = 1; i <= 5; i++) {
                                                s += `<input type="radio" id="rating${i}" name="rating" value="${i}" \${i == dto.rb_star ? 'checked="checked"' : ''} />`;
                                                s += `<label for="rating${i}" class="star" \${i <= dto.rb_star ? 'style="color: orange;"' : ''}>★</label>`;
                                            }
                                            s += `</div></div></div>`;
                                            s += `<div class="rb_listm">`;
                                            s += `<br><h5>리뷰 종류 : \${dto.rb_type == 1 ? "면접" : dto.rb_type == 2 ? "코딩테스트": dto.rb_type == 3 ? "합격후기" : ""}</h5>`;
                                            s += `<p style="color:darkgrey"><img src="\${dto.m_photo}" class="memberimg">&nbsp;  <span style="cursor:pointer;" onclick=message("\${dto.nickName}")>\${dto.nickName}</span> &nbsp;&nbsp; 작성시간 : \${dto.rb_writeday}</p>`;
                                            s += `<h5>내용 : <br></h5>`;
                                            s += `<p><pre>\${dto.rb_content}</pre></p>`;
                                            // sessionScope.memidx에 해당하는 값 필요
                                            let m_idx = "${sessionScope.memidx}";
                                            s += `<div class="fncbtn" style="text-align:right;">`;

                                            if (dto.isAlreadyAddGoodRp==true){
                                                s += `&nbsp;<span class="btn btn-outline add-goodRp-btn already-added yetadded" id="add-goodRp-btn\${dto.rb_idx}"  style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👍도움이 돼요( <span class="add-goodRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px">\${dto.rb_like}</span>&nbsp;)</span>`;
                                                s += `&nbsp;<span class="ml-5 btn btn-outline add-badRp-btn yetadded" id="add-badRp-btn\${dto.rb_idx}" style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👎불필요해요( <span class="add-badRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px" >\${dto.rb_dislike}</span>&nbsp;)</span>`;

                                            }else if(dto.isAlreadyAddBadRp==true){
                                                s += `&nbsp;<span class="btn btn-outline add-goodRp-btn yetadded" id="add-goodRp-btn\${dto.rb_idx}"  style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👍도움이 돼요( <span class="add-goodRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px">\${dto.rb_like}</span>&nbsp;)</span>`;
                                                s += `&nbsp;<span class="ml-5 btn btn-outline add-badRp-btn already-added yetadded" id="add-badRp-btn\${dto.rb_idx}" style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👎불필요해요( <span class="add-badRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px" >\${dto.rb_dislike}</span>&nbsp;)</span>`;
                                            }else{
                                                s += `&nbsp;<span class="btn btn-outline add-goodRp-btn yetadded" id="add-goodRp-btn\${dto.rb_idx}"  style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👍도움이 돼요( <span class="add-goodRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px">\${dto.rb_like}</span>&nbsp;)</span>`;
                                                s += `&nbsp;<span class="ml-5 btn btn-outline add-badRp-btn yetadded" id="add-badRp-btn\${dto.rb_idx}" style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👎불필요해요( <span class="add-badRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px" >\${dto.rb_dislike}</span>&nbsp;)</span>`;
                                            }
                                            if (dto.m_idx == m_idx) {
                                                s += `&nbsp;<button type="button" class="btn btn-sm btn-outline-primary custom-btn" onclick="location.href='./updateform?rb_idx=\${dto.rb_idx}'" style="margin-bottom: 10px">글 수정</button>`;
                                                s += `&nbsp;<button type="button" class="btn btn-sm btn-outline-primary custom-btn" onclick="delreview(\${dto.rb_idx})" style="margin-bottom: 10px">글 삭제</button>`;
                                            }
                                            s += `</div><br></div></div>`;
                                        })

                                        $(".review_box").html(s);
                                        $("#loading").hide();

                                    }, 1000);  // 1초 후에 실행
                                }

                            },

                            error: function (xhr, status, error) {
                                // 요청이 실패했을 때의 처리 로직
                                console.log("Error:", error);
                            }
                        });

                        // 추가 리스트 출력 (스크롤)
                        $(window).scroll(function () {

                            if (Math.floor($(window).scrollTop()) == $(document).height() - $(window).height()) {

                                if (!isLoading && !noMoreData) {
                                    isLoading = true;
                                    let nextPage = currentpage;
                                    $.ajax({
                                        type: "post",
                                        url: "./reviewboardsearchlist",
                                        data: {"keyword": keyword, "searchOption": searchOption, "currentpage": nextPage},
                                        dataType: "json",
                                        beforeSend: function () {
                                            $("#loading").show();
                                        },
                                        complete: function () {
                                            isLoading = false;
                                        },
                                        success: function (res) {
                                            console.log(currentpage);
                                            console.log(noMoreData);
                                            console.log(res.length);
                                           /* alert("추가리스트 출력.");*/
                                            if (res.searchCount == 0) {
                                                noMoreData = true;
                                                $("#loading").hide();
                                            } else {
                                                if (res.length == 0) {
                                                    noMoreData = true;
                                                    $("#loading").hide();
                                                } else {
                                                    setTimeout(function () {
                                                        currentpage++;
                                                        var s = '';
                                                        $.each(res, function (idx, dto) {
                                                            s += `<div class="review" data-type="\${dto.rb_type}">`;
                                                            s += `<div class="rb_listc">`;
                                                            s += `<p><img class="imgSelect" src="\${dto.ci_photo}" data-ci-idx="\${dto.ci_idx}" onclick="showCompanyInfo('\${dto.ci_idx}')"/></p>`;
                                                            s += `<div class="star_listc">&nbsp;<span> 별점 : \${dto.rb_star} . 0 </span>`;
                                                            s += `<div class="star-rb_star">`;
                                                            for (let i = 1; i <= 5; i++) {
                                                                s += `<input type="radio" id="rating${i}" name="rating" value="${i}" \${i == dto.rb_star ? 'checked="checked"' : ''} />`;
                                                                s += `<label for="rating${i}" class="star" \${i <= dto.rb_star ? 'style="color: orange;"' : ''}>★</label>`;
                                                            }
                                                            s += `</div></div></div>`;
                                                            s += `<div class="rb_listm">`;
                                                            s += `<br><h5>리뷰 종류 : \${dto.rb_type == 1 ? "면접" : dto.rb_type == 2 ? "코딩테스트": dto.rb_type == 3 ? "합격후기" : ""}</h5>`;
                                                            s += `<p style="color:darkgrey"><img src="\${dto.m_photo}" class="memberimg">&nbsp;  <span style="cursor:pointer;" onclick=message("\${dto.nickName}")>\${dto.nickName}</span> &nbsp;&nbsp; 작성시간 : \${dto.rb_writeday}</p>`;
                                                            s += `<h5>내용 : <br></h5>`;
                                                            s += `<p><pre>\${dto.rb_content}</pre></p>`;
                                                            // sessionScope.memidx에 해당하는 값 필요
                                                            let m_idx = "${sessionScope.memidx}";
                                                            s += `<div class="fncbtn" style="text-align:right;">`;

                                                            if (dto.isAlreadyAddGoodRp==true){
                                                                s += `&nbsp;<span class="btn btn-outline add-goodRp-btn already-added yetadded" id="add-goodRp-btn\${dto.rb_idx}"  style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👍도움이 돼요( <span class="add-goodRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px">\${dto.rb_like}</span>&nbsp;)</span>`;
                                                                s += `&nbsp;<span class="ml-5 btn btn-outline add-badRp-btn yetadded" id="add-badRp-btn\${dto.rb_idx}" style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👎불필요해요( <span class="add-badRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px" >\${dto.rb_dislike}</span>&nbsp;)</span>`;

                                                            }else if(dto.isAlreadyAddBadRp==true){
                                                                s += `&nbsp;<span class="btn btn-outline add-goodRp-btn yetadded" id="add-goodRp-btn\${dto.rb_idx}"  style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👍도움이 돼요( <span class="add-goodRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px">\${dto.rb_like}</span>&nbsp;)</span>`;
                                                                s += `&nbsp;<span class="ml-5 btn btn-outline add-badRp-btn already-added yetadded" id="add-badRp-btn\${dto.rb_idx}" style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👎불필요해요( <span class="add-badRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px" >\${dto.rb_dislike}</span>&nbsp;)</span>`;
                                                            }else{
                                                                s += `&nbsp;<span class="btn btn-outline add-goodRp-btn yetadded" id="add-goodRp-btn\${dto.rb_idx}"  style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👍도움이 돼요( <span class="add-goodRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px">\${dto.rb_like}</span>&nbsp;)</span>`;
                                                                s += `&nbsp;<span class="ml-5 btn btn-outline add-badRp-btn yetadded" id="add-badRp-btn\${dto.rb_idx}" style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👎불필요해요( <span class="add-badRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px" >\${dto.rb_dislike}</span>&nbsp;)</span>`;
                                                            }
                                                            if (dto.m_idx == m_idx) {
                                                                s += `&nbsp;<button type="button" class="btn btn-sm btn-outline-primary custom-btn" onclick="location.href='./updateform?rb_idx=\${dto.rb_idx}'" style="margin-bottom: 10px">글 수정</button>`;
                                                                s += `&nbsp;<button type="button" class="btn btn-sm btn-outline-primary custom-btn" onclick="delreview(\${dto.rb_idx})" style="margin-bottom: 10px">글 삭제</button>`;
                                                            }
                                                            s += `</div><br></div></div>`;

                                                        })

                                                        $(".review_box").append(s);
                                                        $("#loading").hide();

                                                    }, 1000);  // 1초 후에 실행
                                                }
                                            }
                                        },

                                        error: function (xhr, status, error) {
                                            // 요청이 실패했을 때의 처리 로직
                                            console.log("Error:", error);
                                        }
                                    });
                                }
                            }
                        })
                    }
                }
            });

        </script>
<%--        <select id="rb_typelist" onchange="rb_typelist()">--%>
<%--            <option value="0">전체보기</option>--%>
<%--            <option value="1">면접</option>--%>
<%--            <option value="2">코딩테스트</option>--%>
<%--            <option value="3">합격후기</option>--%>
<%--        </select>--%>

        <div class="review_box">

            <c:forEach var="dto" items="${list}" varStatus="i">

                <script>

                    <%--    현재 버튼이 눌려있는지 확인해서 상태에 따라 버튼에 색상표시  --%>
                    function checkAddRpBefore() {
                        <!-- 변수값에 따라 각 id가 부여된 버튼에 클래스 추가(이미 눌려있다는 색상 표시) -->
                        if (isAlreadyAddGoodRp${dto.rb_idx} == true) {
                            $("#add-goodRp-btn"+${dto.rb_idx}).addClass("already-added");
                        } else if (isAlreadyAddBadRp${dto.rb_idx} == true) {
                            $("#add-badRp-btn"+${dto.rb_idx}).addClass("already-added");
                        } else {
                            return;
                        }
                        $(function() {
                            checkAddRpBefore();
                        });
                    };

                </script>




            <div class="review" data-type="${dto.rb_type}">
                <div class="rb_listc">
                        <p>
                            <img class="imgSelect" src="${dto.ci_photo}" data-ci-idx="${dto.ci_idx}"
                                 onclick="showCompanyInfo('${dto.ci_idx}')"/>
                        </p>
                    <div class="star_listc">
                            &nbsp;<span>  ${dto.rb_star} . 0</span>
                            <div class="star-rb_star">
                                <c:forEach var="i" begin="1" end="5">
                                    <input type="radio" id="rating${i}" name="rating" value="${i}"
                                           <c:if test="${i eq dto.rb_star}">checked="checked"</c:if> />
                                    <label for="rating${i}" class="star"
                                           <c:if test="${i le dto.rb_star}">style="color: orange;"</c:if>>★</label>
                                </c:forEach>
                    </div>

                </div>


            </div>

            <div class="rb_listm">

                        <br>
                        <h5>리뷰 종류
                            : ${dto.rb_type == 1 ? "면접" : dto.rb_type == 2 ? "코딩테스트": dto.rb_type == 3 ? "합격후기" : ""}</h5>
                        <p style="color:darkgrey" >
                            <img src="${dto.m_photo}" class="memberimg">&nbsp;<span style="cursor:pointer;" onclick=message("${dto.nickName}")>${dto.nickName}</span>
                            &nbsp;&nbsp; 작성시간 : ${dto.rb_writeday}</p>

                        <h5>내용 : <br>

                        </h5>
                        <p>
                        <pre>${dto.rb_content}</pre>
                        </p>

                  <div class="fncbtn" style="text-align:right;">
                          <%--            좋아요 / 싫어요 버튼--%>
                      <span id="add-goodRp-btn${dto.rb_idx}" class="btn btn-outline yetadded"
                            style="margin-bottom: 10px">
                       👍 도움이 돼요(
                      <span class="add-goodRp${dto.rb_idx} ml-2 " style="margin-bottom: 10px">${dto.rb_like}</span>
                      )
                      </span>
                      <span id="add-badRp-btn${dto.rb_idx}" class="ml-5 btn btn-outline yetadded"
                            style="margin-bottom: 10px">
                       👎 불필요해요(
                      <span class="add-badRp${dto.rb_idx} ml-2" style="margin-bottom: 10px">${dto.rb_dislike}</span>
                      )
                      </span>
                            <c:set var="m_idx" value="${sessionScope.memidx}"/>
                            <c:if test="${dto.m_idx eq m_idx}">
                                <button type="button" class="btn btn-sm btn-outline-primary custom-btn"
                                        onclick="location.href='./updateform?rb_idx=${dto.rb_idx}'"
                                        style="margin-bottom: 10px">글 수정
                                </button>
                                <button type="button" class="btn btn-sm btn-outline-primary custom-btn"
                                        onclick="delreview(${dto.rb_idx})" style="margin-bottom: 10px">글 삭제
                                </button>
                            </c:if>


                  </div>
                        <br>
            </div>
            </div>

            <script>
                console.log("isAlreadyAddGoodRp : " + ${dto.isAlreadyAddGoodRp});
                console.log("isAlreadyAddBadRp : " + ${dto.isAlreadyAddBadRp});

            var isAlreadyAddGoodRp${dto.rb_idx} = ${dto.isAlreadyAddGoodRp};
            var isAlreadyAddBadRp${dto.rb_idx} = ${dto.isAlreadyAddBadRp};
            checkAddRpBefore();

            </script>

            <script>
                $(document).ready(function() {

                    $("#add-goodRp-btn${dto.rb_idx}").click(function () {

                        if (isAlreadyAddBadRp${dto.rb_idx} == true) {
                            alert('이미 싫어요를 누르셨습니다.');
                            return;
                        }

                        if (isAlreadyAddGoodRp${dto.rb_idx} == false) {
                            $.ajax({
                                url: "/review/increaseGoodRp",
                                type: "POST",
                                data: {
                                    "rb_idx": ${dto.rb_idx},
                                    "m_idx": ${sessionScope.memidx}
                                },
                                success: function (goodReactionPoint) {
                                    $("#add-goodRp-btn${dto.rb_idx}").addClass("already-added");
                                    $(".add-goodRp${dto.rb_idx}").html(goodReactionPoint);
                                    isAlreadyAddGoodRp${dto.rb_idx} = true;

                                },
                                error: function () {
                                    alert('서버 에러, 다시 시도해주세요.');
                                }
                            });

                        } else if (isAlreadyAddGoodRp${dto.rb_idx} == true) {
                            $.ajax({
                                url: "/review/decreaseGoodRp",
                                type: "POST",
                                data: {
                                    "rb_idx": ${dto.rb_idx},
                                    "m_idx": ${sessionScope.memidx}
                                },
                                success: function (goodReactionPoint) {
                                    $("#add-goodRp-btn${dto.rb_idx}").removeClass("already-added");
                                    $(".add-goodRp${dto.rb_idx}").html(goodReactionPoint);
                                    isAlreadyAddGoodRp${dto.rb_idx} = false;
                                },
                                error: function () {
                                    alert('서버 에러, 다시 시도해주세요.');
                                }
                            });
                        } else {
                            return;
                        }
                    });


                    $("#add-badRp-btn${dto.rb_idx}").click(function () {

                        if (isAlreadyAddGoodRp${dto.rb_idx} == true) {
                            alert('이미 좋아요를 누르셨습니다.');
                            return;
                        }

                        if (isAlreadyAddBadRp${dto.rb_idx} == false) {
                            $.ajax({
                                url: "/review/increaseBadRp",
                                type: "POST",
                                data: {
                                    "rb_idx": ${dto.rb_idx},
                                    "m_idx": ${sessionScope.memidx}
                                },
                                success: function (badReactionPoint) {
                                    $("#add-badRp-btn${dto.rb_idx}").addClass("already-added");
                                    $(".add-badRp${dto.rb_idx}").html(badReactionPoint);
                                    isAlreadyAddBadRp${dto.rb_idx} = true;
                                },
                                error: function () {
                                    alert('서버 에러, 다시 시도해주세요.');
                                }
                            });

                        } else if (isAlreadyAddBadRp${dto.rb_idx} == true) {
                            $.ajax({
                                url: "/review/decreaseBadRp",
                                type: "POST",
                                data: {
                                    "rb_idx": ${dto.rb_idx},
                                    "m_idx": ${sessionScope.memidx}
                                },
                                success: function (badReactionPoint) {
                                    $("#add-badRp-btn${dto.rb_idx}").removeClass("already-added");
                                    $(".add-badRp${dto.rb_idx}").html(badReactionPoint);
                                    isAlreadyAddBadRp${dto.rb_idx} = false;
                                },
                                error: function () {
                                    alert('서버 에러, 다시 시도해주세요.');
                                }
                            });
                        } else {
                            return;
                        }
                    });
                });

            </script>


            </c:forEach>
        </div>



    <%--무한스크롤--%>

    <button onclick="topFunction()" id="myBtn" title="Go to top">Top</button>
        <button id="myWriteBtn" type="button" onclick="location.href='./reviewriterform'">글쓰기</button>
    <%--로딩이미지--%>
    <div id="loading"
             style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 9999;">
            <img src="${root}/photo/loading.gif" alt="Loading..."
                 style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">
            <!-- 로딩 이미지의 경로를 설정하세요 -->
    </div>

        <!-- 폼 레이어  -->
    <div class="popupLayer">
        <div onClick="closeLayer(this)" style="cursor:pointer;font-size:1.5em" title="닫기">X</div>
        <div class="alist" style="float: left; margin-right: 150px ;margin-left:30px;">
    </div>

</div>






<%--무한스크롤--%>
<script>
    $(document).ready(function () {

        $(document).on('click', '.imgSelect', function() {
            var ci_idx = $(this).data('ci-idx');  // get the data attribute value
            showCompanyInfo(ci_idx);
        });


        var currentpage = 1;
        var isLoading = false;
        var noMoreData = false;
        // var currentPosition = parseInt($(".quickmenu").css("top"));


        $(window).scroll(function () {
            // var position = $(window).scrollTop();
            // $(".quickmenu").stop().animate({"top": position + currentPosition + "px"}, 1000);

            // 무한스크롤
            if (Math.floor($(window).scrollTop()) == $(document).height() - $(window).height()) {
                if (!isLoading && !noMoreData && !isSearch) {
                    isLoading = true;
                    var nextPage = currentpage + 1;


                    $.ajax({
                        type: "GET",
                        url: "./listajax",
                        data: { currentPage: nextPage },
                        beforeSend: function () {
                            $("#loading").show();
                        },
                        complete: function () {
                            isLoading = false;
                        },
                        success: function (res) {
                            console.log(res);
                            if (res.totalCount == 0) {
                                $(".listbox").append(`<h2 class="alert alert-outline-secondary">등록된 게시글이 없습니다..</h2>`);
                                $("#loading").hide();
                            } else {
                                if (res.length == 0) {
                                    noMoreData = true;
                                    $("#loading").hide();
                                } else {
                                    setTimeout(function () {
                                        currentpage++;
                                        let s = '';
                                        $.each(res, function (idx, dto) {
                                            /*console.log(dto);*/
                                            s += `<div class="review" data-type="\${dto.rb_type}">`;
                                            s += `<div class="rb_listc">`;
                                            s += `<p><img class="imgSelect" src="\${dto.ci_photo}" data-ci-idx="\${dto.ci_idx}" onclick="showCompanyInfo('\${dto.ci_idx}')"/></p>`;
                                            s += `<div class="star_listc">&nbsp;<span> 별점 : \${dto.rb_star} . 0 </span>`;
                                            s += `<div class="star-rb_star">`;
                                            for (let i = 1; i <= 5; i++) {
                                                s += `<input type="radio" id="rating${i}" name="rating" value="${i}" \${i == dto.rb_star ? 'checked="checked"' : ''} />`;
                                                s += `<label for="rating${i}" class="star" \${i <= dto.rb_star ? 'style="color: orange;"' : ''}>★</label>`;
                                            }
                                            s += `</div></div></div>`;
                                            s += `<div class="rb_listm">`;
                                            s += `<br><h5>리뷰 종류 : \${dto.rb_type == 1 ? "면접" : dto.rb_type == 2 ? "코딩테스트": dto.rb_type == 3 ? "합격후기" : ""}</h5>`;
                                            s += `<p style="color:darkgrey"><img src="\${dto.m_photo}" class="memberimg">&nbsp;  <span style="cursor:pointer;" onclick=message("\${dto.nickName}")>\${dto.nickName}</span> &nbsp;&nbsp; 작성시간 : \${dto.rb_writeday}</p>`;
                                            s += `<h5>내용 : <br></h5>`;
                                            s += `<p><pre>\${dto.rb_content}</pre></p>`;
                                            // sessionScope.memidx에 해당하는 값 필요
                                            let m_idx = "${sessionScope.memidx}";
                                            s += `<div class="fncbtn" style="text-align:right;">`;

                                            if (dto.isAlreadyAddGoodRp==true){
                                                s += `&nbsp;<span class="btn btn-outline add-goodRp-btn already-added yetadded" id="add-goodRp-btn\${dto.rb_idx}"  style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👍도움이 돼요( <span class="add-goodRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px">\${dto.rb_like}</span>&nbsp;)</span>`;
                                                s += `&nbsp;<span class="ml-5 btn btn-outline add-badRp-btn yetadded" id="add-badRp-btn\${dto.rb_idx}" style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👎불필요해요( <span class="add-badRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px" >\${dto.rb_dislike}</span>&nbsp;)</span>`;

                                            }else if(dto.isAlreadyAddBadRp==true){
                                                s += `&nbsp;<span class="btn btn-outline add-goodRp-btn yetadded" id="add-goodRp-btn\${dto.rb_idx}"  style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👍도움이 돼요( <span class="add-goodRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px">\${dto.rb_like}</span>&nbsp;)</span>`;
                                                s += `&nbsp;<span class="ml-5 btn btn-outline add-badRp-btn already-added yetadded" id="add-badRp-btn\${dto.rb_idx}" style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👎불필요해요( <span class="add-badRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px" >\${dto.rb_dislike}</span>&nbsp;)</span>`;
                                            }else{
                                                s += `&nbsp;<span class="btn btn-outline add-goodRp-btn yetadded" id="add-goodRp-btn\${dto.rb_idx}"  style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👍도움이 돼요( <span class="add-goodRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px">\${dto.rb_like}</span>&nbsp;)</span>`;
                                                s += `&nbsp;<span class="ml-5 btn btn-outline add-badRp-btn yetadded" id="add-badRp-btn\${dto.rb_idx}" style="margin-bottom: 10px" data-isalreadyaddgoodrp = "\${dto.isAlreadyAddGoodRp}" data-isalreadyaddbadrsp = "\${dto.isAlreadyAddBadRp}">👎불필요해요( <span class="add-badRp\${dto.rb_idx} ml-2" style="margin-bottom: 10px" >\${dto.rb_dislike}</span>&nbsp;)</span>`;
                                            }
                                            if (dto.m_idx == m_idx) {
                                                s += `&nbsp;<button type="button" class="btn btn-sm btn-outline-primary custom-btn" onclick="location.href='./updateform?rb_idx=\${dto.rb_idx}'" style="margin-bottom: 10px">글 수정</button>`;
                                                s += `&nbsp;<button type="button" class="btn btn-sm btn-outline-primary custom-btn" onclick="delreview(\${dto.rb_idx})" style="margin-bottom: 10px">글 삭제</button>`;
                                            }
                                            s += `</div><br></div></div>`;
                                        });
                                        $(".review_box").append(s);
                                        $("#loading").hide();
                                    }, 1000);
                                }
                            }
                        },
                        error: function (xhr, status, error) {
                            console.log("Error:", error);
                            $("#loading").hide();
                        }
                    });
                }
            }





        });
    });




    $(document).on('click', '.add-goodRp-btn', function() {
        let rb_idx = this.id.replace('add-goodRp-btn', '');

        if(dynamicVars[`isAlreadyAddGoodRp\${rb_idx}`] == null && dynamicVars[`isAlreadyAddBadRp\${rb_idx}`] == null) {
            dynamicVars[`isAlreadyAddGoodRp\${rb_idx}`] = $(this).data('isalreadyaddgoodrp');
            dynamicVars[`isAlreadyAddBadRp\${rb_idx}`] = $(this).data('isalreadyaddbadrsp');
            likebuttonCheck(dynamicVars[`isAlreadyAddGoodRp\${rb_idx}`], dynamicVars[`isAlreadyAddBadRp\${rb_idx}`], rb_idx);
        } else {
            likebuttonCheck(dynamicVars[`isAlreadyAddGoodRp\${rb_idx}`], dynamicVars[`isAlreadyAddBadRp\${rb_idx}`], rb_idx);
        }


    });
    $(document).on('click', '.add-badRp-btn', function() {
        let rb_idx = this.id.replace('add-badRp-btn', '');

        if(dynamicVars[`isAlreadyAddGoodRp\${rb_idx}`] == null && dynamicVars[`isAlreadyAddBadRp\${rb_idx}`] == null) {
            dynamicVars[`isAlreadyAddGoodRp\${rb_idx}`] = $(this).data('isalreadyaddgoodrp');
            dynamicVars[`isAlreadyAddBadRp\${rb_idx}`] = $(this).data('isalreadyaddbadrsp');
            dislikebuttonCheck(dynamicVars[`isAlreadyAddGoodRp\${rb_idx}`], dynamicVars[`isAlreadyAddBadRp\${rb_idx}`], rb_idx);
        } else {
            dislikebuttonCheck(dynamicVars[`isAlreadyAddGoodRp\${rb_idx}`], dynamicVars[`isAlreadyAddBadRp\${rb_idx}`], rb_idx);
        }


    });



    // When the user scrolls down 20px from the top of the document, show the button
    window.onscroll = function () {
        scrollFunction()
    };

    function scrollFunction() {
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            document.getElementById("myBtn").style.display = "block";
        } else {
            document.getElementById("myBtn").style.display = "none";
        }
    }

    // When the user clicks on the button, scroll to the top of the document
    function topFunction() {
        document.body.scrollTop = 0; // For Safari
        document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
    }


    function likebuttonCheck(isAlreadyAddGoodRp,isAlreadyAddBadRp,rb_idx) {


        if (isAlreadyAddBadRp == true) {
            alert('이미 싫어요를 누르셨습니다.');
            return;
        }
        if (isAlreadyAddGoodRp == false) {
            $.ajax({
                url: "/review/increaseGoodRp",
                type: "POST",
                data: {
                    "rb_idx": rb_idx,
                    "m_idx": ${sessionScope.memidx}
                },
                success: function (goodReactionPoint) {

                    $("#add-goodRp-btn"+rb_idx).addClass('already-added');
                    $(".add-goodRp"+ rb_idx).html(goodReactionPoint);
                    dynamicVars[`isAlreadyAddGoodRp${rb_idx}`] = true;



                },
                error: function () {
                    alert('서버 에러, 다시 시도해주세요.');
                }
            });
        }else if (isAlreadyAddGoodRp == true){
            $.ajax({
                url : "/review/decreaseGoodRp",
                type : "POST",
                data : {
                    "rb_idx" : rb_idx,
                    "m_idx" : ${sessionScope.memidx}
                },
                success : function(goodReactionPoint) {
                    $("#add-goodRp-btn"+rb_idx).removeClass('already-added');
                    $(".add-goodRp"+ rb_idx).html(goodReactionPoint);
                    dynamicVars[`isAlreadyAddGoodRp${rb_idx}`] = false;


                },
                error : function() {
                    alert('서버 에러, 다시 시도해주세요.');
                }
            });
        } else{
            return;
        };
    };


    function dislikebuttonCheck(isAlreadyAddGoodRp,isAlreadyAddBadRp,rb_idx){


        if (isAlreadyAddGoodRp == true) {
            alert('이미 좋아요를 누르셨습니다.');
            return;
        }

        if (isAlreadyAddBadRp == false) {
            $.ajax({
                url: "/review/increaseBadRp",
                type: "POST",
                data: {
                    "rb_idx": rb_idx,
                    "m_idx": ${sessionScope.memidx}
                },
                success: function (badReactionPoint) {
                    $("#add-badRp-btn"+rb_idx).addClass('already-added');
                    $(".add-badRp"+ rb_idx).html(badReactionPoint);
                    dynamicVars[`isAlreadyAddBadRp${rb_idx}`] = true;
                },
                error: function () {
                    alert('서버 에러, 다시 시도해주세요.');
                }
            });
        }else if (isAlreadyAddBadRp == true){
            $.ajax({
                url : "/review/decreaseBadRp",
                type : "POST",
                data : {
                    "rb_idx" : rb_idx,
                    "m_idx" : ${sessionScope.memidx}
                },
                success : function(badReactionPoint) {
                    $("#add-badRp-btn"+rb_idx).removeClass('already-added');
                    $(".add-badRp"+ rb_idx).html(badReactionPoint);
                    dynamicVars[`isAlreadyAddBadRp${rb_idx}`] = false;
                },
                error : function() {
                    alert('서버 에러, 다시 시도해주세요.');
                }
            });
        } else{
            return;
        };
    };




</script>

