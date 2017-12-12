$(function(){
	/*判断URL路径改变导航样式*/
	var hash=window.location.hash;
	if (hash=="#/service") {
		$("#navigation a dl dt").eq(0).attr("class","after0");
        $("#navigation a dl").eq(0).attr("style","border-bottom: 2px solid #FF5555;color: #FF5555;");
        for(var i=1;i<2;i++){
        	$("#navigation a dl dt").eq(i).attr("class","before"+i);
        	$("#navigation a dl").eq(i).attr("style","border-bottom: none;color: #4A4A4A;");
        }
	}else if (hash=="#/friend") {
		$("#navigation a dl dt").eq(1).attr("class","after1");
		$("#navigation a dl dt").eq(0).attr("class","before0");
		$("#navigation a dl dt").eq(2).attr("class","before2");
		/*$("#navigation a dl dt").eq(3).attr("class","before3");*/
        $("#navigation a dl").eq(1).attr("style","border-bottom: 2px solid #FF5555;color: #FF5555;");
        $("#navigation a dl").eq(0).attr("style","border-bottom: none;color: #4A4A4A;");
        $("#navigation a dl").eq(2).attr("style","border-bottom: none;color: #4A4A4A;");
        /*$("#navigation a dl").eq(3).attr("style","border-bottom: none;color: #4A4A4A;");*/
	} /* else if (hash=="#/vip") {
		$("#navigation a dl dt").eq(2).attr("class","after2");
		$("#navigation a dl dt").eq(0).attr("class","before0");
		$("#navigation a dl dt").eq(1).attr("class","before1");
		$("#navigation a dl dt").eq(3).attr("class","before3");
        $("#navigation a dl").eq(2).attr("style","border-bottom: 2px solid #FF5555;color: #FF5555;");
        $("#navigation a dl").eq(0).attr("style","border-bottom: none;color: #4A4A4A;");
        $("#navigation a dl").eq(1).attr("style","border-bottom: none;color: #4A4A4A;");
        $("#navigation a dl").eq(3).attr("style","border-bottom: none;color: #4A4A4A;");
	}*/ else{
		$("#navigation a dl dt").eq(2).attr("class","after2");
        $("#navigation a dl").eq(2).attr("style","border-bottom: 2px solid #FF5555;color: #FF5555;");
        for(var i=0;i<2;i++){
        	$("#navigation a dl dt").eq(i).attr("class","before"+i);
        	$("#navigation a dl").eq(i).attr("style","border-bottom: none;color: #4A4A4A;");
        }
	}
	
	/*返回*/
    $('.goBack').click(function(){
		window.history.back();
	});
	
	/*导航效果*/
	$("#navigation a").click(function(){
		$("#navigation a dl dt").eq(0).attr("class","before0");
		$("#navigation a dl dt").eq(1).attr("class","before1");
		/*$("#navigation a dl dt").eq(2).attr("class","before2");
		$("#navigation a dl dt").eq(3).attr("class","before3");*/
		$("#navigation a dl").attr("style","color: #4A4A4A;border: 0;");
        $("#navigation a dl dt").eq($(this).index()).attr("class","after"+$(this).index());
        $("#navigation a dl").eq($(this).index()).attr("style","border-bottom: 2px solid #FF5555;color: #FF5555;");
   });    
	
	/*我的瑞生活Tab切换*/
	$(".nav_myLife li").click(function(){	
		var i = $(this).index();
        $(this).addClass("active_li").siblings().removeClass('active_li');
        $(".myView ul").eq(i).addClass("show").siblings().removeClass('show');
        
        /*判断我的瑞生活有无数据*/
	   var len = $(".show li").size();
	   if (len == 0) {
	   	$(".noStr").css("display","block");
	   	$(".myView").css("display","none");
	   } else{
	   	$(".noStr").css("display","none");
	   	$(".myView").css("display","block");
	   }
    });

	$(".price .period .periodUl .month").eq(0).addClass("mon-active").siblings().removeClass('mon-active');

    $(".price .period .periodUl .month").click(function(){
    	alert("222");
        $(this).addClass("mon-active").siblings().removeClass('mon-active');
    });
    
    $(".yes_btn1").click(function(){
    	$("#divshows1").css({"display":"none"});
    });
    
    $(".main_visual").hover(function(){
		$("#btn_prev,#btn_next").fadeIn()
	},function(){
		$("#btn_prev,#btn_next").fadeOut()
	});
	
	$dragBln = false;
	
	

});