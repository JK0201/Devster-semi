<%--
  Created by IntelliJ IDEA.
  User: JuminManeul
  Date: 2023-05-02
  Time: 오후 4:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="slideShow">
    <div class="slide">
        <ul>
            <li class="i1"><img src="/photo/slide_banner_01.jpg" alt="image1"></li>
            <li class="i2"><img src="/photo/slide_banner_02.jpg" alt="image2"></li>
            <li class="i3"><img src="/photo/slide_banner_03.png" alt="image3"></li>
        </ul>
    </div>

    <div class="slide_btn">
        <ul>
            <li class="indent active">m1</li>
            <li class="indent">m2</li>
            <li class="indent">m3</li>
        </ul>
    </div>


    <div class="side_btn">
        <div class="pre indent">
            <div class="pre_icon"></div>
        </div>
        <div class="nex indent">
            <div class="next_icon"></div>
        </div>
    </div>

</div>

<!--=======================================================스크립트==============================================-->

<script>
    $(document).ready(function () {
        let slideIndex = 0;
        let slideCount = $("#slideShow .slide ul li").length;
        let isHover = false;
        const duration = 3000;

        function slideShow() {
            if (!isHover) {
                slideIndex++;
                if (slideIndex >= slideCount) slideIndex = 0;
                $("#slideShow .slide ul").animate({left: -slideIndex * 1000}, 500);
                setActiveIndicator(slideIndex);
            }
        }

        function setActiveIndicator(index) {
            $("#slideShow .slide_btn ul li").removeClass("active");
            $("#slideShow .slide_btn ul li").eq(index).addClass("active");
        }

        let interval = setInterval(slideShow, duration);

        $("#slideShow").hover(
            function () {
                isHover = true;
            },
            function () {
                isHover = false;
            }
        );

        $("#slideShow .pre").on("click", function () {
            slideIndex--;
            if (slideIndex < 0) slideIndex = slideCount - 1;
            $("#slideShow .slide ul").animate({left: -slideIndex * 1000}, 500);
            setActiveIndicator(slideIndex);
        });

        $("#slideShow .nex").on("click", function () {
            slideIndex++;
            if (slideIndex >= slideCount) slideIndex = 0;
            $("#slideShow .slide ul").animate({left: -slideIndex * 1000}, 500);
            setActiveIndicator(slideIndex);
        });

        $("#slideShow .slide_btn ul li").on("click", function () {
            slideIndex = $(this).index();
            $("#slideShow .slide ul").animate({left: -slideIndex * 1000}, 500);
            setActiveIndicator(slideIndex);
        });
    });
</script>


