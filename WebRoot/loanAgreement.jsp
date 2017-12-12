<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control"
  content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>借款协议</title> 
<meta name="viewport"
  content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet" />
<link href="css/common2.css" rel="stylesheet" />
<link href="css/common.css" rel="stylesheet" />
<link href="css/couponstyle.css" rel="stylesheet" />
<link href="css/bottom_munu.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script   type="text/javascript">
 var type = getRequestParam("couponType");
 var from = getRequestParam("from");
 
</script>
<style>
.loanAgreement p{padding:0 1rem 0 1rem;line-height:3rem;color:#666;font-size:1.4rem;}
.loanAgreement table{padding:0 1rem 0 1rem;margin-top:1rem;}
.loanAgreement td{padding:10px;}
</style>
<%@ include file="config/header.jsp" %>
</head>
<body>
    <section>
            <h1 class="home_title red_bg"> 
                                 借款协议          
            </h1>
    </section>
    
    <section class="loanAgreement">
          <p>合同编号：</p>
          <p>甲方（出借人）：详见本协议第一条</p>
          <p>乙方（借款人）：</p>
          <p>生效日期：</p>
          <p>企业编码:</p>
          <p>借款人（乙方）通过北京瑞钱宝资产管理服务有限公司创办的网络借贷中介平台  （以下简称“本平台”），向本平台的注册会员借款。相关借款事项根据《中华人民共和国合同法》等相关法律法规的规定，甲乙双方达成如下协议：</p>
          <p>第一条</p>
          <table border="1" style="width:100%;border-collapse:collapse;border:1px solid #ccc;text-align:center;color:#333;">
            <tr>
              <td>用户名</td>
              <td>身份证号</td>
              <td>借款金额</td>
              <td>期限</td>
              <td>年利率</td>
            </tr>
            <tr>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
            </tr>
          </table>
          <p>第二条 </p>
          <p>1、还款计划：</p>
          <table border="1" style="width:100%;border-collapse:collapse;border:1px solid #ccc;text-align:center;color:#333;">
            <tr>
              <td>期数</td>
              <td>金额</td>
              <td>本金</td>
              <td>日利率</td>
              <td>利息管理费</td>
              <td>截止日</td>
            </tr>
            <tr>
              <td>1/1</td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
            </tr>
          </table>
          <p>2、借款人承诺按照本协议以上约定的时间和金额，按期足额向投资者还款。</p>
          <p>第三条 借款的支付和还款方式</p>
          <p>1、甲方在同意向乙方出借相应款项时，已委托本平台在本借款协议生效时将该笔借款直接划付至借款人帐户。</p>
          <p>2、乙方在还款时已委托本平台将还款直接划付至甲方帐户。</p>
          <p>3、借款人和投资者均同意上述平台接受委托的行为所产生的法律后果均由相应委托方承担。</p>
          <p>第四条：乙方权利、义务</p>
          <p>1、自觉接受甲方对本合同项下借款使用情况的调查、了解及监督。</p>
          <p>2、按本合同约定清偿本合同项下的本金、利息及违约金。</p>
          <p>3、变更住所、通讯地址、号码应在变更后，应当立即书面通知甲方。</p>
          <p>4、如发生对其履行本合同项下还款义务产生重大影响的任何事件（包括但不限于离、结婚，对外投资，承担民事、行政、刑事责任等），应立即书面通知甲方。</p>
          <p>第六条：违约责任</p>
          <p>1、如乙方未按本合同约定履行归还所借款项义务，应从还款之日次日起按应还本金每日千分之八向甲方支付违约金，直到本息清偿为止。</p>
          <p>2、乙方有下列行为之一，甲方有权提前收回借款：</p>
          <p>（1）向甲方提供虚假情况或者隐瞒重要事实;</p>
          <p>（2）不配合、拒绝接受甲方的监督;</p>
          <p>（3）未经甲方同意，转让、处分其资产;</p>
          <p>（4）其财产重要部分或全部被其他债权人占有、接管或其财产被扣押、冻结，可能使甲方遭受严重损失的;</p>
          <p>（5）其他任何可能导致甲方实现债权受到威胁或遭受严重损失的。</p>
          <p>第七条：特别条款</p>
          <p>1、借款人不得将所借款项用于任何违法活动（包括但不限于赌博、吸毒、贩毒、卖淫嫖娼等）及一切高风险投资（如证券期货、彩票等），否则一经发现，投资者有权要求提前收回全部借款，投资者或本平台还将立即向公安等有关行政机关举报，追回此款并追究借款人的刑事责任。</p>
          <p>2、本平台仅作为该网站注册会员之间小额资金互助平台，反对一切利用本平台进行信用卡套现和其他洗钱等不正当交易行为。如发生此类现象，本平台有权向公安等有关行政机关举报，追究其相关法律责任。</p>
          <p>第八条：其他</p>
          <p>1、本协议采用电子文本形式制成，并通过站内信的形式发送协议至本平台。</p>
          <p>2、本协议自借款人在本平台发布的借款标的审核成功之日起生效，借款人、投资者各执一份，并具同等法律效力。</p>
          <p>3、因本协议引起的纠纷由双方协商解决，协商不成，任何一方有权向北京市西城区人民法院提起诉讼。</p>
          <p>4、本平台拥有对本协议的最终解释权。</p>
          <p>居间方：瑞钱宝</p>
  </section>
      
   
    
</body>
</html>