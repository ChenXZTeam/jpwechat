package com.solar.tech.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.bean.entity.userOrderInfo;
import com.solar.tech.dao.GenericDao;

/**
 * @title 执行订单数据的service方法
 * @author solarpc1
 *
 */
@Service
@Transactional
public class userOrderService {
	@Resource
	private GenericDao gDao;
	/**
	 * @Title addOrder(用户的订票订单)
	 * @param orderInfo
	 * @return
	 */
	public int addOrder(userOrderInfo orderInfo){
		try {
			gDao.save(orderInfo);
			return 1;
		} catch (Exception e) {
			return 0;
		}
	}
}
