var tabChoose = 1;

function check() {
	var number = $("#number")[0].value;
	var actNumber = $("#act_number")[0].value;
	if (!checkStr(number, regexes.float)) {
		errorMsg("请正确填写号码");
		return false;
	}
	if (!checkStr(actNumber, regexes.float)) {
		errorMsg("请正确填写激活码");
		return false;
	}
	return true;
}

function activeCoupon() {
	$("#exchange_btn").attr("disabled", true);
	if (check()) {
		var url = "";
		switch (tabChoose) {
		case 1:
			url = "account/ticket/active.do";
			break;
		case 2:
			url = "account/morerate/active.do";
			break;
		}
		
		$.ajax({
			type : "POST",
			url : url,
			data : {
				n : $("#number")[0].value,
				c : $("#act_number")[0].value
			},
			success : function(response) {
				if (response.success) {
					var info = $.parseJSON(response.result);
					$("#tip_content")[0].innerHTML = info.errInfo;
					$("#msg_btn_0")[0].style.display = "block";
					$('#myModal').on('shown.bs.modal', function() {
						$('#myInput').focus();
					});
					$('#myModal').modal('toggle');
					$('#myModal')[0].click();
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
	$("#exchange_btn").attr("disabled", false);
}

function clickTab(index) {
	tabChoose = index;
	$("#cop_tab" + 1).removeClass();
	$("#cop_tab" + 2).removeClass();
	$("#cop_tab" + index).removeClass().addClass("red_border_btm");
	var row = '';
	switch (parseInt(index)) {
	case 1://选择体验券tab
		document.getElementById("number").setAttribute("placeholder", "输入体验券号码");
		break;
	case 2://选择瑞钱币tab
		document.getElementById("number").setAttribute("placeholder", "输入加息券号码");
		break;
	}
}