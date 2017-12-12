$(function() {
	login_name = $("#div_login_name")[0].innerHTML+"";
	showPointsRank();
});

function showPointsRank() {
	$.ajax({
		type: "POST",
		url: "account/points/showrank.do",
		data: {},
		success: function(response) {
			if(response.success){
				var info = $.parseJSON(response.result);
				if(info.result){
						addDataToUI(info.resultObject);
				}else{
					errorMsg(info.errInfo);
				}
			}else{
				if(isEmpty(response.result)){
					errorMsg(response.msg);
				}else{
					window.location.href = response.result;
				}
			}
		},
		dataType: "json"
	});
}


function addDataToUI(data) {

	var topList = data.前三名排行榜;
	var bottomList = data.附近排行榜;
	
		  var row = '<tr>'+ 
		  '<td id="td_rank_img">'+'<img src="images/no1.png" />'+ '</td>'+
		  '<td>'+topList[0].user_login_name+ '</td>'+
		  '<td>'+topList[0].total_points+ '</td>'+
		  '</tr>'+
		  +'<tr>'+ 
		  '<td id="td_rank_img">'+'<img src="images/no2.png" />'+ '</td>'+
		  '<td>'+topList[1].user_login_name+ '</td>'+
		  '<td>'+topList[1].total_points+ '</td>'+
		  '</tr>'+
		  +'<tr>'+ 
		  '<td id="td_rank_img">'+'<img src="images/no3.png" />'+ '</td>'+
		  '<td>'+topList[1].user_login_name+ '</td>'+
		  '<td>'+topList[2].total_points+ '</td>'+
		  '</tr>';
		  $("#vip_rank_table").append(row);
		  // table[0].innerHTML = row;
		  // table.append(row);
	
	for (var i = 0; i < bottomList.length; i++) {
		var row = '';
		if(bottomList[i].user_login_name == login_name){
			row = '<tr class="font_red_bold">'+ 
			  '<td id="td_rank_img">'+bottomList[i].rownum+ '</td>'+
			  '<td>'+bottomList[i].user_login_name+ '</td>'+
			  '<td>'+bottomList[i].total_points+ '</td>'+
			  '</tr>';
			$("#sp_my_rank_value")[0].innerHTML = bottomList[i].rownum+"";
			$("#my_rank_div")[0].style.display = "block";
		}else{
		   row = '<tr>'+ 
		  '<td id="td_rank_img">'+bottomList[i].rownum+ '</td>'+
		  '<td>'+bottomList[i].user_login_name+ '</td>'+
		  '<td>'+bottomList[i].total_points+ '</td>'+
		  '</tr>';
		}
		  $("#vip_rank_table").append(row);
		 }
	
}

