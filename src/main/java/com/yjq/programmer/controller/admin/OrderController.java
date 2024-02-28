package com.yjq.programmer.controller.admin;

import com.yjq.programmer.domain.Order;
import com.yjq.programmer.domain.OrderItem;
import com.yjq.programmer.domain.Page;
import com.yjq.programmer.service.IOrderService;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 16:07
 */
@Controller("AdminOrderController")
@RequestMapping("/admin/order")
public class OrderController {

    @Resource
    private IOrderService orderService;

    /**
     * 订单列表页面
     * @param model
     * @param name
     * @return
     */
    @RequestMapping(value="/index",method = RequestMethod.GET)
    public ModelAndView index(ModelAndView model, String name){
        model.addObject("firstMenu", "order");
        model.addObject("secondMenu", "order-index");
        model.addObject("Page", orderService.getPage(new Page(), name).getData());
        model.setViewName("admin/order/index");
        return model;
    }

    /**
     * 订单列表数据获取
     * @param name
     * @param page
     * @return
     */
    @RequestMapping(value="/list",method = RequestMethod.POST)
    @ResponseBody
    public List<Order> list(String name, Page page){
        return orderService.list(name, page).getData();
    }

    /**
     * 封装分页数据
     * @param page
     * @param name
     * @return
     */
    @RequestMapping(value="/page",method = RequestMethod.POST)
    @ResponseBody
    public Page page(Page page, String name){
        return orderService.getPage(page, name).getData();
    }


    /**
     * 根据订单id获取订单详情数据
     * @param id
     * @return
     */
    @RequestMapping(value="/view",method = RequestMethod.POST)
    @ResponseBody
    public List<OrderItem> getOrderItemList(String id){
        return orderService.getOrderItemList(id);
    }

    /**
     * 保存订单信息
     * @param order
     * @return
     */
    @RequestMapping(value="/save",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> save(Order order){
        return orderService.save(order);
    }

    /**
     * 删除订单信息
     * @param id
     * @return
     */
    @RequestMapping(value="/delete",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> delete(String id){
        return orderService.delete(id);
    }
}
