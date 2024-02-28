package com.yjq.programmer.dao;

import com.yjq.programmer.domain.Cinema;
import com.yjq.programmer.domain.CinemaExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CinemaMapper {
    int countByExample(CinemaExample example);

    int deleteByExample(CinemaExample example);

    int deleteByPrimaryKey(String id);

    int insert(Cinema record);

    int insertSelective(Cinema record);

    List<Cinema> selectByExample(CinemaExample example);

    Cinema selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") Cinema record, @Param("example") CinemaExample example);

    int updateByExample(@Param("record") Cinema record, @Param("example") CinemaExample example);

    int updateByPrimaryKeySelective(Cinema record);

    int updateByPrimaryKey(Cinema record);
}
