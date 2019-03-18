package com.azhen.miaosha.controller;

import com.azhen.miaosha.domain.MiaoshaOrder;
import com.azhen.miaosha.domain.MiaoshaUser;
import com.azhen.miaosha.domain.OrderInfo;
import com.azhen.miaosha.redis.RedisService;
import com.azhen.miaosha.result.CodeMsg;
import com.azhen.miaosha.result.Result;
import com.azhen.miaosha.service.GoodsService;
import com.azhen.miaosha.service.MiaoshaService;
import com.azhen.miaosha.service.MiaoshaUserService;
import com.azhen.miaosha.service.OrderService;
import com.azhen.miaosha.vo.GoodsVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/miaosha")
public class MiaoshaController {
    @Autowired
    MiaoshaUserService userService;

    @Autowired
    RedisService redisService;

    @Autowired
    GoodsService goodsService;

    @Autowired
    OrderService orderService;

    @Autowired
    MiaoshaService miaoshaService;

    @RequestMapping(value = "/do_miaosha", method = RequestMethod.POST)
    @ResponseBody
    public Result<OrderInfo> list(Model model, MiaoshaUser user,
                                  @RequestParam("goodsId") long goodsId) {
        model.addAttribute("user", user);
        if (user == null) {
            return Result.error(CodeMsg.SESSION_ERROR);
        }
        // 判断库存
        GoodsVo goods = goodsService.getGoodsVoByGoodsId(goodsId);
        int stock = goods.getGoodsStock();
        if (stock <= 0) {
            return Result.error(CodeMsg.MIAO_SHA_OVER);
        }
        // 判断是否已经秒杀到了
        MiaoshaOrder order = orderService.getMiaoshaOrderByUserIdGoodsId(user.getId(), goodsId);
        if (order != null) {
            return Result.error(CodeMsg.REPEATE_MIAOSHA);
        }

        // 减库存 下订单 写入秒杀订单
        OrderInfo orderInfo = miaoshaService.miaosha(user, goods);
        return Result.success(orderInfo);
    }
}
