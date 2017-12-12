<%@page import="com.ruiqt.common.utils.StringUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ruiqt.common.persistence.GeneralJdbcDao"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page session="false" %>
<%
	if(request.getMethod().equals("POST")){
		try{
			  ApplicationContext ctx = WebApplicationContextUtils
	                .getWebApplicationContext(config.getServletContext());
				GeneralJdbcDao dao = ctx.getBean(GeneralJdbcDao.class);
				String opr = request.getParameter("opr");
				if("validate".equals(opr)){
					String mobile = request.getParameter("mobile");
					int rows = dao.queryForInt("select count(*) from meeting where mobile = ?", mobile);
					if(rows > 0){
						response.getWriter().write("{\"status\":" + 0 + "}");
					}
				}else if("add".equals(opr)){
					String name = request.getParameter("name");
					String mobile = request.getParameter("mobile");
					String address = request.getParameter("address");
					if(address == null){
						address = "";
					}
					String userName = request.getParameter("userName");
					if(userName == null){
						userName = "";
					}
					String remarks = request.getParameter("remarks");
					if(remarks == null){
						remarks = "";
					}
					int result = dao.update("insert into meeting(name,mobile,address,user_name,remarks) values(?,?,?,?,?)",
							new Object[]{name,mobile,address,userName,remarks});
					if(result > 0){
						response.getWriter().write("{\"status\":" + 0 + "}");
						//out.print("<script>alert('提交成功！由于名额有限，平台将最终选取10名线上报名的用户参会。成功报名的用户，客服将在5月1日-5月3日联系您，请保持您的手机畅通。');location.href='face.jsp'</script>");
					}else{
						response.getWriter().write("{\"status\":" + 1 + "}");
						//out.print("<script>alert('提交失败');location.href='face.jsp'</script>");
					}
				//request.getRequestDispatcher("face.jsp").forward(request, response);
				}else if("thumbUp".equals(opr)){
				  String ip = StringUtils.getRemoteAddr(request);
					int areaId = Integer.valueOf(request.getParameter("areaId"));
					int rows = dao.queryForInt("select count(*) from meeting_thumb_up where address = ?", ip);
					if(rows > 0){
						response.getWriter().write("{\"status\":\"您已经点过赞了！\"}");
					}else{
						int result = dao.update("insert into meeting_thumb_up(address,area_id) values(?,?)",
								new Object[]{ip,areaId});
						int count = dao.queryForInt("select count(*) from meeting_thumb_up where area_id = ?", areaId);
						if(result > 0){
							response.getWriter().write("{\"status\":\"点赞成功！\",\"count\":"+count+"}");
						}else{
							response.getWriter().write("{\"status\":\"点赞失败！\",\"count\":"+count+"}");
						}
					}
				}
		}catch(Exception e){
		}
	}
%> 
