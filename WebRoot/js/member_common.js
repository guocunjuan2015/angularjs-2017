/**
 * Created by guocunjuan on 2015/10/22.
 */
/*提现页面START*/
    /*条件选择*/
     /*   $(function(){
            $("#recharge-ul li").click(function(){
              //  var index=$("#select-ul li").index(this);
                $("#recharge-ul li").css("backgroundColor","#fff");
                $(this).css("backgroundColor","#48B3AE");
                $(this).css("color","#fff").siblings('#recharge-ul li').css("color","#6bb2b3");
            });
            $("#recharge-ul1 li").click(function(){
               $(this).closest("div").find("li[class='optionsearch-firstli']").removeClass("optionsearch-firstli");
               $(this).attr("class","optionsearch-firstli");
            });
        })
        /**/
        /* 我的账户首页js注释 $(function(){
         $(".menu ul li a").click(function(){
             var index=$(".menu ul li a").index(this);
             $(".menu ul li a").css("color","black");
             $(this).css("color","#6CCBF4");
         });
    }) */
        
          /*small tab切换*/
    $(".chargechoose ul li").click(function(){
        var index=$(".chargechoose ul li").index(this);
        $(".chargechoose ul li").eq(index).addClass('selectedli').siblings(".chargechoose ul li").removeClass('selectedli');
        $(".chargechoose-tab").eq(index).css('display','block').siblings(".chargechoose-tab").css('display','none');
        $(".coupon").eq(index).css('display','block').siblings(".coupon").css('display','none');
    })
    
     $(".investmentNews .ranking1 li").hover(function(){
        var index1=$(".investmentNews .ranking1 li").index(this);
        $(".investmentNews .ranking1 li").eq(index1).addClass('selectedli').siblings(".investmentNews .ranking1 li").removeClass('selectedli');
        $(".chargechoose-tab").eq(index1).css('display','block').siblings(".chargechoose-tab").css('display','none');
    }) 
    
     
    
       $(".suspensionFrame ul li").click(function(){
        var index=$(".suspensionFrame ul li").index(this);
        $(".suspensionFrame ul li").eq(index).addClass('currentStatus').siblings(".suspensionFrame ul li").removeClass('currentStatus');
    })
    
        $("#navAbout ul li").click(function(){
        var index=$("#navAbout ul li").index(this);
        $("#navAbout ul li").eq(index).addClass('current').siblings("#navAbout ul li").removeClass('current');
    })


/*提现页面END*/
   
   /* small tab切换	*/
  /*$(".chargechoose ul li").click(function(){
      var index=$(".chargechoose ul li").index(this);
      $(".chargechoose ul li").eq(index).addClass('selectedli').siblings(".chargechoose ul li").removeClass('selectedli');
      $(".chargechoose-tab").eq(index).css('display','block').siblings(".chargechoose-tab").css('display','none');
  })*/
    /*判断是否注册联动用户 */
   /*条件选择*/
        $(function(){
            $("#recharge-ul li").click(function(){
              //  var index=$("#select-ul li").index(this);
                //$("#recharge-ul li").css("backgroundColor","#fff");
                $(this).css("backgroundColor","#D85353");
                $(this).css("color","#fff").siblings('#recharge-ul li').css("color","#333");
                $(".chargechoose-tab").eq(index).css('display','block').siblings(".chargechoose-tab").css('display','none');
            });
        })
   
