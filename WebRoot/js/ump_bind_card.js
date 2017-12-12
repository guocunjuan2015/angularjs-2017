var bindType = "";
var bankAccount ='';
var userId = $("#userId").val();
var userName = $("#user").val();
var basePath = $("#basePath").val();
$(function(){
	getRealname();
	if(window.localStorage.getItem("card")){
		bindType = window.localStorage.getItem("card");
		window.localStorage.removeItem("card");
	};
	bankShow ();
});

/*选择开户行*/
function goBankAccount (){
	if(userId == "null" || userId  == ""){
		window.location.href = basePath + "/login.jsp";
	}else{
		$(".addBankOperation").animate({"margin-left":'-100%'});
		$(".bankAccount").animate({"margin-left":'0'});
	}
}
/*选择开户行html*/
$(".bankList dl").click(function (){
	if($(this).is(".dlAct")){
		$(this).removeClass('dlAct');
	}else{
		$(this).siblings().removeClass('dlAct');
		$(this).addClass('dlAct');
		bankAccount =  $(".dlAct dt img").attr("alt");
		bankShow ();
		setTimeout(function(){
			$(".addBankOperation").animate({"margin-left":'0'});
			$(".bankAccount").animate({"margin-left":'100%'});
		},200);
	}	
});
function bankShow (){
	if(bankAccount == undefined || bankAccount == null ||bankAccount == 'null' || bankAccount =="" ){
		$("#bank_select").val('');
	}else if(bankAccount == 'ICBC'){
		$("#bank_select").val('中国工商银行');	
	}else if(bankAccount == 'CCB'){
		$("#bank_select").val('中国建设银行');	
	}else if(bankAccount == 'ABC'){
		$("#bank_select").val('中国农业银行');	
	}else if(bankAccount == 'BOC'){
		$("#bank_select").val('中国银行');	
	}else if(bankAccount == 'SPDB'){
		$("#bank_select").val('浦发银行');	
	}else if(bankAccount == 'COMM'){
		$("#bank_select").val('交通银行');	
	}else if(bankAccount == 'CMBM'){
		$("#bank_select").val('民生银行');	
	}else if(bankAccount == 'GDB'){
		$("#bank_select").val('广发银行');	
	}else if(bankAccount == 'CITIC'){
		$("#bank_select").val('中信银行');	
	}else if(bankAccount == 'CIB'){
		$("#bank_select").val('兴业银行');	
	}else if(bankAccount == 'CEB'){
		$("#bank_select").val('光大银行');	
	}else if(bankAccount == 'CMB'){
		$("#bank_select").val('招商银行');	
	}else if(bankAccount == 'SPAB'){
		$("#bank_select").val('平安银行');	
	}
}
function bind() {
	if ($("input[type='checkbox']").is(':checked')) {
		isOpenFastPayment = 1;
	} else {
		isOpenFastPayment = 0;
	}
	if (check()) {
		var cardCode = $("#bank_select")[0].value;
		$.ajax({
			type : "POST",
			url : "ump/change/bindcard.do",
			data : {
				iop : isOpenFastPayment,
				cardId : $("#bind_cardNO").val(),
				retUrl : "http://www.rqbao.com/rqb/ump_callback_result.jsp",
				cardCode:bankAccount,
				bindType:bindType
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					if (info.result) {
						document.getElementById("ump_bind_card_form")
						.setAttribute("action",info.resultObject.url);
						$("#ump_bind_card_form").submit();

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

function check() {
	var cardCode = $("#bank_select")[0].value;
	if("0" == cardCode){
		errorMsg("请选择银行名称");
		return false;
	}
	if (isEmptyStr($("#bind_cardNO").val())) {
		errorMsg("请输入银行卡号");
		return false;
	}
	
	// if(){
	//		
	// }
	return true;
}

function onInput(){
	errorMsg("");
}


function getRealname(){
	$.ajax({
		type : "POST",
		url : "account/realname/get.do",
		data : {},
		success : function(response) {
			if (response.success) {
				var info = $.parseJSON(response.result);
				if(info.resultObject.realName){
					$("#real_name")[0].innerHTML = info.resultObject.realName;
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