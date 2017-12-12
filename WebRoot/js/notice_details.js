$(function() {
	k = getRequestParam("detailId");
	initData();
});

function initData(){
	if(k){
		$.ajax({
			type : "POST",
			url : "project/notice/details/get.do",
			data : {
				k : k,
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						 var data = info.resultObject;
						 if(data.t){
							 $("#details_title")[0].innerHTML = data.t;
							 var tt = data.t;
							 tt = tt.replace(/<[^>]+>/g,"");
							 tt = tt.replace("&nbsp;","");
							 tt = tt.replace("&ge","");
							 tt = tt.replace("&ldquo","");
							 tt = tt.replace("&rdquo;","");
							 tt = tt.replace(";","");
							 title = tt;
						 }
						 if(data.d){
							 $("#details_time")[0].innerHTML = data.d;
						 }
						 if(data.c){
							 $("#details_content")[0].innerHTML = data.c;
							 var cont = data.c;
							 cont = cont.replace(/<[^>]+>/g,"");
							 cont = cont.replace(/&nbsp;/g,"");
							 cont = cont.replace("/&ge/g","");
							 cont = cont.replace("/&ldquo/g","");
							 cont = cont.replace("/&rdquo/g;","");
							 cont = cont.replace(/\ +/g,"");//去掉空格
							 cont = cont.replace(/[\r\n]/g,"");//去掉回车换行
							 content = cont.substr(0,98)+"..";//设置app分享内容
						 }
						 $('#details_content img').each(function(){
						     $(this).attr('src',"http://www.rqbao.com"+$(this).attr('src'));
						 })
						 icon = "http://www.rqbao.com/rqb/images/logo.png";
						 url = window.location.href;
						 showShareBtn(title,content,icon,url);
						 weixinShare(title,content,icon,url,"http://www.rqbao.com/rqb");
					} else {
						errorMsg(info.errInfo);
					}
				} else {
					if (isEmpty(response.result)) {
						errorMsg(response.msg);
					} else {
						window.location.href = response.result;
					}
				}
			},
			dataType : "json"
		});
	}
}

function shareClick(){
	if(isAndroidOrIos()){
		IOSModel.noticeShare({"url":url,"title":title,"content":content,"icon":icon});
		iosShare(title,content,icon,url);
		appFunction('share');
	 }else{
		 showShareBox();
	 } 
}
function showShare(){
	IOSModel.showShareBtn();
}
function  shareWithType(){
	IOSModel.noticeShare({"url":url,"title":title,"content":content,"icon":icon});
}