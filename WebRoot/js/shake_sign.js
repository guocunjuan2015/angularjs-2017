var clickDate = 0;
var signDays = 0;//日历上的连续签到
var toDate = 0;
var monthLimits = true; 
var calUtil = {
  //当前日历显示的年份
  showYear:2016,
  //当前日历显示的月份
  showMonth:1,
  //当前日历显示的日
  showDays:1,
  //连续签到天数
  signCount:1,
  eventName:"load",
  //初始化日历
  init:function(signList){
    calUtil.setMonthAndDay();
    calUtil.draw(signList);
    calUtil.bindEnvent();
  },
  draw:function(signList){
    //绑定日历
    var str = calUtil.drawCal(calUtil.showYear,calUtil.showMonth,signList);
    $("#calendar").html(str);
    //绑定日历表头
    var calendarName=calUtil.showYear+"年"+calUtil.showMonth+"月" /*+ calUtil.showDays + "日"*/;
    $(".calendar_month_span").html(calendarName);  
  },
  //绑定事件
  bindEnvent:function(){
    //绑定上个月事件
    $(".calendar_month_prev").click(function(){
      //ajax获取日历json数据
      var signList=[/*{"signDay":"10"},{"signDay":"11"},{"signDay":"12"},{"signDay":"13"}*/];
      calUtil.eventName="prev";
      calUtil.init(signList);
    });
    //绑定下个月事件
    $(".calendar_month_next").click(function(){
      //ajax获取日历json数据
      var signList=[/*{"signDay":"10"},{"signDay":"11"},{"signDay":"12"},{"signDay":"13"}*/];
      calUtil.eventName="next";
      calUtil.init(signList);
    });
  },
  //获取当前选择的年月
  setMonthAndDay:function(){
    switch(calUtil.eventName)
    {
      case "load"://获取当前年月日
        var current = new Date();
        calUtil.showYear=current.getFullYear();
        calUtil.showMonth=current.getMonth() + 1;
        calUtil.showDays = current.getDate();
        break;
      case "prev":
        var nowMonth=$(".calendar_month_span").html().split("年")[1].split("月")[0];
        calUtil.showMonth=parseInt(nowMonth)-1;
        if(calUtil.showMonth==0)
        {
            calUtil.showMonth=12;
            calUtil.showYear-=1;
        }
        break;
      case "next":
        var nowMonth=$(".calendar_month_span").html().split("年")[1].split("月")[0];
        calUtil.showMonth=parseInt(nowMonth)+1;
        if(calUtil.showMonth==13)
        {
            calUtil.showMonth=1;
            calUtil.showYear+=1;
        }
        break;
    }
  },
  getDaysInmonth : function(iMonth, iYear){
   var dPrevDate = new Date(iYear, iMonth, 0);
   return dPrevDate.getDate();
  },
  bulidCal : function(iYear, iMonth) {
   var aMonth = new Array();
   aMonth[0] = new Array(7);
   aMonth[1] = new Array(7);
   aMonth[2] = new Array(7);
   aMonth[3] = new Array(7);
   aMonth[4] = new Array(7);
   aMonth[5] = new Array(7);
   aMonth[6] = new Array(7);
   var dCalDate = new Date(iYear, iMonth - 1, 1);
   var iDayOfFirst = dCalDate.getDay();
   var iDaysInMonth = calUtil.getDaysInmonth(iMonth, iYear);
   var iVarDate = 1;
   var d, w;
   aMonth[0][0] = "日";
   aMonth[0][1] = "一";
   aMonth[0][2] = "二";
   aMonth[0][3] = "三";
   aMonth[0][4] = "四";
   aMonth[0][5] = "五";
   aMonth[0][6] = "六";
   for (d = iDayOfFirst; d < 7; d++) {
    aMonth[1][d] = iVarDate;
    iVarDate++;
   }
   for (w = 2; w < 7; w++) {
    for (d = 0; d < 7; d++) {
     if (iVarDate <= iDaysInMonth) {
      aMonth[w][d] = iVarDate;
      iVarDate++;
     }
    }
   }
   return aMonth;
  },
  ifHasSigned : function(signList,day){
   var signed = false;
   $.each(signList,function(index,item){
    if(item.signDay == day) {
     signed = true;
     return false;
    }
   });
   return signed ;
  },
  ifIsSaved : function(signList,day){
	   var saved = false;
	   $.each(signList,function(index,item){
	    if(item.signDay == day && item.type == 1) {
	    	saved = true;
	     return false;//结束遍历
	    }
	   });
	   return saved ;
  },
  drawCal : function(iYear, iMonth ,signList) {
   var myMonth = calUtil.bulidCal(iYear, iMonth);
   var htmls = new Array();
   htmls.push("<div class='sign_main' id='sign_layer'>");
   htmls.push("<div class='sign_succ_calendar_title'>");
/* htmls.push("<div class='calendar_month_next'>下月</div>");
   htmls.push("<div class='calendar_month_prev'>上月</div>");*/
   htmls.push("<div class='calendar_month_span'></div>");
   htmls.push("</div>");
   htmls.push("<div class='sign' id='sign_cal'>");
   htmls.push("<table>");
   htmls.push("<tr class='calendar_week'>");
   htmls.push("<th>" + myMonth[0][0] + "</th>");
   htmls.push("<th>" + myMonth[0][1] + "</th>");
   htmls.push("<th>" + myMonth[0][2] + "</th>");
   htmls.push("<th>" + myMonth[0][3] + "</th>");
   htmls.push("<th>" + myMonth[0][4] + "</th>");
   htmls.push("<th>" + myMonth[0][5] + "</th>");
   htmls.push("<th>" + myMonth[0][6] + "</th>");
   htmls.push("</tr>");
   var d, w;
   for (w = 1; w < 7; w++) {
    htmls.push("<tr>");
    for (d = 0; d < 7; d++) {
     var ifHasSigned = calUtil.ifHasSigned(signList,myMonth[w][d]);
     var isSaved = calUtil.ifIsSaved(signList,myMonth[w][d]);
     signDays ++ ;
     if(ifHasSigned){
    	 if(monthLimits && signDays %5 == 0){/*连续5天签到*/
    		 monthLimits = false;
    		 htmls.push("<td class='red_evp' style='font-size:1px;color:#fff' id="+myMonth[w][d]+">" + (!isNaN(myMonth[w][d]) ? myMonth[w][d] : " ") + "</td>");
    	 }
    	 else if(isSaved){/*已经补签的*/
    		 htmls.push("<td class='saved' id="+myMonth[w][d]+">" + (!isNaN(myMonth[w][d]) ? myMonth[w][d] : " ") + "</td>");
    	 }else{
    		 htmls.push("<td class='on' id="+myMonth[w][d]+">" + (!isNaN(myMonth[w][d]) ? myMonth[w][d] : " ") + "</td>");
    	 }
     } else {
    	 signDays = 0;
    	 if(parseInt(myMonth[w][d])<= toDate){
    		 htmls.push("<td onclick='saveSign(this.id)' id="+myMonth[w][d]+" class='need_save'>" + (!isNaN(myMonth[w][d]) ? myMonth[w][d] : " ") + "</td>");
    	 }else{
    		 htmls.push("<td id="+myMonth[w][d]+">" + (!isNaN(myMonth[w][d]) ? myMonth[w][d] : " ") + "</td>");
    	 }
     }
    }
    htmls.push("</tr>");
   }
   htmls.push("</table>");
   htmls.push("</div>");
   htmls.push("</div>");
   return htmls.join('');
  }
};

function saveSign(date){
	clickDate = date;
	showAys("确定消耗500积分进行补签?");
}
function realSaveSign(){
	dismissAys();
	var year = calUtil.showYear;
	var month = calUtil.showMonth;
	if(month<10){
		month = "0"+month;
	}
	var day = clickDate;
	if(day < 10){
		day = "0" + day;
	}
	var str = year+"-"+month+"-"+day;
	$.ajax({
		type : "POST",
		url : "points/day/sign/save.do",
		data : {
			date : str
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				showAys3(info.errInfo);
				getSignInfo();
			} else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				} else {
					window.location.href = response.result+ "?reflect_url=shake_sign.jsp";
				}
			}
		},
		dataType : "json"
	});
}
function getSignInfo() {
	$.ajax({
		type : "POST",
		url : "points/shakesign/info/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				var data = info.resultObject;
				toDate = calUtil.showDays;
				 refreshPage(data);
			} else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				} else {
					window.location.href = response.result+ "?reflect_url=shake_sign.jsp";
				}
			}
		},
		dataType : "json"
	});
}
function refreshPage(info){
	var data = info.records;
	$("#totalSign")[0].innerHTML = info.signCount;
	var signList= [];
	if(data.length == 0){
	}else{
		for(var i = 0;i<data.length;i++){
			signList[i] = {"signDay": data[i].date,"type":data[i].type};
		}
	}
	calUtil.signCount = info.signCount;
	calUtil.init(signList);
	var today = calUtil.showDays;
	$("#"+today).removeClass("on").addClass("today_on");
	//addRedEvp();
}
function addRedEvp() {// 添加红包
	var ds = calUtil.signCount;// 连续签到天数
	var showDays = calUtil.showDays;// 当天日期
	var mul = parseInt(ds / 5);
	var rest = ds % 5;
	if (mul > 0) {
		for (var i = 0; i < mul; i++) {
			var id = showDays - (i * 5 + rest);
			$("#" + id)[0].innerHTML = "";
			$("#" + id).removeClass().addClass("red_evp");
		}
	}
}
function daySignIn() {
	$.ajax({
		type : "POST",
		url : "account/day/signin.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				 if(info.result){
					 $("#suc_text")[0].innerHTML = "签到成功";
					 $("#suc_points")[0].innerHTML = "+100";
					 getSignInfo();
				 } 
			} else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				} else {
					window.location.href = response.result+ "?reflect_url=shake_sign.jsp";
				}
			}
		},
		dataType : "json"
	});
}
function dismissAys(){
	//$("#ays2")[0].style.display = "none";
	$("#ays2").animate({"height":"toggle"},200,function(){
		$("#bg")[0].style.display = "none";
	});
}
function showAys(value){
	$("#ays_content2")[0].innerHTML = value;
	$("#bg").css("height", document.body.scrollHeight);
	$("#bg")[0].style.display = "block";
	//$("#ays2")[0].style.display = "block";
	$("#ays2").animate({"height":"toggle"});
}
function dismissAys3(){
	//$("#ays3")[0].style.display = "none";
	$("#ays3").animate({"height":"toggle"},200,function(){
		$("#bg")[0].style.display = "none";
	});
}
function showAys3(value){
	$("#ays_content3")[0].innerHTML = value;
	$("#bg").css("height", document.body.scrollHeight);
	$("#bg")[0].style.display = "block";
	//$("#ays3")[0].style.display = "block";
	$("#ays3").animate({"height":"toggle"});
}