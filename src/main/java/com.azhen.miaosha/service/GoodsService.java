package com.azhen.miaosha.service;

import com.azhen.miaosha.dao.GoodsDao;
import com.azhen.miaosha.domain.MiaoshaGoods;
import com.azhen.miaosha.vo.GoodsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class GoodsService {
	
	@Autowired
	GoodsDao goodsDao;
	
	public List<GoodsVo> listGoodsVo(){
		return goodsDao.listGoodsVo();
	}
	public GoodsVo getGoodsVoByGoodsId(long goodsId) {
		return goodsDao.getGoodsVoByGoodsId(goodsId);
	}

	public boolean reduceStock(GoodsVo goods) {
		MiaoshaGoods g = new MiaoshaGoods();
		g.setGoodsId(goods.getId());
		int ret = goodsDao.reduceStock(g);
		return ret > 0;
	}
}
