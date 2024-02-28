package com.yjq.programmer.service;

import com.yjq.programmer.domain.Rate;
import com.yjq.programmer.vo.ResponseVo;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
public interface IRateService {

    // 电影评分操作处理
    ResponseVo<Boolean> rateMovie(Rate rate);

    // 重新核算所有电影的电影评分和评分人数
    ResponseVo<Boolean> sumRateAndCount();
}
