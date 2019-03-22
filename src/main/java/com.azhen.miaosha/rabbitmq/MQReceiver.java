package com.azhen.miaosha.rabbitmq;

import com.azhen.miaosha.domain.MiaoshaOrder;
import com.azhen.miaosha.domain.MiaoshaUser;
import com.azhen.miaosha.redis.RedisService;
import com.azhen.miaosha.service.GoodsService;
import com.azhen.miaosha.service.MiaoshaService;
import com.azhen.miaosha.service.MiaoshaUserService;
import com.azhen.miaosha.service.OrderService;
import com.azhen.miaosha.vo.GoodsVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MQReceiver {
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

    private static final Logger log = LoggerFactory.getLogger(MQReceiver.class);
    @RabbitListener(queues = MQConfig.QUEUE)
    public void receive(String message) {
        System.out.println("recv: " + message);
    }

    @RabbitListener(queues = MQConfig.TOPIC_QUEUE1)
    public void receiveTopic1(String message) {
        System.out.println("topic queue1 recv: " + message);
    }

    @RabbitListener(queues = MQConfig.TOPIC_QUEUE2)
    public void receiveTopic2(String message) {
        System.out.println("topic queue2 recv: " + message);
    }

    @RabbitListener(queues = MQConfig.HEADER_QUEUE)
    public void receiveHeader(byte[] message) {
        System.out.println("topic queue2 recv: " + new String(message));
    }

    @RabbitListener(queues = MQConfig.MIAOSHA_QUEUE)
    public void receiveMiaosha(String message) {
        log.info("recv: " + message);
        MiaoshaMessage mm = RedisService.stringToBean(message, MiaoshaMessage.class);
        MiaoshaUser user = mm.getUser();
        long goodsId = mm.getGoodsId();

        // 判断库存
        GoodsVo goods = goodsService.getGoodsVoByGoodsId(goodsId);
        int stock = goods.getGoodsStock();
        if (stock <= 0) {
            return ;
        }
        // 判断是否已经秒杀到了
        MiaoshaOrder order = orderService.getMiaoshaOrderByUserIdGoodsId(user.getId(), goodsId);
        if (order != null) {
            return ;
        }

        // 减库存 下订单 写入秒杀订单
        miaoshaService.miaosha(user, goods);
    }
}
