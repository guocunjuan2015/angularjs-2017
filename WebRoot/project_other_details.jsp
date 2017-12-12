<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/global.jsp" %>
<!DOCTYPE html>
<html>
<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
		<title></title>
		<link href="css/projectstyle.css" rel="stylesheet" />
		<link href="css/zqzrstyle.css" rel="stylesheet" />
		<link rel="stylesheet" href="css/lightbox.css" type="text/css" media="screen" />
		<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
		<script src="js/project_other_content.js" type="text/javascript"></script>
		<script src="js/project_other_details.js" type="text/javascript"></script>
    <script src="js/jquery.lightbox.js" type="text/javascript"></script>
		<script type="text/javascript">
		  $(document).ready(function() {
		    $(".lightbox").lightbox({
		      fitToScreen : true,
		      imageClickClose : true
		    });
		  });
		</script>
</head>
<body ng-controller="projectdetailsController">

  <div id="bg"></div>
    <section class="ays" id="ays">
        <div class="ays_h5">
            <h5
                style="text-decoration: underline; background: url(images/common/ays_question.png) no-repeat 80% center; background-size: 6.5%"
                onclick="linkTo('date_project.jsp')">输入投标密码</h5>
            <img src="images/input_clear.png" onclick="dismissAys()" />
        </div>
        <div>
            <input class="form-control input-number" type="tel"
                placeholder="请输入投标密码" id="ctPsw"></input>
        </div>
        <p class="ays_content" id="yb_content">请输入投标密码！致电客服约标,约标成功后可获得投标密码</p>
        <ul class="ays_ul">
        <li><button class="btn btn-primary" style="width: 30%" onclick="linkTo('tel://4000827002')">去约标</button></li>
        <li><button class="btn btn-danger" id="checkCP" style="width: 30%;" onclick="checkContributionAndSave()">&nbsp;确定&nbsp;</button></li></ul>
    </section>
    <section class="ays" id="ays2">
        <div class="ays_h5">
            <h5 style="color: #333;">提示信息</h5>
            <img src="images/input_clear.png" onclick="dismissAys2()" />
        </div>
        <p style="padding: 5% 5% 8% 5%;color: #333;font-size: 1.6rem;" id="ays_content2"></p>
        <ul class="ays_ul">
        <li><button class="btn btn-primary" style="width: 30%" onclick="dismissAys2()">取消</button></li>
        <li><button class="btn btn-danger" id="checkCP" style="width: 30%;" onclick="needToRecharge()">&nbsp;确定&nbsp;</button></li></ul>
    </section>
  <header class="headers">
    <ul>
      <li class="active" onclick="tabClick(1)" id="tab1">项目详情</li>
      <li id="tab2" onclick="tabClick(2)">风险控制</li>
      <li id="tab3" onclick="tabClick(3)" style="border-right: none">投资记录</li>
    </ul>
  </header>
  <section class="projectcontent">
	    <section id="page1" class="page">
	            <div  class="project_infor">
	              <!--项目描述 start  -->
	                <div class="project_list">
	                      <h5 class="dt_title">项目描述</h5>
	                      <p  id="type_info_p"></p>
	                </div>
	                <!--资金用途 start  -->
	                <div class="project_list">
	                      <h5 class="dt_title">资金用途</h5>
	                      <p  id="fin_use"></p>
	                </div>
	            <!--还款来源 start  -->
	                <div class="project_list">
	                      <h5 class="dt_title">还款来源</h5>
	                      <p  id="pay_resource"></p>
	                </div>          
	            <!--证明材料 start  -->
	                <div class="project_list">
	                      <h5 class="dt_title">证明材料</h5>
	                      <ul>
	                          <li class="col-lg-4 col-ms-4 col-sm-4 col-xs-4"></li>
	                          <li class="col-lg-4 col-ms-4 col-sm-4 col-xs-4"></li></li>
	                          <li class="col-lg-4 col-ms-4 col-sm-4 col-xs-4"></li></li>
	                      </ul>
	                </div>  
	            
	            </div>
	    
	    
	      <div style="display: none">
	        <h5 class="dt_title">项目信息</h5>
	        <div class="contenttable">
	          <table cellpadding="0" cellspacing="0" border="0">
	            <thead id="head_pj_name" style="display: none">
	              <th>名称</th>
	              <th class="secondsdd" id="project_name"></th>
	            </thead>
	            <tbody>
	              <tr id="fb_period" style="display: none">
	                <td>封闭期限</td>
	                <td class="secondsdd" id="project_period"></td>
	              </tr>
	              <tr id="epct_income_per_year" style="display: none">
	                <td>预期年化收益</td>
	                <td class="secondsdd" id="project_rate"></td>
	              </tr>
	              <tr id="qt_money" style="display: none">
	                <td>起投金额</td>
	                <td class="secondsdd" id="min_invest"></td>
	              </tr>
	              <tr style="display: none">
	                <td>借贷人信息</td>
	                <td class="secondsdd" id="jdr_info"></td>
	              </tr>
	              <tr id="finc_use_tr" style="display: none">
	                <td>资金用途</td>
	                <td class="secondsdd" id="fin_use"></td>
	              </tr>
	              <tr id="hk_resource" style="display: none">
	                <td>还款来源</td>
	                <td class="secondsdd">
	                  <p id="pay_resource"></p>
	                </td>
	              </tr>
	              <tr id="mortgageInfo_td" style="display: none">
	                <td>抵押物信息</td>
	                <td class="secondsdd">
	                  <p id="mortgageInfo"></p>
	                </td>
	              </tr>
	              <tr>
	                <td>还款方式</td>
	                <td class="secondsdd" id="repay_way">按月付息到期还本</td>
	              </tr>
	              <tr class="lasttr" id="exit_way" style="display: none">
	                <td>退出方式</td>
	                <td class="secondsdd">到期退出持有1个月以上可转让</td>
	              </tr>
	            </tbody>
	          </table>
	        </div>
	      </div>
	    </section>
	    <!-- 风险控制start -->
	    <section id="page2" style="display: none">
			    <img  src="images/project_content/riskControlmg.png"/>
			       <!--还款来源 start  -->
			        <div class="project_list">
			            <h5 class="dt_title">保障措施一：</h5>
			            <p id="first_tp"></p>
			        </div>  
			        
			         <div class="project_list">
			            <h5 class="dt_title">保障措施二：</h5>
			              <p id="seconddtp"></p>
			        </div>  
				      <p class="rdb-info" style="display: none" id="dyw_info"></p>
				      <div id="pjt_pic_info" class="business-info" style="display: none">
				        <h5 class="dt_title">合同资料</h5>
				        <ul id="list_content">
				        </ul>
				      </div>
	    </section>
	    <!-- 投资记录start -->
	    <section id="page3" style="display: none">
	       <div class="invest_record">
           <ul>
                <li>134****423</li>
                <li>100,000</li>
                <li>2016-09-06</li>
           </ul><div class="clear"></div>
           <ul>
                <li>134****423</li>
                <li>100,000</li>
                <li>2016-09-06</li>
           </ul><div class="clear"></div>
        </div> 
	      <div id="predgeList_content">
	        <div class="safediv" style="display:none;">
	          <div id="bzh1" class="safediv-height" style="display: none">
	            <p class="firstp">保障措施一：</p>
	            <p id="first_tp"></p>
	          </div>
	          <div id="bzh2" class="safediv-height" style="display: none">
	            <p id="bzh2_p" class="firstp">保障措施二：</p>
	            <p id="seconddtp"></p>
	          </div>
	          <div class="safediv-height">
	            <p id="bzh3_p" class="firstp" style="display: none">保障措施三：</p>
	            <p>由第三方担保公司担保</p>
	            <br />
	            <p class="font_bold">担保机构</p>
	            <p id="bzh3_jig"></p>
	            <br />
	            <p class="font_bold">担保机构简介</p>
	            <p id="bzh3_jig_jj"></p>
	          </div>
	        </div>
	      </div>
	    </section>
	    <!-- 投资记录end -->
	     <p><button class="btnjoin" id="investBtnNew" onclick="invest()">&nbsp;</button></p>
  </section>
  <div id="footpanel" style="border: none; height: auto;display:none">
    <div id="error_info" class="error_info"></div>
    <section class="tzAdd">
      <div id="yue_div" style="display: none">
        可用余额： <span id="yue_span"> </span>元 <span id="to_recharge"
          onclick="toRecharge()">去充值>></span>
      </div>
      <div id="epxt_div" style="display: none">
        预期收益： <span id="epxt_income"> </span>元
      </div>
      <div class="Addinfo" id="add_invest">
        <span id="input_span"> <input
          class="form-control input-number" type="tel" id="invest_number"
          min="0" onkeyup="changeInvest(this.value)" onclick="checkStatus()"
          placeholder=""></input></span>
        <button class="btnjoin" id="button_invest" onclick="invest()">&nbsp;</button>
      </div>
    </section>
    <input type="hidden" id="project_type" />
  </div>
  
  
  <button style="display: none" id="myModal" type="button"
    class="btn btn-danger mt20 ml20" data-toggle="modal"
    data-target=".bs-example-modal-lg">温馨提示</button>
  <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog"
    aria-labelledby="myLargeModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal"
            aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
          <h4 class="modal-title" id="myModalLabel">提示信息</h4>
        </div>
        <div class="modal-body">
          <h4 class="text-success text-center" id="tip_content"></h4>
          <!-- <p>投资金额：<span class="text-danger" id="money_invest_modal">1000</span>元</p> -->
        </div>
        <div class="modal-footer">
          <button type="button" style="display: none" onclick="gotoPage(0)"
            id="msg_btn_0" class="btn btn-primary btn-block">设置支付密码</button>
          <button type="button" style="display: none" onclick="gotoPage(1)"
            id="msg_btn_1" class="btn btn-primary btn-block">实名认证</button>
          <button type="button" style="display: none" onclick="gotoPage(2)"
            id="msg_btn_2" class="btn btn-primary btn-block">绑定银行卡</button>
          <button type="button" style="display: none"
            onclick="needRecharge()" id="msg_btn_3"
            class="btn btn-primary btn-block">充值</button>
          <button type="button" style="display: none" onclick="gotoPage(4)"
            id="msg_btn_4" class="btn btn-primary btn-block"
            data-dismiss="modal">绑定银行卡(联动优势)</button>
          <div id="msg_btn_5" style="display: none">
            <button type="button" onclick="gotoPage(5)"
              class="btn btn-danger btn-block" data-dismiss="modal">立即操作</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
