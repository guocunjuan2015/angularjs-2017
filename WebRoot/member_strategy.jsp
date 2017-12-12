<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/mylevel.css" rel="stylesheet"/>
    <script src="js/jquery.mobile-1.3.2.min.js"></script>
    <script  type="text/javascript">
    function toPointsRules(){
    	window.location.href = "vantagesrule.jsp";
    }
    </script>
    <title>会员攻略</title>
</head>
<body>
  <section class="member1">
      <dl>
          <dt><span>如何升级</span><span onclick="toPointsRules()">查看积分规则 &gt;</span></dt>
          <dd style="clear:both;"></dd>
          <dd>你可以通过签到、投资、做任务、参与活动多种途径积累你的积分，平台根据你的累计积分及上月新增积分来评定你本月的会员等级，每月1日进行评定</dd>
      </dl>
  </section>
  <section class="member1">
      <dl>
          <dt>升级能给我带来什么？</dt>
          <dd style="clear:both;"></dd>
          <dd>升级可以享受更多的会员特权、会员福利及增值服务，达到最高等级有九种特权，每月奖励6000瑞钱币，生日奖励10000瑞钱币，还有满满的增值服务等着你</dd>
      </dl>
  </section>
  <section class="member1 member2">
      <dl>
          <dt>会员等级</dt>
          <dd style="clear:both;"></dd>
          <dd>VIP会员等级根据用户在平台当日获得的积分换算成的财富值进行划分为8个等级，对应积分如下：</dd>
      </dl>
      <table>
          <tr>
              <th>等级名称</th>
              <th>积分</th>
              <th>本月新增积分</th>
          </tr>
          <tr>
              <td><img src="images/vip_level/level1.png"/></td>
              <td>0到300</td>
              <td>0</td>
          </tr>
          <tr>
              <td><img src="images/vip_level/level2.png"/></td>
              <td>301到3000</td>
              <td>0</td>
          </tr>
          <tr>
              <td><img src="images/vip_level/level3.png"/></td>
              <td>3001到10000</td>
              <td>0</td>
          </tr>
          <tr>
              <td><img src="images/vip_level/level4.png"/></td>
              <td>10001到5w</td>
              <td>0</td>
          </tr>
          <tr>
              <td><img src="images/vip_level/level5.png"/></td>
              <td>5W+1到20W</td>
              <td>1W</td>
          </tr>
          <tr>
              <td><img src="images/vip_level/level6.png"/></td>
              <td>20W+1到100W</td>
              <td>5W</td>
          </tr>
          <tr>
              <td><img src="images/vip_level/level7.png"/></td>
              <td>100W+1到500W</td>
              <td>20W</td>
          </tr>
          <tr>
              <td><img src="images/vip_level/level8.png"/></td>
              <td>500W以上</td>
              <td>50W</td>
          </tr>
      </table>
      <p>
          <span>升级条件：</span>
          <span>达到高等级积分数并满足高等级本月新增积分数即可升级到高等级</span>
      </p>
      <p>
          <span>维持当前等级条件：</span>
          <span>达到当前等级本月新增积分数</span>
      </p>
      <p style="padding-bottom:5%;">
          <span>降级条件：</span>
          <span>不满足升级条件，对比当前等级本月新增积分数，未达到则降到下一级</span>
      </p>
  </section>
</body>
</html>