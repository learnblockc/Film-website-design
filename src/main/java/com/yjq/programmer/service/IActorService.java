package com.yjq.programmer.service;

import com.yjq.programmer.domain.Actor;
import com.yjq.programmer.vo.ResponseVo;

import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
public interface IActorService {

    // 根据电影id获取演职人员列表数据
    ResponseVo<List<Actor>> getByMovieId(String id);

    // 保存演职人员信息
    ResponseVo<Boolean> save(Actor actor);

    // 删除演职人员信息
    ResponseVo<Boolean> delete(String id);
}
