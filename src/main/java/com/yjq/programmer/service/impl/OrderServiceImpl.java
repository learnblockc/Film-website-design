package com.yjq.programmer.service.impl;

import com.github.pagehelper.PageHelper;
import com.yjq.programmer.bean.CodeMsg;
import com.yjq.programmer.constant.RuntimeConstant;
import com.yjq.programmer.dao.*;
import com.yjq.programmer.domain.*;
import com.yjq.programmer.enums.OrderStateEnum;
import com.yjq.programmer.service.IOrderService;
import com.yjq.programmer.service.ISessionService;
import com.yjq.programmer.util.CommonUtil;
import com.yjq.programmer.util.SnowFlake;
import com.yjq.programmer.util.UuidUtil;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
@Service
@Transactional
public class OrderServiceImpl implements IOrderService {

    @Resource
    private OrderMapper orderMapper;

    @Resource
    private SessionMapper sessionMapper;

    @Resource
    private CinemaMapper cinemaMapper;

    @Resource
    private MovieMapper movieMapper;

    @Resource
    private OrderItemMapper orderItemMapper;

    @Resource
    private UserMapper userMapper;

    @Resource
    private ISessionService sessionService;

    /**
     * 生成订单操作处理
     * @param orderItemList
     * @param order
     * @param request
     * @return
     */
    @Override
    public ResponseVo<Order> generateOrder(List<OrderItem> orderItemList, Order order, HttpServletRequest request) {
        if(order == null || orderItemList == null || orderItemList.size() == 0) {
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        if(CommonUtil.isEmpty(order.getSessionId()) || CommonUtil.isEmpty(order.getCinemaId()) || CommonUtil.isEmpty(order.getMovieId())){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        Cinema cinema = cinemaMapper.selectByPrimaryKey(order.getCinemaId());
        Session session = sessionMapper.selectByPrimaryKey(order.getSessionId());
        Movie movie = movieMapper.selectByPrimaryKey(order.getMovieId());
        if(cinema == null || session == null | movie == null){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 判断场次时间是否已经超过
        if(session.getTime().getTime() < (new Date()).getTime()){
            return ResponseVo.errorByMsg(CodeMsg.SESSION_TIME_OVER);
        }
        // 判断座位数是否足够
        if(session.getTotalSeat() - session.getOrderSeat() < orderItemList.size()){
            return ResponseVo.errorByMsg(CodeMsg.ORDER_SEAT_ERROR);
        }
        BigDecimal totalPrice = new BigDecimal("0.00");
        String orderId = UuidUtil.getShortUuid();
        order.setTradeNo(String.valueOf(new SnowFlake(2,3).nextId()));
        order.setId(orderId);
        order.setState(OrderStateEnum.NO_PAY.getCode());
        User user = (User) request.getSession().getAttribute(RuntimeConstant.HOME_USER);
        order.setUserId(user.getId());
        order.setCinemaName(cinema.getName());
        order.setMovieName(movie.getName());
        order.setMoviePhoto(movie.getPhoto());
        order.setSessionHall(session.getHall());
        order.setSessionTime(session.getTime());
        order.setCreateTime(new Date());
        totalPrice = session.getPrice().multiply(new BigDecimal(orderItemList.size()));
        order.setTotalPrice(totalPrice);
        for(OrderItem orderItem : orderItemList){
            orderItem.setOrderId(orderId);
            orderItem.setPrice(session.getPrice());
            orderItem.setId(UuidUtil.getShortUuid());
            orderItem.setSessionId(session.getId());
            if(orderItemMapper.insertSelective(orderItem) == 0){
                throw new RuntimeException("生成订单失败，请稍后重试！");
            }
        }
        if(orderMapper.insertSelective(order) == 0){
            throw new RuntimeException("生成订单失败，请稍后重试！");
        }
        // 增加已预订座位数
        session.setOrderSeat(session.getOrderSeat() + orderItemList.size());
        if(sessionMapper.updateByPrimaryKeySelective(session) == 0){
            throw new RuntimeException("生成订单失败，请稍后重试！");
        }
        return ResponseVo.successByMsg(order ,"确认选座成功！");
    }

    /**
     * 根据用户id获取订单数据
     * @param userId
     * @return
     */
    @Override
    public ResponseVo<List<Order>> getByUserId(String userId) {
        if(CommonUtil.isEmpty(userId)){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        OrderExample orderExample = new OrderExample();
        orderExample.createCriteria().andUserIdEqualTo(userId);
        orderExample.setOrderByClause("create_time desc");
        List<Order> orderList = orderMapper.selectByExample(orderExample);
        OrderItemExample orderItemExample = new OrderItemExample();
        for(Order order : orderList){
            orderItemExample.createCriteria().andOrderIdEqualTo(order.getId());
            List<OrderItem> orderItemList = orderItemMapper.selectByExample(orderItemExample);
            order.setOrderItemList(orderItemList);
        }
        return ResponseVo.success(orderList);
    }

    /**
     * 根据订单id获取订单信息
     * @param id
     * @return
     */
    @Override
    public ResponseVo<Order> getById(String id) {
        if(CommonUtil.isEmpty(id)){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        Order order = orderMapper.selectByPrimaryKey(id);
        OrderItemExample orderItemExample = new OrderItemExample();
        orderItemExample.createCriteria().andOrderIdEqualTo(id);
        List<OrderItem> orderItemList = orderItemMapper.selectByExample(orderItemExample);
        order.setOrderItemList(orderItemList);
        return ResponseVo.success(order);
    }

    /**
     * 支付订单操作处理
     * @param id
     * @return
     */
    @Override
    public ResponseVo<Boolean> payOrder(String id) {
        if(CommonUtil.isEmpty(id)){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        Order order = orderMapper.selectByPrimaryKey(id);
        if(order == null){
            return ResponseVo.errorByMsg(CodeMsg.ORDER_NOT_EXIST);
        }
        order.setState(OrderStateEnum.FINISH.getCode());
        if(orderMapper.updateByPrimaryKeySelective(order) == 0){
            return ResponseVo.errorByMsg(CodeMsg.ORDER_PAY_ERROR);
        }
        return ResponseVo.successByMsg(true, "支付订单成功！");
    }

    /**
     * 取消订单操作处理
     * @param id
     * @return
     */
    @Override
    public ResponseVo<Boolean> cancelOrder(String id) {
        if(CommonUtil.isEmpty(id)){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        Order order = orderMapper.selectByPrimaryKey(id);
        if(order == null ){
            return ResponseVo.errorByMsg(CodeMsg.ORDER_NOT_EXIST);
        }
        order.setState(OrderStateEnum.CANCEL.getCode());
        if(orderMapper.updateByPrimaryKeySelective(order) == 0){
            return ResponseVo.errorByMsg(CodeMsg.ORDER_CANCEL_ERROR);
        }
        return ResponseVo.successByMsg(true, "取消订单成功！");
    }

    /**
     * 获取订单列表数据
     * @param name
     * @param page
     * @return
     */
    @Override
    public ResponseVo<List<Order>> list(String name, Page page) {
        OrderExample orderExample = new OrderExample();
        if(!CommonUtil.isEmpty(name)){
            // 进行了搜索
            orderExample.createCriteria().andTradeNoEqualTo(name);
        }
        orderExample.setOrderByClause("create_time desc");
        PageHelper.startPage(page.getPage(), page.getRows());
        List<Order> orderList = orderMapper.selectByExample(orderExample);
        for(Order order : orderList){
            User user = userMapper.selectByPrimaryKey(order.getUserId());
            order.setUser(user);
        }
        return ResponseVo.success(orderList);
    }

    /**
     * 封装分页数据
     * @param page
     * @param name
     * @return
     */
    @Override
    public ResponseVo<Page> getPage(Page page, String name) {
        OrderExample orderExample = new OrderExample();
        if(!CommonUtil.isEmpty(name)){
            orderExample.createCriteria().andTradeNoEqualTo(name);
        }
        page.setTotalCount(orderMapper.countByExample(orderExample));
        return ResponseVo.success(page);
    }

    /**
     * 根据订单id获取订单详情的
     * @param id
     * @return
     */
    @Override
    public List<OrderItem> getOrderItemList(String id) {
        if(CommonUtil.isEmpty(id)){
            return new ArrayList<>();
        }
        OrderItemExample orderItemExample = new OrderItemExample();
        orderItemExample.createCriteria().andOrderIdEqualTo(id);
        return orderItemMapper.selectByExample(orderItemExample);
    }

    /**
     * 保存订单信息
     * @param order
     * @return
     */
    @Override
    public ResponseVo<Boolean> save(Order order) {
        if(order == null){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 保存订单信息操作
        if(orderMapper.updateByPrimaryKeySelective(order) == 0){
            return ResponseVo.errorByMsg(CodeMsg.ORDER_SAVE_ERROR);
        }
        return ResponseVo.success(true);
    }

    /**
     * 删除订单信息
     * @param id
     * @return
     */
    @Override
    public ResponseVo<Boolean> delete(String id) {
        if(CommonUtil.isEmpty(id)){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 删除订单详情数据
        OrderItemExample orderItemExample = new OrderItemExample();
        orderItemExample.createCriteria().andOrderIdEqualTo(id);
        if(orderItemMapper.deleteByExample(orderItemExample) == 0){
            throw new RuntimeException("订单信息删除失败，请联系管理员！");
        }
        // 删除订单数据
        if(orderMapper.deleteByPrimaryKey(id) == 0){
            throw new RuntimeException("订单信息删除失败，请联系管理员！");
        }
        // 重新计算已定座位数
        sessionService.sumOrderSeat();
        return ResponseVo.success(true);
    }

    /**
     * 获取订单的总数
     * @return
     */
    @Override
    public ResponseVo<Integer> getTotal() {
        return ResponseVo.success(orderMapper.countByExample(new OrderExample()));
    }
}
