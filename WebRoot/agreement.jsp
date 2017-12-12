<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<%
	String userId = "";
	String loanId = "";
	userId = request.getParameter("userId");
	if (userId == null || "".equals(userId)) {
		userId = "";
	}
	loanId = request.getParameter("loanId");
	if (loanId == null || "".equals(loanId)) {
		loanId = "";
	}
%>
<html lang="zh-cn">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta name="viewport" content="maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width,initial-scale=1.0"/>
    <meta name="format-detection" content="telephone=no"/> 
   <title>借款协议-瑞钱宝</title>
    <meta name="keywords" content="瑞钱宝，互联网金融，投资理财，理财产品，理财" />
    <meta name="description" content="瑞钱宝互联网金融平台投资越多惊喜越多,年收化率7%-13.5%，活动期间你可以选择适合您的理财产品，活动期间设置自动幸运抽奖区，投资理财奖品主要有三星电视、九阳榨汁机、iphone 6s 等，活动时间6月6日-6月24日。" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link href="<%=basePath%>/css/common2.css" rel="stylesheet"/>
		<style>
			body{background-color:#fff;}
	  	  .Lending_Agreement {
		    width:100%;
		    height:auto;
		    margin:0px;
		    padding:0px;
		  }
		  .Lending_Agreement_center {
		   /*  width:1024px; */
		    height:auto;
		    margin:0 auto;
		    border:1px solid #EEEEEE;
		  }
		  .lending_ageeement_tit {
		 /*    width:960px; */
		    height:45px;
		    line-height:45px;
		    color:#666666;
		    font-family:Arial, Helvetica, sans-serif;
		    font-size:1.6rem;
		    font-weight:bold;
		    text-align:center;
		    margin:0 auto;
		    margin-top:30px;
		    border-bottom:1px solid #EEEEEE;
		  }
		  .ageeement_content {
		   /*  width:1000px; */
		    height:auto;
		    margin:0 auto;
		    margin-top:2rem;
		    font-size:1.4rem;
		    font-weight:bold;
		    color:#666666;
		    overflow:auto;
		    font-family:Arial, Helvetica, sans-serif;
		  }
		  .ageeement_content h3 {
		    font-size:1.4rem;
		    font-weight:bold;
		    color:#999999;
		    font-family:Arial, Helvetica, sans-serif;
		    padding-left:10px;
		  }
		  .font_lendig {
		   font-size:1.4rem;
		    font-weight:bold;
		    color:#666666;
		    font-family:Arial, Helvetica, sans-serif;
		    padding-left:10px;
		    margin-bottom:10px;
		    display:block;
		    margin-top:20px;
		  }
		  .ageeement_content p {
		    line-height:26px;
		    font-family:Tahoma, Geneva, sans-serif;
		    font-size:1.4rem;
		    color:#999999;
		    margin:0px;
		    font-weight:normal;
		    padding-left:10px;
		    margin-top:6px;
		  }
		  .ageement_tab {
		  font-size:1.2rem;
		    height:40px;
		    line-height:40px;
		  }
		  .ageement_tab_ite {
		    height:40px;
		    line-height:40px;
		    font-size:0.8rem;
		    font-weight:normal;
		  }
		  .lending_top_inf {
		    /* width:1000px; */
		    height:auto;
		    margin-left:10px;
		  }
		  .lending_logo {
		    /* width:1000px; */
		    height:70px;
		    padding-top:20px;
		    border-bottom:2px solid #00ADEE;
		  }
		  .lenging_left_logo {
		  /*   height:100px; */
		    float:left;
		  }
		  .name_inf {
		  /*   width:400px; */
		    height:65px;
		    float:left;
		    margin-left:40px;
		    margin-top:2px;
		  }
		  .lenging_right_inf {
		  /*   width:260px; */
		    height:50px;
		    float:left;
		    margin-top:9px;
		  }
		  .lenging_right_inf ul {
		    margin:0px;
		    padding:0px;
		  }
		  .lenging_right_inf ul li {
		    /* width:400px; */
		    height:25px;
		    line-height:25px;
		    font-family:Arial, Helvetica, sans-serif;
		    font-size:1.4rem;
		    color:#999999;
		    list-style:none;
		    float:left;
		    padding-left:0px;
		  }
		  .lenging_right_inf ul li a {
		    color:#999999;
		    text-decoration:none;
		  }
		  .lenging_right_inf ul li a:hover {
		    color:#FF9900;
		    text-decoration:none;
		  }
		  .Seal {
		    width:auto;
		    height:auto;
		    margin-right:20px;
		    float:right;
		    text-align:center;
		  }
		  .seal_text {
		    font-family:Arial, Helvetica, sans-serif;
		    font-size:1.4rem;
		    color:#999999;
		    margin-top:6px;
		    margin-bottom:40px;
		    display:block;
		    font-weight:normal;
		  }
		  .Agreement_pic {
		  /*   width:200px;
		    height:45px; */
		    margin:0 auto;
		  }
		  a,a:visited{color: #E67714; text-decoration:none;}
		</style>
		<style id="clearly_highlighting_css" type="text/css">/* selection */ html.clearly_highlighting_enabled ::-moz-selection { background: rgba(246, 238, 150, 0.99); } html.clearly_highlighting_enabled ::selection { background: rgba(246, 238, 150, 0.99); } /* cursor */ html.clearly_highlighting_enabled {    /* cursor and hot-spot position -- requires a default cursor, after the URL one */    cursor: url("chrome-extension://pioclpoplcdbaefihamjohnefbikjilc/clearly/images/highlight--cursor.png") 14 16, text; } /* highlight tag */ em.clearly_highlight_element {    font-style: inherit !important; font-weight: inherit !important;    background-image: url("chrome-extension://pioclpoplcdbaefihamjohnefbikjilc/clearly/images/highlight--yellow.png");    background-repeat: repeat-x; background-position: top left; background-size: 100% 100%; } /* the delete-buttons are positioned relative to this */ em.clearly_highlight_element.clearly_highlight_first { position: relative; } /* delete buttons */ em.clearly_highlight_element a.clearly_highlight_delete_element {    display: none; cursor: pointer;    padding: 0; margin: 0; line-height: 0;    position: absolute; width: 34px; height: 34px; left: -17px; top: -17px;    background-image: url("chrome-extension://pioclpoplcdbaefihamjohnefbikjilc/clearly/images/highlight--delete-sprite.png"); background-repeat: no-repeat; background-position: 0px 0px; } em.clearly_highlight_element a.clearly_highlight_delete_element:hover { background-position: -34px 0px; } /* retina */ @media (min--moz-device-pixel-ratio: 2), (-webkit-min-device-pixel-ratio: 2), (min-device-pixel-ratio: 2) {    em.clearly_highlight_element { background-image: url("chrome-extension://pioclpoplcdbaefihamjohnefbikjilc/clearly/images/highlight--yellow@2x.png"); }    em.clearly_highlight_element a.clearly_highlight_delete_element { background-image: url("chrome-extension://pioclpoplcdbaefihamjohnefbikjilc/clearly/images/highlight--delete-sprite@2x.png"); background-size: 68px 34px; } } </style><style>[touch-action="none"]{ -ms-touch-action: none; touch-action: none; }[touch-action="pan-x"]{ -ms-touch-action: pan-x; touch-action: pan-x; }[touch-action="pan-y"]{ -ms-touch-action: pan-y; touch-action: pan-y; }[touch-action="scroll"],[touch-action="pan-x pan-y"],[touch-action="pan-y pan-x"]{ -ms-touch-action: pan-x pan-y; touch-action: pan-x pan-y; }</style>
		<script src="<%=basePath%>/js/jquery-1.11.2.min.js" type="text/javascript"></script> 
		<script type="text/javascript" language="javascript">
			$(function() {
				$.ajax({
					url:'<%=localPath%>/invest/showAgreementResp',
                    type:'POST',
                    dataType:'json',
                    data : {
                      userId : "<%=userId %>",
                      loanId : "<%=loanId %>"
                    },
                    success : function (data) {
                    	if (data.success) {
                    		if (!data.isCompleted) {
                    			$(".Agreement_pic").html("借款协议(满标审核后生效)");
                    		}
                    		$(".contractNum").html(data.loan.id); // 合同编号
                    		$(".legalName").html(data.loan.borrowCompany); // 借款人
                    		$(".borrowCompany").html(data.loan.borrowCompany); // 借款企业
//                     		$(".legalId").html(data.loan.legalId); // 身份证
                    		$(".legalNo").html(data.loan.legalNo); // 企业编码
                    		$(".guaranteeCompany").html(data.guaranteeCompany); // 担保方(丙方)
                    		if (data.loan.projectType != '125') {
                    			$("#huarong").hide();
                    		} else {
                    			$("#guarantor").hide();
                    			$("#nohuarong").hide();
                    		}
                    		$(".updateDate").html(data.LendingDate); // 生效日期
                    		$(".configProductName").html(data.configProductName);
                    		$("#investAmountForMorerate").html(data.investAmountForMorerate);
                    		$("#interestForMorerate").html(data.interestForMorerate);
							var firstTable = '';
                    		firstTable += '<tbody>';
                    		firstTable += '	<tr class="ageement_tab">';
                    		firstTable += '		<td width="196" height="40" align="center" valign="middle">用户名</td>';
                    		firstTable += '		<td width="196" height="40" align="center" valign="middle">姓名</td>';
                    		firstTable += '		<td width="196" height="40" align="center" valign="middle">身份证号</td>';
                    		firstTable += '		<td width="196" height="40" align="center" valign="middle">投资金额</td>';
                    		firstTable += '		<td width="196" height="40" align="center" valign="middle">期限</td>';
                    		firstTable += '		<td width="196" height="40" align="center" valign="middle">年利率</td>';
                    		firstTable += '	</tr>';
                    		firstTable += '	<tr class="ageement_tab_ite">';
                    		firstTable += '		<td width="196" height="40" align="center" valign="middle">' + data.invest.investor.loginName + '</td>';
                    		firstTable += '		<td width="196" height="40" align="center" valign="middle">' + data.umpRegister.realName + '</td>';
                    		firstTable += '		<td width="196" height="40" align="center" valign="middle">' + data.umpRegister.cardNo + '</td>';
                    		firstTable += '		<td width="196" height="40" align="center" valign="middle">' + data.investTotal + '元</td>';
                    		if (data.loan.activity == '101' || data.loan.activity == '102') {
                    			firstTable += '	<td width="196" height="40" align="center" valign="middle">' + (data.invest.loanActivity.loanPeriod) + ((data.loan.projectType=="111"||data.loan.repaymentWay=="306"||data.loan.repaymentWay=="307")?"天":"个月") + '</td>';
                    			firstTable += '	<td width="196" height="40" align="center" valign="middle">' + data.invest.loanActivity.loanRate + '%</td>';
                    		} else {
                    			firstTable += '	<td width="196" height="40" align="center" valign="middle">' + (data.loan.loanPeriod) + ((data.loan.projectType=="111"||data.loan.repaymentWay=="306"||data.loan.repaymentWay=="307")?"天":"个月") + '</td>';
                    			if (data.loan.loanType == '3') {
                    				firstTable += '	<td width="196" height="40" align="center" valign="middle">' + data.monthRate + '%</td>';
                    			} else {
                    				firstTable += '	<td width="196" height="40" align="center" valign="middle">' + data.loan.loanRate + '%</td>';
                    			}
                    		}
                    		firstTable += '	</tr>';
                    		firstTable += '</tbody>'
                    		$(".firstTable").html(firstTable);
                    		
                    		var secondTable = '';
                    		secondTable += '<tbody>';
                    		secondTable += '	<tr class="ageement_tab">';
                    		secondTable += '		<td width="196" height="40" align="center" valign="middle">期数</td>';
                    		secondTable += '		<td width="196" height="40" align="center" valign="middle">金额</td>';
                    		secondTable += '		<td width="196" height="40" align="center" valign="middle">本金</td>';
                    		secondTable += '		<td width="196" height="40" align="center" valign="middle">利息</td>';
                    		secondTable += '		<td width="196" height="40" align="center" valign="middle">利息管理费</td>';
                    		secondTable += '		<td width="196" height="40" align="center" valign="middle">截止日</td>';
                    		secondTable += '	</tr>';
                    		$.each(data.page.list, function (index, incomePlan) {
	                    		secondTable += '	<tr class="ageement_tab_ite">';
	                    		secondTable += '		<td align="center">' + incomePlan.period + '</td>';
	                    		secondTable += '		<td align="center">' + incomePlan.actualInterestPrincipal + '元</td>';
	                    		secondTable += '		<td align="center">' + incomePlan.principal + '元</td>';
	                    		secondTable += '		<td align="center">' + incomePlan.interest + '元</td>';
                    			secondTable += '		<td align="center">' + incomePlan.payInterestManagementFee + '元</td>';
                    			secondTable += '		<td height="28" align="center">' + incomePlan.due_date + '</td>';
	                    		secondTable += '	</tr>';
                    		})
                    		secondTable += '</tbody>'
                    		$(".secondTable").html(secondTable);
                    		var seal = '';
                    		seal += '居间方:' + data.configProductName;
                    		seal += '<span class="seal_text">' + data.invest.updateDate;
                    		seal += '</span>';
                    		$(".Seal").html(seal);
                    	}
                    },
                    error : function (data) {
                    	
                    }
				})
			})
		</script>
	</head>
	<body>
		<div class="Lending_Agreement">
			<div class="Lending_Agreement_center">
				<!--顶部信息开始-->
<!-- 			  	<div class="lending_top_inf"> -->
<!-- 			    	<div class="lending_logo"> -->
<!-- 			      		<div class="lenging_left_logo"> -->
<!-- 				      		<a href="http://www.rqbao.com">  -->
<!-- 				      			<img style="float: left;" src="http://www.rqbao.com/static_3/image/logo.jpg" /> -->
<!-- 					            <div style="float:left;margin:6px 6px 0;background:url('http://www.rqbao.com/static_3/image/li.png') no-repeat;width:5px;height:48px;display:inline-block"></div> -->
<!-- 					            <div style="float:right;font:bold 1.4rem Microsoft YaHei;display: inline-block;line-height:47px;color:#333;">互联网金融资产交易信息服务平台</div> -->
<!-- 				            </a> -->
<!-- 			      		</div> -->
<!-- 			    	</div> -->
<!-- 			  	</div> -->
			  	<!--顶部信息结束-->
			  	<div class="lending_ageeement_tit">
			  		<span class="Agreement_pic">借款协议</span>
		  		</div>
			  	<div class="ageeement_content">
				    <p align="left">合同编号：<u><strong class="contractNum"></strong></u></p>
				    <p align="left">甲方（出借人）：详见本协议第一条</p>
				    <p align="left" id="nohuarong">乙方（借款人）：<u class="legalName"></u>&nbsp;&nbsp;&nbsp;&nbsp;
					<!-- 身份证号:<u class="legalId"></u>&nbsp;&nbsp;&nbsp;&nbsp; -->
				      	企业编码:<u class="legalNo"></u>
			    	</p>
			    	<p align="left" id="huarong">乙方（借款企业）：<u class="borrowCompany"></u>&nbsp;&nbsp;&nbsp;&nbsp;
					               注册号:<u>110000015413406</u>
           			</p>
				    <p align="left" id="guarantor">担保方（丙方）：<u class="guaranteeCompany"></u></p>
				    <p align="left">生效日期：<u class="updateDate"></u></p>
				    <p>&nbsp;</p>
				    <p>借款人（乙方）通过<label class="configProductName"></label>创办的网络借贷中介平台&nbsp;&nbsp;（以下简称“本平台”），向本平台的注册会员借款，该借款由担保方（丙方）为借款人（乙方）提供担保。相关借款事项根据《中华人民共和国合同法》等相关法律法规的规定，甲乙丙三方达成如下协议：</p>
				    <p>&nbsp;</p>
			    	<strong class="font_lendig">第一条&nbsp;&nbsp;</strong>
				    <table border="1px" bordercolor="#EEEEEE" cellspacing="0px" style="border-collapse:collapse;margin-top:20px;margin-left:10px;" class="firstTable">
				    	<tbody>
				      		<tr class="ageement_tab">
				      			<td width="196" height="40" align="center" valign="middle">用户名</td>
				        		<td width="196" height="40" align="center" valign="middle">姓名</td>
				         		<td width="196" height="40" align="center" valign="middle">身份证号</td>
				        		<td width="196" height="40" align="center" valign="middle">投资金额 </td>
				        		<td width="196" height="40" align="center" valign="middle">期限</td>
				        		<td width="196" height="40" align="center" valign="middle">年利率</td>
				      		</tr>
				      		<tr class="ageement_tab_ite">
				        		<td width="196" height="40" align="center" valign="middle"></td>
				         		<td width="196" height="40" align="center" valign="middle"></td>
				         		<td width="196" height="40" align="center" valign="middle"></td>
				        		<td width="196" height="40" align="center" valign="middle"></td>
				          		<td width="196" height="40" align="center" valign="middle"></td>
				              	<td width="196" height="40" align="center" valign="middle"></td>
				      		</tr>
				    	</tbody>
			    	</table>
    				<p>&nbsp;</p>
    				<strong class="font_lendig">第二条&nbsp;&nbsp;</strong>
    				<p align="left">1、还款计划：</p>
				    <table border="1px" bordercolor="#EEEEEE" cellspacing="0px" style="border-collapse:collapse;margin-top:20px;margin-left:10px;" class="secondTable">
				    	<tbody>
				    		<tr class="ageement_tab">
						        <td width="196" height="40" align="center" valign="middle">期数</td>
						        <td width="196" height="40" align="center" valign="middle">金额 </td>
						        <td width="196" height="40" align="center" valign="middle">本金</td>
						        <td width="196" height="40" align="center" valign="middle">利息</td>
						        <td width="196" height="40" align="center" valign="middle">利息管理费</td>
						        <td width="196" height="40" align="center" valign="middle">截止日</td>
				       		</tr>
				      	</tbody>
			      	</table>
			      	<p>加息本金：<font id="investAmountForMorerate"></font>元,加息收益：<font id="interestForMorerate"></font>元.</p>
    				<p>2、借款人承诺按照本协议以上约定的时间和金额，按期足额向投资者还款。</p>
				    <p>&nbsp;</p>
				    <strong class="font_lendig">第三条&nbsp;&nbsp; 借款的支付和还款方式 </strong>
				    <p>&nbsp;1、甲方在同意向乙方出借相应款项时，已委托本平台在本借款协议生效时将该笔借款直接划付至借款人帐户。</p>
				    <p>2、乙方在还款时已委托本平台将还款直接划付至甲方帐户。</p>
				    <p>3、借款人和投资者均同意上述平台接受委托的行为所产生的法律后果均由相应委托方承担。</p>
				    <p>&nbsp;</p>
				    <strong class="font_lendig">第四条&nbsp;&nbsp; 担保 </strong>
				    <p>1、本合同项下借款的担保方式为丙方承担连带责任的保证担保。</p>
				    <p>2、丙方完全了解乙方的借款用途，为其提供连带责任的保证担保完全出于自愿，其在本合同项下的全部内容表示真实。</p>
				    <p>3、保证担保的范围包括本合同项下的借款本金、利息、违约金、赔偿金、实现债权的费用（含律师费）和所有其他应付费用。</p>
				    <p>4、保证期间为本合同确定的到期之次日起两年。分期还款的为本合同确定的最后一期还款期限到期之次日起两年。</p>
				    <p>5、若借款人超过截止日仍未还款，则视为逾期。还款发生逾期时，每天的违约金是当天应还款项的千分之八。</p>
				    <p>6、乙方逾期还款，丙方须在乙方逾期的当日内，按照本网站内借贷规则中的赔付方式对甲方（所有出借人）进行垫付本息，同时债权归丙方所有，丙方负责向乙方追讨本息、违约金等。</p>
				    <p>7、丙方保证责任为独立责任，不因甲、乙方借款合同的无效而无效。</p>
				    <p>&nbsp;</p>
				    <strong class="font_lendig">第五条：乙方权利、义务</strong>
				    <p>1、借款人可在每期还款截止日之前的任意时段提前清偿该期还款。</p>
				    <p>2、自觉接受甲方或丙方对本合同项下借款使用情况的调查、了解及监督。</p>
				    <p>3、按本合同约定清偿本合同项下的本金、利息及违约金。</p>
				    <p>4、乙方请求丙方作为担保人，为乙方基于本合同对甲方所负的全部债务承担连带责任。</p>
				    <p>5、变更住所、通讯地址、号码应在变更后，应当立即书面通知甲方或丙方。</p>
				    <p>6、如发生对其履行本合同项下还款义务产生重大影响的任何事件（包括但不限于离、结婚，对外投资，承担民事、行政、刑事责任等），应立即书面通知甲方或丙方。</p>
				    <p>&nbsp;</p>
				    <strong class="font_lendig">第六条：违约责任</strong>
				    <p>1、如乙方未按本合同约定履行归还所借款项义务，丙方对逾期借款从垫付之日起按应还本金每日千分之八收取违约金，直到本息清偿为止。</p>
				    <p>2、乙方有下列行为之一，甲方有权提前收回借款：</p>
				    <p>（1）向甲方或者丙方提供虚假情况或者隐瞒重要事实;</p>
				    <p>（2）不配合、拒绝接受甲方或者丙方的监督;</p>
				    <p>（3）未经甲方或者丙方同意，转让、处分其资产;</p>
				    <p>（4）其财产重要部分或全部被其他债权人占有、接管或其财产被扣押、冻结，可能使甲方或者丙方遭受严重损失的;</p>
				    <p>（5）其他任何可能导致甲方或者丙方实现债权受到威胁或遭受严重损失的。</p>
				    <p>3、如借款人提前一次性清偿剩余的全部应还本金及利息，需额外向甲方支付一个月的利息作为违约金。</p>
				    <p>&nbsp;</p>
				    <strong class="font_lendig">第七条：特别条款</strong>
				    <p>1、借款人不得将所借款项用于任何违法活动（包括但不限于赌博、吸毒、贩毒、卖淫嫖娼等）及一切高风险投资（如证券期货、彩票等），否则一经发现，投资者有权要求提前收回全部借款，投资者或本平台还将立即向公安等有关行政机关举报，追回此款并追究借款人的刑事责任。</p>
				    <p>2、本平台仅作为该网站注册会员之间小额资金互助平台，反对一切利用本平台进行信用卡套现和其他洗钱等不正当交易行为。如发生此类现象，本平台有权向公安等有关行政机关举报，追究其相关法律责任。</p>
				    <p>&nbsp;</p>
				    <strong class="font_lendig">第八条：其他</strong>
				    <p>1、本协议采用电子文本形式制成，并通过站内信的形式发送协议至本平台。</p>
				    <p>2、本协议自借款人在本平台发布的借款标的审核成功之日起生效，借款人、投资者和担保方各执一份，并具同等法律效力。</p>
				    <p>3、其他未尽事宜三方另行协商解决，协商不成，在丙方所在地人民法院通过诉讼解决。</p>
				    <p>4、本平台拥有对本协议的最终解释权。</p>
				   	<p>&nbsp;</p>
      				<div class="Seal">
         				居间方：
        				<span class="seal_text"></span>
					</div>
  				</div>
			</div>
		</div>
	</body>
</html>