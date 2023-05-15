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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        * {
            margin: 0px;
            padding: 0px;
        }

        #dropbox {
            width: 600px;
            height: 400px;
            cursor: default;
        }

        .uploadbox {
            width: 600px;
            height: 300px;
            border: 3px dashed #808080;
        }

        #dndtext {
            text-align: center;
            background-color: rgb(128, 7, 173);
            font-size: 30px;
            width: 220px;
            height: 50px;
            color: white;
            border-radius: 10px;
            font-weight: bold;
        }
        #sizetxt {
            font-size: 20px;
            float:left;
            margin-left: 5px;
            font-weight: bold;
        }
        .btnupload {
            font-size: 25px;
            float: right;
            margin-right: 15px;
            font-weight: bold;
            cursor: pointer;
        }

        #preview {
            width: 600px;
            height: 200px;
        }

        .imgpreview {
            width: 180px;
            height: 180px;
        }

        .previewdelbtn {
            color: red;
            opacity: 60%;
            font-size: 140px;
            position: absolute;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -60%);
            display: none;
        }
    </style>
</head>
<body>
<button type="button" id="alertStart">버튼</button>
<script>
    $().ready(function () {
        $("#alertStart").click(function () {
            Swal.fire({
                icon: 'success',                         // Alert 타입
                title: 'Devstaer 회원가입 하쉴?',         // Alert 제목
                text: '이곳은 내용이 나타나는 곳입니다.',  // Alert 내용
            });
        });
    });


</script>
//drag and drop

<section id="dropbox">
    <span style="font-weight: bold">UPLOAD</span>
    <div class="uploadbox">
        <input type="file" accept=".jpg, .jpeg, .png, .gif" multiple id="filebtn" class="btn-file d-none">
        <div style="width:600px; height:50px;">
            <span id="sizetxt"><span id="mbsize">0.0</span> / 20Mb</span>
            <i class="bi bi-plus-circle btnupload"></i></div>
        <div id="preview" align="center">
            <i class="bi bi-cloud-upload" style="color:#bdbebd; font-size: 50px;"></i><br>
            <b style="color:#bdbebd; font-size: 15px;">최대 3장이내의 jpeg, jpg, png, gif 파일만 업로드 가능</b>
            <br><br>
            <div id="dndtext">Drag & Drop</div>
        </div>
        <div style="width:600px; height:50px;"></div>
    </div>
    <button type="button" id="submitbtn">submit</button>
</section>
<script>
    var filesarr = [];
    $(".btnupload").mouseover(function () {
        $(this).attr("class", "bi bi-plus-circle-fill btnupload");
        $(this).css("color", "rgb(128, 7, 173)");
    });
    $(".btnupload").mouseout(function () {
        $(this).attr("class", "bi bi-plus-circle btnupload");
        $(this).css("color", "black");
    });

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
            updatetotalsize()
        }

        //유효성
        function isValidBtn(data) {
            //이미지인가?
            for (let i = 0; i < cnt; i++) {
                if (data[i].type.indexOf("image") < 0) {
                    alert("이미지만 업로드 가능합니다");
                    return false;
                }
            }

            //클릭 업로드 개수
            if (filesarr.length + cnt > 3) {
                alert("파일은 최대 3개까지 업로드 가능합니다");
                return false;
            }

            //파일의 사이즈는 20MB
            let totalsize = filestotalsize(filesarr) + filestotalsize(data);
            if (totalsize >= 1024 * 1024 * 20) {
                alert("전체 업로드 파일의 크기가 20MB를 초과하였습니다");
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
            $(this).css("border-color", "rgb(128,7,173)");
            $("#dndtext").css("backgroundColor", "#bdbebd");
        }
    });

    //박스 밖으로 Drag가 나갈때
    uploadbox.addEventListener("dragleave", function (e) {
        e.preventDefault();
        $(this).css("border-color", "#808080");
        $("#dndtext").css("backgroundColor", "rgb(128,7,173)");
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
            updatetotalsize()
        }
    });

    //preview
    var fileidx = 0;

    function imgpreview(file) {
        file.forEach(function (f) {
            if (!f.type.match("image.*")) {
                alert("이미지만 업로드 가능합니다");
                return;
            }

            if (filesarr.length == 0) {
                $("#preview").html("");
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
                s += "<h6>" + f.name + "</h6>";
                s += "</div>";
                $("#preview").hide().fadeIn("fast");
                $("#preview").append(s);
                fileidx++;
            }
            reader.readAsDataURL(f);
        });
    }

    //del btn anime
    $(document).ready(function () {
        $("#preview").on("mouseenter", ".imgbox", function () {
            $(this).find(".previewdelbtn").show();
        });

        $("#preview").on("mouseleave", ".imgbox", function () {
            $(this).find(".previewdelbtn").hide();
        });
    });

    //delete
    function deletefile(index) {
        $("#box" + index).fadeOut("slow", function () {
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
                $("#preview").html('<i class="bi bi-cloud-upload" style="color:#bdbebd; font-size: 50px;"></i>' +
                    '<br><b style="color:#bdbebd; font-size: 15px;">최대 3장이내의 jpeg, jpg, png, gif 파일만 업로드 가능</b>' +
                    '<br><br>' +
                    '<div id="dndtext">Drag & Drop</div>').hide().fadeIn("fast");
            }
            updatetotalsize()
        });
    }

    //유효성 검사
    function isValid(data) {
        //파일인가?
        if (data.types.indexOf('Files') < 0)
            return false;

        //이미지인가?
        for (let i = 0; i < data.files.length; i++) {
            if (data.files[i].type.indexOf("image") < 0) {
                alert("이미지만 업로드 가능합니다");
                return false;
            }
        }

        //파일개수 최대 3개
        if (filesarr.length + data.files.length > 3) {
            alert("파일은 최대 3개까지 업로드 가능합니다");
            return false;
        }

        //파일의 사이즈는 총 20MB

        let totalsize = filestotalsize(filesarr) + filestotalsize(data.files);
        if (totalsize >= 1024 * 1024 * 20) {
            alert("전체 업로드 파일의 크기가 20MB를 초과하였습니다");
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

    //update total size
    function updatetotalsize() {
        let totalsize = filestotalsize(filesarr);
        let mbsize = (totalsize / (1024 * 1024)).toFixed(1);
        $("#mbsize").html(mbsize);
    }

    //submit
    $("#submitbtn").click(function () {
        let formData = new FormData();
        console.log(filesarr);
        console.log(filesarr.length);

        for (i = 0; i < filesarr.length; i++) {
            console.log(filesarr[i]);
            formData.append("upload", filesarr[i]);
        }
        console.log(formData);
        $.ajax({
            type: "post",
            url: "dndtest",
            dataType: "text",
            data: formData,
            processData: false,
            contentType: false,
            success: function () {
                alert("업로드 성공");
            }
        });
    });

</script>
</body>
</html>
