package com.ruiqt.lianlian.utils;

/**
 * 商户配置信息
 * 
 * @author zhanglei
 * @date:2015-8-24
 * @version :1.0
 */
public interface PartnerConfig {
//-----------------------------生产环境---------------------
 String ONLINEURL_APP = "http://localhost/controller/app";
  // appasyn28
  String ONLINEURL_APPASYN28 = "http://localhost/appasyn28";
  // banner地址
  String BANNERURL = "http://www.rqbao.com/app/image/images/banner";
  // html版本文件目录   本地,root.app.rqb在web.xml配置
  String VERSION_DIR = System.getProperty("root.app.rqb")+"/WEB-INF/";
  //新版本的下载目录
  String DOWNLOADURL = "http://www.rqbao.com/app/image/";

//-----------------------------测试环境---------------------
  /*
  // online
  String ONLINEURL_APP = "http://localhost/rqt/controller/app";
  // appasyn28
  String ONLINEURL_APPASYN28 = "http://localhost/rqt/appasyn28";
  // banner地址
  String BANNERURL = "http://123.57.77.184/app/image/images/banner";
  // html版本文件目录   本地,root.app.rqb在web.xml配置
  String VERSION_DIR = System.getProperty("root.app.rqb")+"/WEB-INF/";
  //新版本的下载目录
  String DOWNLOADURL = "http://localhost/app/image/";
  */
 
  
//--------------------------------------------------------------------  
    // 银通公钥
	String YT_PUB_KEY = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCSS/DiwdCf/aZsxxcacDnooGph3d2JOj5GXWi+q3gznZauZjkNP8SKl3J2liP0O6rU/Y/29+IUe+GTMhMOFJuZm1htAtKiu5ekW0GlBMWxf4FPkYlQkPE0FtaoMP3gYfh+OwI+fIRrpW3ySn3mScnc6Z700nU/VYrRkfcSCbSnRwIDAQAB";
	// MD5 KEY
	String MD5_KEY = "5416b9dbff02358930b01496c9e09425";
	// 签名方式 RSA或MD5
	String SIGN_MD5_TYPE = "MD5";
	
	/* ump start*/
	// 用户注册
	String BACKENDURL_UMP_REG = ONLINEURL_APP + "/ump/reg";
	// 绑卡
	String BACKENDURL_UMP_BANDCARD = ONLINEURL_APP + "/ump/bandCard";
	// 我的银行卡
	String BACKENDURL_UMP_MYBANDCARD = ONLINEURL_APP + "/ump/myBandCard";
	// 提现记录
	String BACKENDURL_UMP_WITHDRAW = ONLINEURL_APP + "/ump/withdraw";
	// 充值记录
	String BACKENDURL_UMP_RECHARGE = ONLINEURL_APP + "/ump/recharge";
	// 投资
	String BACKENDURL_UMP_INVEST = ONLINEURL_APP + "/ump/invest";
	// 检查交易结果
	String BACKENDURL_UMP_CHECKTRADERESULT = ONLINEURL_APP + "/ump/checkTradeResult";
	// 检查状态
	String BACKENDURL_UMP_CHECKREGISTERSTATUS = ONLINEURL_APP
				+ "/ump/checkRegisterStatus";
	// 重置交易密码
	String BACKENDURL_UMP_CHANGEPAYPASSWORD = ONLINEURL_APP
			+ "/ump/changePayPassword";
	/* ump end*/
	
	/* member start*/
	// 返回真实姓名
	String BACKENDURL_RE_REALNAME = ONLINEURL_APP + "/member/re_realName";
	// 身份验证
	String BACKENDURL_AUTHIDENTITY = ONLINEURL_APP + "/member/authenticationIdentity";
	// 修改登录密码
	String BACKENDURL_CHANGEL = ONLINEURL_APP + "/member/changel";
	// *修改登录密码
	String BACKENDURL_CHANGEPASSWORD = ONLINEURL_APP + "/member/changePassword";
	// 修改支付口令
	String BACKENDURL_CHANGEP = ONLINEURL_APP + "/member/changep";
	// 修改手机号
	String BACKENDURL_CHANGETEL = ONLINEURL_APP + "/member/changeTel";
	// *修改手机号
	String BACKENDURL_CHANGEMOBILE = ONLINEURL_APP + "/member/changeMobile";
	// 检查状态
	String BACKENDURL_CHECKREGISTERSTATUS = ONLINEURL_APP
			+ "/member/checkRegisterStatus";
	// 实名认证
	String BACKENDURL_CHECKAUTHENTICATION = ONLINEURL_APP
				+ "/member/checkAuthentication";
	// 实名认证
	String BACKENDURL_DOAPPAUTHIDCARD = ONLINEURL_APP + "/member/doAPPAuthIdCard";
	// 用户登录
	String BACKENDURL_LOGIN = ONLINEURL_APP + "/member/login";
	// 用户注册
	String BACKENDURL_REG = ONLINEURL_APP + "/member/reg";
	// 获取账户当前的手机号
	String BACKENDURL_FINDOLDM = ONLINEURL_APP + "/member/findOldM";
	// 找回密码
	String BACKENDURL_FINDPW = ONLINEURL_APP + "/member/findPW";
	// 修改头像
	String BACKENDURL_PIC = ONLINEURL_APP + "/member/pic";
	// 验证手机号
	String BACKENDURL_REGMOBILE = ONLINEURL_APP + "/member/regMobile";
	// 个人中心
	String BACKENDURL_INCOME = ONLINEURL_APP + "/member/income";
	// 获取手机验证码
	String BACKENDURL_GENCODE = ONLINEURL_APP + "/member/gencode";
	// 发送语音验证码
	String BACKENDURL_SENDAUDIO = ONLINEURL_APP + "/member/sendAudio";
	/* member end*/
	
	/* loan start*/
	// 获取最新投资项目
	String BACKENDURL_NEWLOAN = ONLINEURL_APP + "/loan/newLoan";
	// 查看投资详情
	String BACKENDURL_VLOAN = ONLINEURL_APP + "/loan/vloan";
	// 投资列表
	String BACKENDURL_LOANS = ONLINEURL_APP + "/loan/loans";
	// 项目分类
	String BACKENDURL_TYPES = ONLINEURL_APPASYN28 + "/types";
	// 投资列表分类
	String BACKENDURL_LOANSCLASSIFY = ONLINEURL_APPASYN28 + "/loansClassify";
	// 交易记录
	String BACKENDURL_RECORD = ONLINEURL_APP + "/loan/record";
	/* loan end*/
	
	/* coupon start*/
	// 激活瑞钱币
	String BACKENDURL_ACTIVECOUPON = ONLINEURL_APP + "/coupon/activeCoupon";
	// 代金劵详情
	String BACKENDURL_COUPON_SUMMARY = ONLINEURL_APPASYN28 + "/coupon_summary";
	// 用户代金券
	String BACKENDURL_COUPON = ONLINEURL_APP + "/coupon/coupon";
	// 代金券列表
	String BACKENDURL_COUPONRECORD = ONLINEURL_APP + "/coupon/couponRecord";
	// 积分兑换规则
	String BACKENDURL_EXCHANGE_RULE = ONLINEURL_APP + "/coupon/exchange_rule";
	// 积分兑换锐钱币
	String BACKENDURL_EXCHANGE = ONLINEURL_APPASYN28 + "/exchange";
	/* coupon end*/
	
	/* account start*/
	// 回款记录
	String BACKENDURL_PAMENTRECORD = ONLINEURL_APP + "/account/paymentRecord";
	// 账户明细
	String BACKENDURL_ACCOUNTRECORD = ONLINEURL_APP + "/account/accountRecord";
	// 提现记录
	String BACKENDURL_WITHDRAWRECORD = ONLINEURL_APP + "/account/withdrawRecord";
	// 充值记录
	String BACKENDURL_RECHARGERECORD = ONLINEURL_APP + "/account/rechargeRecord";
	
	// this is old interface
	// 接收用户提现请求,判断是否可以提现
	String BACKENDURL_BANKCARDNO = ONLINEURL_APPASYN28 + "/bankCardNO";
	// 绑卡
	String BACKENDURL_BANDCARD = ONLINEURL_APPASYN28 + "/bandCard";
	// 接收用户提现请求,生成一张体现单,进入待审核状态
	String BACKENDURL_WITHDRAWREQUEST = ONLINEURL_APPASYN28
			+ "/withDrawRequest";
	/* account end*/
	
	/* shop start*/
	// 积分商城商品兑换
	String BACKENDURL_SHOP_EXCHANGE = ONLINEURL_APP + "/shop/shop_exchange";
	// 积分商城首页
	String BACKENDURL_SHOP_index = ONLINEURL_APP + "/shop/shop_index";
	// 商品详情
	String BACKENDURL_SHOP_DETAIL_LIST = ONLINEURL_APP + "/shop/shop_detail_list";
	// 商品兑换历史
	String BACKENDURL_SHOP_EXCHANGE_HISTORY = ONLINEURL_APP + "/shop/shop_exchange_history";
	// 商品兑换历史
	String BACKENDURL_SHOP_EXCHANGE_NOTIFY = ONLINEURL_APP + "/shop/shop_exchange_notify";
	/* shop end*/
	
	/* point start*/
	// 积分兑换锐钱币 历史详情
	String BACKENDURL_EXCHANGE_HISTORY = ONLINEURL_APP + "/point/exchange_history";
	// 查询瑞钱币明细
	String BACKENDURL_TOTALPOINT = ONLINEURL_APP + "/point/totalPoint";
	// 积分明细
	String BACKENDURL_POINTDETAILS = ONLINEURL_APP + "/point/pointDetails";
	// 签到得积分
	String BACKENDURL_SIGNIN = ONLINEURL_APP + "/point/signIn";
	// 检查积分是否能够加入vip俱乐部
	String BACKENDURL_VIPJOINCLUB = ONLINEURL_APP + "/point/vipJoinClub";
	// 检查是否申请VIP俱乐部
	String BACKENDURL_CHECKVIPMEMBER = ONLINEURL_APP + "/point/checkVipMember";
	// VIP用户主页
	String BACKENDURL_VIPLEVEL = ONLINEURL_APP + "/point/viplevel";
	// 积分排行榜
	String BACKENDURL_POINTPANKINGS = ONLINEURL_APP + "/point/pointRankings";
	/* point end*/
	
	/* ticket start*/
	// 激活优惠劵
	String BACKENDURL_ACTIVETICKET = ONLINEURL_APP + "/ticket/activeTicket";
	// 优惠劵列表
	String BACKENDURL_TICKETRECORD = ONLINEURL_APP + "/ticket/ticketRecord";
	// 用户优惠劵
	String BACKENDURL_REWARD = ONLINEURL_APP + "/ticket/reward";
	/* ticket end*/
	
	/* invest start*/
	// 转让接口
	String BACKENDURL_TRANSFOR = ONLINEURL_APP + "/invest/transfor";
	// 投资更多详情
	String BACKENDURL_INVESTMORE = ONLINEURL_APP + "/invest/investMore";
	// 投资记录
	String BACKENDURL_SEARCHMYINVEST = ONLINEURL_APP + "/invest/searchMyInvest";
	// 投资
	String BACKENDURL_MAXINVEST = ONLINEURL_APP + "/invest/maxInvest";
	// 投资,用于iOS，需要验证码
	String BACKENDURL_ADDINVEST1 = ONLINEURL_APP + "/invest/addInvest1";
	// 进入投资
	String BACKENDURL_INVEST = ONLINEURL_APP + "/invest/invest";
	// 我的投资
	String BACKENDURL_MYINVEST = ONLINEURL_APP + "/invest/myInvest";
	/* invest end*/
	
	/* message start*/
	// 标记消息为已读
	String BACKENDURL_CHANGEMESSAGESTATE = ONLINEURL_APP + "/message/changeMessageState";
	// 标记单个消息为已读
	String BACKENDURL_CHANGESINGLEMESSAGESTATE = ONLINEURL_APP + "/message/changeSingleMessageState";
	// 未读消息列表
	String BACKENDURL_MESSAGECENTER = ONLINEURL_APP + "/message/messageCenter";
	// 清空消息
	String BACKENDURL_DELETEMESSAGE = ONLINEURL_APP + "/message/deleteMessage";
	// 删除单个消息
	String BACKENDURL_DELETESINGLEMESSAGE = ONLINEURL_APP + "/message/deleteSingleMessage";
	// 检查有无未读消息
	String BACKENDURL_CHECKISHASNOREADMESSAGE = ONLINEURL_APP + "/message/checkIsHasNoReadMessage";
	// 消息详情
	String BACKENDURL_MESSAGEDETAIL = ONLINEURL_APP + "/message/messageDatail";
	/* message end*/
	
	/* reference start*/
	// 推荐明细
	String BACKENDURL_REFERENCERECORD = ONLINEURL_APP + "/reference/referenceRecord";
	// 好友推荐
	String BACKENDURL_REFERENCEFRIEND = ONLINEURL_APP + "/reference/referenceFriend";
	// 我的推荐
	String BACKENDURL_MYREFERENCE = ONLINEURL_APP + "/reference/myReference";
	/* reference end*/
	
	/* article start*/
	// 查看公告详情
	String BACKENDURL_VIEW = ONLINEURL_APP + "/view";
	// 网站公告
	String BACKENDURL_ARTICLE = ONLINEURL_APP + "/article";
	// 网站公告
	String BACKENDURL_ARTICLE_v2 = ONLINEURL_APP + "/article/article";
	/* article end*/
	// 分享接口
	String BACKENDURL_SHAREAWARD = ONLINEURL_APPASYN28 + "/shareAward";
}
