<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common.css" rel="stylesheet" />
<link href="css/common2.css" rel="stylesheet" />

<title>自动投标说明</title>
</head>
<body>
	<section>
		<div id="illus" class="illus" style="display: block; position: relative;top: 0px;">
			<p>1、单笔最低投标额：限制每次投标的实际投标额不得低于某个数值，一旦系统判断本次投标额低于该数值时，将自动放弃本次投标机会并保持排名继续前进。该数值默认值为0。</p>
			<p>2、账户保留金额：每次投标后账户必须保留的最低可用余额。如果系统判断本次投标结束后账户可用余额将低于该数值，则本次投标金额将修正为最大投标金额减去账户保留金额，且不能低于该借款标限制的最低投标额。该数值默认值为0。</p>
			<p>3、当前规则满足所有条件时，系统将为您自动投标的金额只能为大于0的整数。</p>
			<p>4、系统最终判定的实际投标金额如果超过借款标的最大投标额度则以该额度为准进行投标，如果小于标的最小投标额度则放弃此次投标机会，排名继续前进。</p>
		</div>
	</section>
</body>
</html>