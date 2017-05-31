package com.solar.tech.bean;

/**
 * 只是用于提示用户订票失败或者成功的功能，运用于预定中转和往返航班的时候
 */
public class MessgesAlert {
	private String depCity;
	private String orgCity;
	private String isOk;
	public String getDepCity() {
		return depCity;
	}
	public void setDepCity(String depCity) {
		this.depCity = depCity;
	}
	public String getOrgCity() {
		return orgCity;
	}
	public void setOrgCity(String orgCity) {
		this.orgCity = orgCity;
	}
	public String getIsOk() {
		return isOk;
	}
	public void setIsOk(String isOk) {
		this.isOk = isOk;
	}
	
	
}
