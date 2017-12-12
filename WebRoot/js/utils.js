/***      常量      ***/

//用于匹配的正则表达式
var regexes = {
	//校验ip地址
	ip : /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/,
	//校验端口
	port : /^[1-9]$|(^[1-9][0-9]$)|(^[1-9][0-9][0-9]$)|(^[1-9][0-9][0-9][0-9]$)|(^[1-6][0-5][0-5][0-3][0-5]$)/,
	//校验数字
	number: /^([1-9][0-9]*)$|(^0$)/,
	//校验数字
	float: /^[1-9][0-9]*\.[0-9]+$|^[1-9][0-9]*$|^0$|^0\.[0-9]+$/,
	//校验数字、字母
	letterNumber: /^[a-zA-Z0-9]*$/,
	//校验数字、字母、下划线
	letterNumber_: /^[a-zA-Z0-9\_]*$/,
	//校验数字、字母、下划线和短横线
	letterNumber__: /^[a-zA-Z0-9\_-]*$/
};

/***      工具方法      ***/

/**
 * 格式化钱数，并保留小数点后2位
 * @param num 钱数
 * @return 格式化好的钱数
 */
function formatCurrency(num) {  
    if (!num)  
        return "0.00";  
    num = num.toString().replace(/\$|\,/g, '');//去除$符号  
    if (isNaN(num))  
        num = "0.00";  
    sign = (num == (num = Math.abs(num)));  
    num = Math.floor(num * 100 + 0.50000000001);  
    cents = num % 100;  
    num = Math.floor(num / 100).toString();  
    if (cents < 10)  
        cents = "0" + cents;  
    for ( var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)  
        num = num.substring(0, num.length - (4 * i + 3)) + ','+ num.substring(num.length - (4 * i + 3));  
    return (((sign) ? '' : '-') + '' + num + '.' + cents);  
} 

function formatIntCurrency(num) {  //整数格式化
    if (!num)  
        return "0";  
    num = num.toString().replace(/\$|\,/g, '');//去除$符号  
    if (isNaN(num))  
        num = "0";  
    sign = (num == (num = Math.abs(num)));  
    num = Math.floor(num * 100 + 0.50000000001);  
    cents = num % 100;  
    num = Math.floor(num / 100).toString();  
    if (cents < 10)  
        cents = "0" + cents;  
    for ( var i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++)  
        num = num.substring(0, num.length - (4 * i + 3)) + ','+ num.substring(num.length - (4 * i + 3));  
    return (((sign) ? '' : '-') + '' + num);  
}

function disableBtn(btn){
	btn.disabled = true;
}

/**
 * 提示方法
 * @param str 提示内容
 */
function errorMsg(str){
	$("#error_info")[0].innerHTML = str;
}

/**
 * 动态提示方法，5秒后消失
 * 
 * @param str
 *            提示内容
 */
function myErrorMsg(msg_id, str) {
	$("#" + msg_id).text(str);
	$("#" + msg_id).show();

	var count = 5;
	var countdown = setInterval(CountDown, 1000);
	function CountDown() {
		if (count == 0) {
			$("#" + msg_id).hide();
			clearInterval(countdown);
		}
		count--;
	}
}

/**
 * 获取url中的参数
 * @param name 参数名称
 * @returns 如果未找到则返回null
 */
function getRequestParam(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null) {
		return unescape(r[2]); 
	}
	return null;
}

/**
 * 情况标签内的内容
 * @param id html标签id
 */
function cleanHtml(id){
	if(!isEmpty($("#" + id)[0])){
		$("#" + id)[0].innerHTML = "";
	}
}

/**
 * 获取一个object数组中特定id的对象
 * @param id 要获取的object对象的id
 * @param arr object对象列表
 * @returns 如果未找到，则会返回new Object()
 */
function getById(id, arr){
	if(!isEmpty(arr)){
		for(var i = 0; i < arr.length; i++){
			if(!isEmpty(arr[i]) && arr[i].id == id){
				return arr[i];
			}
		}
	}
	return new Object();
}

/**
 * 去除字符串两边的空格，如果字符串未创建，则返回空字符串
 * @param str 字符串
 * @returns
 */
function parseString(str){
	var target = str;
	if(isEmpty(target)){
		target = "";
	}
	target = $.trim(target);
	return target;
}

/**
 * 正则表达式校验字符串
 * @param str 待校验的字符串
 * @param regex 正则表达式
 * @returns 是否匹配成功
 */
function checkStr(str, regex){
	return regex.test(str);
}

/**
 * 将对象转化成json
 * @param obj
 */
function toJson(obj){
	return JSON.stringify(obj);
}

/**
 * 判断字符串是否为空的方法
 * @param str 要判断的字符串
 * @returns {Boolean} undefined，null和空格判断是true，其他为false
 */
function isEmptyStr(str){
	return parseString(str) == "";
}

/**
 * 判断js对象是否为空的方法
 * @param obj 要判断的字符串
 * @returns {Boolean} 如果为undefined或者null则返回true，其他返回false
 */
function isEmpty(obj){
	return obj == undefined || obj == null;
}

//添加理财页底部tab菜单按钮
function addBottomMenu(){
	//Adjust panel height
	$.fn.adjustPanel = function(){ 
		$(this).find("ul, .subpanel").css({ 'height' : 'auto'}); //Reset subpanel and ul height
		
		var windowHeight = $(window).height(); //Get the height of the browser viewport
		var panelsub = $(this).find(".subpanel").height(); //Get the height of subpanel	
		var panelAdjust = windowHeight - 100; //Viewport height - 100px (Sets max height of subpanel)
		var ulAdjust =  panelAdjust - 25; //Calculate ul size after adjusting sub-panel (27px is the height of the base panel)
		
		if ( panelsub >= panelAdjust ) {	 //If subpanel is taller than max height...
			$(this).find(".subpanel").css({ 'height' : panelAdjust }); //Adjust subpanel to max height
			$(this).find("ul").css({ 'height' : ulAdjust}); //Adjust subpanel ul to new size
		}
		else if ( panelsub < panelAdjust ) { //If subpanel is smaller than max height...
			$(this).find("ul").css({ 'height' : 'auto'}); //Set subpanel ul to auto (default size)
		}
	};
}
function roundToTenth(v){//保留小数点后一位小数
	return (parseFloat(formatCurrency(v))).toFixed(1);
}
function linkTo(url){//跳转到url
	window.location.href = url;
}
function replaceTo(url){//跳转到url，替换当前
	window.location.replace(url);
}
function display(id){
	$("#"+id)[0].style.display = "block";
}
function dismiss(id){
	$("#"+id)[0].style.display = "none";
}
/*跳转本地窗口的方法
function newWindow(){
	 var myWindow = window.open('', '_self');
	
}*/