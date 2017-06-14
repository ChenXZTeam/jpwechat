package com.solar.tech.bean;

/**
 * 只是用于提示用户订票失败或者成功的功能，运用于预定中转和往返航班的时候
 */
public class MessgesAlert {
	private String depCity;
	private String orgCity;
	private String isOk;
	private String commit;
	private String pntr;
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
	public String getCommit() {
		return commit;
	}
	public void setCommit(String commit) {
		this.commit = commit;
	}
	public String getPntr() {
		return pntr;
	}
	public void setPntr(String pntr) {
		this.pntr = pntr;
	}
	
}
