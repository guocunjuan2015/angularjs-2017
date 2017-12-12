//页面定义html字体大小
(function (doc,win) {
	var clientWidth;
	var docEl = doc.documentElement,
        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
    recalc = function (){
        clientWidth = docEl.clientWidth;
        if (!clientWidth) {return ;}
    	docEl.style.fontSize = 10 * (clientWidth / 375) +"px";
    };
    if(!doc.addEventListener) return;
    win.addEventListener(resizeEvt,recalc,false);
    doc.addEventListener('DOMContentLoaded',recalc,false);
})(document,window);
var userId = $("#userId").val();
var userName = $("#userName").val();

var loanMoney = parseInt(1000);
var period = 21;
//利息   借款金额*借款天数*标的年化利率/365
var interest = (loanMoney * period * 6 / 100) / 365;
interest = interest.toFixed(2);
//审核费   (借款金额*借款天数*借款日利率 - 利息)*74%
var review = (loanMoney * period * 0.4762 / 100 - interest) * (74 / 100);
review = review.toFixed(2);
//通道费   (借款金额*借款天数*借款日利率 - 利息)*26%
var path = (loanMoney * period * 0.4762 / 100 - interest) * (26 / 100);
path = path.toFixed(2);
//实际到帐
var actualArrival = loanMoney - review - path;
actualArrival = actualArrival.toFixed(2);
//到期应还
var due = Number(loanMoney) + Number(interest);
due = due.toFixed(2);
//弹出框数据 
$(".loanMoneyP span").text(loanMoney);
$(".actualArrival span").text(actualArrival);
$(".due span").text(due);

if(userId == "null" || userId  == ""){
	window.location.href = "login.jsp";
};

$("#idCardLi").click(function (){
	if(!idCard){
		window.location.href = "loan_idCard.jsp";
	}
});
function seeMyLoan(){
	if(userId == "null" || userId  == ""){
		window.location.href = "login.jsp";
	}else{
		window.location.href = "my_loan.jsp";
	}
}
$("#creditLi").click(function (){
	if(!credit){
		$.ajax({
			type : "POST",
			url : "zmxy/ZMAuthorization.do",
			data : { },
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if(info.result == 1){
						window.location.href=info.resultObject;
					}
				}else{
					
				}
			}
		})
	}
})
//上传身份证图片
var image = '',image2 = '',image3 = '';
var type='.jpg', type2='.jpg', type3='.jpg';
function handleFiles(file){
	if(!file.files || !file.files[0]){
		return;
	}
	var reader = new FileReader();
	reader.onload = function(evt){
		type = file.files[0].name.substring(file.files[0].name.indexOf('.')+1);
		document.getElementById('image').style.display = 'block';
		document.getElementById('image').src = evt.target.result;
		image = evt.target.result.split(',')[1];
		image.width = '100%';
	}
	reader.readAsDataURL(file.files[0]);
};
function handleFiles2(file){
	if( !file.files || !file.files[0] ){
		return;
	}
	var reader = new FileReader();
	reader.onload = function(evt){
		type2 = file.files[0].name.substring(file.files[0].name.indexOf('.')+1);
		document.getElementById('image2').style.display = 'block';
		document.getElementById('image2').src = evt.target.result;
		image2 = evt.target.result.split(',')[1];
		console.log(evt.target.result.split(',')[1]);
		image2.width = '100%';
	}
	reader.readAsDataURL(file.files[0]);
}
function handleFiles3(file){
	if( !file.files || !file.files[0] ){
		return;
	}
	var reader = new FileReader();
	reader.onload = function(evt){
		type3 = file.files[0].name.substring(file.files[0].name.indexOf('.')+1);
		document.getElementById('image3').style.display = 'block';
		document.getElementById('image3').src = evt.target.result;
		image3 = evt.target.result.split(',')[1];
		image3.width = '100%';
	}
	reader.readAsDataURL(file.files[0]);
}
//点击认证
$("#idCardBtn").click(function (){
	$(".loading").show();
	if(!image){
		$(".loading").hide();
		$(".prompt").html("请上传手持身份证照片");
		$(".prompt").show(300).delay(2000).hide(300);
		return;
	}
	if(!image2){
		$(".loading").hide();
		$(".prompt").html("请上传身份证正面照片");
		$(".prompt").show(300).delay(2000).hide(300);
		return;
	}
	if(!image3){
		$(".loading").hide();
		$(".prompt").html("请上传身份证背面照片");
		$(".prompt").show(300).delay(2000).hide(300);
		return;
	}
	$(this).attr("disabled","true");
	$.ajax({
		type:'POST',
		url: 'user/credit/uploadImg.do', 
		data: {
			"image": image,
            "image2": image2,
            "image3": image3,
            "type":type,
            "type2":type2,
            "type3":type3
		},
		async: false,
		dataType: 'json',
		success: function(data){
			if(data.success){
				var info = $.parseJSON(data.result);
				$(".loading").hide();
				if(info.result == 1){
					$(this).val("上传成功");
					$(".prompt").html("恭喜您，上传成功！");
					$(".prompt").show(300).delay(2000).hide(300);
					window.location.href="loan_authentication.jsp";
				}else{
					$(".prompt").html("很抱歉，上传失败！");
					$(".prompt").show(300).delay(2000).hide(300);
					$(this).removeAttr("disabled");
				}
			}
		},
		error: function(data){
			$(".loading").hide();
			$(".prompt").html(data.msg);
			$(".prompt").show(300).delay(2000).hide(300);
		}
	});
});
//立即申请
$("#applyBtn").click(function (){
	console.log(loanMoney);
	var $this = $(this);
	if(idCard && credit){
		$(".loanDirlog").show();
		$(".promptMoney").show;
	}else{
		// 失败信息
		$(".fail p.failP").html('您的信息还没有完善，请继续完善！');
		$(".loanDirlog").show();
		$(".fail").show();
	}
});
function fixedLoan (){
	$.ajax({
		type : "POST",
		url : "project/credit/apply.do",
		dataType : "json",
		data : JSON.stringify({
			amount : '1000',
			goodId : '10006',
			loanPeriod : '21',
			projectType : '200',
			repaymentWay : '306'
		}),
		success : function( response ) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if(info.result =="1"){
					// 成功信息
					$(".promptMoney").hide();
					$(".success").show();
					$this.val("已申请");
					$this.attr("disabled",true);
				}else{
					// 失败信息
					$(".fail p.failP").html(info.errInfo);
					$(".loanDirlog").show();
					$(".fail").show();
				}
			}
		},
		error:function (response){
			// 失败信息
			$(".loanDirlog").show();
			$(".fail").show();
		}
	})
}
//点击关闭
$(".closeMsg2").click(function (){
	$(".loanDirlog").hide();
	$(".success").hide();
});
$(".closeMsg3").click(function (){
	$(".loanDirlog").hide();
	$(".fail").hide();
});
$(".closeMsg4").click(function (){
	$(".loanDirlog").hide();
	$(".promptMoney").hide();
});