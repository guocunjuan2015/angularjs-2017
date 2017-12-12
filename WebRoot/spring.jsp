<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no" />
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/common2.css" rel="stylesheet" />
<link href="css/spring.css" rel="stylesheet">
<script src="js/jquery-1.11.2.min.js"></script>
<script src="js/utils.js" type="text/javascript"></script>
<script src="js/frame/ios_js.js" type="text/javascript"></script>
<script type="text/javascript">
$(function (){
	getInvestPerson();
});
function toProject(){
    IOSModel.toIosInvest();
    if(isAndroidOrIos()){
        toIosInvest();
        appFunction('invest');
    }else{
        toIosInvest();
        window.location.href = "project.jsp";
    }
}

 function showShare(){
    IOSModel.changeWebTitle("春季来财富种");
} 
 
 function getInvestPerson(){
	 $.ajax({
         type : "POST",
         url : "account/recentlist/get.do",
         data : {
         },
         success : function(response) {
             if (response.success) {
            	 var info = $.parseJSON(response.result);
            	 var data = info.resultObject;
            	 addDataToPage(data);
             } else {
                 if (isEmpty(response.result)) {
                     errorMsg(response.msg);
                 } else {
                     window.location.href = response.result;
                 }
             }
         },
         dataType : "json"
     });
 }

				
	function addDataToPage(data) {
		var table = $("#table");
		table[0].innerHTML = "";
		if (data) {
			for (var i = 0; i < data.length; i++) {
				var row = '';
				row += '<tr>';
				row += '<td>'+data[i].investDate+'</td>';
				row += '<td>'+data[i].loginName+'</td>';
				row += '<td>'+data[i].loanPeriod+'</td>';
				row += '<td>'+data[i].investAmount+'</td></tr>';
				table.append(row);
			}
		}
	}
</script>
<title>春季来财富种</title>
</head>
<body>

  <div style="line-height:180px;">
  
    <p style="text-align:center;"><span style="width:8rem;height:8rem;border:1px solid red; border-radius:50%;display: inline-block;background:red;"></span></p>
  
  </div>
	
</body>
<script type="text/javascript" src="js/frame/rqbaoappshare.js"></script>
</html>