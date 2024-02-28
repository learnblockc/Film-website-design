package com.yjq.programmer.controller.home;

import com.yjq.programmer.domain.Order;
import com.yjq.programmer.domain.OrderItem;
import com.yjq.programmer.service.IOrderService;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author WZX
 * @create 2023-03-22 8:58
 */
@Controller("HomeOrderController")
@RequestMapping("/home/order")
public class OrderController {

    @Resource
    private IOrderService orderService;

    /**
     * 订单支付页面
     * @param model
     * @param orderId
     * @return
     */
    @RequestMapping(value="/pay",method = RequestMethod.GET)
    public ModelAndView pay(ModelAndView model, String orderId){
        model.addObject("order", orderService.getById(orderId).getData());
        model.setViewName("home/order/pay");
        return model;
    }

    /**
     * 支付订单操作处理
     * @param id
     * @return
     */
    @RequestMapping(value="/pay",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> pay(String id){
        return orderService.payOrder(id);
    }

    /**
     * 生成订单操作处理
     * @param orderItemList
     * @param order
     * @param request
     * @return
     */
    @RequestMapping(value="/generate",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Order> generate(@RequestBody List<OrderItem> orderItemList, Order order, HttpServletRequest request){
        return orderService.generateOrder(orderItemList, order, request);
    }

    /**
     * 取消订单操作处理
     * @param id
     * @return
     */
    @RequestMapping(value="/cancel",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> cancel(String id){
        return orderService.cancelOrder(id);
    }
}
