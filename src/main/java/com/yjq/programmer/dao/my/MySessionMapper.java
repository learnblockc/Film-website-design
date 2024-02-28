package com.yjq.programmer.dao.my;

import com.yjq.programmer.domain.Session;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author WZX
 * @create 2023-02-26 8:58
 */
public interface MySessionMapper {

    // 根据时间获取场次列表
    List<Session> getSessionListByDate(@Param("queryMap") Map<String, Object> queryMap);
}
