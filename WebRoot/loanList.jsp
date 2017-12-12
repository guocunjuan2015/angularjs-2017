<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
 <%@ include file="/config/config.jsp" %>
<%@ include file="/config/global.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
     <meta charset="utf-8">    
    <meta content="telephone=no" name="format-detection">
    <meta name="viewport" content="width=device-width , initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0,user-scalable=no">
    <title>借款列表</title> 
    <link href="css/rqbao_index.css" rel="stylesheet"/>
		<script>
		  function goLoan(index){
			  
			  location.href="https://credit.chaodai.net/act/light-loan-new?source_tag=386";
			  
		  }
		</script>
</head>
<body>
    <section class="loanContent clearfix" onclick="goLoan(1);">
            <img  class="leftIcon"  src="images/loanImg1.png"/>
        <div>
              <h3>潮贷</h3>
              <p>额度500-5000元.1分钟信审，极速放款小额贷  </p>
        </div>
        <span><img   src="images/arrowRightIcon.png"/></span>          
    </section>
   
    
    
      
   
    
</body>
</html>