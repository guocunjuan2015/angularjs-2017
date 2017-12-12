<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="fixedDirlog"></div>
  <!--实名或者绑卡start  -->
  <div class="realNameOrCard">
       <span class="closeNameOrCard">×</span>
       <img  style="max-width:100%;" src="images/custodyBanner.png" />
       <p class="custodyTie">现瑞钱宝已对接海口联合农商银行存管系统，您的投资理财将更加安全</p>
       <p class="custodyImg"><img  src="images/cooperationImage.png" /></p>
        <p class="goOpened">
              <a href="javascript:;" class="btn btn-danger" onclick="goRealname();">去开通</a>
        </p>
  </div>
   <!--实名或者绑卡end  -->
   
   
 <!--去提现start  -->
  <div class="balanceBox">
     <!--   <span class="closeNameOrCard closeBalanceBox">×</span> -->
       <img  style="max-width:100%;" src="images/withdrawImg1.png" />
       <p class="custodyTie">现瑞钱宝已对接海口联合农商银行存管系统，请将您在联动优势账户中的余额进行提现处理</p>
       <p class="custodyImg"><img  src="images/withdrawImg2.png" /></p>
        <p class="goOpened">
              <a href="javascript:;" class="btn btn-danger" onclick="goWithdraw();">去提现</a>
        </p>
  </div>
   <!--去提现end  -->
<script>
		//判断是否实名绑卡
		var realNametf = false;// 实名
		var bankCodetf = false;//绑卡
		isrealName();
		isDirlogShow ();
		function isrealName (){
		    $.ajax({
		        url: "cg/user/getRegisterInfo.do", // 是否实名、绑卡
		        type: "post",
		        dataType: "json",
		        data: { },
		        async : false,
		        success: function (response) {
		          var result = $.parseJSON(response.result);
		          var info =result.resultObject; 
		          console.log(info);
		          //console.log(info);
		        //  var data = info.resultObject;
		      if(info.realName == ''){
		        realNametf = false;
		        $("#recharge_button").attr("disabled",true);
		      }else{
		        realNametf = true;
		        $("#recharge_button").attr("disabled",false);
		      };
		      if(info.bankCardNo == ''){
		        $("#cash_button").attr("disabled",true);
		        bankCodetf = false;
		      }else{  
		        bankCodetf = true;
		        $("#cash_button").attr("disabled",false);
		        $("#bank_name").text(info.bankName);
		        $("#bank_code").text(info.bankCardNo);
		        $("#account_balance").text();
		      }
		        },
		      error: function (data){
		        realNametf = false;
		        bankCodetf = false;
		      }
		    });
		}
		
		//是否显示弹出框
		function isDirlogShow (){
		  if(realNametf == false){//未注册
		    $(".fixedDirlog").show();
		    $(".realNameOrCard").show();   
		    $("body").css("overflow","hidden");
		  } else if(realNametf == true && bankCodetf == false ){//已经注册用户但未绑卡
		     $('html,body').animate({scrollTop: '0px'}, 800);  
		     $(".fixedDirlog").show();
		     $(".realNameOrCard").show(); 
		     $("body").css("overflow","hidden"); 
		   } else{
		     $(".realNameOrCard").hide(); 
		   }
		}
		
		//去实名认证
		function goRealname (){
		     $.ajax({
		        url:"cg/user/register.do", // 去认证
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
		/*关闭 实名认证按钮  */
		$(".closeNameOrCard").click(function (){
			  $(".realNameOrCard").hide();
			  $(".fixedDirlog").hide();
			})
			
			/*关闭 提现按钮   */
    $(".closeBalanceBox").click(function (){
        $(".balanceBox").hide();
        $(".fixedDirlog").hide();
      })
</script>

