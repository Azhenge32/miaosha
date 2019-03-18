package com.azhen.miaosha.controller;

import com.azhen.miaosha.domain.MiaoshaUser;
import com.azhen.miaosha.domain.User;
import com.azhen.miaosha.redis.RedisService;
import com.azhen.miaosha.result.Result;
import com.azhen.miaosha.service.MiaoshaUserService;
import com.azhen.miaosha.vo.LoginVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/login")
public class LoginController {

	private static Logger log = LoggerFactory.getLogger(LoginController.class);
	
	@Autowired
    MiaoshaUserService userService;
	
	@Autowired
    RedisService redisService;
	
    @RequestMapping("/to_login")
    public String toLogin() {
        return "login";
    }
    
    @RequestMapping("/do_login")
    @ResponseBody
    public Result<Boolean> doLogin(HttpServletResponse response, @Valid LoginVo loginVo) {
    	//登录
    	userService.login(response, loginVo);
    	return Result.success();
    }

    @RequestMapping("/genAllToken")
    @ResponseBody
    public String genAllToken() {
        List<MiaoshaUser> userList = userService.getAll();
        StringBuilder builder = new StringBuilder();
        for (MiaoshaUser user : userList) {
            String mobile = String.valueOf(user.getId());
            String password = "d3b1294a61a07da9b49b6e22b2cbd7f9";
            LoginVo loginVo = new LoginVo();
            loginVo.setMobile(mobile);
            loginVo.setPassword(password);
            String token = userService.genToken(loginVo);
            builder.append(token).append("<br>");
        }
        return builder.toString();
    }
}
