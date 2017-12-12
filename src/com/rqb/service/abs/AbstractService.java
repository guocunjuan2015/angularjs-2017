package com.rqb.service.abs;

import com.rqb.common.ConfigManager;
import com.ultrapower.cloudup.common.abs.Component;

public class AbstractService extends Component{
	protected ConfigManager config;
	public AbstractService(){
		config = ConfigManager.getInstance();
	}
}
