<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"> 
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/common2.css" rel="stylesheet"/>
    <link href="css/Friendstyle.css" rel="stylesheet"/>
    <script src="js/jquery-1.8.3.min.js"></script>
    <script src="js/utils.js" type="text/javascript"></script>
    <title></title>
    <script type="text/javascript">
    $(function(){
    	if("app" == getRequestParam("from")){
    	}else{
    		$("#rule_title")[0].style.display = "block";
    	}
    });
    </script>
    <%@ include file="config/header.jsp" %>
</head>
<body>
<section class="rulehead" id="rule_title" style="display:none">
</section>
<section>
    <div class="rule">
			<p style="margin-top: 0;">
				1、<span>推荐好友注册得100积分</span>
			</p>
			<p>
				2、<span>推荐好友投资（除债券转让外），好友每年化投资10000元得200积分。</span>
			</p>
		</div>
</section>
<sectinon class="friend-rule" style="display:none">

    <div class="hgroup">
        <h2>返现比例表</h2>
        <h6>（根据推荐好友投资额及投资期限返现,按月发放）</h6>
    </div>
    <div class="contenttable">
        <table cellpadding="0" cellspacing="0" border="0">
            <thead>
            <th>投资期限</th>
            <th>返现比例</th>
            <th class="lastth">案例</th>
            </thead>
            <tbody>
            <tr>
                <td>1月</td>
                <td>0.14%</td>
                <td class="lasttd">好友投资1个月项目10000元,可获得返现10000X0.14%=14元</td>
            </tr>
            <tr>
                <td>3月</td>
                <td>0.425%</td>
                <td class="lasttd">
                    你推荐好友投资3个月项
                    目10000元,可以获得返现10000X0.425%=42.5元
                </td>
            </tr>
            <tr>
                <td>6月</td>
                <td>0.86%</td>
                <td class="lasttd">
                    你推荐好友投资6个月项目10000元,可以获得返现10000X0.86%=86元
                </td>
            </tr>
            <tr class="lasttr">
                <td>12月</td>
                <td>1.80%</td>
                <td class="lasttd">
                    你推荐好友投资12个月项目10000元,可以获得返现10000X1.80%=180
                    元
                </td>
            </tr>
            </tbody>
        </table>
    </div>

</sectinon>
</body>
</html>
