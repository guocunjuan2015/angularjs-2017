//判断是否实名绑卡
		 var basePath = $("#basePath").val();
		 var realNametf = false;//实名
		 var bankCodetf = false;//绑卡
		 var  userId = $("#userId").val();
		 var  user = $("#user").val();
		 isrealName();
		 function isrealName (){
			 //判断是否登录 
			 if ((userId == "" || userId == null || userId == "null") && (user == "" || user == null || user == "null")){
				 return;
			 }
			 /* 是否实名、绑卡  */
		     $.ajax({
		         url: basePath + "/cg/user/getRegisterInfo.do", 
		         type: "post",
		         dataType: "json",
		         data: { },
		         async : false,
		         success: function (response) {
		           var result = $.parseJSON(response.result);
		           var info =result.resultObject;
		           console.log(info);
		         //  var data = info.resultObject;
		       if(info.realName == ''){
		         realNametf = false;
		         $("#goOpen").text("开通银行存管账户");
		         $("#opened").text("立即开通 ");
		         $("#goOpen").attr("onclick","goRealname();");
		         $("#opened").attr("onclick","goRealname();");
		       }else{
		         realNametf = true;
		         $("#goOpen").text("已开通 ");
		         $("#opened").text("已开通 ");
		         $("#goOpen").css("cursor","not-allowed");
		         $("#opened").css("cursor","not-allowed");
		         $("#goOpen").removeAttr("onclick");
		         $("#opened").removeAttr("onclick");
		       };
		       if(info.bankCardNo == ''){
		    	   $("#goOpen").text("开通银行存管账户");
		    	   $("#opened").text("立即开通 ");
		    	   $("#goOpen").attr("onclick","goRealname();");
		         bankCodetf = false;
		       }else{
		         bankCodetf = true;
		         $("#goOpen").text("已开通 ");
		         $("#opened").css("cursor","not-allowed");
		         $("#goOpen").css("cursor","not-allowed");
		         $("#opened").removeAttr("onclick");
		         $("#goOpen").removeAttr("onclick");
		       }
		         },
		       error: function (data){
		         realNametf = false;
		         bankCodetf = false;
		         $("#goOpen").text("开通银行存管账户");
		         $("#opened").text("立即开通 ");
		       }
		     });
		 }
		 
		 /*点击开通银行存管切 判断是否登录 */
		 function goOpen(){
		   /*判断是否登录 */
			 if ((userId == "" || userId == null || userId == "null") && (user == "" || user == null || user == "null")){
		    	 if (isAndroidOrIos()) {
		           IOSModel.login();
		           appFunction('login');
		         } else {
		           window.location.href = basePath + "/login.jsp";
		         }
		       
		     } else {
		       //判断是否实名绑卡
		    	 $("#goOpen").attr("onclick","goRealname");  
		    	 $("#opened").attr("onclick","goRealname");  
		      
		     }
		   
		   
		 }
		 
		//去实名认证
		    function goRealname (){
		         $.ajax({
		            url:basePath + "/cg/user/register.do", // 去认证
		            type: "post",
		            dataType: "json",
		            data: {
		              bizType : '01',
		            returnUrl : 'http://'+document.domain + window.location.pathname
		            },
		            success: function (data) {
		              var infos = $.parseJSON(data.result);
		              //console.log(data);
		              // result为1时，表示成功
		              if (infos.result == "1") {
		                var myWindow = window.open('', '_self');
		                myWindow.document.write(infos.resultObject);
		              } else {
		                alert(infos.errInfo);
		              }
		            },
		            error: function (data){
		              console.log(data);
		            }
		        }); 
		    }