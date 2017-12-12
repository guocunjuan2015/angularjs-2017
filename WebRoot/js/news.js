$(function(){
	getNewsData();
	$("#loading_anim")[0].style.display = "block";
});


function addDataToContainer(data){
	var table = $("#outter_div");
	table[0].innerHTML = "";
	for(var i = 0;i<data.length;i++){ 
		var row = '';
		row += '<div ';
		row += 'class="news"';
			row += 'onclick="clickContent(\'';
			var link = data[i].url;
			if(link.indexOf("user=")>=0){
				var arr = link.split("user=");
				user = arr[arr.length-1];
				if(user){//传递了用户
					row += link;
				} 
			}
			else if(link.indexOf("http")>=0){
				row += link;
			}else if("" == link){
				row += link;
			}else{
				row += "http://www.rqbao.com/rqb/notice_details.jsp?detailId="+link;
			}
			row += '\','+i+')"';
		row += '><dl><dt>';
		row += data[i].title;
		row += '<i class="news-hot">&nbsp;</i></dt>';
		row += '<dd>';
		row += data[i].activeDate;
		row += '</dd><dd><img src="';
		row +=  data[i].imgSrc;
		row += '"></dd><dd><a href=';
		row += '#';
		row += '>立即查看</a></dd></dl></div>';
		table.append(row);
	}
}

function clickContent(addr, i) {// !!!!!!提交前需修改
    //IOSModel.toIosRefer();//for ios
	/*if (i == 1 && isAndroidOrIos()) {
		toIosRefer();
		appFunction('toRefer');
	} else {*/
		window.location.href = addr;
	//}
}

function getNewsData(){
	$.ajax({
		type : "POST",
		url : "account/news/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					$("#loading_anim")[0].style.display = "none";
					addDataToContainer(info.resultObject);
				} else {
					errorMsg(info.errInfo);
				}
			} else {
				if (isEmpty(response.result)) {
					errorMsg(response.msg);
				} else {
					window.location.href = response.result
					+ "?reflect_url="
					+ encodeURIComponent("news.jsp");
				}
			}
		},
		dataType : "json"
	});
}
function showShare(){
	IOSModel.changeWebTitle("最新活动");
}