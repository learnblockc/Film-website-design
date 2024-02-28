package com.yjq.programmer.service;

import com.yjq.programmer.domain.Cinema;
import com.yjq.programmer.domain.Page;
import com.yjq.programmer.vo.ResponseVo;

import java.util.List;
/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
public interface ICinemaService {

    // 获取电影院列表数据
    ResponseVo<List<Cinema>> list(String name, Page page);

    // 获取电影院的总数
    ResponseVo<Integer> getTotal();

    // 根据电影院id获取电影院信息
    ResponseVo<Cinema> findById(String id);

    // 封装分页数据
    ResponseVo<Page> getPage(Page page, String name);

    // 保存电影院信息
    ResponseVo<Boolean> save(Cinema cinema);

    // 删除电影院信息
    ResponseVo<Boolean> delete(String id);

    // 根据日期和电影id获取场次对应的影院信息
    ResponseVo<List<Cinema>> findBySessionAndDate(String time, String movieId);
}
