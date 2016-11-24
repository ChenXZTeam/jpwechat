package com.solar.tech.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.InvitationCode;
import com.solar.tech.bean.entity.WX_PayCost;
import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.dao.GenericDao;
/**
 * @title 执行微信支付的service类
 * @author solarpc1
 *
 */
@Service
@Transactional
public class WXpayorderSer {
	@Resource
	private GenericDao gDao;
	
	/**
	 * @title (创建支付订单的数据)
	 * @param wxpay
	 * @return
	 */
	public int creamOrder(WX_PayCost wxpay){
		try {
			gDao.save(wxpay);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
	/**
	 * @title (根据orderNum查找订单)
	 * @param OrderNum
	 * @return
	 */
	public userOrderInfo findByOrderNum(String OrderNum) {
		List<Object> params = new ArrayList<Object>();
		params.add(OrderNum);
		String sql = "from userOrderInfo o where o.orderNum=?";
		List<userOrderInfo> list = gDao.getListByHql(userOrderInfo.class, sql, params);
		if (list.size() > 0) {
			return list.get(0);
		}
		return null;
	}
	
	/**
	 * 查找活动
	 * @param id
	 * @return
	 */
	public List<InvitationCode> findactivByid(String id) {
		String hql = "FROM InvitationCode WHERE ID = '" + id+"'";
		List<InvitationCode> cList = this.gDao.find(hql);
		return cList;
	}
}
