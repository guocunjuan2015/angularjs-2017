<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/config.jsp" %>
<% 
HttpSession s = request.getSession();
String from = request.getParameter("from");
String user = "";
String appUser = request.getParameter("user");
String userAppId = request.getParameter("userId");
String userApp = request.getParameter("user");
String utm_source = request.getParameter("utm_source");//渠道
if("app".equals(from) && appUser != null && !("").equals(appUser)){
    user = request.getParameter("user");
}else if(s.getAttribute("loginUser") != null){
    user = (String)s.getAttribute("loginUser");
};
 
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control"
  content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
<title>瑞钱宝新手注册</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/activity/newhand.css" rel="stylesheet">
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/jweixin-1.0.0.js" type="text/javascript"></script>
<script src="js/frame/ios_js.js" type="text/javascript"></script>
<script src="<%=basePath%>/js/weixin_share.js" type="text/javascript"></script>
<script src="js/json2.js" type="text/javascript"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
<script type="text/javascript">
  var title = "";
  var content = "";
  var icon = "";
  var _url  = "";
  var url  = "";
  var projectId = "";
  var projectType = "";
  var appObject = {
		getUserInfo : function(userId, userName, isRealName, isBindCard) {
			var storage = window.sessionStorage;
			storage.setItem("userId", userId);
			storage.setItem("userName", userName);
			storage.setItem("isRealName", isRealName);
			storage.setItem("isBindCard", isBindCard);
		}
	}
	$(function(){
		getProjectList();
		/*点击红包规则列表 */
		   $(".packages li img").on("click",function(){
			     IOSModel.toIosInvest();
		        if (isAndroidOrIos()) {
		          toIosInvest();
		          appFunction('invest');
		        } else {
		          toIosInvest();
		          window.location.href = "project.jsp";
		        }
    })

		/*点击红包规则列表 */
		$(".newhandTitle").on("click",function(){
			IOSModel.iosRegist();
			if (isAndroidOrIos()) {
				iosRegist();
				appFunction('regist');
			} else { 
				window.location.href = "ump_register.jsp";
			}
		})
		
		/*关闭红包规则弹框 */
      $(".btn-danger").click(function(){
    $(".modal-backdrop").hide();
    $("#myModal").hide();
    })
    
		if ('<%=user %>') {
			$(".register").css("background-image","url(images/activity/newhand/btn_01-1.png)");
			$(".register").attr("onclick", "javascript:;");
			$(".register").html("已注册");
			$.ajax({
				type : "POST",
				url : "<%=localPath %>/appAccount/checkRegisterStatus",
				dataType : "JSON",
				data : {
					u : "<%=user %>"
				},
				success : function (data) {
					if (data.success) {
						// 判断是否实名 认证
						if (data.liandongRegister) {
							$(".openUmp").css("background-image","url(images/activity/newhand/btn_01-1.png)");
							$(".openUmp").attr("onclick", "javascript:;");
							$(".openUmp").html("已实名")
						}
						
						// 判断是否绑卡
						if (data.liandongBankcard) {
							$(".bindCard").css("background-image","url(images/activity/newhand/btn_01-1.png)");
							$(".bindCard").attr("onclick", "javascript:;");
							$(".bindCard").html("已绑卡")
						}
						
						// 判断是否投资过新手标
						if (data.isInvestNewHandLoan) {
							$(".btn-bind").css("background-image","url(images/activity/newhand/btn_01-1.png)");
							$(".btn-bind").attr("id", "");
						}
						
						// 判断是否首次投资
						if (data.isInvest) {
							$(".toProject").css("background-image","url(images/activity/newhand/btn_01-1.png)");
							$(".toProject").attr("onclick", "javascript:;");
							$(".toProject").html("已投资")
						}
					} else {
						alert(data.msg);
					}
					
				},
				error : function (data) {
					alert('温馨提示-服务器错误，请联系管理员')
				}
			});
		}
	});
	function toProject() {
		IOSModel.toIosInvest();
		if (isAndroidOrIos()) {
			toIosInvest();
			appFunction('invest');
		} else {
			toIosInvest();
			window.location.href = "project.jsp";
		}
	}

	
	// 去绑卡
	function bindCard() {
		IOSModel.toBindCard();
		if (isAndroidOrIos()) {
			appFunction('bindCard');
		}
	}
	
	// 去开户
	function openUmp() {
		IOSModel.openUmp();
		if (isAndroidOrIos()) {
			appFunction('openUmp');
		}
	}
	
	function showShare() {
		IOSModel.changeWebTitle("瑞钱宝新手注册");
	}
  $(function(){
      title = "瑞钱宝新手注册";
      content = "瑞钱宝—大型国企参股，多种优质项目，让您轻松理财！";
      icon = "<%=basePath %>/images/app/488.png";
      url  = "<%=basePath %>/new_hand.jsp?from=app&utm_source=<%=utm_source %>";
      _url  = "<%=basePath %>/new_hand.jsp?from=app&utm_source=<%=utm_source %>";
       // getReferenceRank();
      /*分享好友*/
        weixinShare(title,content,icon,_url,'<%=basePath%>');
    });
  /*分享 */
  function shareClick() {
   var shareUrl=url;
     if("<%=userApp %>" != null && 
          "<%=userApp %>" != "" && 
          "<%=userApp %>" != "null"){
           if(shareUrl.indexOf("&referrer")>=0)
           {
           }
           else
           {
           shareUrl=shareUrl+"&referrer="+$("#m").val();
           url=shareUrl;
           }
    }
    var uu = '<%=userApp%>';
    if(!uu){
      showAys3("您还没有登录，需要登录后才可以分享，现在去登录？");
    }else{ 
      if (isAndroidOrIos()) {
              IOSModel.noticeShare({
                  "url" : shareUrl,
                  "title" : title,
                  "content" : content,
                  "icon" : icon
              });
              iosShare(title, content, icon, shareUrl);
              appFunction('share');
          } else {
            weixinShare(title,content,icon,_url,'<%=basePath%>');
             showShareBox();
          }
    }
  }
    function showShare() {
      IOSModel.showShareBtn();
    }
    
    function shareWithType() {
      var shareUrl=url;
      if("<%=userApp %>" != null && 
        "<%=userApp %>" != "" && 
        "<%=userApp %>" != "null"){
          shareUrl=url+"&referrer="+$("#m").val();
          
        }
      IOSModel.noticeShare({
        "url" : shareUrl,
        "title" : title,
        "content" : content,
        "icon" : icon
      });
    }
	function getProjectList() {
		var url = "";
		url = "project/newget.do";
		$
				.ajax({
					type : "POST",
					url : url,
					data : {
						type : 2,
						childType : "",
						status : "",
						order : "",
						orderType : "",
						index : 1,
						size : 10,
						from : ""
					},
					success : function(response) {
						if (response.success) {
							var info = $.parseJSON(response.result);
							if (info.result) {
								var projects = info.resultObject.list == undefined ? info.resultObject
										: info.resultObject.list;
								if (projects.length == 0) {
								} else {
									for(var i = 0;i<projects.length;i++){
										if(projects[i].projectType == "111"){
											addDataToPage(projects[i]);
											return;
										}
									}
								}

							} else {
								errorMsg(info.errInfo);
							}
						} else {
							errorMsg(response.msg);
						}
					},
					dataType : "json"
				});
	}
	  
	function addDataToPage(data){
		  if(data.award>0){
			  $("#rate")[0].innerHTML = data.loanRate_split + " + " + data.award; 
		  }else{
			$("#rate")[0].innerHTML = data.loanRate_split;
		  }
			$("#period")[0].innerHTML = data.loanPeriod;
			$("#unit")[0].innerHTML = data.unit;
			$("#total")[0].innerHTML = data.loanAmount;
			/* $("#progress")[0].innerHTML = data.projectPercent + "%";
			$("#progressBar").css("width", data.projectPercent+"%"); */
			$(".handProcess1").on("click",function(){
				
// 				IOSModel.toIosInvest();
				projectId = data.projectID;
				projectType = '1';
		        if (isAndroidOrIos()) {
					if (window.sessionStorage.getItem("userId") != null 
							&& window.sessionStorage.getItem("userId") != '') {
			    	    IOSModel.toProjectDetail({
			    		    projectId : data.projectID,
			    		    projectType : '1',
			    		    loanType : data.projectType
			    	    });
	// 		            toIosInvest();
			            appFunction('toProjectDetail');
					} else {
						toProject();
// 						IOSModel.login();
// 						appFunction('login');
					}
		        } else {
                    toIosInvest();
                    window.location.href = "project_other_content.jsp?id=" + data.projectID;
		        }
    })
	}
	
	function toParter(){
		window.location.href = "partner.jsp?from=<%=from%>&user=<%=user%>";
	}
	
</script>
</head>
<body style="background:#A5034D;">
<div class="newHandsBanner"><img src="images/activity/newhand/banner.png"  /></div>
<div class="newHandsBanner"></div>
  <div class="newhandBox">
    <div class="centerdiv">
      <!-- 注册即享488元理财红包 -->
      <div class="newhand newhand1">
        <p class="newhandTitle"><img src="images/activity/newhand/pro_02.png"/></p>
        <div class="handProcess">
          <img  src="images/activity/newhand/pro_09.png"/>
        </div>
      </div>
      
      <!-- 注册即享大礼包 -->
      <div class="newhand newhand2">
        <p class="newhandTitle"><img src="images/activity/newhand/pro_04.png"/></p>
        <div class="packages">
					<ul>
						<li class="col-xs-6 col-sm-6 col-md-6  col-lg-6"><img
							src="images/activity/newhand/redPapper1.png" />
						<p>
								<span>投资金额：800元</span>投资期限：1个月及以上
							</p></li>
						<li class="col-xs-6 col-sm-6 col-md-6  col-lg-6"><img
							src="images/activity/newhand/redPapper2.png" />
						<p>
								<span>投资金额：1000元</span>投资期限：3个月及以上
							</p></li>
					</ul>
					<ul>
						<li class="col-xs-6 col-sm-6 col-md-6  col-lg-6"><img
							src="images/activity/newhand/redPapper3.png" />
						<p>
								<span>投资金额：5000元</span>投资期限：3个月及以上
							</p></li>
						<li class="col-xs-6 col-sm-6 col-md-6  col-lg-6"><img
							src="images/activity/newhand/redPapper4.png" />
						<p>
								<span>投资金额：5000元</span>投资期限：6个月及以上
							</p></li>
					</ul>
					<ul>
						<li class="col-xs-6 col-sm-6 col-md-6  col-lg-6"><img
							src="images/activity/newhand/redPapper5.png" />
						<p>
								<span>投资金额：5000元</span>投资期限：12个月
							</p></li>
						<li class="col-xs-6 col-sm-6 col-md-6  col-lg-6"><img
							src="images/activity/newhand/redPapper6.png" />
						<p>
								<span>投资金额：20000元</span>投资期限：12个月
							</p></li>
					</ul>
					<div class="clear"></div>
				</div>
      </div>
        <p class="redRule"><a data-toggle="modal" data-target="#myModal" href="javascript:;" >查看红包使用规则</a></p>
      <!-- 新手专享理财计划 -->
      <div class="newhand newhand3">
        <p class="newhandTitle"><img src="images/activity/newhand/pro_06.png"/></p>
        <div class="handProcess1">
          <div class="xmggdiv">
		          <div class="percentList" style="float: left; width: 25%;">
		            <div style="margin:10% 0 10px 0;position: relative; text-align: left;">
		              <span class="yq-bigfont" style="font-size: 1.6rem;" id="rate"><span
		                style="color: #f64840; font-size: 1.6rem;">%</span>
		              </span> <span class="yq-smallfont">年化收益率</span>
		            </div>
		          </div>

				        <div class="endlist" style="padding-left: 2%;width: 35%;">
		
					            <ul>
						              <li><span>期限:</span> <span id="period"></span><span
						                style="font-size: 1.2rem;" id="unit"></span></li>
						              <li><span>剩余金额:</span> <span id="total"></span><span
					                style="font-size: 1.2rem;"></span></li>
					            </ul>
		          </div>
		          <div class="endlist" style="margin-left:2rem;width:25%;">
		            <ul>
		              <li><a class="btn-bind  btn btn-danger"><span id="buyBtn">查看详情</span></a></li>
		            </ul>
		          </div>

          <div class="clear"></div>
        </div>
  </div>
</div>

<p class="newhandTitle" style="margin:0 1rem 2rem 1rem;"><a href="javascript:;" id="toRegister"><img src="images/activity/newhand/pro_08.png"/></a></p>
<!-- 活动说明 -->
<div class="newhand newhand3">
  <p class="newhandTitle"><img src="images/activity/newhand/pro_07.png"/></p>
  <div class="eventDescri">
    <p>1.活动所有奖励以红包形式发放至用户“我的帐户－我的礼物－红包”中，可在用户投资时使用</p>
    <p>2.投资成功标满计息，红包对应金额会返到“我的帐户－可用帐户余额”中</p>
    <p>3.活动时间：2016年9月26日－2017年3月1日</p>
    <p>4.客服电话：400-919-8555</p>
  </div>
  <p style="margin:2rem 0 2rem 0; text-align:center;"><img src="images/activity/newhand/code.png"/></p>
</div>
</div>
<div class="copyRights"><p>*本次活动最终解释权归瑞钱宝所有</p><p>如有疑问请咨询400-919-8555</p></div>
</div>

<!-- 点击红包规则弹框-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog" style="margin-left:2rem;width:90%">
      <div class="modal-content">
         <div class="modal-body" style="line-height:30px;">
            <p style="text-align:center;"><img class="ruleTitle" src="images/activity/newhand/ruleTitle.png"/></p>
               <div class="ruleContent">
                   <p>1、使用红包之后，不可进行债权转让； </p>
                   <p>2、投资债权转让的标的，不能使用红包； </p>
                   <p>3、投资红包均设有使用期限，逾期则失效。</p>
              </div>
              <p style="text-align:center;"><a href="javascript:;" class="btn btn-danger">知道了</a></p>
      </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</html>
