package com.rqb.common;

/**
 * 公共常量
 * @author guyifan
 */
public class Constants {
	// 返回值
	public static class Msg{
		public static final String SUCCESS = "操作成功";
		public static final String FAILURE = "操作失败";
	}
	
	// 配置文件属性
	public static class Pks{
		public static final String REGISTER_LOGIN = "rqb.interface.register.login";
		public static final String REGISTER_GETCODE = "rqb.interface.register.getcode";
		public static final String REGISTER_REG = "rqb.interface.register.reg";
		public static final String REGISTER_USER_VALIDATE = "rqb.interface.register.uservalidate";
		public static final String REGISTER_CHECK_REGISTER_STATUS = "rqb.interface.register.checkRegisterStatus";
		
		public static final String ACCOUNT_INFO_FINDPW = "rqb.interface.account.findpw";
		
		public static final String ACCOUNT_CHANGEL = "rqb.interface.account.changel";
		public static final String ACCOUNT_CHANGEP = "rqb.interface.account.changep";
		
		public static final String ACCOUNT_INFO_DOAPPAUTHIDCARD = "rqb.interface.account.info.doAPPAuthIdCard";
		public static final String ACCOUNT_INFO_INCOME = "rqb.interface.account.info.income";
		public static final String ACCOUNT_INFO_SEARCHMYINVEST = "rqb.interface.account.info.searchMyInvest";
		public static final String ACCOUNT_INFO_SEARCH_TRANSFER_INVEST = "rqb.account.search.transfer.invest";
		public static final String ACCOUNT_INFO_RECORD = "rqb.interface.account.info.record";
		public static final String ACCOUNT_INFO_TRANSFOR = "rqb.interface.account.info.transfor";
		public static final String ACCOUNT_FUNDING_LIST = "rqb.interface.account.funding.list";
		public static final String ACCOUNT_BALANCE = "rqb.interface.account.balance";
		
		public static final String PROJECT_LOANS = "rqb.interface.project.loans";
		public static final String PROJECT_LOANSCLASSIFY = "rqb.interface.project.loansClassify";
		public static final String PROJECT_VLOAN = "rqb.interface.project.vloan";
		public static final String PROJECT_TRANSFER_VLOAN = "rqb.interface.project.transfer.vloan";
		public static final String PROJECT_INVESTMORE = "rqb.interface.project.investMore";
		public static final String PROJECT_INVEST = "rqb.interface.project.invest";
		public static final String PROJECT_ADDINVEST = "rqb.interface.project.addInvest";
		
		public static final String RECHARGE_RECHARGEVALIDATE = "rqb.interface.recharge.rechargeValidate";
		public static final String RECHARGE_DORECHARGEAPP = "rqb.interface.recharge.doRechargeApp";
		public static final String RECHARGE_BANKCARDNO = "rqb.interface.recharge.bankCardNO";
		public static final String RECHARGE_BANDCARD = "rqb.interface.recharge.bandCard";
		public static final String RECHARGE_WITHDRAWREQUEST = "rqb.interface.recharge.withDrawRequest";
		
		public static final String VOUCHER_COUPON = "rqb.interface.voucher.coupon";
		public static final String VOUCHER_REWARD = "rqb.interface.voucher.reward"; // 我的奖励
		
		public static final String BQ_REGISTER_BEIQING = "rqb.interface.bq.register.beiqing";
		public static final String BQ_REGISTER_RQB = "rqb.interface.bq.register.rqb";
		
		public static final String LIANLIAN_URL = "rqb.lianlian.interface.url";
		
		public static final String WEIXIN_CHECK_CODE_URL = "rqb.weixin.interface.checkcode.url";
		public static final String WEIXIN_USER_INFO_URL = "rqb.weixin.interface.userinfo.url";
		public static final String WEIXIN_APP_ID = "rqb.weixin.interface.appid";
		public static final String WEIXIN_APP_SECRET = "rqb.weixin.interface.appsecret";
		
		public static final String SAVE_WITH_VISIT_COUNT = "rqb.share.savecount";
		public static final String CHECK_MOBILE_USED_OR_NOT = "check.mobile.used.or.not";
		
		//积分瑞钱币
		public static final String GET_ALL_COUPON = "rqb.getall.coupon";
		public static final String GET_REWARD_RUIQB = "rqb.getReward.Ruiqb";
		public static final String EXCHANGE_RUIQB = "to.exchange.ruiqb";
		public static final String GET_POINTS_INFO = "get.points.info";
		public static final String SHOW_EXCHANGE_HISTORY = "show.exchange.history";
		public static final String VIP_CLUB_INFO = "vip.club.info";
		public static final String POINTS_EXCHANGE_HISTORY = "points.exchange.history";
		public static final String VIP_POINTS_RANK = "vip.points.rank";
		public static final String DAY_SIGN_IN = "eachday.signin";
		
		//投资改版
		public static final String FIND_PROJECT_INFO = "find.project.info";
		public static final String FIND_USER_NUMBER = "find.user.mobile";
		public static final String CONFIRM_INVEST_TOPAY = "confirm.invest.to.pay";
		public static final String CHECK_WHETHER_VIP_MEMBER = "check.whether.vip.member";
		public static final String CHECK_CAN_JOIN_VIP_CLUB = "check.whether.can.join.club";
		
		public static final String SEARCH_BRANCH_NAME = "search.branch.name";
		public static final String SEND_AUDIO_TO_GET_CODE = "rqb.send.audio.get.phone.code";
		public static final String CHECK_MAX_COUPON_CAN_USE = "check.max.coupon.can.use";
		public static final String MY_REWARD_GET_RATE_PERCENT = "my.reward.get.rate.percent";
		
		
		public static final String PROJECT_NEW_LOANS = "rqb.project.new.loans";
		public static final String PROJECT_LOANS_LIST = "rqb.project.loans.list";
		public static final String PROJECT_LOANS_DETAIL = "rqb.project.loans.detail";
		public static final String PROJECT_HOME_INFO = "rqb.project.home.info";
		public static final String PROJECT_MY_INVEST_LIST = "rqb.project.my.invest.list";
		public static final String PROJECT_MY_INVEST_DETAIL = "rqb.project.my.invest.detail";
		public static final String PROJECT_RY_INVEST_LIST = "rqb.project.ry.invest.list";
		public static final String PROJECT_TRANSFER_LOANS = "rqb.project.transfer.loans";
		public static final String ACCOUNT_RECORD_INFO = "personal.center.invest.record.info";
		
		public static final String CHECK_UMP_STATUS_START_TIME = "rqb.check.liandong.whether.start";
		
		public static final String UMP_REAL_REGISTER = "rqb.ump.real.register";
		public static final String RQB_UMP_MONEY_RECHARGE = "rqb.ump.money.recharge";
		public static final String RQB_UMP_BIND_CARD = "rqb.ump.change.bind.card";
		public static final String RQB_UMP_CHANGE_CARD = "rqb.ump.change.card";
		public static final String RQB_UMP_MONEY_CASH = "rqb.ump.money.cash";
		public static final String RQB_UMP_INVEST = "rqb.ump.invest";
		public static final String RQB_UMP_TRANSFER_INVEST = "rqb.ump.transfer.invest";
		
		public static final String PERSONAL_CENTER_CEHCK_MESSAGE_HAS_READ = "personal.center.check.message.has.read";
		public static final String MESENGE_CENTER_DELETE_SINGLE_MESSAGE = "message.center.delete.single.message";
		public static final String GET_REFER_REWARD = "rqb.get.refer.reward";
		public static final String GET_REFER_OF_MY_FRIENTDS = "rqb.get.refer.of.my.friends";
		public static final String GET_MESSAGE_CENTER_INFO = "rqb.get.message.center.info";
		public static final String GET_CHANGE_RECORD_INFO = "rqb.get.change.record.info";
		public static final String GET_POINTS_DETAILS = "rqb.get.points.details";
		public static final String POINTS_EXCHANGE_COUPON = "rqb.points.exchange.coupon";
		public static final String RQB_GET_PROJECT_MORE_INFO = "rqb.get.project.more.info";
		public static final String RQB_GET_TRANSFER_PROJECT_MORE_INFO = "rqb.transfer.project.invest.more";
		public static final String RQB_GET_PROJECT_INVEST_RECORD = "rqb.get.project.invest.record";
		public static final String RQB_GET_TRANSFER_PROJECT_INVEST_RECORD = "rqb.get.transfer.project.invest.record";
		public static final String GET_PERSONAL_COUPON_INFO = "rqb.get.personal.coupon.info";
		public static final String GET_PERSONAL_TICKET_INFO = "rqb.get.personal.ticket.info";
		public static final String GET_PERSONAL_RED_ENVELOPE_INFO = "rqb.account.red.envelope.record";
		public static final String GET_RECENT_INVEST_LIST = "rqb.account.get.recent.invest.list";
		public static final String GET_EXCHANGE_COUPON_DETAILS = "rqb.get.exchange.coupon.details";
		public static final String COUPON_ACTIVE = "rqb.active.coupon";
		public static final String TICKET_ACTIVE = "rqb.active.ticket";
		public static final String MORERATE_ACTIVE = "rqb.account.active.morerate";
		public static final String RQB_UMP_PAY_PASSWORD_RESET = "rqb.ump.pay.password.reset";
		public static final String ACCOUNT_MARKET_GET_LIST = "account.market.get.list";
		public static final String ACCOUNT_MARKET_COUPON_EXCHANGE = "account.market.coupon.exchange";
		public static final String ACCOUNT_MARKET_GET_DETAILS = "account.market.get.details";
		public static final String ACCOUNT_MARKET_EXCHANGE_RECORD = "account.market.exchange.record";
		public static final String ACCOUNT_MARKET_UPDATE_USER_RECORD = "account.market.update.user.record";
		public static final String MESSAGE_CENTER_CHANGE_ALL_MESSAGE_STATUS = "message_center.change.all.message.status";
		public static final String RQB_PROJECT_GET_NOTICE_INFO = "rqb.project.get.notice.info";
		public static final String RQB_PROJECT_GET_NOTICE_DETAILS = "rqb.project.get.notice.details";
		public static final String RQB_ACCOUNT_RECHARGE_RECORD = "rqb.account.recharge.record";
		public static final String RQB_ACCOUNT_WITHDRAW_RECORD = "rqb.account.withdraw.record";
		public static final String RQB_ACCOUNT_CHANGE_MOBILE = "rqb.account.change.mobile";
		public static final String RQB_ACCOUNT_PROJECT_TRANSFER = "rqb.account.project.transfer";
		public static final String RQB_MY_BAND_CARD_INFO = "rqb.get.myband.card.info";
		public static final String RQB_ACCOUNT_GET_USER_REALNAME = "rqb.account.get.user.realname";
		public static final String RQB_CHANGE_CARD_INDENTIFY = "rqb.account.card.identify";
		public static final String RQB_AUTO_INVEST_CONSTANT_GET = "rqb.account.autoinvest.constant.get";
		public static final String RQB_AUTO_INVEST_SET_SAVE = "rqb.account.auto.invest.set.save";
		public static final String RQB_AUTO_INVEST_GET_LIST = "rqb.account.auto.invest.get.list";
		public static final String RQB_AUTO_INVEST_RULE_DELETE = "rqb.account.auto.invest.delete.rule";
		public static final String RQB_GET_CAN_TRANSFER_LIST = "rqb.account.get.can.transfer.list";
		public static final String RQB_ACCOUNT_GET_NEWS_LIST = "rqb.account.get.news.list";
		public static final String RQB_UMP_OPEN_PAYMENT = "rqb.ump.open.payment";
		public static final String RQB_UMP_CLOSE_PAYMENT = "rqb.account.secret.agreement.unbind";
		public static final String RQB_HOME_WAP_DATA = "rqb.wap.home.index";
		public static final String PROJECT_BINGGO_RATE = "rqb.get.binggo.project.rate";
		public static final String PROJECT_TRANSFER_BUY_RECORD = "rqb.project.transfer.buy.record";
		public static final String PROJECT_CHECK_CONTRIBUTION_PSW = "rqb.project.check.contributionpwd";
		public static final String NORMAL_GET_PEIZI_RATE = "rqb.normal.get.peizi.rate";
		public static final String NORMAL_GET_ORAL_INVEST_LIST = "rqb.normal.get.invest.list";
		public static final String NORMAL_SHOW_ACTIVE_LOGO = "normal.show.active";
		public static final String NORMAL_GET_REFERENCE_RANK_LIST = "rqb.normal.get.referencerank.list";
		public static final String NORMAL_GET_BANNER_LIST = "rqb.normal.get.app.banner.list";
		public static final String POINTS_POINTS_TASK_DETAILS = "points.points.task.details";
		public static final String POINTS_POINT_SHAKE_SIGN_INFO = "points.point.shake.sign.info";
		public static final String POINTS_SAVE_SIGN = "points.save.sign";
		public static final String RQB_ACCOUNT_REPAYMENT_CARD_LIST = "rqb.account.repayment.card.list";
		public static final String RQB_ACCOUNT_REPAYMENT_CARD_DETAILS_LIST = "rqb.account.repayment.card.details.list";
		
		// 瑞生活
		// 积分
		public static final String RLIFE_POINT_GETAVAILABLEPOINTS = "life.point.getAvailablePoints";
		public static final String RLIFE_POINT_GETVIPLEVEL = "life.point.getVipLevel";
		// 商品
		public static final String RLIFE_GOODS_RLIFEGOODSLIST = "life.goods.rLifeGoodsList";
		public static final String RLIFE_GOODS_RLIFEGOOD = "life.goods.rLifeGood";
		public static final String RLIFE_GOODS_GETGOODSBYTYPE = "life.goods.getGoodsByType";
		// 订单
		public static final String RLIFE_GOODS_GETPARTINCOUNT = "life.order.getPartInCount";
		public static final String RLIFE_GOODS_SIGNUP = "life.order.signUp";
		public static final String RLIFE_GOODS_ISATTENDEDACTIVE = "life.order.isAttendedActive";
		public static final String RLIFE_GOODS_EXCHANGE = "life.order.exchange";
		public static final String RLIFE_GOODS_UPDATERORDER = "life.order.updateROrder";
		public static final String RLIFE_GOODS_GETUSERRORDERLIST = "life.order.getUserROrderList";
		
		// 用户奖品
		public static final String USER_AWARD_LIST = "user.award.list";
		// 红包列表
		public static final String USER_AWARD_COUPON_LIST = "user.award.coupon.list";
		// 加息券列表
		public static final String USER_AWARD_MORERATE_LIST = "user.award.morerate.list";
		// 获取投资时用户的可用红包与加息券
		public static final String USER_CAN_USE_COUPON_MORERATE_LIST = "user.can.use.coupon.morerate.list";
		// 用户中心
		public static final String USER_CENTER = "user.center";
		// 回款计划明细
		public static final String USER_PAYMENT_PLAN_DETAIL = "user.payment.plan.detail";
		
		
		// 聚信立
		public static final String BACKEND_URL_JXL_COLLECT_REQ = "backend_url_jxl_collect_req";
		public static final String BACKEND_URL_JXL_DATASOURCE = "backend_url_jxl_datasource";
		public static final String BACKEND_URL_JXL_APPLY = "backend_url_jxl_apply";
		public static final String BACKEND_URL_JXL_CREDITCARD_APPLICATIONS = "backend_url_jxl_creditcard_applications";
		public static final String BACKEND_URL_JXL_CREDITCARD_MESSAGE_COLLECT_REQ = "backend_url_jxl_creditcard_message_collect_req";
		public static final String BACKEND_URL_JXL_CREDITCARD_MESSAGE_QRCODECOLLECT_RESP = "backend_url_jxl_creditcard_message_qrcodeCollect_resp";
	
		// 身份证认证
		public static final String BACKEND_URL_AUTHEN_UPLOADIMG = "backend_url_authen_uploadImg";
		// 用户认证信息
		public static final String BACKEND_URL_AUTHEN_USERAUTHENINFO = "backend_url_authen_userAuthenInfo";
		// 芝麻信用
		public static final String BACKEND_URL_ZMXY_ZMAUTHORIZATION = "backend_url_zmxy_ZMAuthorization";
		/**
		 * 借款申请接口
		 */
		public static final String BACKEND_URL_LOAN_APPLY = "backend_url_loan_apply";
	}
}
