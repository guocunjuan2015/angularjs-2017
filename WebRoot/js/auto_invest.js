var curSize = 0;
var idAll = "";
var isShow = false;


function main(){
	clearSession();
	loadData();
}
function addRule(data,curSize){
	var table = $("#container");
		var row = '';
		row += '<div class="zdtb" id="item_'+ curSize;
		row += '" onclick="modifyRule(\'';
		row += data.autoBidId;
		row += '\')">';
		if(data.enable){
			row += '<i class="sort-icon">';
		}else{
			row += '<i class="sort-icon1">';
		}
		row += curSize;
		row += '</i>';
		row += '<div class="zdtb-left zdtb-left-width">';
		row += '<p>排名<span>';
		row += data.rank;
		row += '</span></p>';
		if(!data.enable){
			if(data.desc){
				row += '<p>'+data.desc+'<span>';
				row += ' ';
				row += '</span></p>';	
			}
		} 
		row += '</div>';
		row += '<div class="zdtb-right" style="display:none" id="item_'+curSize+'_del';
		row += '" >';
		row += '<a onclick="deleteRule(\'';
		row +=  data.autoBidId;
		row += '\',event)">删除</a></div>';
		if(data.enable){
			row += '<div class="zdtb-center zdtb-center1 font-red">';
			row += '已开启';
		}else{
			row += '<div class="zdtb-center zdtb-center1 font-grey">';
			row += '未开启';
		}
		row += '</div>';
		row += '</div>';
		table.append(row);
		swipeEvent('item_'+curSize);
}

function loadData(){
	$.ajax({
		type : "POST",
		url : "account/autoinvest/set/query.do",
		data : {
			
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					 var data = info.resultObject;
					 curSize = data.length;
					 var id = "";
					 for(var i=0;i<data.length;i++){
						 id = id + "," + data[i].autoBidId;
					 }
					 idAll = id.substring(1);
					 var table = $("#container");
					 table[0].innerHTML = "";
					 addDataToContainer(data);
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
function addDataToContainer(data){
	for(var i=0;i<data.length;i++){
		addRule(data[i],i+1);
	}
}

function swipeEvent(id) {
	var a = new LSwiperMaker({
		bind : document.getElementById(id), // 绑定的DOM对象
		dire_h : true, //true 判断左右， false 判断上下
		backfn : function(o) { //回调事件
			if ("R" == o.dire) {
				$("#" + id + "_del")[0].style.display = "none";
			} else if ("L" == o.dire) {
				$("#" + id + "_del")[0].style.display = "block";
			}
		}
	})
	/*$("#" + id + "_del").click(function() {
		var item = document.getElementById(id);
		if (item != null) {
			item.parentNode.removeChild(item);
		}
	});*/
}

function edit(){
	
}
function showBg() {
	if (isShow) {
		isShow = false;
		$("#bg").css({
			display : "none",
			height : $(document).height()
		});
		$("#footpanel").css({
			display : "none"
		});
	} else {
		isShow = true;
		$("#bg").css({
			display : "block",
			height : $(document).height()
		});
		$("#footpanel").css({
			display : "block"
		});
	}
}

function clearAll(event){
	showBg();
	deleteRule(idAll,event);
}
function toAddRule(){
	if(curSize < 3){
		window.location.href = "auto_invest_edit.jsp?retUrl=auto_invest.jsp";
	}else{
		alert("只允许添加三条自动投标规则");
	}
	
}

function clearSession(){
	var session = window.sessionStorage;
	if(session.getItem("autoWayValue")){
		session.removeItem("autoWayValue");
		session.removeItem("autoWayLabel");
	}
	if(session.getItem("autoTypeValue")){
		session.removeItem("autoTypeValue");
		session.removeItem("autoTypeLabel");
	}
	if(session.getItem("autoRepayWayValue")){
		session.removeItem("autoRepayWayValue");
		session.removeItem("autoRepayWayLabel");
	}
	if(session.getItem("autoPeriodValue")){
		session.removeItem("autoPeriodValue");
		session.removeItem("autoPeriodLabel");
	}
	if(session.getItem("autoRateFrom")){
		session.removeItem("autoRateFrom");
		session.removeItem("autoRateTo");
	}
	if(sessionStorage.getItem("autoRateLimit")){
		sessionStorage.removeItem("autoRateLimit");
	}
	if(sessionStorage.getItem("checked")){
		sessionStorage.removeItem("checked");
	}
	if(sessionStorage.getItem("autoRemain")){
		sessionStorage.removeItem("autoRemain");
	}
	if(sessionStorage.getItem("maxInvest")){
		sessionStorage.removeItem("maxInvest");
	}
	if(sessionStorage.getItem("minInvest")){
		sessionStorage.removeItem("minInvest");
	}
}
function deleteRule(id,event){
	event.stopPropagation();//阻止父dom点击事件
	$.ajax({
		type : "POST",
		url : "account/autoinvest/rule/delete.do",
		data : {
			autoBidId:id
		},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if (info.result) {
					loadData();
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
function modifyRule(id){
	window.location.href = "auto_invest_modify.jsp?id="+id+"&retUrl=auto_invest.jsp";
} 