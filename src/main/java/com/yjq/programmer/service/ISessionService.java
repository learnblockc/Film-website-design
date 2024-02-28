package com.yjq.programmer.service;

import com.yjq.programmer.domain.OrderItem;
import com.yjq.programmer.domain.Page;
import com.yjq.programmer.domain.Session;
import com.yjq.programmer.vo.ResponseVo;

import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
public interface ISessionService {

    // 获取场次列表数据
    ResponseVo<List<Session>> list(String name, Page page);

    // 封装分页数据
    ResponseVo<Page> getPage(Page page, String name);

    // 保存场次信息
    ResponseVo<Boolean> save(Session session);

    // 删除场次信息
    ResponseVo<Boolean> delete(String id);

    // 根据日期和电影id获取场次信息
    ResponseVo<List<Session>> findByDateAndMovieId(String time, String movieId);

    // 根据id获取场次信息
    ResponseVo<Session> findById(String id);

    // 根据id获取选座详情
    ResponseVo<List<OrderItem>> findOrderItemById(String id);

    // 获取场次的总数
    ResponseVo<Integer> getTotal();

    // 重新核算所有场次的已定座位数
    ResponseVo<Boolean> sumOrderSeat();
}
