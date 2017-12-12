<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="custodyProcessStep">
    <ul>
        <li onclick="goHome();"><font></font><span>返回主页</span></li>
        <li onclick="goAccountProcess();"><font></font><span>开户流程</span></li>
        <li onclick="goRechargeProcess();"><font></font><span>充值流程</span></li>
        <li onclick="goInvestProcess();"><font></font><span>投资流程</span></li>
        <li onclick="goWithdrawProcess();"><font></font><span>提现流程</span></li>
    </ul>  
</div>  
   <script>
   
   /*银行存管流程 */
   function goHome(){//返回主页
       
       window.location.href =" <%=basePath%>/active/custodyOperation/custodyOperation.jsp";
     
   }
   
   function goAccountProcess(){ //开户流程
       
       window.location.href =" <%=basePath%>/active/custodyOperation/accountProcess.jsp";
     
   }
   
   
  function goRechargeProcess(){ //充值流程
       
       window.location.href =" <%=basePath%>/active/custodyOperation/rechargeProcess.jsp";
     
   }
  
  function goInvestProcess(){ // 投资流程
      
      window.location.href =" <%=basePath%>/active/custodyOperation/investProcess.jsp";
    
  }
  
 function goWithdrawProcess(){ // 充值流程
      
      window.location.href =" <%=basePath%>/active/custodyOperation/withdrawProcess.jsp";
    
  }
   
   $(function(){
	   /*底部导航切换 */
      $(".custodyProcessStep li").click(function(){
         var index=$(".custodyProcessStep  li").index(this);
         $(".custodyProcessStep  li").eq(index).addClass('selectedli').siblings(".custodyProcessStep  li").removeClass('selectedli');
         $(".chargechoose-tab").eq(index).css('display','block').siblings(".chargechoose-tab").css('display','none');
            
     })
     
   })
   
   /*图片轮播效果 */
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        parallax: true,
        speed: 600,
    });
</script>