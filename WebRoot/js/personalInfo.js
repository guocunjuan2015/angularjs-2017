;(function($) {
          var applyUrl= localPath + "/jxl/api/apply.do",
              dsUrl= localPath + "/jxl/api/datasources.do",
              reqUrl= localPath + "/jxl/api/collect/req.do",
              uploadUrl= localPath +  "/product/uploadImg.do",
              addOrgCodeUrl= localPath +  "/product/addOrgCode.do",
              loanApplyUrl= localPath +  "/product/apply.do",
              zmCreditUrl= localPath +  "/zmxy/ZhimaCreditIvsDetailGet.do",
              creditApplyUrl= localPath +  "/jxl/api/creditcard/applications.do",
              creditCollectUrl= localPath +  "/jxl/api/creditcard/message/collect/req.do",
              qrcodeCollectUrl= localPath +  "/jxl/api/creditcard/messages/qrcodeCollect/resp.do";
          
		          
          var home = function() {
        	//初始化个人信息认证
	          	$.ajax({
	          		url: localPath + "/user/credit/userAuthenInfo.do",
	          		type:'POST',
	          		data:{
	          			userId : userId
	          		},
	          		success:function(respnose){
	          			var infos = JSON.parse(respnose.result);
	          			//console.log(respnose);
	          			//console.log(infos.resultObject);
	          			if(respnose.success){
	          				if(infos.resultObject != undefined || infos.resultObject != null ){
	    	          			if(infos.result == 1){
	    	          				   var data = JSON.parse(respnose.result).resultObject;
	    	          				     /*判断信息是否认证        01、已采集 跳转认证中心，认证芝麻和手持身份证  02、已认证 直接申请借款*/
	    	          				    if(data.status == '01'){
	    	          						window.location.href = localPath + "/loan_authentication.jsp";
	    	          					} else if(data.status == '00' && data.contacts != "" && data.contacts != undefined){
	    	          					 var params = '{contacts :'; 
	  		          					   params += JSON.stringify(data.contacts) + '}';
	    	          						getInfo(params);
	    	          						$(".second-flow").hide();/*个人信息隐藏*/
	    	          						$(".first-flow").show();/*运营商展示*/
	    	          					} else {
	    	          						$(".second-flow").show();/*个人信息隐藏*/
	    	          						$(".first-flow").hide();/*运营商展示*/
	    	          					}
	    	          					/*
	    	          					判断联系人基本信息是否为空
	    	          					if(data.contacts.length > 0 || data.contacts != "" || infos.contacts != null){
	    	          						getInfo(params);
	    	          						$(".second-flow").hide();个人信息隐藏
	    	          						$(".first-flow").show();运营商展示
	    	          					}*/
	    	          					
	    	          			}
	          					
	          				}
		          			
	          			}	
	          			
	          		},error:function(respnose){
	          			alert("服务器错误,请联系管理员");
	          		}
	          		
	          	});
              var whatServerStr = '<div class="modal-dialog"> ' +
                  '<div class="modal-content"> ' +
                  '<div class="modal-header"> ' +
                  '<button type="button" class="close" data-dismiss="modal" > &times; </button> ' +
                  '<h4 class="modal-title" >服务密码 </h4> ' +
                  '</div> ' +
                  '<div class="modal-body"> ' +
                  '<p class="subtitle">请拨打您的运营商（如：移动10086，联通10010，电信10000）的人工客服来咨询或修改服务密码</p>'+
                  '</div> ' +
                  '<div class="modal-footer"> ' +
                  '<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>' +
                  '</div> ' +
                  '</div> </div>',
                  whatServerYDStr = '<div class="modal-dialog"> ' +
                  '<div class="modal-content"> ' +
                  '<div class="modal-header"> ' +
                  '<button type="button" class="close" data-dismiss="modal" > &times; </button> ' +
                  '<h4 class="modal-title" >查询密码 </h4> ' +
                  '</div> ' +
                  '<div class="modal-body"> ' +
                  '<p class="subtitle">北京移动网站查询密码为您的北京移动官方网站登陆密码</p>'+
                  '</div> ' +
                  '<div class="modal-footer"> ' +
                  '<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>' +
                  '</div> ' +
                  '</div> </div>',
                  ydPopstr = '<div class="modal-dialog"> ' +
                  '<div class="modal-content"> ' +
                  '<div class="modal-header"> ' +
                  '<button type="button" class="close" data-dismiss="modal" > &times; </button> ' +
                  '<h4 class="modal-title" id="modalTitle">动态密码</h4> ' +
                  '</div> ' +
                  '<div class="modal-body modal-code-body"> ' +
                  '<div class="clearfix"> ' +
                  '<input class="input" type="text" id="dongtaimima" placeholder="输入手机动态密码" /> ' +
                  '</div> ' +
                  '<div class="error-info" id="yd-errorInfo"></div> ' +
                  '</div> ' +
                  '<div class="modal-footer"> ' +
                  '<button type="button" class="btn btn-primary btn-close" id="toDynamic"><span>确认</span></button> ' +
                  '</div> ' +
                  '</div> </div>',
                  jdPopstr = '<div class="modal-dialog"> ' +
                  '<div class="modal-content"> ' +
                  '<div class="modal-header"> ' +
                  '<button type="button" class="close" data-dismiss="modal" > &times; </button> ' +
                  '<h4 class="modal-title" id="modalTitle">京东</h4> ' +
                  '</div> ' +
                  '<div class="modal-body modal-code-body"> ' +
                  '<div class="jdInputStr"> ' +
                  '<input class="input" type="text" id="jdStrName" placeholder="手机号/会员名/邮箱" /> ' +
                  '<input class="input" type="password" id="jdStrPassword" placeholder="请输入京东密码" /> ' +
                  '<input class="input hide" type="text"  id="jdStrYan" placeholder="请输入手机验证码" /> ' +
                  '</div> ' +
                  '<div class="error-info" id="JD-errorInfo"></div> ' +
                  '</div> ' +
                  '<div class="modal-footer jdInputStrFooter"> ' +
                  '<button type="button" class="btn btn-primary btn-close" id="toDynamic"><span>认证</span></button> ' +
                  '</div> ' +
                  '</div> </div>',
                  creditPopstr = '<div class="modal-dialog"> ' +
                  '<div class="modal-content"> ' +
                  '<div class="modal-header"> ' +
                  '<button type="button" class="close" data-dismiss="modal" > &times; </button> ' +
                  '<h4 class="modal-title" id="modalTitle">信用卡认证</h4> ' +
                  '</div> ' +
                  '<div class="modal-body modal-code-body"> ' +
                  '<div class="jdInputStr"> ' +
                  '<input class="input" type="text" id="creditStrName" placeholder="请输入信用卡账单的邮箱" /> ' +
                  '<input class="input" type="password" id="creditStrPassword" placeholder="请输入邮箱密码" /> ' +
                  '<input class="input" type="password" style="display:none" id="creditOneStrPassword" placeholder="邮箱独立密码(qq邮箱选填)" /> ' +
                  '</div> ' +
                   '<div class="qq-code hide" style="text-align:center;"><img id="code-img" /></div> ' +
                  '<div class="error-info" id="credit-errorInfo"></div> ' +
                  '</div> ' +
                  '<div class="modal-footer jdInputStrFooter"> ' +
                  '<button type="button" class="btn btn-primary btn-close" id="toDynamic"><span>认证</span></button> ' +
                  '</div> ' +
                  '</div> </div>',
                  invitation_code = '<div class="modal-dialog"> ' +
                  '<div class="modal-content"> ' +
                  '<div class="modal-header"> ' +
                  '<button type="button" class="close" data-dismiss="modal" > &times; </button> ' +
                  '<h4 class="modal-title" >机构邀请码 </h4> ' +
                  '</div> ' +
                  '<div class="modal-body modal-code-body"> ' +
                  '<input class="input" type="text" id="invitation-code" placeholder="请输入机构邀请码" /> ' +
                  '</div> ' +
                  '<div class="modal-footer"> ' +
                  '<button type="button" class="btn btn-primary btn-close" id="toDynamic"><span>认证</span></button> ' +
                  '</div> ' +
                  '</div> </div>',
                  password = $('#servicePassword'),
                  phonePassword = $('#phonePassword'),
                  first = $('.second-flow'),
                  second = $('.first-flow'),
                  third = $('.third-flow'),
                  four = $('.four-flow'),
                  token = '',
                  cell_phone_num = '',
                  website = '',
                  req_msg_tp_type = '',
                  upPop = $('#puPop');
          
      	


              //记录cookie
              var moreThreeBtn = getCookie('more_three_btn')||0;
              
              function getCookie(name) {
                  var c_start,c_end;
                  if (document.cookie.length > 0) {
                      c_start = document.cookie.indexOf(name + "=");
                      if (c_start != -1) {
                          c_start = c_start + name.length + 1;
                          c_end = document.cookie.indexOf(";",c_start);
                          if (c_end == -1)
                              c_end = document.cookie.length;
                          return document.cookie.substring(c_start,c_end);
                      }
                  }
                  return ""
              };
          
          
              //第一步需要的参数
              var ofamily2IdBtn = $('#family2_btn'),
                  ofamily2IdLi = $('#family2_select > li'),
                  ofamily3Btn = $('#family3_btn'),
                  ofamily3IdLi = $('#family3_select > li');
          
              var family1_type = $('#family1_type'),
                  family2_type = $('#family2_type'),
                  family3_type = $('#family3_type'),
                  family1_name = $('#family1_name'),
                  family2_name = $('#family2_name'),
                  family3_name = $('#family3_name'),
                  family1_phone = $('#family1_phone'),
                  family2_phone = $('#family2_phone'),
                  family3_phone = $('#family3_phone');
              var contact_tel='',
                  contact_name='',
                  contact_type='',
                  contact2_tel='',
                  contact2_name='',
                  contact2_type='',
                  contact3_tel='',
                  contact3_name='',
                  contact3_type='';
                 
          
              //后台传给前端 用户的信息
               var user_name = '', //用户姓名
                 id_card_num = '',//用户身份证
                 iphone_number = '';//用户手机号

              $("#myselfpicFile").uploadPreview({ Img: "myselfpic", Width: 260, Height: 195 }).CheckInito();
              $("#myselfpicFile2").uploadPreview({ Img: "myselfpic2", Width: 260, Height: 195 }).CheckInito();
              $("#myselfpicFile3").uploadPreview({ Img: "myselfpic3", Width: 260, Height: 195 }).CheckInito();

              //跳转下个步骤
              function titleXinxi(index){
                  $('.first').each(function(i,k){
                      titleActive(i,index,k);
                  });
                  $('.line').each(function(i,k){
                      titleActive(i,index,k);
                  });
                  if(index == 1){
                      $('title').html('填写个人信息_校验手机号');
                  }else if(index == 2){
                      $('title').html('填写个人信息_信息认证');
                  }
              }

              function titleActive(i,index,obj){
                  if(i == index){
                      $(obj).addClass('active');
                  }
              }

              
              function errorHtmlClear(){
                  $('#yd-errorInfo').hide();
                  $('#JD-errorInfo').hide();
              }

              function checkPostAjax(){
                  $.ajax({
                      url: reqUrl,
                      type: 'POST',
                      contentType: 'application/json;charset=utf-8',
                      data: JSON.stringify({
                          token: token,
                          account: cell_phone_num,
                          password: $('#servicePassword').val(),
                          captcha:$('#dongtaimima').val(),
                          queryPwd: $('#checkPassword').val()|| '',
                          type: req_msg_tp_type,
                          website: website
                      }),
                      success: function (resp) {
                          $('#toDynamic').prop("disabled", "");
                          $('#toDynamic').text('确认');
                          var info = JSON.parse(resp.result);
                          var returnDta = JSON.parse(resp.result).resultObject;
                          if(resp.success){
                        	  if(info.resultObject != undefined || info.resultObject != null ){
	                              if(returnDta.members.data.content){
	                                  if (returnDta.members.data.type == 'CONTROL') {
	                                      //前端交互流程完成
	                                      if (returnDta.members.data.process_code === 10008) {
	                                          upPop.modal('hide');
	                                          second.hide();
	                                          third.show();
	                                          titleXinxi(2);
	                                          //流程结束标识
	                                      }
	                                  } else if (returnDta.members.data.type == 'ERROR') {
	                                      $('#yd-errorInfo').html(returnDta.members.data.content).show();
	                                      $('#dongtaimima').val('');
	                                      return false;
	                                  }
	                              }
                        	  } else {
                        		  
                        		 alert("网络超时请稍后重试"); 
                        	  }
                          }
                          if(returnDta.members.data.finish){
                              //upPop.modal('hide');
                        	  $("#ays3").hide();
                              second.hide();
                              window.location.href = localPath +  "/loan_authentication.jsp";
                              /*third.show();
                              titleXinxi(2);*/
                          }

                          $('#yd-errorInfo').html(returnDta.members.data.content).show();
                          $('#dongtaimima').val('');
                           return false;


                      },
                      error:function(){
                          $('#yd-errorInfo').html('网络不佳，请重新尝试').show();
                      }
                  });
              }

               //判断是否为数字
              function checkNumber(){
                  var _this = $(this),
                      val = _this.val(),
                      reg = new RegExp('^-?\\d+$');
                   _this.css('border','1px solid #ddd');
                  if(reg.test(val)){
                      first.find('.error-info').html('请输入真实姓名').show();
                      _this.css('color','#ff5555');
                      $('#submitBtn2').prop("disabled", "disabled");
                      $('#submitBtn2').html('请填写正确信息');
                  }else{
                      first.find('.error-info').html('').hide();
                      _this.css('color','#333');
                      $('#submitBtn2').prop("disabled", "");
                      $('#submitBtn2').html('保存并继续');
                  }
              }
              //判断是否为真实手机号
              function checkPhoneNumber(){
                  var _this = $(this),
                      val = _this.val();
              
                  _this.css('border','1px solid #ddd');
                  if(!(/^1[34578]\d{9}$/.test(val))){
                      first.find('.error-info').html('请输入真实手机号').show();
                      _this.css('color','#ff5555');
                      $('#submitBtn2').prop("disabled", "disabled");
                      $('#submitBtn2').html('请填写正确信息');
                  }else{
                      first.find('.error-info').html('').hide();
                      _this.css('color','#333');
                      $('#submitBtn2').prop("disabled", "");
                      $('#submitBtn2').text('保存并继续');
                  }
              }
              
              function checkNumberFocus(){
                  var _this = $(this);
                  _this.css('color','#333');
                  first.find('.error-info').html('').hide();
              }
              
              function addInputRedBorder(){
                  var _this = $(this);
                  _this.css('border','1px solid #ff5555');
              }


              family1_name.on('blur',checkNumber);
              family2_name.on('blur',checkNumber);
              family3_name.on('blur',checkNumber);
              family1_phone.on('blur',checkPhoneNumber);
              family2_phone.on('blur',checkPhoneNumber);
              family3_phone.on('blur',checkPhoneNumber);
              
              family1_name.on('focus',checkNumberFocus);
              family2_name.on('focus',checkNumberFocus);
              family3_name.on('focus',checkNumberFocus);
              family1_phone.on('focus',checkNumberFocus);
              family2_phone.on('focus',checkNumberFocus);
              family3_phone.on('focus',checkNumberFocus);


              //第一步验证
              $('#submitBtn2').on('click',function(){
                  contact_tel=family1_phone.val();
                  contact_name=family1_name.val();
                  contact_type="1";
                  contact2_tel=family2_phone.val();
                  contact2_name=family2_name.val();
                  contact2_type="6";
                 /* contact3_tel=family3_phone.val();
                  contact3_name=family3_name.val();
                  contact3_type=family3_type.attr('data-value');*/


                  //这是正确的步骤
                  if(!contact_name||!contact2_name){
                      first.find('.error-info').html('姓名不能为空').show();
                      return;
                  }
                  if(!contact_tel||!contact2_tel){
                      first.find('.error-info').html('手机号不能为空').show();
                      return;
                  }
                 /* if(contact2_type ==''||contact3_type==''){
                      first.find('.error-info').html('请选择联系人关系').show();
                      return;
                  }*/
                  
//                  if(contact_tel == contact2_tel||contact_tel==contact3_tel||contact2_tel==contact3_tel){
//                  	 first.find('.error-info').html('手机号不能相同').show();
//                       return;
//                  }
                  if(contact_tel == contact2_tel /*&& contact2_tel == contact3_tel*/){
                      family1_phone.css('color','#ff5555');
                      family2_phone.css('color','#ff5555');
                      family3_phone.css('color','#ff5555');
                      first.find('.error-info').html('手机号不能相同').show();
                      return;
                  }else if(contact_tel == contact2_tel){
                      family1_phone.css('color','#ff5555');
                      family2_phone.css('color','#ff5555');
                      first.find('.error-info').html('手机号不能相同').show();
                      return;
                  }else{
                      family1_phone.css('color','#333');
                      family3_phone.css('color','#333');
                      family2_phone.css('color','#333');  
                  }
                  
                  //判断用户是否登录
                  if(userId == '' || userId == null) {
                	  window.location.href = localPath + 'login.jsp';
                	  return;
                  } else {
                	  var params = JSON.stringify({
                          basic_info: {
                              name: user_name,
                              id_card_num: id_card_num,
                              cell_phone_num: iphone_number
                          },
                      contacts:[
                                {
                                    contact_tel:contact_tel,
                                    contact_name:contact_name,
                                    contact_type:contact_type

                                },{
                                    contact_tel:contact2_tel,
                                    contact_name:contact2_name,
                                    contact_type:contact2_type

                                }/*,{
                                    contact_tel:contact3_tel,
                                    contact_name:contact3_name,
                                    contact_type:contact3_type

                                }*/
                            ]
                      });
                	  getInfo(params);

               }  
              });
              
              function getInfo(params) {
            	  //console.log("params - " + params);
        		  $.ajax({
        	           url:dsUrl,
        	           type:'GET',
        	           success:function(res) {
        	                if (res.success) {
        	                    $.ajax({
        	                        url: applyUrl,
        	                        type: 'POST',
        	                        contentType: 'application/json;charset=utf-8',
        	                        dataType : "json",
        	                        data: params,
        	                        success: function (resg) {   
        	                      	  var info = resg.result;
        	                      	  info = JSON.parse(info).resultObject;
        	                      	  //console.log(info);
        	                      	  //console.log(info.data.datasource.name);
        	                            if (resg.success) {
        	                                token = info.members.data.token;
        	                                cell_phone_num = info.members.data.cell_phone_num;
        	                                website = info.members.data.datasource.website;
        	                                first.hide();
        	                                second.show();
        	                                titleXinxi(1);
        	                                
        	                                if (info.members.data.datasource.name == '北京移动') {
        	                                   /* $('#checkPassword').parent().show();*/
        	                              	  $(".checkPassward").show();
        	                                    req_msg_tp_type = 'SUBMIT_QUERY_PWD';
        	                                } else {
        	                                    //$('#checkPassword').parent().remove();
        	                                    $(".checkPassward").hide();
        	                                    req_msg_tp_type = 'SUBMIT_CAPTCHA';
        	                                }
        	                            } else {
        	                                first.find('.error-info').html(resg.message).show();
        	                            }
        	                        }
        	
        	
        	                    });
        	                }
        	            }
        	        });
        	}
              
              //第二步验证
              $('#submitBtn1').on('click',function(){
                  var _this = $(this),
                      error_black_server = password.parent().find('.error-info'),
                      error_black_chaxun = $('#checkPassword').parent().find('.error-info');
                  $('#errorServer').hide();
                  if(!password.val()){
                	  $(".service-info").text('请填写您的服务密码').show();
                      $(".password-info").text('请填写您的查询密码').hide();
                      password.focus();
                      return false;
                  }
                  //如果非移动  则直接跳过
                  if( $('#checkPassword').val() == 'undefined'){
                      //console.log( $('#checkPassword'), $('#checkPassword').val());
                      if(!$('#checkPassword').val()){
                          $(".service-info").text('请填写您的服务密码').hide();
                          $(".password-info").text('请填写您的查询密码').show();
                          $('#checkPassword').focus();
                          return false;
                      }
                  }
                  
                  $(".service-info").text('请填写您的服务密码').hide();
                  $(".password-info").text('请填写您的查询密码').hide();
                  
                
                   $('#errorServer').hide();
                  _this.prop("disabled", "disabled");
                  _this.text('正在校验，请稍等...');
                  $.ajax({
                      url: reqUrl,
                      type: 'POST',
                      contentType: 'application/json;charset=utf-8',
                      data: JSON.stringify({
                          token: token,
                          account: cell_phone_num,
                          password: $('#servicePassword').val(),
                          queryPwd: $('#checkPassword').val() || '',
                          type:req_msg_tp_type,
                          website: website
                      }),
                      success: function (resp) {
                    	  var infos = resp.result;
                    	  //console.log(resp);
                    	  //console.log(infos);
                    	  infos = JSON.parse(infos).resultObject;
                    	 // console.log(infos);
                    	  //console.log(infos.members.data.content);
                          _this.prop("disabled", "");
                          _this.text('校验手机');
                          if (infos.members.success) {
                              if(infos.members.data.content){

                                  if (infos.members.data.type == 'CONTROL') {
                                      //前端交互流程完成
                                      if (infos.members.data.process_code === 10008) {
                                    	  alert("000");
                                          second.hide();
                                          third.show();
                                          titleXinxi(2);
                                          return false;
                                      }else if (infos.members.data.process_code === 10002) {
                                          req_msg_tp_type = infos.members.data.req_msg_tpl.type;

                                          //upPop.html(ydPopstr);
                                          $("#bg").css("height", document.body.scrollHeight);
                                          $("#bg")[0].style.display = "block";
                                          //$("#ays")[0].style.display = "block";
                                          $("#ays3").show();
                                          $('#modalTitle').html(infos.members.data.content);
                                          upPop.modal('show');

                                          $('#toDynamic').on('click', function () {                                        
                                              errorHtmlClear();
                                              $(this).prop("disabled", "disabled");
                                              $(this).text('正在验证，请稍等...');
                                              checkPostAjax();
                                          });

                                          $('#yd-errorInfo').html(infos.members.data.content).show();
                                          return false;
                                      }
                                        //获取当前时间
                                      var date=new Date();
                                       //将date设置为1天以后的时间
                                      date.setDate(date.getDate()+1);
                                      moreThreeBtn = Number(getCookie('more_three_btn'))||0;
                                      moreThreeBtn +=1;
                                      document.cookie='more_three_btn='+moreThreeBtn+'; EXPIRES='+date.toGMTString();
                                      //console.log(moreThreeBtn);
                                      if(moreThreeBtn > 10){
                                          $('#errorServer').html('输错密码次数已达上线，请24小时后再次尝试').show();
                                           _this.prop("disabled", "disabled");
                                          return false;
                                      }

                                  }

                                  $('#errorServer').html(infos.members.data.content + "111").show();
                              }
                              // 对于返回信息的逻辑处理  ==》 结束
                          }else{
                              $('#errorServer').html(infos.members.message).show();
                          }
                      },
                      error:function(){
                          $('#errorServer').html('网络不佳，请重新尝试').show();
                          _this.prop("disabled", "");
                          _this.text('校验手机');
                      }
                  });


              });
              
              //第三步验证        
              function authenticationEnd(){
                  var count = 0;
                  $('#authenticationed').find('li').find('div').each(function(){
                      var _this = $(this);
                      if(_this.hasClass('hook')){
                          count++;
                      }
                  });
                  return count;
              }

              $('#submitBtn3').on('click',function(){
              	var _this = $(this),
                          bHook = authenticationEnd(),
                          bOk = $('#isLook').prop('checked'),
                          clear = null;
                  $('.error-info').hide();
                  if (bOk && bHook == 3) {
                      //点击阅读后才能执行下一步
                      $.ajax({
                          url: loanApplyUrl,
                          type: 'POST',
                          data: {
                              loanPeriod: $('#loanPeriod').val(),
                              repaymentWay: $('#repaymentWay').val(),
                              projectType: $('#projectType').val(),
                              goodId: $('#goodId').val(),
                              amount: $('#amount').val()
                          },
                          success: function (res) {
                              if (res == '1') {
                                  $.ajax({
                                      url: zmCreditUrl,
                                      type: 'GET',
                                      success: function (res) {
                                          if (res == '1') {
                                              third.hide();
                                              four.show();
                                              titleXinxi(3);
                                          }
                                      }
                                  });
                              } else {
                                  $('.error-info').html('提交失败').show();
                              }
                          }
                      });
                  }else{
                  	$('.error-info').html('资料不全请填写完毕').show();
                      if(!bOk){
                          $('.error-info').html('请完整阅读瑞钱宝分期借款协议').show();
                      }
                      _this.prop("disabled", "disabled");
                      _this.text('立即申请');
                      setTimeout(function(){
                      	_this.prop("disabled", "");
                          _this.text('立即申请');
                      },3000);
                      
                  }
              });
              //机构邀请码认证
              $('#invitationCode').on('click',function(){
                  var _this = $(this);
                  
                   if(_this.parent().find('div').hasClass('hook')){
                      return false;
                   }
                  
                  $('#puPop').html(invitation_code);
                  $('#puPop').modal('show');

                  $('#toDynamic').on('click',function(){
                     $.ajax({
                        url:addOrgCodeUrl,
                         type:'POST',
                         data:{
                             orgCode:$('#invitation-code').val()
                         },
                         success:function(res) {
                              if (res=='1') {
                                  $('#puPop').modal('hide');
                                  _this.parent().find('div').addClass('hook');
                                  eachHook();
                              }
                          }
                      });


                  });
              });

              //身份认证-上传图片
              var image = '',
                  image2 = '',
                  image3 = '';
              var type='.jpg',
                  type2='.jpg',
                  type3='.jpg';
              function selectedImage(file,index){
                  if(!file.files || !file.files[0]){
                      return;
                  }
                  //type = file.files[0].name.substring(file.files[0].name.indexOf('.'));
                  var reader = new FileReader();

                  reader.onload = function(evt){
                      if(index == 1){
                          type = file.files[0].name.substring(file.files[0].name.indexOf('.'));
                          image = evt.target.result;
                      }else if(index == 2){
                          type2 = file.files[0].name.substring(file.files[0].name.indexOf('.'));
                          image2 = evt.target.result;
                      }else if(index == 3){
                          type3 = file.files[0].name.substring(file.files[0].name.indexOf('.'));
                          image3 = evt.target.result;
                      }
                      //image = evt.target.result;
                  };
                  reader.readAsDataURL(file.files[0]);
              }
              function uploadImage() {
                  if(!image||!image2||!image3){
                      return false;
                  }
                  $.ajax({
                      type: 'POST',
                      url: uploadUrl,
                      data: {
                          "image": image,
                          "image2": image2,
                          "image3": image3,
                          "phone":$('#userPhone').val(),
                          "type":type,
                          "type2":type2,
                          "type3":type3,
                      },
                      async: false,
                      dataType: 'json',
                      success: function (data) {
                          if (data.success) {
                              $('#notBind').modal('hide');
                              $('#verifyBtn').parent().find('div').addClass('hook');
                              eachHook();
                              //alert('上传成功');
                          } else {
                              alert('上传失败,请重新尝试');
                          }
                      },
                      error: function (err) {
                          alert('网络故障');
                      }
                  });
              }

              //身份认证
              $('#verifyBtn').on('click',function(){
                  var _this = $(this);
                  
                  if(_this.parent().find('div').hasClass('hook')){
                      return false;
                  }
                  
                  $('#notBind').modal('show');

                  $('#myselfpicFile').on('change',function(){
                       selectedImage($(this)[0],1);
                  });
                  $('#myselfpicFile2').on('change',function(){
                       selectedImage($(this)[0],2);
                  });
                  $('#myselfpicFile3').on('change',function(){
                       selectedImage($(this)[0],3);
                  });
                  $('#toBind').on('click',uploadImage);
              });

              //芝麻信用认证
              $('#sesameCredit').on('click',function(){
                  var _this = $(this);
                   if(_this.parent().find('div').hasClass('hook')){
                      return false;
                   }
              });




              //京东认证
              function JDAuthentication(){
                  var JDname = $('#jdStrName'),
                      JDpassword = $('#jdStrPassword'),
                      JDPhone = $('#jdStrYan'),
                      _this = $(this);
                  $('#JD-errorInfo').hide();
                  _this.prop("disabled", "disabled");
                  _this.text('正在校验，请稍等...');
                  if(!JDname.val()){
                      $('#JD-errorInfo').html('请填写您的用户名').show();
                      JDname.focus();
                      return false;
                  }else if(!JDpassword.val()){
                      $('#JD-errorInfo').html('请填写您的密码').show();
                      JDpassword.focus();
                      return false;
                  }
                 
                 if(!JDPhone.hasClass('hide')){
                    if(!JDPhone.val()){
                       $('#JD-errorInfo').html('请填写您的手机验证码').show();
                      JDPhone.focus();
                      return false;
                    }
                 }
                 // JDBtn();
                 // var website; 这个我加过了
                 clearErrorJd();
                 JDIphone();

              }        
              
              function JDBtn(){
                  var _this = $('#toDynamic');
                  $.ajax({
                      url: reqUrl,
                      type: 'POST',
                      contentType: 'application/json;charset=utf-8',
                      data: JSON.stringify({
                          token: token,
                          account: cell_phone_num,
                          password: $('#jdStrPassword').val(),
                          //手机验证码
                         //captcha:JDPhone.val(),
                          website: website
                      }),
                      success: function (resp) {
                          _this.prop("disabled", "");
                          _this.text('完成');
                          if (resp.success) {
                              if(resp.data.content){
                                  if (resp.data.type == 'CONTROL') {
                                      //前端交互流程完成
                                      if (resp.data.process_code === 10008) {
                                           $('#jdAuthenticationBtn').parent().find('div').addClass('hook');
                                           eachHook();
                                          upPop.modal('hide');
                                          return false;
                                      }else if (resp.data.process_code === 10002) {
                                          //req_msg_tp_type = resp.data.req_msg_tpl.type||'';
                                          $('#JD-errorInfo').html(resp.data.content).show();
                                          $('#jdStrYan').removeClass('hide');
                                          return false;
                                      }
                                  }
                                  $('#JD-errorInfo').html(resp.data.content).show();
                              }
                          }else{
                              $('#JD-errorInfo').html(resp.message).show();
                          }
                      },
                      error:function(){
                          $('#JD-errorInfo').html('网络不佳，请重新尝试').show();
                          _this.prop("disabled", "");
                          _this.text('完成');
                      }
                  });

                 
               }
             
              
              function JDIphone(){
                   var _this = $('#toDynamic');
                   $.ajax({
                      url: reqUrl,
                      type: 'POST',
                      contentType: 'application/json;charset=utf-8',
                      data: JSON.stringify({
                          token: token,
                          account: $('#jdStrName').val(),
                          password: $('#jdStrPassword').val(),
                          //手机验证码
                         captcha:$('#jdStrYan').val()|| '',
                          type: req_msg_tp_type||'',
                          website: website
                      }),
                      success: function (resp) {
                         _this.prop("disabled", "");
                         _this.text('继续提交');
                          if (resp.success) {
                              if(resp.data.content){
                                  if (resp.data.type == 'CONTROL') {
                                      //前端交互流程完成
                                      if (resp.data.process_code === 10008) {
                                           $('#jdAuthenticationBtn').parent().find('div').addClass('hook');
                                           eachHook();
                                          upPop.modal('hide');
                                          return false;
                                      }else if (resp.data.process_code === 10002) {
                                          req_msg_tp_type = resp.data.req_msg_tpl.type;
                                          $('#JD-errorInfo').html(resp.data.content).show();
                                          $('#jdStrYan').removeClass('hide');
                                          return false;
                                      }
                                  }
                                  $('#JD-errorInfo').html(resp.data.content).show();
                              }
                          }else{
                              $('#JD-errorInfo').html(resp.message).show();
                          }
                      },
                      error:function(){
                          $('#JD-errorInfo').html('网络不佳，请重新尝试').show();
                          _this.prop("disabled", "");
                          _this.text('继续提交');
                      }
                  });
              }
              
              function jdFocusClear(dom){
                  dom.on('focus',function(){
                      $('#JD-errorInfo').hide();
                       $('#credit-errorInfo').hide();
                  });
              }
              
              function clearErrorJd(){
                  var JDname = $('#jdStrName'),
                      JDpassword = $('#jdStrPassword'),
                      JDPhone = $('#jdStrYan');
                    jdFocusClear(JDname);  
                    jdFocusClear(JDpassword);  
                    jdFocusClear(JDPhone);  
              }
              

              //京东认证
              $('#jdAuthenticationBtn').on('click',function(){
                  var _this = $(this);
                  
                  if(_this.parent().find('div').hasClass('hook')){
                      return false;
                  }else{
                      upPop.html(jdPopstr);
                      
                      $.ajax({
                          url:dsUrl,
                          type:'GET',
                          success:function(res) {
                              if (res.success) {
                                  website=res.data[0].website;
                                  $.ajax({
                                      url: applyUrl,
                                      type: 'POST',
                                      contentType: 'application/json;charset=utf-8',
                                      data: JSON.stringify({
                                          skip_mobile:true,
                                          selected_website:[
                                              {
                                                  website:res.data[0].website,
                                                  category:res.data[0].category
                                              }
                                          ],
                                          basic_info: {
                                              name: user_name,
                                              id_card_num: id_card_num,
                                              cell_phone_num: iphone_number
                                          }
                                      }),
                                      success: function (resg) {
                                          if(resg.success){
                                              token = resg.data.token;
                                              cell_phone_num = $('#jdStrName').val();
                                          }else{
                                              $('#JD-errorInfo').html('失败请重试').show();
                                          }
                                      }
                                  });
                              }
                          }
                      })

                       upPop.modal('show');
                       $('#toDynamic').on('click',JDAuthentication);
                  }
                 

              });
             
           
              function CheckMail() {
                  var mail = $(this).val();
                  var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                  if (filter.test(mail)){
                      $('#credit-errorInfo').html('').hide();
                      $('#toDynamic').prop("disabled", "");
                  }else {
                      $('#credit-errorInfo').html('您的邮箱格式不正确').show();
                      $('#toDynamic').prop("disabled", "disabled");
                  }
              }
              
              function clearErrorCredIt(){
                  var creditName = $('#creditStrName'),
                      creditpassword = $('#creditStrPassword'),
                      creditOnepassword = $('#creditOneStrPassword');
                    jdFocusClear(creditName);  
                    jdFocusClear(creditpassword);  
                    jdFocusClear(creditOnepassword);  
              }
              
              //信用卡认证
              function creditAuthentication(){
                  clearErrorCredIt();
                  var creditName = $('#creditStrName'),
                      creditpassword = $('#creditStrPassword'),
                      creditOnepassword = $('#creditOneStrPassword'),
                      _this = $(this),
                      creditOnepassword_type = '';
                  
                   $('#credit-errorInfo').hide();
                  if(!creditName.val()){
                      $('#credit-errorInfo').html('请填写您的信用卡邮箱').show();
                      creditName.focus();
                      return false;
                  }else if(!creditpassword.val()){
                      $('#credit-errorInfo').html('请填写您的密码').show();
                      creditpassword.focus();
                      return false;
                  }
                  if(creditName.val().indexOf('163.com')!= -1){
                      creditOnepassword.show();
                      if(!creditOnepassword.val()){
                          $('#credit-errorInfo').html('请填写您邮箱的独立密码').show();
                          creditOnepassword.focus();
                          return false;
                      }
                  }else if(creditName.val().indexOf('126.com')!= -1){
                      creditOnepassword.show();
                      if(!creditOnepassword.val()){
                          $('#credit-errorInfo').html('请填写您邮箱的独立密码').show();
                          creditOnepassword.focus();
                          return false;
                      }
                  }else if(creditName.val().indexOf('yeah.com')!= -1){
                      creditOnepassword.show();
                      if(!creditOnepassword.val()){
                          $('#credit-errorInfo').html('请填写您邮箱的独立密码').show();
                          creditOnepassword.focus();
                          return false;
                      }
                  }else{
                      creditOnepassword.hide();
                  }
                  //else if(!creditOnepassword.val()){
                  //    $('#credit-errorInfo').html('请填写您邮箱的独立密码').show();
                  //    creditOnepassword.focus();
                  //    return false;
                  //}
                  //这个后台需要传下
                   //   user_name='';
                   //   id_card_num='';
                   //   iphone_number='';
                      
                  _this.prop("disabled", "disabled");
                  _this.text('正在校验，请稍等...');
                  $.ajax({
                      url:creditApplyUrl,
                      type: 'POST',
                      contentType: 'application/json;charset=utf-8',
                      data: JSON.stringify({
                          apply_info: {
                              basic_info:{
                              name: user_name,
                              id_card_num: id_card_num,
                              cell_phone_num: iphone_number
                          }},
                          email:creditName.val(),
                          password:creditpassword.val(),
                          identity:creditOnepassword.val()
                      }),
                     success:function(resg) {
                          if (resg.success) {
                              token = resg.data.token;
                              $.ajax({
                                  url: creditCollectUrl,
                                  type: 'POST',
                                  contentType: 'application/json;charset=utf-8',
                                  data: JSON.stringify({
                                      token: token,
                                      password:creditpassword.val(),
                                      identity:creditOnepassword.val(),
                                      type:creditOnepassword_type
                                  }),
                                  success: function (resp) {
                                      _this.prop("disabled", "");
                                      _this.text('完成');
                                      if (resp.success) {
                                          if(resp.data.content){                                        
                                              if (resp.data.type == 'CONTROL') {
                                                  //前端交互流程完成
                                                  if (resp.data.process_code === 10008) {
                                                      upPop.modal('hide');
                                                       $('#creditBtn').parent().find('div').addClass('hook');
                                                       eachHook();
                                                      return false;
                                                  }else if (resp.data.process_code === 10003) {
                                                      req_msg_tp_type = resp.data.req_msg_tpl.type;
                                                      $('#credit-errorInfo').html(resp.data.content).show();
                                                      return false;
                                                  }else if (resp.data.process_code === 10005) {
                                                      req_msg_tp_type = resp.data.req_msg_tpl.type;
                                                      creditOnepassword_type ='SUBMIT_IDENTITY';
                                                      $('#credit-errorInfo').html(resp.data.content).show();
                                                      return false;
                                                  } else if (resp.data.process_code === 10111) {
                                                      //二维码已授权
                                                      //$('#credit-errorInfo').html(resp.data.content.split("_")[0]).show();
                                                      $('#credit-errorInfo').html('请使用QQ客户端扫描上方二维码').show();
                                                     var imgCode = resp.data.content.split("_")[1];
                                                      $("#code-img").attr('src',imgCode);
                                                      $('.qq-code').removeClass('hide');
                                                      qrCodeAjax();
                                                      //creditAuthentication();
                                                      return false;
                                                  } else if (resp.data.process_code === 10112) {
                                                      //二维码已失效,已重新生成
                                                       //$('#credit-errorInfo').html(resp.data.content.split("_")[0]).show();
                                                      $('#credit-errorInfo').html('请使用QQ客户端扫描上方二维码').show();
                                                     var imgCode = resp.data.content.split("_")[1];
                                                      $('.qq-code').show();
                                                      qrCodeAjax();
                                                      //creditAuthentication();
                                                      return false;
                                                  } else if (resp.data.process_code === 10013) {
                                                      //等待用户打开qq安全中心进行确认
                                                      //需要请求获取信用卡响应接口

                                                  } else if (resp.data.process_code === 10016) {
                                                      //等待用户打开微信安全中心公众号进行确认
                                                      //需要请求获取信用卡响应接口
                                                  }
                                              }
                                              $('#credit-errorInfo').html(resp.data.content).show();
                                          }
                                      }else{
                                           $('#credit-errorInfo').html(resg.message).show();
                                      }
                                  },
                                  error:function(){
                                      $('#credit-errorInfo').html('网络不佳，请重新尝试').show();
                                      _this.prop("disabled", "");
                                      _this.text('完成');
                                  }
                              });
                          }else {
                              $('#credit-errorInfo').html(resg.message).show();
                               //$('#credit-errorInfo').html('系统发生内部错误').show();
                                _this.prop("disabled", "");
                                _this.text('完成');
                          }
                          
                      }
                  })


              }
              function qrCodeAjax(){
                  $.ajax({
                      url:qrcodeCollectUrl,
                      type:'POST',
                       contentType: 'application/json;charset=utf-8',
                      data: JSON.stringify({ token:token}),
                      success:function(data){
                          if(data.success){
                              if(data.data.content){
                                  if (data.data.type == 'CONTROL') {
                                      //前端交互流程完成
                                      if (data.data.process_code === 10008) {
                                          upPop.modal('hide');
                                           $('#creditBtn').parent().find('div').addClass('hook');
                                           eachHook();
                                          return false;
                                      }
                                  }
                              }
                          }else{
                               $('#credit-errorInfo').html(data.message).show();
                          }
                      }
                  });
              }
              //信用卡认证
              $('#creditBtn').on('click',function(){
                  var _this = $(this);
                  if(_this.parent().find('div').hasClass('hook')){
                      return false;
                  }
                   
                  upPop.html(creditPopstr);
                  $('#creditStrName').on('blur',CheckMail);
                  upPop.modal('show');
                  $('#toDynamic').on('click',creditAuthentication);
              });

              //第三步验证 end

                
               function selectShow(_this) {
                  _this.find('.bank_btn').find('span').removeClass('btn-top').addClass('btn-bottom');
                  _this.find('.daylist').show();
              }
              function selectHide(dom){
                  dom.find('.bank_btn').find('span').removeClass('btn-bottom').addClass('btn-top');
                  dom.find('.daylist').hide();
              }
              function dayShow(event){
                  var _this = $(this).parent();
                  var oBankShow = _this.find('.bank_btn').find('span').hasClass('btn-top');
                  if(!oBankShow){
                      selectHide(_this);
                  }else{
                      selectShow(_this);
                      _this.find('.daylist').css({display:'block'});
                  }
                  event.stopPropagation();
              }
              function dayList(){
                  var _this = $(this),
                      parent = _this.parent().parent(),
                      _parent = _this.parent().parent().find('.text'),
                      html = _this.html();
                  _parent.html(html);
                  _parent.attr('data-value',_this.attr('data-value'));

                  selectHide(parent);
              }

              ofamily2IdBtn.on('click',dayShow);
              family2_type.on('click',dayShow);
              ofamily2IdLi.on('click',dayList);

              ofamily3Btn.on('click',dayShow);
              family3_type.on('click',dayShow);
              ofamily3IdLi.on('click',dayList);

              //芝麻信用s
              function zhifubao(){
                  $.ajax({
                      url:'',
                      type:'POST',
                      data:{
                          
                      },
                      success:function(data){
                          if(data.success){
                              //成功返回  执行
                              //下面四行代码用户芝麻信用跳转认证后回来切步骤
                              first.hide();
                              second.hide();
                              third.show();
                              $('#zhifubao').addClass('hook');
                              eachHook();
                              titleXinxi(1);
                              titleXinxi(2);
                          }
                      }
                  });
              }
              
              function eachHook(){
                  $('.authentLi').each(function(){
                      var _this = $(this);
                      if(_this.find('div').hasClass('hook')){
                          _this.find('a').html('已认证');
                      }
                  });
              }
              
              function init(){  
                  //如果用户通过手机认证直接跳过
                  if($("#status").val()=='01'||$("#status").val()=='02'){
                      first.hide();
                      second.hide();
                      third.show();
                      titleXinxi(1);
                      titleXinxi(2);
                  }

                  eachHook();
                  
                  $('#whatServerYD').on('click', function () {
                      $('#puPop').html(whatServerYDStr);
                      $('#puPop').modal('show');
                  });

              }
              init();
          };

          $(document).ready(home);
          
          
      }(jQuery));

      $.fn.extend({
          uploadPreview: function (opts) {
              var _self = this,
                  _this = $(this);
              opts = jQuery.extend({
                  Img: "ImgPr",
                  Width: 100,
                  Height: 100,
                  ImgType: ["gif", "jpeg", "jpg", "bmp", "png"],
                  Callback: function () { }
              }, opts || {});
              _self.getObjectURL = function (file) {
                  var url = null;
                  if (window.createObjectURL != undefined) {
                      url = window.createObjectURL(file)
                  } else if (window.URL != undefined) {
                      url = window.URL.createObjectURL(file)
                  } else if (window.webkitURL != undefined) {
                      url = window.webkitURL.createObjectURL(file)
                  }
                  return url
              };
              _this.change(function () {
                  if (this.value) {
                      if (!RegExp("\.(" + opts.ImgType.join("|") + ")$", "i").test(this.value.toLowerCase())) {
                          alert("选择文件错误,图片类型必须是" + opts.ImgType.join("，") + "中的一种");
                          this.value = "";
                          return false
                      }
                      var ie = navigator.appName == "Microsoft Internet Explorer" ? true : false;
                      if (ie) {
                          try {
                              $("#" + opts.Img).attr('src', _self.getObjectURL(this.files[0]))
                          } catch (e) {
                              var src = "";
                              var obj = $("#" + opts.Img);
                              var div = obj.parent("div")[0];
                              _self.select();
                              if (top != self) {
                                  window.parent.document.body.focus()
                              } else {
                                  _self.blur()
                              }
                              src = document.selection.createRange().text;
                              document.selection.empty();
                              obj.hide();
                              obj.parent("div").css({
                                  'filter': 'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)',
                                  'width': opts.Width + 'px',
                                  'height': opts.Height + 'px'
                              });
                              div.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = src
                          }
                      } else {
                          $("#" + opts.Img).attr('src', _self.getObjectURL(this.files[0]))
                      }
                      $('#imgText').remove();
                      opts.Callback()
                  }
              });

              return {
                  /*ie不适用！*/
                  checkFile: function CheckFile() {
                      var ie = navigator.appName == "Microsoft Internet Explorer" ? true : false;
                      if (ie) {
                          _this[0].click();
                      } else {
                          var mouseobj = document.createEvent("MouseEvents");
                          mouseobj.initEvent("click", true, true);
                          _this[0].dispatchEvent(mouseobj);
                      }
                      return _self;
                  },
                  //兼容ie8的
                  CheckInito: function () {
                      var ie = navigator.appName == "Microsoft Internet Explorer" ? true : false;
                      _this.css("position", "absolute");
                      _this.parent().css("width", opts.Width + "px");
                      _this.parent().css("height", opts.Height + "px");
                      if (ie) {
                          //width: 67.5px; height: 37.4px; padding-right: 5px; position: absolute; opacity: 1;
                          _this.css("width", opts.Width + "px");
                          _this.css("height", opts.Height + "px");
                          _this.css("font-size", "200px");
                          _this.css("overflow", "hidden");
                      } else {
                          _this.css("left", "0px");
                          _this.css("top", "0px");
                          _this.css("width", opts.Width + "px");
                          _this.css("height", opts.Height + "px");
                      }
                      _this.css("opacity", "0");
                      return _self;
                  }
              };
          }
      });



/*展示服务密码 */
      function showMask1(){
    	  $("#bg").css("height", document.body.scrollHeight);
          $("#bg")[0].style.display = "block";
          //$("#ays")[0].style.display = "block";
          $("#ays1").animate({"height":"toggle"});
      }  
        
      /*展示网站密码  */
      function showMask2(){
        $("#bg").css("height", document.body.scrollHeight);
          $("#bg")[0].style.display = "block";
          //$("#ays")[0].style.display = "block";
          $("#ays2").animate({"height":"toggle"});
      } 
      /*关闭服务密码  */
      function dismissAys1() {
    	  $("#ays1").animate({"height":"toggle"},200,function(){
    	    $("#bg")[0].style.display = "none";
    	  });
    	}
      
      /*关闭网站密码   */
      function dismissAys2() {
        $("#ays2").animate({"height":"toggle"},200,function(){
          $("#bg")[0].style.display = "none";
        });
      }
      
      /*关闭动态密码   */
      function dismissAys3() {
        $("#ays3").animate({"height":"toggle"},200,function(){
          $("#bg")[0].style.display = "none";
        });
      }
      


      