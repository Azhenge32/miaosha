package com.azhen.miaosha.controller;

import com.azhen.miaosha.domain.MiaoshaOrder;
import com.azhen.miaosha.domain.MiaoshaUser;
import com.azhen.miaosha.rabbitmq.MQSender;
import com.azhen.miaosha.rabbitmq.MiaoshaMessage;
import com.azhen.miaosha.redis.GoodsKey;
import com.azhen.miaosha.redis.RedisService;
import com.azhen.miaosha.result.CodeMsg;
import com.azhen.miaosha.result.Result;
import com.azhen.miaosha.service.GoodsService;
import com.azhen.miaosha.service.MiaoshaService;
import com.azhen.miaosha.service.MiaoshaUserService;
import com.azhen.miaosha.service.OrderService;
import com.azhen.miaosha.vo.GoodsVo;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Controller
@RequestMapping("/miaosha")
public class MiaoshaController implements InitializingBean {

    /**
     * 系统初始化时，把数据库加载到缓存n
     * @throws Exception
     */
    @Override
    public void afterPropertiesSet() throws Exception {
        List<GoodsVo> goodsList = goodsService.listGoodsVo();
        if (goodsList == null) {
            return ;
        }
        localOverMap = new ConcurrentHashMap<Long, Boolean>(goodsList.size());
        for (GoodsVo goods : goodsList) {
            redisService.set(GoodsKey.getMiaoshaGoodsStock, "" + goods.getId(), goods.getStockCount());
            localOverMap.put(goods.getId(), false);
        }
    }

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

    @Autowired
    MQSender mqSender;

    private Map<Long, Boolean> localOverMap;

    /**
     * QPS:1306
     * 5000 * 10
     * QPS:2114
     *
     * @param user
     * @param goodsId
     * @return
     */
    @RequestMapping(value = "/{path}/do_miaosha", method = RequestMethod.POST)
    @ResponseBody
    public Result<Integer> list(MiaoshaUser user,
                                @RequestParam("goodsId") long goodsId,
                                @PathVariable("path") String path) {
        if (user == null) {
            return Result.error(CodeMsg.SESSION_ERROR);
        }
        // 验证path
        boolean valid=miaoshaService.checkPath(user,goodsId, path);
        if (!valid){
            return Result.error(CodeMsg.REQUEST_ILLEGAL);
        }
        // 内存标记
        Boolean isOver = localOverMap.get(goodsId);
        if (isOver) {
            return Result.error(CodeMsg.MIAO_SHA_OVER);
        }
        // 预减库存
        long stock = redisService.decr(GoodsKey.getMiaoshaGoodsStock, "" + "" + goodsId);
        if (stock < 0) {
            localOverMap.put(goodsId, true);
            return Result.error(CodeMsg.MIAO_SHA_OVER);
        }
        // 判断是否已经秒杀到了
        MiaoshaOrder order = orderService.getMiaoshaOrderByUserIdGoodsId(user.getId(), goodsId);
        if (order != null) {
            return Result.error(CodeMsg.REPEATE_MIAOSHA);
        }

        // 入队
        MiaoshaMessage mm = new MiaoshaMessage();
        mm.setUser(user);
        mm.setGoodsId(goodsId);
        mqSender.sendMiaoshaMessage(mm);
        return Result.success(0);// 排队中
        /*if (user == null) {
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
        return Result.success(orderInfo);*/
    }

    /**
     * -1 秒杀成功
     * 0 排队中
     * @param user
     * @param goodsId
     * @return
     */
    @RequestMapping(value = "/result", method = RequestMethod.GET)
    @ResponseBody
    public Result<Long> miaoshaResult(MiaoshaUser user,
                                @RequestParam("goodsId") long goodsId) {
        if (user == null) {
            return Result.error(CodeMsg.SESSION_ERROR);
        }
        long result = miaoshaService.getMiaoshaResult(user.getId(), goodsId);
        return Result.success(result);
    }

    @RequestMapping(value = "/path", method = RequestMethod.POST)
    @ResponseBody
    public Result<String> getMiaoshaPath(Model model, MiaoshaUser user,
                                         @RequestParam("goodsId") long goodsId) {
        model.addAttribute("user", user);
        if (user == null) {
            return Result.error(CodeMsg.SESSION_ERROR);
        }
        String path = miaoshaService.createMiaoshaPath(user, goodsId);
        return Result.success(path);
    }
}
