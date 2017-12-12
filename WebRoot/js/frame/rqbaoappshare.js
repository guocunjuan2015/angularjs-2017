/**
 */

//分享信息定义
var title     = '';
var content   = '';
var url       = '';
var icon      = '';
var amount    = '';
var projectId = '';
var projectName = '';
var projectType = '';
var period = '';
var orderId = '';

/*判断是安卓或者是IOS*/
var browser = {
  versions : function() {
    var u = navigator.userAgent, app = navigator.appVersion;
    return { //移动终端浏览器版本信息
      ios : !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
      android : u.indexOf('Android') > -1
          || u.indexOf('Linux') > -1, //android终端或uc浏览器
      weixin : u.indexOf('MicroMessenger') > -1, //是否微信 （2015-01-22新增）
    };
  }(),
  language : (navigator.browserLanguage || navigator.language)
      .toLowerCase()
}

// 安卓调用
!function() {// 分享
	if (document.getElementById('share-btn')) {
		document.getElementById('share-btn').onclick = function() {
			jsb.require('share', {
				'title' : title,
				'desc' : content,
				'link' : url,
				'imgUrl' : icon
			});
		}
	}
}();
!function(){// 去投资
	if(document .getElementById('invest-btn')){
		document .getElementById('invest-btn').onclick=function(){
	        jsb.require('invest', {
	        });
	    }
	}
}();
!function(){//去注册
	if(document .getElementById('regist-btn')){
		document .getElementById('regist-btn').onclick=function(){
	        jsb.require('regist', {
	        });
	    }	
	}
}();
!function(){//去登录
	if(document .getElementById('login-btn')){
		document .getElementById('login-btn').onclick=function(){
	        jsb.require('login', {
	        });
	    }	
	}
}();
 
function appFunction(name){//jsp中调用app中的方法
	if ('share' == name || 'setShareContent' == name || 'shareGetDifferentAward' == name) {
		jsb.require(name, {
			'title' : title,
			'desc' : content,
			'link' : url,
			'imgUrl' : icon
		});
		
	} else if ('investFinishToShare' == name) {
		jsb.require(name, {
			'title' : title,
			'desc' : content,
			'link' : url,
			'imgUrl' : icon
		});
	} else if ('toNextPage' == name) {
		jsb.require(name, {
			'title' : title,
			'link' : url
		});
	} else if ('toInvest' == name) {
		jsb.require(name, {
			'amount' : amount,
			'projectId' : projectId,
			'projectName' : projectName,
			'projectType' : projectType,
			'period' : period,
			'orderId' : orderId
		});
	} else if ('toProjectDetail' == name) {
		jsb.require(name, {
			'projectId' : projectId,
			'projectType' : projectType
		});
	} else {
		jsb.require(name, {});
	} 
}
 
 
function isAndroidOrIos(){//判断来源是否是app
    var API_NAMESPACE = '__JavascriptBridge__';
    var api = window[API_NAMESPACE] || null;
    if(api || window.WebViewJavascriptBridge){
    	return true;
    }else{
    	return false;
    }
}

function isAndroid(){//判断来源是否是android
	var NAMESPACE = 'jsb';
    var API_NAMESPACE = '__JavascriptBridge__';
    var API_FREQUENCY = 200;
    var context = window[NAMESPACE] = {};
    var api = window[API_NAMESPACE] || null;
    if(api){
    	return true;
    }else{
    	return false;
    }
}
function isIos(){//判断来源是否是Ios
	if( window.WebViewJavascriptBridge){
		return true;
	}else{
		return false;
	}
}

// 判断来源是IOS 还是 ANDROID 还是 微信
function whereComeForm() {
    if (browser.versions.android || browser.versions.ios) {
    	return true;
    } else {
       return false;
    }
}
// AndroidJavascriptBridge
!function(undefined){
    var NAMESPACE = 'jsb';
    var API_NAMESPACE = '__JavascriptBridge__';
    var API_FREQUENCY = 200;
    var context = window[NAMESPACE] = {};
    var api = window[API_NAMESPACE] || null;
    if(!api){
        return ''; //('发生错误, 未找到 api 对象!');
    }
    /**
     * 保存提供给java调用的js方法列表
     * @type {Object}
     */
    var jsMethodMap = {};
    /**
     * 添加提供给java调用的js方法
     * @param {[type]} method [description]
     * @param {[type]} func   [description]
     */
    context.addJavascriptMethod = function(method, func){
        jsMethodMap[method] = func;
    }

    /**
     * 请求调用java方法
     * @param  {[type]}   cmd      [description]
     * @param  {[type]}   params   [description]
     * @param  {Function} callback [description]
     * @return {[type]}
     */
    context.require = function(cmd, params, callback){
        params = params || '{}';
        var result = api.require(cmd, JSON.stringify(params));
        if(callback && result){
            result = JSON.parse(result);
        }
        callback && callback(result);
    }

    var executeCommand = function(cmdObj){
        var method = jsMethodMap[cmdObj.cmd];
        if(method instanceof Function){
            var result = method.call(window, cmdObj.params);
            if(result){
                api.setResult(cmdObj.serial, JSON.stringify(result));
            }
        }
    }

    var listener = {
        _timer: 0,
        _timerFunc: function(){
            var cmdsStr = api.getCommands();
            var cmdList = JSON.parse(cmdsStr);
            if(cmdList.length){
                for(var i in cmdList){
                    executeCommand(cmdList[i]);
                }
            }
            listener.run();
        },
        run: function(){
            this._timer = setTimeout(this._timerFunc, API_FREQUENCY);
        },
        stop: function(){
            clearTimeout(this._timer);
            this._timer = 0;
        }
    };
    listener.run();
}();


/**
 * IOS 微信分享
 */
window.onerror = function(err) {
    //log('window.onerror: ' + err)
}

function connectWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) {
        callback(WebViewJavascriptBridge)
    } else {
        document.addEventListener('WebViewJavascriptBridgeReady', function() {
            callback(WebViewJavascriptBridge)
        }, false)
    }
}

connectWebViewJavascriptBridge(function(bridge) {
    var uniqueId = 1
    function log(message, data) {
        var log = document.getElementById('log')
        var el = document.createElement('div')
        el.className = 'logLine'
        el.innerHTML = uniqueId++ + '. ' + message + ':<br/>' + JSON.stringify(data)
        if (log.children.length) { log.insertBefore(el, log.children[0]) }
        else { log.appendChild(el) }
    } 
    bridge.init(function(message, responseCallback) {
        //log('JS got a message', message)
        var data = { 'Javascript Responds':'Wee!' }
        //log('JS responding with', data)
        responseCallback(data)
    })

    bridge.registerHandler('testJavascriptHandler', function(data, responseCallback) {
        //log('ObjC called testJavascriptHandler with', data)
        var responseData = { 'Javascript Says':'Right back atcha!' }
        //log('JS responding with', responseData)
        responseCallback(responseData)
    })

    var button = document.getElementById('share-btn');//.appendChild(document.createElement('button'))
    //button.innerHTML = 'Send message to ObjC'
    button.onclick = function(e) {
        e.preventDefault()
        var data = 'Hello from JS button'
        //log('JS sending message', data)
        bridge.send(data, function(responseData) {
           // log('JS got response', responseData)
        })
    }

    document.body.appendChild(document.createElement('br'))

    
    /**为按钮添加监听事件*/
    var callbackButton = document.getElementById('share-btn');//appendChild(document.createElement('button'))
   // callbackButton.innerHTML = '分享给小伙伴'
    if(callbackButton){
    	callbackButton.onclick = function(e) {
            e.preventDefault();
            //log('JS calling handler "share2Wechat"');
            bridge.callHandler('share', {
                'title'   : title,
                'content' : content,
                'url'     : url,
                'icon'    : icon
                },function(response) {
                //log('JS got response', response);
            })
        }
    }
/*    var messagecallbackButton = document.getElementById('shareMessage');//appendChild(document.createElement('button'))
    // callbackButton.innerHTML = '分享给小伙伴'
     if(messagecallbackButton){
    	 messagecallbackButton.onclick = function(e) {
             e.preventDefault();
             //log('JS calling handler "share2Wechat"');
             bridge.callHandler('investFinishToShare', {
                 'title'   : title,
                 'content' : content,
                 'url'     : url,
                 'icon'    : icon
                 },function(response) {
                 //log('JS got response', response);
             })
         }
     }*/
     
    
    var investCallback = document.getElementById('invest-btn');//点击去投资
    if(investCallback){
    	investCallback.onclick = function(e) {
            e.preventDefault();
            //log('JS calling handler "share2Wechat"');
            bridge.callHandler('invest', {
                },function(response) {
                //log('JS got response', response);
            })
        }
    }
    
    var registCallback = document.getElementById('regist-btn');//点击去注册
    if(registCallback){
    	registCallback.onclick = function(e) {
            e.preventDefault();
            //log('JS calling handler "share2Wechat"');
            bridge.callHandler('regist', {
                },function(response) {
                //log('JS got response', response);
            })
        }
    }
    
    var loginCallback = document.getElementById('login-btn');//点击去登陆
    if(loginCallback){
    	loginCallback.onclick = function(e) {
            e.preventDefault();
            //log('JS calling handler "share2Wechat"');
            bridge.callHandler('login', {
                },function(response) {
                //log('JS got response', response);
            })
        }
    }
    
    var referCallback = document.getElementById('referrer-btn');//点击去推荐注册分享
    if(referCallback){
    	referCallback.onclick = function(e) {
            e.preventDefault();
            //log('JS calling handler "share2Wechat"');
            bridge.callHandler('toRefer', {
                },function(response) {
                //log('JS got response', response);
            })
        }
    }
    
    
})