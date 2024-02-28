package com.yjq.programmer.service;

import com.yjq.programmer.domain.Order;
import com.yjq.programmer.domain.OrderItem;
import com.yjq.programmer.domain.Page;
import com.yjq.programmer.vo.ResponseVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
public interface IOrderService {

    // 生成订单操作处理
    ResponseVo<Order> generateOrder(List<OrderItem> orderItemList, Order order, HttpServletRequest request);

    // 根据用户id获取订单数据
    ResponseVo<List<Order>> getByUserId(String userId);

    // 根据订单id获取订单信息
    ResponseVo<Order> getById(String id);

    // 支付订单操作处理
    ResponseVo<Boolean> payOrder(String id);

    // 取消订单操作处理
    ResponseVo<Boolean> cancelOrder(String id);

    // 获取订单列表数据
    ResponseVo<List<Order>> list(String name, Page page);

    // 封装分页数据
    ResponseVo<Page> getPage(Page page, String name);

    // 根据订单id获取订单详情
    List<OrderItem> getOrderItemList(String id);

    // 保存订单信息
    ResponseVo<Boolean> save(Order order);

    // 删除订单信息
    ResponseVo<Boolean> delete(String id);

    // 获取订单的总数
    ResponseVo<Integer> getTotal();
}
