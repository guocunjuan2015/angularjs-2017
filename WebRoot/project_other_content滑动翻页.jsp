<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/global.jsp" %>
<%@ include file="/config/config.jsp" %>
<%
String path = request.getContextPath();
/* String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; */ 
String project_id = request.getParameter("id");
String projectType = request.getParameter("projectType");
%>
<!DOCTYPE html>
<html ng-app="projectdetailsApp">
<head>
	<meta charset="utf-8" />
	<title id="project_name">产品列表-项目详情</title>
	<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
	<link rel="stylesheet" href="css/swiper.min.css"> 
	<link href="css/rqbao_index.css" rel="stylesheet"/>
	<link href="css/zqzrstyle.css" rel="stylesheet" />
	<script src="js/project_other_content.js" type="text/javascript"></script>
</head>
<body>
 <%@ include file="/config/globalHead.jsp" %>
 <input type="hidden" value="<%=localPath%>"  id="localPath">
  <input type="hidden" value="<%=basePath%>"  id="basePath">
 <input type="hidden" value="${param.id}"  id="project_id">
 <input type="hidden" value="<%=userId%>"  id="userId">
 <input type="hidden" value="${param.projectType}"  id="projectType">
 <script>
        var project_id = $("#project_id").val();
        var userId = $("#userId").val();
        var projectType = $("#projectType").val();
        function tabClick(index){
			  for(var i = 1;i<= 3;i++){
			    $("#tab"+i).removeClass("active");
			    $("#page"+i)[0].style.display = "none";
			  }
			  $("#tab"+index).addClass("active");
			  $("#page"+index)[0].style.display = "block";
			}
  </script>
	 <!-- 主题内容显示区 -->
	 <div id="main">
           <div  ng-controller="projectdetailsController">
           <!-- 详情banner部分 -->
          <div class="swiper-container">
              <div class="swiper-wrapper">
                  <div class="swiper-slide">
				               <section class="project_content">
												    <p>
												    	<span id="project_loanRate">{{rate}}</span>
												    	<span ng-if="subsidyRate != '0'" > + {{subsidyRate}}</span><font>%</font>
											    	</p>
												    <p class="border_bottom"><i class="border_bottom_l"></i>预期年化收益<i class="border_bottom_r"></i></p>
												</section>
												<section class="pj_top outter">
												   <div class="poject_top">
															<ul>
																<li class="col-lg-4 col-ms-4 col-sm-4 col-xs-4">
																	<p id="project_loanPeriod"> 
																	   {{projectPeriod}} 
																	</p>
																	<p class="bottom_tit" id="qixian">{{deadlineDetail}}</p>
															 </li>
															<li class="col-lg-4 col-ms-4 col-sm-4 col-xs-4">
											            <p><span id="project_balance">{{residualAmount}}</span></p> 
											            <p class="bottom_tit">剩余金额</p>
											         </li>
											        <li class="col-lg-4 col-ms-4 col-sm-4 col-xs-4">
											            <p><font id="project_minNum">{{totleMoney}}</font></p>
											            <p class="bottom_tit">项目总金额 </p>
											         </li>
															</ul>
														</div>	
													 <div class="bottom_progress" style="display: none">
														   <span id="investCount"> </span>
														</div>
												</section>
									      <section class="projectlx outter">
									            <ul>
									               <li class="projectlx-lastli" style="border-bottom:6px solid #F5F4F4;">
				                              <span >万元预计收益</span> <span class="projectlx-secondspan" id="time_span1" style="color:#ff5555;">{{incomePerMyriad}}</span>
				                         </li>
											           <li class="projectlx-lastli">
											                <span >投标倒计时</span> <span class="projectlx-secondspan" id="time_span"> </span>
											           </li>
											            <li>
									                  <span>起息时间</span> 
									                  <span class="projectlx-secondspan">投标当天起息</span>
									                </li>
									                <li>
													            <span>还款方式</span>
													            <span class="projectlx-secondspan" id="project_repaymentWay">{{paymentMethod}}</span>
											            </li>
									            </ul>
									    </section>
					    <!--  <section class="yjhcontent outter">
					        <div class="plandiv">
					            <ul>
					                <li class="firstli" onclick="getDetail()">
					                <p><img
					                    src="images/projectincr.png" /></p>
					                    <p class="intro_p">项目介绍</p></li>
					
					                <li class="secondli" onclick="toInvestRecord()">
					                <p><img src="images/addrecord.png" /></p>
					                    <p class="intro_p">投资记录</p></li>
					            </ul>
					        </div>
					    </section> -->
					 </div>
				 <div class="swiper-slide">	    
					   <!--项目详情start  --> 
						<div class="headers" style="border-bottom:none;">
						    <ul>
						      <li class="active" onclick="tabClick(1)" id="tab1">项目详情</li>
						      <li id="tab2" onclick="tabClick(2)">风险控制</li>
						      <li id="tab3" onclick="tabClick(3)" style="border-right: none">投资记录</li>
						    </ul>
				   </div>
				  <div class="projectcontent">
				      <section id="page1" class="page">  
				           <!-- 普通项目详情start -->
				              <div  class="project_infor" ng-if="isBorrowing == false">
				                <!--项目描述 start  -->
				                  <div class="project_list">
				                        <h5 class="dt_title">项目描述</h5>
				                        <p  id="type_info_p">{{projectIntro}}</p>
				                  </div>
				                  <!--资金用途 start  -->
				                  <div class="project_list">
				                        <h5 class="dt_title">资金用途</h5>
				                        <p  id="fin_use">{{fundPurpose}}</p>
				                  </div>
				              <!--还款来源 start  -->
				                  <div class="project_list">
				                        <h5 class="dt_title">还款来源</h5>
				                        <p  id="pay_resource">{{paymentSource}}</p>
				                  </div>          
				              <!--证明材料 start  -->
				                  <div class="project_list">
				                        <h5 class="dt_title">证明材料</h5>
				                        <ul>
				                            <li ng-repeat="proofUrlList in proofUrlLists" class="col-lg-4 col-ms-4 col-sm-4 col-xs-4"> 
				                                <img  ng-src="{{proofUrlList}}" alt="" />
				                            </li>
				                         
				                        </ul>
				                  </div>  
				              
				              </div>
				               <!-- 普通项目详情end -->
				              
				               <!-- 借款项目详情start -->
				              <div  class="project_infor" ng-if="isBorrowing == true">
                        <!--借款理由start  -->
                          <div class="project_list">
                                <h5 class="dt_title" ng-show="borrowRemark != ''">借款理由</h5>
                                <p  id="type_info_p">{{borrowRemark}}</p>
                          </div>
                          <!--资金用途 start  -->
                          <div class="project_list">
                                <h5 class="dt_title">借款人身份</h5>
                                <ul>
                                  <li>用户名:{{borrowLoginName}} </li>
                                  <li>姓名:{{borrowUserName}}</li>
                                  <li>性别:{{sex}}</li>
                                  <li>身份所在地:{{homeAddr}}</li>
                                </ul>
                          </div>
                      <!--借款人学历start  -->
                          <div class="project_list">
                                <h5 class="dt_title" ng-show="borrowEducation != ''">借款人学历</h5>
                                <p ng-bind="borrowEducation"></p>
                          </div>          
                      <!--认证信息 start  -->
                          <div class="project_list">
                                <h5 class="dt_title">认证信息</h5>
                                <table border="1" style="border:1px solid #555555">
                                  <tr>
                                    <td>项目</td>
                                    <td>认证状态</td>
                                    <td>认证时间</td>
                                  </tr>
                                 
                                  <tr  ng-repeat="contactTypeList in contactTypeList" style="text-align:center;">
	                                    <td>{{contactTypeList.contactType}}</td>
	                                    <td ng-if="contactTypeList.contactType!=''">已认证</td>
	                                    <td>{{approDate}}</td>
                                  </tr>
                                
                                </table>
                          </div> 
                           <!--证明材料 start  -->
                          <div class="project_list">
                                <h5 class="dt_title">借入记录</h5>
                                <ul>
                                  <li>共计借入：{{BorrowTotalAmount}}元</li>
                                  <li>借款次数：{{BorrowTotalNum}}次</li>
                                  <li>正常还清：{{normalPayNum}}次（其中提前还清 0 次）</li>
                                  <li>待还本金：{{WaitePrincipal}}元</li>
                                </ul>
                          </div>   
                      
                      </div>
				              <!-- 借款项目详情start -->
				      
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
				              <div class="project_list" ng-if="riskUrl == ''">
				                  <h5 class="dt_title">保障措施一：</h5>
				                  <p id="first_tp">{{safeguard1}}</p>
				              </div>  
				              
				               <div class="project_list" ng-if="riskUrl == ''">
				                  <h5 class="dt_title">保障措施二：</h5>
				                    <p id="seconddtp">{{safeguard2}}</p>
				              </div> 
				              
				              <div class="project_list" ng-if="riskUrl == ''">
                          <h5 class="dt_title">保障措施三：</h5>
                            <p>{{safeguard3}}</p>
                      </div> 
                       <div class="project_list" ng-if="riskUrl != ''">
                            <object type="text/x-scriptlet" data="{{riskUrl}}" width=100% height=100%></object>
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
				           <ul ng-repeat="invest_record in invest_records">
				                <li>{{invest_record.investorName}}</li>
				                <li>{{invest_record.investAmount}}</li>
				                <li>{{invest_record.investDate}}</li>
				           </ul><div class="clear"></div>
				        </div>
				        <div ng-show="showLoadMsg" class="loading">{{loadMsg}}</div>
				      </section>
				      <!-- 投资记录end -->
				    </div>
          </div> 
         </div>    
				      <div class="globalFooter">
				        <div>
				         		<p style="text-align:center;"><button  id="investBtnNew" onclick="checkStatus()">投资</button></p>
				         </div>
				      </div>
				  </div>
			  </div>
    </div>
    <!-- 底部输入框区 -->
    <div id="footpanel">
			    <div id="error_info" class="error_info"></div>
			     <section class="tzAdd">
			        <div id="yue_div" style="display: none">
			                           可用余额： <span id="yue_span"> </span>元 
			          <span id="to_recharge" onclick="toRecharge()">去充值>></span>
			        </div>
			        <div id="epxt_div" style="display: none">
			            <span class="epxt">预期收益：</span> <span class="epxt" id="epxt_income"> </span>
			            <span id="epxt_yuan">元</span><span id="all_in"
			                onclick="allIn()">一键全投</span>
			        </div>
			        <div></div>
			        <div class="Addinfo" id="addinitProjectInfo_invest" style="display:none;">
			            <span id="input_span"> <input class="form-control input-number"
			                type="tel" id="invest_number" min="0"  
			                onkeyup="changeInvest(this.value)" onclick="checkStatus()"
			                placeholder=""></input></span> <button class="btnjoin"
			                id="button_invest" onclick="invest()">&nbsp;</button>
			        </div>
			    </section>
    </div>
  
    <div>
        <FORM id="form_save_cop_info">
            <input type="hidden" name="copType" id="copType" /> <input
                type="hidden" name="passValue" id="passValue" /> <input
                type="hidden" name="copId" id="copId" /> <input type="hidden"
                name="project_type" id="project_type" />
        </FORM>
    </div>
    <div style="display: none">
        <span id="project_id"></span>
    </div>

    <button style="display: none" id="myModal" type="button" 
     class="btn btn-danger mt20 ml20" data-toggle="modal"
        data-target=".bs-example-modal-lg">
                          温馨提示
    </button>
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
                    <button type="button" style="display: none" onclick="gotoPage(3)"
                        id="msg_btn_3" class="btn btn-primary btn-block">充值</button>
                    <button type="button" style="display: none" onclick="gotoPage(4)"
                        id="msg_btn_4" class="btn btn-primary btn-block"
                        data-dismiss="modal">绑定银行卡(联动优势)</button>
                    <div id="msg_btn_5" style="display: none">
                    <button type="button"  onclick="gotoPage(5)"
                        class="btn btn-danger btn-block"
                        data-dismiss="modal">立即操作</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
    <!--转让条件弹框start-->
	    <!--<section class="ays" id="ays3">
	        <div class="ays_h5">
	            <h5 style="color: #333;">转让条件说明</h5>
	            <img src="images/input_clear.png" onclick="dismissAys3()" />
	        </div>
	       
	        <p style="margin:0 2rem 0 2rem;line-height:3rem;text-align:center;color: #333;">在投资该项目时，如果使用了红包，则该项目不可转让；如果使用了加息券，则加息券的利息作废。</p>
	    </section>
      <!--转让条件弹框end-->
<div class="fixedDirlog"></div>
<div class="evaluation">
    <h3>请先完成风险测评</h3>
    <p>本项目适合风险承受能力为“保守型、稳健型、积极型”的用户投资。认购前，请先完成风险评估测试。</p>
    <p><a class="closelog" href="javascript:;">暂不投资</a><a href="<%=basePath%>/riskAssessment.jsp?reflect_url=project_other_content.jsp?id=${param.id}&projectType=${param.projectType}">立即测评</a></p>
  </div>
  <script src="js/swiper.min.js"></script>
   <script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        direction: 'vertical',
        slidesPerView: 1,
        paginationClickable: true,
        spaceBetween: 30,
        mousewheelControl: true
    });
    </script>
</body>
</html>
