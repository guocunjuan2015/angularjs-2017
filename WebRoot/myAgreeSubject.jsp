<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/config/global.jsp" %>
<!DOCTYPE html>
<html ng-app="ngApp">
<head>
<meta charset="UTF-8">
<title>个人中心  | 我的约标</title>
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="stylesheet" type="text/css" href="css/reset.css">
<link rel="stylesheet" type="text/css" href="css/project.css" />
<link href="css/rqbao_index.css" rel="stylesheet"/>
<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="js/angular.min.js"></script>
<script type="text/javascript" src="js/angular-route.min.js" ></script>
<script type="text/javascript" src="js/bootstrap.min3.0.3.js"></script>
<%@ include file="/config/config.jsp" %>
<%@ include file="config/header.jsp"%>
<%
	String userName = (String) request.getSession().getAttribute("loginUser");
%>
<style>
.errorZone p{line-height:3rem !important;}
.errorZone p img{padding:2rem;}
 #page ul li{width:190px;}
 #page ul{background:none;}
</style>
</head>
<body>
<%@ include file="/config/globalHead.jsp" %>
<input type="hidden" value="<%=basePath%>"  id="basePath">
<input type="hidden" value="<%=localPath%>"  id="localPath">
<input type="hidden" value="<%=userId%>"  id="userId">
<div class="view" ng-controller="yuebiaoList">
  <div class="financialBox" ng-repeat="financial in financials"><a href="project_other_content.jsp?id={{financial.projectId}}&projectType=1">
    <div class="entryName clearfix"><h3 class="fl">{{financial.projectName}}</h3><p class="fr">剩余金额：<font>{{financial.residualAmount}}</font> 元</p></div>
    <div class="entry clearfix">
      <div class="interest fl">
        <h4>
          {{financial.rate}}<i ng-show="isAward($index)"><b>+</b>{{financial.subsidyRate}}</i>
          <p class="icon blue" ng-show="isAward($index)"><font>{{financial.subsidyDesc}}</font></p>
        </h4>
        <span class="clearfix">预期年化收益(%)</span>
      </div>
      <div class="month fl">
        <h4>{{financial.projectPeriod}}</h4>
        <span>{{financial.deadlineDetail}}</span>
      </div>
      <div class="click fl">
        <input ng-class="{{financial.projectStatus}} == 2 ? 'buy' : 'ash'" type="button" value="{{financial.projectStatusDescName}}">
      </div>
    </div>
    <div class="investmentProgress">
      <div class="progress fl">
        <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="{{financial.progress}}" aria-valuemin="0" aria-valuemax="100" style="width: {{financial.progress}}%">
          <span class="sr-only"></span>
          </div>
      </div>
      <span>{{financial.progress}}%</span>
    </div>
  </a></div> 
  <div ng-show="showLoadMsg" class="loading">{{loadMsg}}</div>
  <div class="errorTxt errorZone" ng-show="error()" style="position:inherit !important;">
       <p><img style="max-width:auto;width:18rem;"  src="images/yIcon1.png"/></p> 
       <p style="font-size:2rem;color:#9B9B9B;">约标息加息，5万起约</p>
       <p style="color:#4A4A4A;">拨打客服电话 进行约标 </p>
       <p><a style="color:#80B7F5;text-decoration:underline;" href="tel:400-919-8555">400-919-8555</a></p>
  </div>
</div>
</body>
<script type="text/javascript" src="js/projectCenterTang.js"></script>
</html>