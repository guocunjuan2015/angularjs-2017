var map = {};
var firstValue = "";
var firstId = "";
$(function(){
	initPage();
});
function initPage(){
	var sessionStorage = window.sessionStorage;
	if(sessionStorage.getItem("autoRateFrom")){
		$("#input_from").val(sessionStorage.getItem("autoRateFrom"));
	}
	if(sessionStorage.getItem("autoRateTo")){
		$("#input_to").val(sessionStorage.getItem("autoRateTo"));
	}
	if(!(sessionStorage.getItem("autoRateFrom") || sessionStorage.getItem("autoRateTo"))){
		$("#item0").addClass("checkarrow");
		map[0] = "不限制";
	}
	 
}
function itemClick(id){
	$(".input-number").val("");
	if (map[0] != undefined) {
		/*$("#"+id).removeClass("checkarrow");
		delete map[value];*/
	} else {
		clearMap(map);
		$(".item_i").removeClass("checkarrow");
		$("#"+id).addClass("checkarrow");
		map[0] = "不限制";
	}
}
function clickInput(){
	clearMap(map);
	$(".item_i").removeClass("checkarrow");
}
function clearMap(map) {
	for (key in map) {
		delete map[key];
	}
}
/*function fromKeyup(v){
	var sessionStorage = window.sessionStorage;
	sessionStorage.setItem("autoRateFrom", v);
}
function toKeyup(v){
	var sessionStorage = window.sessionStorage;
	sessionStorage.setItem("autoRateTo", v);
}*/

function countValue() {
	var sessionStorage = window.sessionStorage;
	if($("#input_from").val() && $("#input_to").val()){
		sessionStorage.setItem("autoRateFrom", $("#input_from").val());
		sessionStorage.setItem("autoRateTo", $("#input_to").val());
		sessionStorage.removeItem("autoRateLimit");
	}else{for (key in map) {
		if(map[key]){
			if(map[key]){
				sessionStorage.removeItem("autoRateFrom");
				sessionStorage.removeItem("autoRateTo");
				sessionStorage.setItem("autoRateLimit", true);
			}
		}
	}}
}
function saveExit(){
	if(check()){
		countValue();
		//location.href=document.referrer;
		//history.go(-1);
		var url = getRequestParam("retUrl");
		if(url.indexOf("?")>0){
			url = url + "&retUrl=auto_invest.jsp";
		}else{
			url = url + "?retUrl=auto_invest.jsp";
		}
		window.location.replace(url);
	}
}
function check(){
	var min_rate = $("#input_from")[0].value;
	var max_rate = $("#input_to")[0].value;
	
	if(map[0] != undefined){
		return true;
	}else{
		if (!checkStr(min_rate, regexes.float)) {
			errorMsg("请正确填写收益利率");
			return false;
		}
		if (!checkStr(max_rate, regexes.float)) {
			errorMsg("请正确填写收益利率");
			return false;
		}
	}
	 
	return true;
	
}

