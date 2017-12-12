/**
 * Created by wangdandan on 2015/12/21.
 */
$(function(){
     
    var loanPercent=$("#inverstrate").val();
    if (loanPercent>0 && loanPercent<1) loanPercent=1;
    var radialObj4 = $('#inverstrate').radialIndicator({ 
        barWidth:16,
        barColor:'#7ecdfe',
        barBgColor:'#c3e7fd',
        fontColor:'#7ecdfe',
        fontFamily:'Hiragino Sans GB',
        fontSize:'30',
        format:'',
        minValue:0,
        maxValue:10000,
        roundCorner : true,
        radius:86
        //percentage: false
    }).data('radialIndicator');

     
    radialObj4.animate(3000);
})
