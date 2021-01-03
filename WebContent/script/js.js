var width = window.innerWidth;
var height = window.innerHeight;
var body_margin = (width * 15) / 100;
var body_width = (width * 70) / 100;

var banner_index = 2;
var news_index = 2;
var prom_index = 2;
var guide_index = 2;

$(document).ready(function() {
	
    $("body").css("background-size", width + "px " + (height / 2 + 100) + "px");
    
    setInterval(function() {
        changeBanner(banner_index);
        changeWorldNews(news_index);
        changePromotion(prom_index);
        changeGuide(guide_index);
        banner_index++;
        news_index++;
        prom_index++;
        guide_index++;
        if (banner_index == 4) banner_index = 1;
        if (news_index == 4) news_index = 1;
        if (prom_index == 4) prom_index = 1;
        if (guide_index == 4) guide_index = 1;
    }, 3000);
   
});

$(window).resize(function() {
    width = window.innerWidth;
    height = window.innerHeight;
    body_margin = (width * 15) / 100;
    body_width = (width * 70) / 100;
    if (width > 1250) {
        $("body").css("background-size", width + "px " + height / 2+ "px");
    }
});

function changeBanner(index) {
    if (index == 1) {
        $(".index").html(index);  
        $(".banner_first").show();
        $(".banner_second").hide();
        $(".banner_third").hide();
    }
    else if (index == 2) {
        $(".index").html(index);
        $(".banner_first").hide();
        $(".banner_second").show();
        $(".banner_third").hide();
    }
    else if (index == 3) {
        $(".index").html(index);
        $(".banner_first").hide();
        $(".banner_second").hide();
        $(".banner_third").show();
    }
    banner_index = index;
}

function changeWorldNews(index) {
    if (index == 1) {
        $(".news_top_first").css("color", "red");
        $(".news_top_second").css("color", "black");
        $(".news_top_third").css("color", "black");
        $("#newsFirst").css("display", "block");
        $("#newsSecond").css("display", "none");
        $("#newsThird").css("display", "none");
    }
    else if (index == 2) {
        $(".news_top_first").css("color", "black");
        $(".news_top_second").css("color", "red");
        $(".news_top_third").css("color", "black");
        $("#newsFirst").css("display", "none");
        $("#newsSecond").css("display", "block");
        $("#newsThird").css("display", "none");
    }
    else if (index == 3) {
        $(".news_top_first").css("color", "black");
        $(".news_top_second").css("color", "black");
        $(".news_top_third").css("color", "red");
        $("#newsFirst").css("display", "none");
        $("#newsSecond").css("display", "none");
        $("#newsThird").css("display", "block");
    }
    news_index = index;
}

function changePromotion(index) {
    if (index == 1) {
        $(".prom_top_first").css("color", "red");
        $(".prom_top_second").css("color", "black");
        $(".prom_top_third").css("color", "black");
        $("#promotionFirst").css("display", "block");
        $("#promotionSecond").css("display", "none");
        $("#promotionThird").css("display", "none");
    }
    else if (index == 2) {
        $(".prom_top_first").css("color", "black");
        $(".prom_top_second").css("color", "red");
        $(".prom_top_third").css("color", "black");
        $("#promotionFirst").css("display", "none");
        $("#promotionSecond").css("display", "block");
        $("#promotionThird").css("display", "none");
    }
    else if (index == 3) {
        $(".prom_top_first").css("color", "black");
        $(".prom_top_second").css("color", "black");
        $(".prom_top_third").css("color", "red");
        $("#promotionFirst").css("display", "none");
        $("#promotionSecond").css("display", "none");
        $("#promotionThird").css("display", "block");
    }
    prom_index = index;
}

function changeGuide(index) {
    if (index == 1) {  
        $(".guide").css("border", "3px solid red");
    }
    else if (index == 2) {
        $(".guide").css("border", "3px solid yellow");
    }
    else if (index == 3) {
        $(".guide").css("border", "3px solid blue");
    }
    guide_index = index;
}


function onMouseIn(elem) {
    if (elem == 1) {
        $(".nav_ul").css("background-color", "rgba(239, 243, 245, 0.5)");
        $(".nav_ul a").css("", "rgba(239, 243, 245, 0.5)");
    }
    else if (elem == 2) {
        $(".news").css("display", "block");
        $(".nav_ul").css("background-color", "rgba(239, 243, 245, 0.5)");
    }
    else if (elem == 3) {
        $(".commu").css("display", "block");
        $(".nav_ul").css("background-color", "rgba(239, 243, 245, 0.5)");
    }
    else if (elem == 4) $(".nav_ul").css("background-color", "rgba(239, 243, 245, 0.5)");
    else if (elem == 5) $(".nav_ul").css("background-color", "rgba(239, 243, 245, 0.5)");
    else if (elem == 6) {
        $(".promotion").css("display", "block");
        $(".nav_ul").css("background-color", "rgba(239, 243, 245, 0.5)");
    }
    else if (elem == 7) $(".nav_ul").css("background-color", "rgba(239, 243, 245, 0.5)");
    else ;
}
// transparent
function onMouseOut(elem) {
    if (elem == 1) $(".nav_ul").css("background-color", "transparent");
    else if (elem == 2) {
        $(".news").css("display", "none");
        $(".nav_ul").css("background-color", "transparent");
    }
    else if (elem == 3) {
        $(".commu").css("display", "none");
        $(".nav_ul").css("background-color", "transparent");
    }
    else if (elem == 4) $(".nav_ul").css("background-color", "transparent");
    else if (elem == 5) $(".nav_ul").css("background-color", "transparent");
    else if (elem == 6) {
        $(".promotion").css("display", "none");
        $(".nav_ul").css("background-color", "transparent");
    }
    else if (elem == 7) $(".nav_ul").css("background-color", "transparent");
    else ;
}
