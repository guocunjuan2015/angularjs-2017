package com.rqb.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.rqb.common.Constants.Msg;
import com.rqb.controller.abs.AbstractController;
import com.rqb.service.ProjectService;
import com.ruiqt.lianlian.utils.LLPayUtil;
import com.ultrapower.cloudup.utils.EmptyUtils;
import com.ultrapower.cloudup.utils.StringUtils;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/project")
public class ProjectController extends AbstractController {
	@Autowired
	ProjectService projectService;

	@RequestMapping(value = "/get.do", method = { RequestMethod.GET,
			RequestMethod.POST })
	public void get(HttpServletRequest request, HttpServletResponse response) {
		Integer type = StringUtils.parseInteger(request.getParameter("type"));
		String info = "";
		switch (type) {
		case 1:
			info = projectService.getProject();
			break;
		case 2:
			info = projectService.getProject(ProjectService.FUND);
			break;
		case 3:
			info = projectService.getProject(ProjectService.ASSURE);
			break;
		case 4:
			info = projectService.getProject(ProjectService.TRANSFER);
			break;
		case 5:
			info = projectService.getProject(ProjectService.BAOLI);
			break;
		case 6:
			info = projectService.getProject(ProjectService.JIAOYU);
			break;
		case 7:
			info = projectService.getProject(ProjectService.GEDAI);
			break;
		default:
			info = projectService.getProject();
		}
		sendResponse(projectService, info, response);
	}

	@RequestMapping(value = "/newget.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void newGet(HttpServletRequest request, HttpServletResponse response) {
        String type = request.getParameter("type");
        String childType = request.getParameter("childType");
        String status = request.getParameter("status");
        String order = request.getParameter("order");
        String orderType = request.getParameter("orderType");
        String index = request.getParameter("index");
        String size = request.getParameter("size");
        String from = request.getParameter("from");
        String info = "";
            info = projectService.getNewProject(type,childType,status,order,orderType,
                    index,size,from);
        sendResponse(projectService, info, response);
    }
	
	@RequestMapping(value = "/find.do", method = { RequestMethod.GET,
			RequestMethod.POST })
	public void find(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String info = projectService.find(id);
		sendResponse(projectService, info, response);
	}
	@RequestMapping(value = "/transfer/find.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void transferFind(HttpServletRequest request, HttpServletResponse response) {
        String id = request.getParameter("id");
        String info = projectService.transferFind(id);
        sendResponse(projectService, info, response);
    }

	@RequestMapping(value = "/detail.do", method = { RequestMethod.GET,
			RequestMethod.POST })
	public void detail(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String info = projectService.detail(id);
		sendResponse(projectService, info, response);
	}

	// 获取代金券优惠券
	@RequestMapping(value = "/choose_cop.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void getCouponDJ(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("projectIdToCop");//项目id
		Object userObj = request.getSession().getAttribute("loginUser");
		String user = "";
		user = userObj.toString();
		String info = "";
		info = projectService.getCoupon(user, id);//获得代金券
		sendResponse(projectService, info, response);
	}
	
	@RequestMapping(value = "/project/info.do", method = { RequestMethod.GET,
			RequestMethod.POST })
	public void getProjectInfo(HttpServletRequest request, HttpSession session,
			HttpServletResponse response) {
		String account = (String) session.getAttribute("loginUser");
		String id = request.getParameter("id");
		if (EmptyUtils.isEmpty(account)) {
			sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
		} else {
			String info = projectService.getProjectInfo(account,id);
			sendResponse(projectService, info, response);
		}
	}

	@RequestMapping(value = "/invest.do", method = { RequestMethod.GET,
			RequestMethod.POST })
	public void invest(HttpServletRequest request, HttpSession session,
			HttpServletResponse response) {
		String account = (String) session.getAttribute("loginUser");
		String loginPassword = (String) session.getAttribute("loginPassword");
		String id = request.getParameter("id");
		String code = request.getParameter("code");
		String money = request.getParameter("money");
		String password = request.getParameter("password");
		String tel = request.getParameter("tel");
		String f = request.getParameter("f");
		String couponId = request.getParameter("couponId");
		String ticketId = request.getParameter("ticketId");
		if (EmptyUtils.isEmpty(account)) {
			sendResponse(false, Msg.FAILURE, LOGIN_PAGE, response);
		} else {
			String info = projectService.invest(id, account, money, loginPassword,
					password,code,couponId,ticketId,tel,f);
			sendResponse(projectService, info, response);
		}
	}
	
	@RequestMapping(value = "/more/details/get.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void getProjectMoreDetails(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
	        String id = request.getParameter("id");
            String info = projectService.getProjectMoreDetails(id);
            sendResponse(projectService, info, response);
    }
	//债权转让项目更多
	@RequestMapping(value = "/more/transfer/details/get.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void getTransferProjectMoreDetails(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
            String projectId = request.getParameter("id");
            String info = projectService.getTransferProjectMoreDetails(projectId);
            sendResponse(projectService, info, response);
    }
	
    @RequestMapping(value = "/invest/record.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void getProjectInvestRecord(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
            String id = request.getParameter("id");
            String info = projectService.getProjectInvestRecord(id);
            sendResponse(projectService, info, response);
    }
    //债权转让购买记录
    @RequestMapping(value = "/transfer/invest/record.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void getTransferProjectInvestRecord(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
            String id = request.getParameter("id");
            String info = projectService.getTransferProjectInvestRecord(id);
            sendResponse(projectService, info, response);
    }
    //获取公告消息
    @RequestMapping(value = "/notice/get.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void getNoticeInfo(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
            String n = request.getParameter("n");
            String c = request.getParameter("c");
            String info = projectService.getNoticeInfo(n,c);
            sendResponse(projectService, info, response);
    }
  //获取公告详情消息
    @RequestMapping(value = "/notice/details/get.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void getNoticeDetails(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
            String k = request.getParameter("k");
            String info = projectService.getNoticeDetails(k);
            sendResponse(projectService, info, response);
    }
    
    //获取wap首页收益信息
    @RequestMapping(value = "/wap/data/get.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void getWapData(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
            String info = projectService.getWapData();
            sendResponse(projectService, info, response);
    }
    
  //获取理财债权转让列表
    @RequestMapping(value = "/transferget.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void getTransferList(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String type = request.getParameter("type");
        String childType = request.getParameter("childType");
        String status = request.getParameter("status");
        String order = request.getParameter("order");
        String orderType = request.getParameter("orderType");
        String index = request.getParameter("index");
        String size = request.getParameter("size");
        String info = "";
            info = projectService.getTransferList(type,childType,status,order,orderType,
                    index,size);
        sendResponse(projectService, info, response);
    }
  //获取并购项目投资利率
    @RequestMapping(value = "/binggo/rate/get.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void getBingGoRate(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String projectId = request.getParameter("projectId");
        String amount = request.getParameter("amount");
        String info = "";
            info = projectService.getBingGoRate(projectId,amount);
        sendResponse(projectService, info, response);
    }
  //获取债权转让认购记录
    @RequestMapping(value = "/transfer/buy/record.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void getTransferBuyRecord(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String projectId = request.getParameter("projectId");
        String pageSize = request.getParameter("pageSize");
        String pageNo = request.getParameter("pageNo");
        String info = "";
            info = projectService.getTransferBuyRecord(projectId,pageSize,pageNo);
        sendResponse(projectService, info, response);
    }
  //验证约标密码
    @RequestMapping(value = "/contribution/check.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void checkContributionPsw(HttpServletRequest request, HttpSession session,
            HttpServletResponse response) {
        String projectId = request.getParameter("projectId");
        String password = request.getParameter("password");
        String info = "";
            info = projectService.checkContributionPsw(projectId,password);
        sendResponse(projectService, info, response);
    }
    
    /**
	 * 获取产品列表
	 * @author wangya
	 * @since 2017-01-03
	 * @param request
	 * @return
	 */
    @RequestMapping(value = "/getLoanList.do", method = { RequestMethod.GET,
            RequestMethod.POST })
    public void getLoanList(HttpServletRequest request, HttpServletResponse response) {
        String projectType = request.getParameter("projectType");
        String pageSize = request.getParameter("pageSize");
        String currentPage = request.getParameter("currentPage");
        String userId = request.getParameter("userId");
        String from = request.getParameter("from");
        String info = "";
        info = projectService.getNewProject(projectType,pageSize,currentPage,from, userId);
        sendResponse(projectService, info, response);
    }
    
    /**
	 * 获取项目祥情
	 * @author wangya
	 * @since 2017-01-04
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getLoanDetail.do", method = { RequestMethod.GET,
            RequestMethod.POST })
	public void getLoanDetail (HttpServletRequest request,
			HttpServletResponse response) {
		String projectId = request.getParameter("projectId");
        String projectType = request.getParameter("projectType");
        String userId = request.getParameter("userId");
        if (userId == null || "".equals(userId.trim())) {
        	userId = (String) request.getSession().getAttribute("userId");
        }
        System.out.println("projectId - " + projectId + " - projectType - " + projectType + " - " + userId);
        String info = "";
        info = projectService.getLoanDetail(projectId, projectType, userId);
        sendResponse(projectService, info, response);
	}
	
	/**
	 * 首页数据接口
	 * @author wangya
	 * @since 2017-01-04
	 * @return
	 */
	@RequestMapping(value = "/getHomeInfo.do", method = { RequestMethod.GET,
            RequestMethod.POST })
	public void getHomeInfo(HttpServletRequest request,
			HttpServletResponse response) {
		String userId = request.getParameter("userId");
		String info = "";
        info = projectService.getHomeInfo(userId);
        sendResponse(projectService, info, response);
	}
	
	/**
	 * 我的投资 - 投资列表和转让列表
	 * @author wangya
	 * @since 2017-01-09
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "getMyInvestList.do", method = { RequestMethod.GET,
            RequestMethod.POST })
	public void getMyInvestList(HttpServletRequest request, HttpServletResponse response) {
		String userId = request.getParameter("userId");
		/**
		 * 1-投标中，2-回款中，3-已结清，4-可转让，5-转让中，6-已转让
		 */
		String loanType = request.getParameter("loanType");
		String currentPage = request.getParameter("currentPage");
		String pageSize = request.getParameter("pageSize");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("loanType", loanType);
		params.put("currentPage", currentPage);
		params.put("pageSize", pageSize);
		params.put("userId", userId);
		String info = "";
		try {
			info = projectService.getMyInvestList(params);
			sendResponse(projectService, info, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 我的投资祥情
	 * @author wangya
	 * @since 2017-01-09
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "getMyInvestDetail.do", method = { RequestMethod.GET,
            RequestMethod.POST })
	public void getMyInvestDetail(HttpServletRequest request, HttpServletResponse response) {
		String userId = request.getParameter("userId");
		String projectId = request.getParameter("projectId");
		/**
		 * 1：为普通标，2：为债转标
		 */
		String projectType = request.getParameter("projectType");
		/**
		 * 1-投标中，2-回款中，3-已结清，4-可转让，5-转让中，6-已转让
		 */
		String loanType = request.getParameter("loanType");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("loanType", loanType);
		params.put("projectType", projectType);
		params.put("projectId", projectId);
		params.put("userId", userId);
		String info = "";
		try {
			info = projectService.getMyInvestDetail(params);
			sendResponse(projectService, info, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 产品详情页投资记录
	 * @author wangya
	 * @since 2017-01-10
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "getRyInvestList.do", method = { RequestMethod.GET,
            RequestMethod.POST })
	public void getRyInvestList(HttpServletRequest request, HttpServletResponse response) {
		String projectId = request.getParameter("projectId");
		/**
		 * 1：为普通标，2：为债转标
		 */
		String projectType = request.getParameter("projectType");
		String pageSize = request.getParameter("pageSize");
		String currentPage = request.getParameter("currentPage");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("projectType", projectType);
		params.put("projectId", projectId);
		params.put("currentPage", currentPage);
		params.put("pageSize", pageSize);
		String info = "";
		try {
			info = projectService.getRyInvestList(params);
			sendResponse(projectService, info, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 借款申请接口
	 * @author wangya
	 * @since 2017-02-22
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/credit/apply.do", method = {RequestMethod.POST }, produces = "application/json;charset=UTF-8")
	public void apply(HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = LLPayUtil.getJSONObject(request);
		_log.info("jsonObject - " + jsonObject);
		Object userId = request.getSession().getAttribute("userId");
		String info = "";
		try {
			if (null != userId && !"".equals(userId.toString())) {
				jsonObject.put("userId", userId.toString());
				info = projectService.apply(jsonObject);
				sendResponse(projectService, info, response);
			} else {
				String result = getResult(0,"温馨提示-您还未登录,请先登录");
				sendResponse(projectService, result, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			String result = getResult(0,"温馨提示-服务器错误,请稍候重试");
			sendResponse(projectService, result, response);
		}
	}
	
	public String getResult(int result, String message){
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("errInfo", message); 
		param.put("result", result); 
		String res = JSONObject.fromObject(param).toString();
		return res;
	}
}
