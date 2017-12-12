<%@page import="com.ruiqt.common.utils.RegexpUtils"%>
<%@page import="com.ruiqt.common.web.RequestUtils"%>
<%@page import="com.ruiqt.modules.point.service.*"%>
<%@page import="org.springframework.web.util.HtmlUtils"%>
<%@page import="com.ruiqt.modules.account.entity.AccountRecords"%>
<%@page import="com.ruiqt.modules.account.service.AccountRecordsService"%>
<%@page import="com.ruiqt.modules.account.service.AccountService"%>
<%@page import="com.ruiqt.modules.account.entity.Account"%>
<%@page import="com.ruiqt.modules.account.utils.AccountUtils"%>
<%@page import="java.math.BigDecimal"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@page import="org.springframework.jdbc.core.JdbcTemplate"%>
<%@page import="javax.sql.DataSource"%>
<%@page import=" com.ruiqt.modules.sys.service.UserService"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="org.springframework.util.StringUtils"%>
<%@page import="com.ruiqt.modules.ump.entity.*"%>
<%@page import="java.util.*"%>
<%@page import="org.springframework.jdbc.core.*"%>
<%@page import="com.ruiqt.modules.ump.service.*"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.ruiqt.modules.ump.service.*"%>
<%@page import="com.ruiqt.modules.sys.entity.*"%>
<%@page import="com.ruiqt.common.utils.DateUtils"%>
<%@page import="com.umpay.api.paygate.v40.Mer2Plat_v40"%>
<%@page import="com.ruiqt.modules.ump.service.UMPRegisterService"%>
<%@page import="com.ruiqt.modules.ump.service.UMPRechargeService"%>
<%@page import="com.ruiqt.modules.ump.utils.UMPUtils"%>
<%@page import="com.umpay.api.common.ReqData"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%
  out.clear();
  String nianyue = RequestUtils.getString(request, "nianyue");
  String fanxian = RequestUtils.getString(request, "fanxian");
  String status1 = RequestUtils.getString(request, "status1");

  //转账方类型
  String particAccType = "01";
  //转账方向
  String transAction = "02";
  String remark = "transfer";
  String projectId = null;
  String paymentId = null;
  String sourceV = null;
%>

<div style="margin:auto;width:550px;">
<form action='addmoneyInvest' method='post' style="margin-top:60px;" name="dbform">
  <label style="font-weight:bold;margin-left:100px;">合伙人奖励查询及其返现</label>
     <br>
           <p> 年份-月份：<input type="text" name="nianyue"> <font style="color:red;font-size:12px;">*格式如 2016-01</font></p>
           <input type="hidden" name="fanxian" id="fanxian" value="">
          <p style="margin-left:8px;"> 是否返现:
     <select id="status1" name="status1">
     <option value="">请选择</option>
      <option value="0">未返</option>
      <option value="1">已返</option>
      </select>
      </p>
    <p style="margin-left:150px;">
    <input type="submit" id="search"  value="查询" />
    <input type="button" onclick="caozuo()" value="返现" />
    </p>
<script type="text/javascript">
function caozuo(){
  document.getElementById("fanxian").value="yes"; 
  document.getElementById("status1").value="0"; 
  dbform.submit(); 
}
</script>
</form>
</div>
<%
  if (request.getMethod().equals("POST")) {
    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(config.getServletContext());
    UserService userService = (UserService) ctx.getBean(UserService.class);
    DataSource dataSource = (DataSource) ctx.getBean("dataSource");
    JdbcTemplate jt = new JdbcTemplate(dataSource);
    UMPRegisterService registerService = (UMPRegisterService) ctx.getBean(UMPRegisterService.class);
    UMPRechargeService rechargeService = (UMPRechargeService) ctx.getBean(UMPRechargeService.class);
    UMPTransferService transferService = (UMPTransferService) ctx.getBean(UMPTransferService.class);
    AccountRecordsService accountRecordsService = (AccountRecordsService) ctx.getBean(AccountRecordsService.class);
    AccountService accountService = (AccountService) ctx.getBean(AccountService.class);
    ReferrerAwardService referrerAwardService = (ReferrerAwardService) ctx.getBean(ReferrerAwardService.class);
    UMPTransferServiceForTransaction transferServiceForTransaction = (UMPTransferServiceForTransaction) ctx
        .getBean(UMPTransferServiceForTransaction.class);
    Logger log = Logger.getLogger(this.getClass());
    if(!StringUtils.isEmpty(nianyue) || "yes".equals(fanxian)){
    out.println("<table border='1' style='border-collapse:collapse;'>");
    out.println("<tr><th>序号</th><th>id</th><th>用户名</th><th>奖励</th><th>月份</th><th>状态</th>"
                 +"</tr>");
    int i=1;
    String sql="SELECT ra.id, ra.referrer_name,ra.award_money,"
        +"ra.month_date ,ra.`status` FROM  referrer_award ra where ra.month_date=?"  
        +" and  ra.referrer_name not in('wy52221') and status=? ";
 //   if(!StringUtils.isEmpty(status1)){
  //        sql=sql+" and status='"+status1+"'";
  //      }else{
   //       sql=sql+" and status='0'";
   //     }
    List<Map<String,Object>>  awardList=jt.queryForList(sql, nianyue,status1);
        for(Map<String,Object>  map :awardList){
          String id=(String)map.get("id");
          String referrerName=(String)map.get("referrer_name");
          BigDecimal awardMoney=(BigDecimal)map.get("award_money");
          String monthDate=(String)map.get("month_date");
          String status=(String)map.get("status");
          String userId=jt.queryForObject("select id from sys_user where login_name=? or mobile=? and del_flag=0 ",
          String.class, referrerName,referrerName);
          if(StringUtils.endsWithIgnoreCase(fanxian, "yes")){
           if(StringUtils.endsWithIgnoreCase(status, "0")){
             UMPTransfer transfer = new UMPTransfer();
             UMPRegister register=null;
             try {
             register= registerService.getById(userId);
             }catch(Exception e){
               register=null;
             }
             if(StringUtils.isEmpty(register)){
               out.println(i+"  用户名>> "+referrerName+" 此用户联动未开户或未绑卡"+"<br>");
              }else{
               log.debug("通过此用户的register " + register + " " + "umpUserid:" + register.getUmpUserId() + "userId:"
                   + userId);
               transfer.setMerDate(DateUtils.getDate().replaceAll("-", ""));
               transfer.setRqtuserid(register.getUserId());
               transfer.setOrderId(UUID.randomUUID().toString().replaceAll("-", ""));
               transfer.setRequestDate(DateUtils.formatToday());
               transfer.setParticAccType(particAccType);
               transfer.setTransAction(transAction);
               transfer.setParticUserId(register.getUmpUserId());
               transfer.setAmount(awardMoney.toString());
               transfer.setRemark(nianyue+"合伙人奖励");
               //transfer.setStatus("1");
               transfer.setNotifyUrl("http://www.rqbao.com/ump/transferNotify");
               transferServiceForTransaction.saveUMPTransfer(transfer);
               Map<String, Object> mapRe = UMPUtils.setRequestParameters("transfer", null);
               mapRe.put("order_id", transfer.getOrderId());
               mapRe.put("mer_date", transfer.getMerDate());
               mapRe.put("partic_acc_type", transfer.getParticAccType());
               mapRe.put("trans_action", transfer.getTransAction());
               mapRe.put("partic_user_id", transfer.getParticUserId());
               mapRe.put("amount", UMPUtils.getCentValue(transfer.getAmount()));
               mapRe.put("notify_url", transfer.getNotifyUrl());
               String code = "";
               try {
                 ReqData reqData = Mer2Plat_v40.makeReqDataByGet(mapRe);
                 String sendUrl = reqData.getUrl();
                 log.debug("service发送的资金转账信息" + sendUrl);
                 Map receiveMap = UMPUtils.getParamFromUMP(sendUrl);
                 log.debug("非标的无密转账返回的直连结果" + receiveMap);
                 code = (String) receiveMap.get("ret_code");
                 if (StringUtils.endsWithIgnoreCase(code, "0000")) {
                   String orderId = (String) receiveMap.get("order_id");
                   String merDate = (String) receiveMap.get("mer_date");
                   String codes = (String) receiveMap.get("ret_code");
                   transfer.setCode(codes);
                   transfer.setResponseDate(DateUtils.formatToday());
                   transferServiceForTransaction.saveUMPTransfer(transfer);
                   
                   Account account = AccountUtils.getAccountByUserId(userId);
                   BigDecimal balance = account.getAccountBalance();
                   BigDecimal amo = new BigDecimal(awardMoney.toString());
                   BigDecimal accountBalance = account.getAccountBalance().add(amo);
                   account.setAccountBalance(accountBalance);
                   accountService.save(account);
                   String remarks = nianyue+"合伙人奖励";
                   AccountRecords investAccountRecords = new AccountRecords(userId, 8, awardMoney,
                       remarks);
                   investAccountRecords.setBalance(accountBalance);
                   accountRecordsService.save(investAccountRecords);//添加一条核算清分交易记录
                   referrerAwardService.update(id, "1");
                   out.println(referrerName + "---账户原=" + balance + ",新余额=" + accountBalance+"<br>");
                 }else{
                   out.println(i+"  "+referrerName +"转账失败"+"<br>");
                 }
               } catch (Exception e) {
                 log.error("联动用户编号" + transfer.getParticUserId() + "资金转账失败", e);
               }
             }
           }else{
             out.println(i+"  用户名>> "+referrerName+"已返现,请不要重复操作！！"+"<br>");
           }
          }else{
            out.println("<tr>");
            out.println("<td>");out.println(i);out.println("</td>");
            out.println("<td>");out.println(id);out.println("</td>"); 
            out.println("<td>");out.println(referrerName);out.println("</td>"); 
            out.println("<td>");out.println(awardMoney);out.println("</td>"); 
            out.println("<td>");out.println(monthDate);out.println("</td>"); 
            out.println("<td>");out.println((status.equalsIgnoreCase("0")?"未返":"已返"));out.println("</td>");
            out.println("</tr>");
           
            
          }
          i++;
        }
        out.println("</table>");
    }else{
      out.print("请输入合伙人奖励查询时间段！！！");
    }
  }

%>