package com.azhen.miaosha.controller;

import com.azhen.miaosha.domain.MiaoshaUser;
import com.azhen.miaosha.redis.RedisService;
import com.azhen.miaosha.service.GoodsService;
import com.azhen.miaosha.service.MiaoshaUserService;
import com.azhen.miaosha.vo.GoodsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/goods")
public class GoodsController {

	@Autowired
	MiaoshaUserService userService;
	
	@Autowired
	RedisService redisService;

	@Autowired
	GoodsService goodsService;

    @RequestMapping(value="/to_list")
    public String toLogin(Model model, MiaoshaUser user) {
    	model.addAttribute("user", user);
    	List<GoodsVo> goodsList = goodsService.listGoodsVo();
		model.addAttribute("goodsList", goodsList);
    	return "goods_list";
	}

	@RequestMapping("/detail/{goodsId}")
	public String detail(Model model, MiaoshaUser user, @PathVariable("goodsId") long goodsId) {
		model.addAttribute("user", user);
		GoodsVo goods = goodsService.getGoodsVoByGoodsId(goodsId);
		model.addAttribute("goods", goods);

		long startAt = goods.getStartDate().getTime();
		long endAt = goods.getEndDate().getTime();
		long now = System.currentTimeMillis();

		int miaoshaStatus = 0;
		int remainSeconds = 0;
		if(now < startAt ) {//秒杀还没开始，倒计时
			miaoshaStatus = 0;
			remainSeconds = (int)((startAt - now )/1000);
		}else  if(now > endAt){//秒杀已经结束
			miaoshaStatus = 2;
			remainSeconds = -1;
		}else {//秒杀进行中
			miaoshaStatus = 1;
			remainSeconds = 0;
		}
		model.addAttribute("miaoshaStatus", miaoshaStatus);
		model.addAttribute("remainSeconds", remainSeconds);

		return "goods_detail";
	}
}