$(function(){
	getBannerList();
});
function getBannerList(){
		 $.ajax({
	         type : "POST",
	         url : "normal/banner/list/get.do",
	         data : {
	         },
	         success : function(response) {
	             if (response.success) {
	                 var info = $.parseJSON(response.result);
	                 var data = info.resultObject;
	                 addDataToPage(data);
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
function addDataToPage(data){
	var table = $("#bannerList");
	table[0].innnerHTML = "";
	var row = '';
	for(var i = 0;i<data.length;i++){
		if(i == 0){
			if(data[i].imgSrc){
				row += '<div class="swiper-slide" id="s1" ';
				row += 'onclick="linkTo(\'';
				row += data[i].url;
				row += '\')"';
				row +='><img src="';
				row += data[i].imgSrc;
				row += '" style="width:100%;" /><div class="bt-nav"></div></div>';
			}
		}else{
			if(data[i].imgSrc){
			row += '<div class="swiper-slide"'
			row += 'onclick="linkTo(\'';
			row += data[i].url;
			row += '\')"';
			row += '><img src="';
			row += data[i].imgSrc;
			row += '" style="width:100%;" /> </div>';
			}
		}
	}
	table.append(row);
	swiper.update(true);
}


/*$(function(){
	var table = $("#bannerList");
	table[0].innnerHTML = "";
	var row = '';
	row += '<div class="swiper-slide" id="s1"><img src="images/reg-banner01.jpg" style="width:100%;" /><div class="bt-nav"></div></div>';
 row += '<div class="swiper-slide" id="s2">';
row += '<img src="images/reg-banner02.jpg" style="width:100%;" /> </div>';
row += '<div class="swiper-slide" id="s3">';
row += '<img src="images/reg-banner03.jpg" style="width:100%;" /> </div>'
row += '<div class="swiper-slide" id="s4">';
row += '<img src="images/reg-banner05.jpg" style="width:100%;" /> </div>';
table.append(row);
swiper.update(true);
//更新动态添加banner
});*/


