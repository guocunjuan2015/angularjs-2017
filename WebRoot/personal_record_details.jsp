<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/inverstdetails.css" rel="stylesheet"/>
    <title>投资记录</title>
</head>
<body>
<section class="invert-details">
    <h3 class="invert-header">
        <i class="icon-zhuan" id="pj_type"></i><i class="icon-A">A</i><span id="pj_title"></span>
    </h3>
    <section class="self_circle">
    <div id="circle_content">
    <p class="circle_text"><span id="income_text" style="display:none">已得收益(元)</span></p>
    <p class="circle_value"><span id="circle_val"></span></p>
    </div>
    <div id="inverstrate">
    </div>
    </section>
    <div class="invert-favour">
       <span ><i class="favour-bi"></i><strong id="useRedEvp">0</strong></span>
        <span>  <i class="favour-coupon"></i><strong id="useTicket">0</strong></span>
         <span>  <i class="favour-morerate"></i><strong id="useMoreRate">+0%</strong></span>
    </div>
    <div class="invert-money">
        <ul>
          <li>
              <span>理财金额</span>
              <span id="total_invest"></span>
          </li>
          <li>
              <span>预期年化收益</span>
              <span id="epxt_rate"></span>
          </li>
          <li>
              <span>预期收益</span>
              <span id="invest_income"></span>
          </li>
        </ul>
    </div>
</section>
<section class="invert-info">
  <ul>
      <li>
          <span>距离理财结束</span>
          <span id="fromEndTime"></span>
      </li>
      <li>
          <span>购买日期</span>
          <span id="buyDate"></span>
      </li>
      <li>
          <span>期限</span>
          <span id="loanPeriod"></span>
      </li>
  </ul>
    <button id="single_btn" style="display:none;width: 80%;margin: 0 auto;margin-top: 20px;" class="btn btn-lg btn-block btn-danger" onclick="toProject()">查看其他投资</button>
    <div style="margin: 5% 6%;display:none" id="group_btn">
    <table style="width: 100%;">
    <tr><td style="width: 50%; text-align: center"><button class="btn btn-lg btn-primary " onclick="transfer()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;转让&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button></td>
    <td style="width: 50%; text-align: center"><button class="btn btn-lg btn-danger " onclick="toProject()">查看其他投资</button></td></tr>
    </table>
    </div>
</section>
<div id="error_info" class="error_info"></div>
  <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
  <script type="text/javascript" src="js/radialIndicator.min.js"></script>
  <script type="text/javascript" src="js/personal_record_details.js"></script>
  <script type="text/javascript" src="js/utils.js"></script>
</body>
</html>