package com.rqb.test;

import com.rqb.service.AccountService;

public class Test {
	public static void main(String[] args) {
//		ConfigManager config = ConfigManager.getInstance();
//		String url = config.get(Pks.ACCOUNT_INFO_RECORD);
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("u", "guyifan");
//		map.put("p", "guyifan");
//		String a = SendRequest.post(url, map);
//		System.out.println(a);
		AccountService a = new AccountService();
		System.out.println(a.getRecord("ruben95001"));
	}
}
