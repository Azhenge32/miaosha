package com.azhen.miaosha.controller;

import com.azhen.miaosha.domain.MiaoshaUser;
import com.azhen.miaosha.redis.RedisService;
import com.azhen.miaosha.service.MiaoshaUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/goods")
public class GoodsController {

	@Autowired
	MiaoshaUserService userService;
	
	@Autowired
	RedisService redisService;

    @RequestMapping(value="/to_list")
    public String toLogin(Model model, MiaoshaUser user) {
    	model.addAttribute("user", user);
    	return "goods_list";
	}
}
