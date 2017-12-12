/*******************************************************************************
 * --------------------------------见面会相关-------------------------------------------*
 ******************************************************************************/
  var path = $("#path").val();
$(function(){
	  $("input[name='mobile']").blur(function(){
		  var mobile = $(this).val().trim();
		  $.ajax({
			  url: path + "faceVaildate.jsp?opr=validate",
			  type:"post",
			  dataType:"json",
			  data:{
				  "mobile":mobile
			  },
			  success:function(res){
				 var data = eval(res);
				 if(data.status == 0){
					 alert("手机号被占用");
					 $("input[name='mobile']").focus();
				 }
			  }
		  });
	  });  
	 $("#btn_save").click(function(){
		  var name = $("input[name='name']").val();
		  var mobile = $("input[name='mobile']").val();
		  var address = $("input[name='address']").val();
		  var userName = $("input[name='userName']").val();
		  var remarks = $("input[name='remarks']").val();
		  if(name == ""){
			  alert("姓名不能为空");
			  return;
		  }
		  if(mobile == ""){
			  alert("手机号不能为空");
			  return;
		  }
		   $.ajax({ 
			   url: path + "faceVaildate.jsp?opr=add",
			  type:"post",
			  dataType:"json",
			  data:{
				  name:name,
				  mobile:mobile,
				  address:address,
				  userName:userName,
				  remarks:remarks
			  },
			  success:function(res){
				  var data = eval(res);
				  if(data.status == 0){
					  alert("提交成功！由于名额有限，平台将最终选取10名线上报名的用户参会。成功报名的用户，客服将在5月1日-5月3日联系您，请保持您的手机畅通。");
				  }else{
					  alert("提交失败");
				  }
				  location.href =path+"face.jsp";
			  }
		  });  
	  }); 
  }); 
