package com.yjq.programmer.dao;

import com.yjq.programmer.domain.Session;
import com.yjq.programmer.domain.SessionExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SessionMapper {
    int countByExample(SessionExample example);

    int deleteByExample(SessionExample example);

    int deleteByPrimaryKey(String id);

    int insert(Session record);

    int insertSelective(Session record);

    List<Session> selectByExample(SessionExample example);

    Session selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") Session record, @Param("example") SessionExample example);

    int updateByExample(@Param("record") Session record, @Param("example") SessionExample example);

    int updateByPrimaryKeySelective(Session record);

    int updateByPrimaryKey(Session record);
}
