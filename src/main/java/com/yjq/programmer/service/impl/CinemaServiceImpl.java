package com.yjq.programmer.service.impl;

import com.github.pagehelper.PageHelper;
import com.yjq.programmer.bean.CodeMsg;
import com.yjq.programmer.dao.CinemaMapper;
import com.yjq.programmer.dao.SessionMapper;
import com.yjq.programmer.dao.my.MySessionMapper;
import com.yjq.programmer.domain.*;
import com.yjq.programmer.service.ICinemaService;
import com.yjq.programmer.service.ISessionService;
import com.yjq.programmer.util.CommonUtil;
import com.yjq.programmer.util.UuidUtil;
import com.yjq.programmer.util.ValidateEntityUtil;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
@Service
@Transactional
public class CinemaServiceImpl implements ICinemaService {

    @Resource
    private CinemaMapper cinemaMapper;

    @Resource
    private MySessionMapper mySessionMapper;

    @Resource
    private SessionMapper sessionMapper;

    @Resource
    private ISessionService sessionService;

    /**
     * 封装分页数据
     * @return
     */
    @Override
    public ResponseVo<Page> getPage(Page page, String name) {
        CinemaExample cinemaExample = new CinemaExample();
        cinemaExample.createCriteria().andNameLike('%'+name+'%');
        page.setTotalCount(cinemaMapper.countByExample(cinemaExample));
        return ResponseVo.success(page);
    }

    /**
     * 获取电影院列表数据
     * @param name
     * @param page
     * @return
     */
    @Override
    public ResponseVo<List<Cinema>> list(String name, Page page) {
        CinemaExample cinemaExample = new CinemaExample();
        if(!CommonUtil.isEmpty(name)){
            // 进行了搜索
            cinemaExample.createCriteria().andNameLike('%' + name + '%');
        }
        PageHelper.startPage(page.getPage(), page.getRows());
        List<Cinema> cinemaList = cinemaMapper.selectByExample(cinemaExample);
        return ResponseVo.success(cinemaList);
    }

    /**
     * 获取电影院的总数
     * @return
     */
    @Override
    public ResponseVo<Integer> getTotal() {
        return ResponseVo.success(cinemaMapper.countByExample(new CinemaExample()));
    }

    /**
     * 根据电影院id获取电影院信息
     * @param id
     * @return
     */
    @Override
    public ResponseVo<Cinema> findById(String id) {
        return ResponseVo.success(cinemaMapper.selectByPrimaryKey(id));
    }

    /**
     * 保存电影院信息
     * @param cinema
     * @return
     */
    @Override
    public ResponseVo<Boolean> save(Cinema cinema) {
        if(cinema == null){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 进行统一表单验证
        CodeMsg validate = ValidateEntityUtil.validate(cinema);
        if (!validate.getCode().equals(CodeMsg.SUCCESS.getCode())) {
            return ResponseVo.errorByMsg(validate);
        }
        if(CommonUtil.isEmpty(cinema.getId())){
            // 添加操作
            // 判断电影院名称是否存在
            if(isCinemaNameExist(cinema, "")){
                return ResponseVo.errorByMsg(CodeMsg.CINEMA_NAME_EXIST);
            }
            cinema.setId(UuidUtil.getShortUuid());
            if(cinemaMapper.insertSelective(cinema) == 0){
                return ResponseVo.errorByMsg(CodeMsg.CINEMA_ADD_ERROR);
            }
        }else {
            // 修改操作
            // 判断电影院名称是否存在
            if(isCinemaNameExist(cinema, cinema.getId())){
                return ResponseVo.errorByMsg(CodeMsg.CINEMA_NAME_EXIST);
            }
            if(cinemaMapper.updateByPrimaryKeySelective(cinema) == 0){
                return ResponseVo.errorByMsg(CodeMsg.CINEMA_EDIT_ERROR);
            }
        }
        return ResponseVo.success(true);
    }

    /**
     * 删除电影院信息
     * @param id
     * @return
     */
    @Override
    public ResponseVo<Boolean> delete(String id) {
        if(CommonUtil.isEmpty(id)){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 删除场次信息
        SessionExample sessionExample = new SessionExample();
        sessionExample.createCriteria().andCinemaIdEqualTo(id);
        sessionMapper.deleteByExample(sessionExample);
        // 删除电影院信息
        if(cinemaMapper.deleteByPrimaryKey(id) == 0){
            return ResponseVo.errorByMsg(CodeMsg.CINEMA_DELETE_ERROR);
        }
        return ResponseVo.success(true);
    }

    /**
     * 根据日期和电影id获取场次对应的影院信息
     * @return
     */
    @Override
    public ResponseVo<List<Cinema>> findBySessionAndDate(String time, String movieId) {
        List<Session> sessionList = sessionService.findByDateAndMovieId(time, movieId).getData();
        List<Cinema> cinemaList = new ArrayList<>();
        for(Session session : sessionList){
            cinemaList.add(cinemaMapper.selectByPrimaryKey(session.getCinemaId()));
        }
        cinemaList = cinemaList.stream().distinct().collect(Collectors.toList());
        return ResponseVo.success(cinemaList);
    }

    /**
     * 判断电影院名称是否重复
     * @param cinema
     * @param id
     * @return
     */
    public Boolean isCinemaNameExist(Cinema cinema, String id) {
        CinemaExample cinemaExample = new CinemaExample();
        cinemaExample.createCriteria().andNameEqualTo(cinema.getName());
        List<Cinema> selectedCinemaList = cinemaMapper.selectByExample(cinemaExample);
        if(selectedCinemaList != null && selectedCinemaList.size() > 0) {
            if(selectedCinemaList.size() > 1){
                return true; //出现重名
            }
            if(!selectedCinemaList.get(0).getId().equals(id)) {
                return true; //出现重名
            }
        }
        return false;//没有重名
    }
}
