package com.solar.tech.bean.entity;

public class SeatInfo {
	private String cangwei; // 舱位
	private String cangwei_data; // 舱位信息
	private String basicCabin; // 基础舱位类型(头等舱:F,公务舱:C,经济舱:Y)

	private String onewayPrice; // 单程票价
	private String roundtripPrice; // 往返票价

	public String getBasicCabin() {
		return basicCabin;
	}

	public void setBasicCabin(String basicCabin) {
		this.basicCabin = basicCabin;
	}

	public String getCangwei_data() {
		return cangwei_data;
	}

	public void setCangwei_data(String cangwei_data) {
		this.cangwei_data = cangwei_data;
	}

	public String getOnewayPrice() {
		return onewayPrice;
	}

	public void setOnewayPrice(String onewayPrice) {
		this.onewayPrice = onewayPrice;
	}

	public String getRoundtripPrice() {
		return roundtripPrice;
	}

	public void setRoundtripPrice(String roundtripPrice) {
		this.roundtripPrice = roundtripPrice;
	}

	public String getCangwei() {
		return cangwei;
	}

	public void setCangwei(String cangwei) {
		this.cangwei = cangwei;
	}

	@Override
	public String toString() {
		return "[cangwei=" + cangwei + ", cangwei_data="
				+ cangwei_data + ", basicCabin=" + basicCabin
				+ ", onewayPrice=" + onewayPrice + ", roundtripPrice="
				+ roundtripPrice+"]";
	}
}
