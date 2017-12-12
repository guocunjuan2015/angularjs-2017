var projectId = "";
var isTransfer = "";
var needRecharge = "";
var basePath = $("#basePath").val();
$(function() {  
	enableUMP = -1;
	//getAccountInfo();
	initData();
	//checkUMPRegister();
	//checkIfUMPRegister();
	//getCardInfo();
	getAccountInfo();
	//checkUMPRegister();
	
});

function initData(){
	projectId = getRequestParam("projectId");
	isTransfer = getRequestParam("isTransfer");
	needRecharge = getRequestParam("needRecharge");
	if(needRecharge){
		$("#recharge_money").val(parseFloat(needRecharge));
	}
}

function getAccountInfo(){
	
	/*初始化加息券个数 */
    $.ajax({
              url:'account/getUserBalance.do',
              type:'POST',
              dataType:'json',
              success:function(data){
            	   var info = $.parseJSON(data.result);
                   var _info = info.resultObject;
                  /* console.log(_info);*/
                  if (info.result == "1") {
                     $("#account_balance").text(_info.accountBalance);
                     $("#feeRate").val(_info.feeRate);
                     if (_info.feeRate == 0.00) { //首次提现免提现费
         				//fee = Number("0.00");
         				$("#fee").text("本次提现手续费由平台垫付");
         				$(".withdrawCash").hide();
         				$("#unit").hide();
         			}
                     /** 初始点击检查，如果金额等于0.00，不让用户输入*/
                     if (_info.accountBalance == '0.00' ) {
                 		$("#cash_money").val(_info.accountBalance);
                 		$("#cash_money").attr("readOnly", true);
                 		
                 	}
                    } else {
                      
                      alert("请联系管理员");
                      
                    } 
               
             }
              
        }) 
	
	
	
}


function recharge() {
	if(realNametf && bankCodetf){
		doUMPRecharge();//只有开通快捷支付才能去充值
	}	
}

/*$("#recharge_btn").on("touchend", function() {
	if(realNametf && bankCodetf){
		doUMPRecharge();//只有开通快捷支付才能去充值
	}	
})*/

function doUMPRecharge(){
	if(check()){
		var money = $("#recharge_money")[0].value;
		$.ajax({
			  type: "POST",
			  url: "cg/trade/recharge.do",
			  dataType: "json",
			  data: {
				  amount:money,
				  returnUrl : 'http://'+document.domain + "/rqb/personal_center.jsp"
				},
			  success: function(response) {
			   if(response.success){
				    var info = $.parseJSON(response.result);
				    if(info.result == 1){
				    	//保存充值来源
				    	 var myWindow = window.open('', '_self');
				         myWindow.document.write(info.resultObject);
				    }else{
				    	alert(info.errInfo);
				    }
			   }
			  },
			 });
	}
}

function doOpenPayment(){
	alert();
	$("#recharge_btn").attr("disabled", true);
	$.ajax({
		type: "POST",
		url: "ump/payment/open.do",
		data: {
			payment:"ZKJP0700",
			returl:"http://www.rqbao.com/rqb/ump_callback_result.jsp",
		},
		success: function(response) {
			//alert(response);
			if(response.success){
				var info = $.parseJSON(response.result);
            	window.location.href = info.resultObject.url;
              /*   document.getElementById("payment_form")
                .setAttribute("action",info.resultObject.url); */
                //$("#payment_form").submit();
			} else {
				if(isEmpty(response.result)){
					errorMsg(response.msg);
				}else{
					window.location.href = response.result;
				}
			}
			$("#recharge_btn").attr("disabled", false);
		},
		error:function(){
			alert();
		},
		dataType: "json"
	});
}


function gotoPage(index) {
	switch (index) {
	case 0:
		window.location.href = "modify_paypassword_f.jsp";
		break;
	case 1:
		window.location.href = "real_name.jsp";
		break;
	case 2:
		window.location.href = "money_bind.jsp";
		break;
	case 3:
		window.location.href = "money_recharge.jsp";
		break;
	case 4:
		window.location.href = "project.jsp";
		break;
	case 5:
		window.location.href = "personal_center.jsp";
		break;
	case 6:
		//ump绑卡
		window.location.href = "ump_bind_card.jsp";
		break;
	case 7:
		//联动开户
		window.location.href = "ump_real_register.jsp";
		break;
		
	}
}

function real_recharge(){
	if(check()){
		var money = $("#recharge_money")[0].value;
		$.ajax({
			type: "POST",
			url: "money/recharge.do",
			data: {
				money: money
			},
			success: function(response) {
				if(response.success){
					$("#req_data")[0].value = response.result;
					var form = $("#request_form")[0];
					form.submit();
				}else{
					if(isEmpty(response.result)){
						errorMsg(response.msg);
					}else{
						window.location.href = response.result;
					}
				}
				$("#recharge_btn").attr("disabled", false);
			},
			dataType: "json"
		});
	}else{
		$("#recharge_btn").attr("disabled", false);
	}
}

function check() {
	var money = $("#recharge_money")[0].value;

	if (!checkStr(money, regexes.float)) {
		errorMsg("请正确填写金额");
		return false;
	}
	if (money < 100) {
		errorMsg("填写金额应当大于等于100元");
		return false;
	}
	return true;
}



/**重新输入金额，错误信息清除*/
function changeRecharge(){
	errorMsg("");
}

function showRechargeRecord(){
	window.location.href = "money_record.jsp?type=recharge";
}


function changeCard(){
	window.location.href = "identify.jsp";
}



function doOpenPayment(){
    $("#openFastBtn").attr("disabled", true);
    $.ajax({
        type: "POST",
        url: "ump/payment/open.do",
        data: {
            payment:"ZKJP0700",
            returl:"http://www.rqbao.com/rqb/ump_callback_result.jsp",
        },
        success: function(response) {
            if(response.success){
            	var info = $.parseJSON(response.result);
            	window.location.href = info.resultObject.url;
            }else{
                if(isEmpty(response.result)){
                    errorMsg(response.msg);
                }else{
                    window.location.href = response.result;
                }
            }
            $("#openFastBtn").attr("disabled", false);
        },
        dataType: "json"
    });
}
