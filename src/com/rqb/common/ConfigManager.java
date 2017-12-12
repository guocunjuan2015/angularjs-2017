package com.rqb.common;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Properties;

import org.apache.log4j.Logger;

public class ConfigManager {
	private static final Logger _log = Logger.getRootLogger();
	private static final String PATH = "rqb.properties";
	private static ConfigManager instance;
	
	private Properties config;
	
	private ConfigManager(){
		config();
	};
	
	public static ConfigManager getInstance(){
		if(instance == null){
			instance = new ConfigManager();
		}
		return instance;
	}
	
	/**
	 * 读取配置文件
	 */
	public void config(){
		config = new Properties();
		InputStream in = null;
		try {
			in = Constants.class.getClassLoader().getResourceAsStream(PATH);
			config.load(in);
		} catch (IOException e) {
			_log.error("Load config config error -> " + e);
			e.printStackTrace();
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					_log.error("close input stream error -> " + e);
					e.printStackTrace();
				}
			}
		}
	}
	
	/**
	 * 读取配置文件信息
	 * @param key 配置文件参数
	 * @return 配置文件值
	 */
	public String get(String key){
		return config.getProperty("rqbao.base.url") + config.getProperty(key);
	}
	
	/**
	 * 读取配置文件信息
	 * @param key 配置文件参数
	 * @return 配置文件值
	 */
	public String getApiPay(String key){
		return config.getProperty("rqbao.base.url") + key;
	}
    
	/**
	 * 读取配置文件信息
	 * @param key 配置文件参数
	 * @return 配置文件值
	 */
	public String getProperty(String key){
		return config.getProperty(key);
	}
	
	public String getRlife(String key) {
		return config.getProperty("rqbao.base.rlife.url") + config.getProperty(key);
	}
}
