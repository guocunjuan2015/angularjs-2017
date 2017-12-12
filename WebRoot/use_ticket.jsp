<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    HttpSession s = request.getSession(); 
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
    String project_id = request.getParameter("id");
    String investAmount = request.getParameter("investAmount");
    String projectType = request.getParameter("projectType");
%>
<%@ include file="/config/global.jsp" %>
<!DOCTYPE html>
<html ng-app="myGiftApp">
<head>
		<meta charset="UTF-8">
		<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
		<meta http-equiv="Pragma" content="no-cache" />
		<meta http-equiv="Expires" content="0" />
		<title>我的优惠券</title>
		<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
		<link href="css/rqbao_index.css" rel="stylesheet"/>
		<link rel="stylesheet" type="text/css" href="css/project.css">
		<link href="css/couponstyle.css" rel="stylesheet" />
		<script src="js/project_invest.js" type="text/javascript"></script>
<%@ include file="config/header.jsp" %>
</head>
<body ng-controller="myGiftController">
<%@ include file="/config/globalHead.jsp" %>
 <input type="hidden" value="${param.project_id}"  id="project_id">
 <input type="hidden" value="<%=userId%>"  id="userId">
 <input type="hidden" value="${param.investAmount}"  id="investAmount">
 <input type="hidden" value="${param.projectType}"  id="projectType">
<script>
        var project_id = $("#project_id").val();
        var userId = $("#userId").val();
        var projectType = $("#projectType").val();
        var investAmount = $("#investAmount").val();
  </script>

<div class="gifBox">
		<p style="margin:0 1rem 0 1rem;height:3rem;line-height:3rem;border:1px solid #F5F4F4;text-align:center;" ng-click="couponClick('', '','',false)">不使用优惠券</p>
    <section class="myGiftBox"  ng-repeat="couponList in couponLists">
	     <div class="myGift"  ng-click="couponClick(couponList.couponId, couponList.couponAmount,couponList.couponType,true,$event)">
		      <div class="myGiftL">
		          <p><b>{{couponList.couponAmount}}</b>{{couponList.unit}}</p>
		          <p ng-if="couponList.couponType == 1">红包</p>
		          <p ng-if="couponList.couponType == 2">加息券</p>
		      </div>
		      <div class="myGiftR" >
		          <ul style="clear:both;">  
		              <li ng-if="couponList.source != null">{{couponList.source}}</li>
		              <li>{{couponList.rule}}</li>
		              <li>有效期{{couponList.validity}}</li>
		          </ul>
		          <div class="rightIcon"></div>
		      </div><div class="clear"></div>
	      </div>
      <div class="clear"></div>
    </section>
    <div class="noCoupon">
    	 <p><img  src="images/noCoupon.png"/></p> 
    	 <p>暂无可用优惠劵</p>
    </div>
</div>


	<!-- <button style="display:none" id="myModal" type="button" class="btn btn-danger mt20 ml20" data-toggle="modal" data-target=".bs-example-modal-lg">提示信息</button>
	<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">提示信息</h4>
				</div>
				<div class="modal-body">
					<h4 class="text-success text-center" id="msg_content"></h4>
				</div>
				<div class="modal-footer">
					<button type="button" data-dismiss="modal" class="btn btn-danger btn-block" >返回</button>
				</div>
			</div>
		</div>
	</div>
		<div class="mt10" id="coupon_table"></div>
	<div>
		<FORM action="project_invest.jsp" method="post" id="choose_cop_form">
			<input type="hidden" name="copType" id="copType" /> <input
				type="hidden" name="passValue" id="passValue" /> <input
				type="hidden" name="copId" id="copId" /> <input type="hidden"
				name="periodBack" id="periodBack" /> <input type="hidden"
				name="projectIdBack" id="projectIdBack" /> <input type="hidden"
				name="rateBack" id="rateBack" />
		</FORM>不使用用优惠券
	</div> -->
	<!-- <div id="div_no_cop_record"></div>
	<div id="show_choose_div">已选择 <span id="sp_cop_count">0</span> 张 <span id="sp_cop_type"></span>,共 <span id="sp_cop_value">0.00</span></div> -->
	<div id="error_info" class="error_info"></div>
	<script src="js/use_ticket.js" type="text/javascript"></script>
</body>
</html>