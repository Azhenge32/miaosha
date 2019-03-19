package com.azhen.miaosha.rabbitmq;

import com.azhen.miaosha.redis.RedisService;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MQSender {
    @Autowired
    AmqpTemplate amqpTemplate;

    public void send(Object message) {
        String msg = RedisService.beanToString(message);
        System.out.println("send: " + msg);
        amqpTemplate.convertAndSend(MQConfig.QUEUE, msg);
    }
}
