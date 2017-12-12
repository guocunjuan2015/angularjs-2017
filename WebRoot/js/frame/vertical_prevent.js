$(function(){
	document.addEventListener('touchmove', function (e) {
	    e.preventDefault(); 
	}, false);// 禁止微信touchmove冲突,禁止页面下拉事件
});