package com.azhen.miaosha.service;

import com.alibaba.druid.util.StringUtils;
import com.azhen.miaosha.dao.MiaoshaUserDao;
import com.azhen.miaosha.domain.MiaoshaUser;
import com.azhen.miaosha.exception.GlobalException;
import com.azhen.miaosha.redis.MiaoshaUserKey;
import com.azhen.miaosha.redis.RedisService;
import com.azhen.miaosha.result.CodeMsg;
import com.azhen.miaosha.util.MD5Util;
import com.azhen.miaosha.util.UUIDUtil;
import com.azhen.miaosha.vo.LoginVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

@Service
public class MiaoshaUserService {
    public static final String COOKI_NAME_TOKEN = "token";

    @Autowired
    MiaoshaUserDao miaoshaUserDao;

    @Autowired
    RedisService redisService;

    public MiaoshaUser getById(long id) {
        return miaoshaUserDao.getById(id);
    }

    public Boolean login(HttpServletResponse response, LoginVo loginVo) {
        if (loginVo == null) {
            throw new GlobalException(CodeMsg.SERVER_ERROR);
        }
        String mobile = loginVo.getMobile();
        String formPass = loginVo.getPassword();

        // 判断手机号是否存在
        MiaoshaUser user = getById(Long.parseLong(mobile));
        if (user == null) {
            throw new GlobalException(CodeMsg.MOBILE_NOT_EXISTS);
        }

        // 验证密码
        String dbPass = user.getPassword();
        String saltDB = user.getSalt();
        String calcPass = MD5Util.formPassToDBPass(formPass, saltDB);
        if (!calcPass.equals(dbPass)) {
            throw new GlobalException(CodeMsg.PASSWORD_ERROR);
        }
        //生成cookie
        addCookie(response, user);
        return true;
    }

    private void addCookie(HttpServletResponse response, MiaoshaUser user) {
        String token = UUIDUtil.uuid();
        redisService.set(MiaoshaUserKey.token, token, user);
        Cookie cookie = new Cookie(COOKI_NAME_TOKEN, token);
        cookie.setMaxAge(MiaoshaUserKey.token.expireSeconds());
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    public MiaoshaUser getByToken(HttpServletResponse response, String token) {
        if(StringUtils.isEmpty(token)) {
            return null;
        }
        MiaoshaUser user = redisService.get(MiaoshaUserKey.token, token, MiaoshaUser.class);
        //延长有效期
        if(user != null) {
            addCookie(response, user);
        }
        return user;
    }
}
