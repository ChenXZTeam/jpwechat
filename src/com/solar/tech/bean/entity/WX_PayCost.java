package com.solar.tech.bean.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.solar.tech.controller.ExcelAnnotation;

/**
 * 
 * @ClassName: WXOrder
 * @Description: 微信支付订单信息
 * @author: ChenXZ
 * @date: 2016年5月6日 上午10:59:08
 */
@Entity
@Table(name = "rd_payMessage")
public class WX_PayCost {
	// 订单id
		@Id
		@GeneratedValue(generator = "uuid")
		@GenericGenerator(name = "uuid", strategy = "uuid")
		@Column(name = "ID", length = 100)
		private String ID;
		public static final String OID = "ID";

		// 微信openid
		@Column(name = "openId", length = 100)
		private String openId;
		public static final String OPENID = "openId";

		// 预约号̬
		@ExcelAnnotation(exportName = "预约编号")
		@Column(name = "OrderNum", length = 50)
		private String OrderNum;
		public static final String ORDERNUM = "OrderNum";

		// 约定号̬
		// @ExcelAnnotation(exportName = "约定号")
		@Column(name = "AppointNum", length = 50)
		private String AppointNum;
		public static final String APPOINTNUM = "AppointNum";

		// 订单金额̬
		// @ExcelAnnotation(exportName = "订单金额")
		@Column(name = "OrderCost")
		private String OrderCost;

		// 创建时间
		// @ExcelAnnotation(exportName = "创建时间")
		@Column(name = "createTime")
		private Timestamp createTime;

		// 商家订单号̬
		@ExcelAnnotation(exportName = "商家订单号")
		@Column(name = "TradeNum", length = 50)
		private String TradeNum;
		public static final String TRADENUM = "TradeNum";

		//order表订单UUID̬
		@ExcelAnnotation(exportName = "yh_order表订单UUID̬")
		@Column(name = "YhUUID", length = 50)
		private String YhUUID;
		public static final String YHUUID = "YhUUID";

		//微信订单的id
		@ExcelAnnotation(exportName = "微信订单的id")
		@Column(name = "Transaction_id", length = 100)
		private String transaction_id;

		//用户的身份证号码
		@Column(name = "personIDnum" , length = 20)
		private String personIDnum;
		
		//中航信的PNR
		@Column(name = "PNR" , length = 20)
		private String pnrNum;
		
		//用户的手机号码
		@Column(name = "phoneNumB" , length = 20)
		private String phoneNumB;
		
		// 支付类型： 1:支付，0：未支付̬
		@Column(name = "Status")
		private int Status;

		public String getYhUUID() {
			return YhUUID;
		}

		public void setYhUUID(String yhUUID) {
			YhUUID = yhUUID;
		}
		
		public int getStatus() {
			return Status;
		}

		public void setStatus(int status) {
			Status = status;
		}

		public String getID() {
			return ID;
		}

		public void setID(String iD) {
			ID = iD;
		}

		public String getPhoneNumB() {
			return phoneNumB;
		}

		public void setPhoneNumB(String phoneNumB) {
			this.phoneNumB = phoneNumB;
		}

		public String getPnrNum() {
			return pnrNum;
		}

		public void setPnrNum(String pnrNum) {
			this.pnrNum = pnrNum;
		}

		public String getPersonIDnum() {
			return personIDnum;
		}

		public void setPersonIDnum(String personIDnum) {
			this.personIDnum = personIDnum;
		}

		public String getOpenId() {
			return openId;
		}

		public void setOpenId(String openId) {
			this.openId = openId;
		}

		public String getOrderNum() {
			return OrderNum;
		}

		public void setOrderNum(String orderNum) {
			OrderNum = orderNum;
		}

		public String getAppointNum() {
			return AppointNum;
		}

		public void setAppointNum(String appointNum) {
			AppointNum = appointNum;
		}

		public Timestamp getCreateTime() {
			return createTime;
		}

		public void setCreateTime(Timestamp createTime) {
			this.createTime = createTime;
		}

		public String getTradeNum() {
			return TradeNum;
		}

		public void setTradeNum(String tradeNum) {
			TradeNum = tradeNum;
		}
		

		public String getTransaction_id() {
			return transaction_id;
		}

		public void setTransaction_id(String transaction_id) {
			this.transaction_id = transaction_id;
		}

		public String getOrderCost() {
			return OrderCost;
		}

		public void setOrderCost(String orderCost) {
			OrderCost = orderCost;
		}

		public static String getOid() {
			return OID;
		}

		public static String getOpenid() {
			return OPENID;
		}

		public static String getOrdernum() {
			return ORDERNUM;
		}

		public static String getAppointnum() {
			return APPOINTNUM;
		}

		public static String getTradenum() {
			return TRADENUM;
		}
}
