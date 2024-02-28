package com.yjq.programmer.service.impl;

import com.github.pagehelper.PageHelper;
import com.yjq.programmer.bean.CodeMsg;
import com.yjq.programmer.dao.CinemaMapper;
import com.yjq.programmer.dao.MovieMapper;
import com.yjq.programmer.dao.OrderItemMapper;
import com.yjq.programmer.dao.SessionMapper;
import com.yjq.programmer.dao.my.MySessionMapper;
import com.yjq.programmer.domain.*;
import com.yjq.programmer.service.ISessionService;
import com.yjq.programmer.util.CommonUtil;
import com.yjq.programmer.util.UuidUtil;
import com.yjq.programmer.util.ValidateEntityUtil;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
@Service
@Transactional
public class SessionServiceImpl implements ISessionService {

    @Resource
    private SessionMapper sessionMapper;

    @Resource
    private CinemaMapper cinemaMapper;

    @Resource
    private MySessionMapper mySessionMapper;

    @Resource
    private MovieMapper movieMapper;

    @Resource
    private OrderItemMapper orderItemMapper;

    /**
     * 获取场次列表数据
     * @param name
     * @param page
     * @return
     */
    @Override
    public ResponseVo<List<Session>> list(String name, Page page) {
        SessionExample sessionExample = new SessionExample();
        if(!CommonUtil.isEmpty(name)){
            // 进行了搜索
            sessionExample.createCriteria().andIdEqualTo(name);
        }
        PageHelper.startPage(page.getPage(), page.getRows());
        List<Session> sessionList = sessionMapper.selectByExample(sessionExample);
        for(Session session : sessionList){
            session.setMovie(movieMapper.selectByPrimaryKey(session.getMovieId()));
            session.setCinema(cinemaMapper.selectByPrimaryKey(session.getCinemaId()));
        }
        return ResponseVo.success(sessionList);
    }

    /**
     * 封装分页数据
     * @param page
     * @param name
     * @return
     */
    @Override
    public ResponseVo<Page> getPage(Page page, String name) {
        SessionExample sessionExample = new SessionExample();
        if(!CommonUtil.isEmpty(name)){
            sessionExample.createCriteria().andIdEqualTo(name);
        }
        page.setTotalCount(sessionMapper.countByExample(sessionExample));
        return ResponseVo.success(page);
    }

    /**
     * 保存场次信息
     * @param session
     * @return
     */
    @Override
    public ResponseVo<Boolean> save(Session session) {
        if(session == null){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 进行统一表单验证
        CodeMsg validate = ValidateEntityUtil.validate(session);
        if (!validate.getCode().equals(CodeMsg.SUCCESS.getCode())) {
            return ResponseVo.errorByMsg(validate);
        }
        if(CommonUtil.isEmpty(session.getId())){
            // 添加操作
            session.setId(UuidUtil.getShortUuid());
            session.setTotalSeat(session.getRow() * session.getCol());
            if(sessionMapper.insertSelective(session) == 0){
                return ResponseVo.errorByMsg(CodeMsg.SESSION_ADD_ERROR);
            }
        }else {
            // 修改操作
            // 不让修改 座位行数 座位列数信息
            session.setRow(null);
            session.setCol(null);
            if(sessionMapper.updateByPrimaryKeySelective(session) == 0){
                return ResponseVo.errorByMsg(CodeMsg.SESSION_EDIT_ERROR);
            }
        }
        return ResponseVo.success(true);
    }

    /**
     * 删除场次信息
     * @param id
     * @return
     */
    @Override
    public ResponseVo<Boolean> delete(String id) {
        if(CommonUtil.isEmpty(id)){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        if(sessionMapper.deleteByPrimaryKey(id) == 0){
            return ResponseVo.errorByMsg(CodeMsg.SESSION_DELETE_ERROR);
        }
        return ResponseVo.success(true);
    }

    /**
     * 根据日期和电影id获取场次信息
     * @param time
     * @param movieId
     * @return
     */
    @Override
    public ResponseVo<List<Session>> findByDateAndMovieId(String time, String movieId) {
        Map<String, Object> queryMap = new HashMap<>();
        queryMap.put("movieId", movieId);
        if(CommonUtil.isEmpty(time)){
            // 全部查询
            queryMap.put("start", 0);
        }else {
            // 按时间查询
            switch (Integer.parseInt(time)){
                case 1:
                    // 获取当天数据
                    queryMap.put("start", 0);
                    queryMap.put("end", -1);
                    break;
                case 2:
                    // 获取明天数据
                    queryMap.put("start", -1);
                    queryMap.put("end", -2);
                    break;
                case 3:
                    // 获取后天数据
                    queryMap.put("start", -2);
                    queryMap.put("end", -3);
                    break;
                case 4:
                    // 获取大后天数据
                    queryMap.put("start", -3);
                    queryMap.put("end", -4);
                    break;
            }
        }
        List<Session>  sessionList = mySessionMapper.getSessionListByDate(queryMap);
        return ResponseVo.success(sessionList);
    }

    /**
     * 根据id获取场次信息
     * @param id
     * @return
     */
    @Override
    public ResponseVo<Session> findById(String id) {
        if(CommonUtil.isEmpty(id)){
            return ResponseVo.success(new Session());
        } else {
            return ResponseVo.success(sessionMapper.selectByPrimaryKey(id));
        }
    }

    /**
     * 根据id获取选座详情
     * @param id
     * @return
     */
    @Override
    public ResponseVo<List<OrderItem>> findOrderItemById(String id) {
        OrderItemExample orderItemExample = new OrderItemExample();
        orderItemExample.createCriteria().andSessionIdEqualTo(id);
        List<OrderItem> orderItemList = orderItemMapper.selectByExample(orderItemExample);
        return ResponseVo.success(orderItemList);
    }

    /**
     * 获取场次的总数
     * @return
     */
    @Override
    public ResponseVo<Integer> getTotal() {
        return ResponseVo.success(sessionMapper.countByExample(new SessionExample()));
    }

    /**
     * 重新核算所有场次的已定座位数
     * @return
     */
    @Override
    public ResponseVo<Boolean> sumOrderSeat() {
        List<Session> sessionList = sessionMapper.selectByExample(new SessionExample());
        for(Session session : sessionList){
            OrderItemExample orderItemExample = new OrderItemExample();
            orderItemExample.createCriteria().andSessionIdEqualTo(session.getId());
            List<OrderItem> orderItemList = orderItemMapper.selectByExample(orderItemExample);
            session.setOrderSeat(orderItemList.size());
            if(sessionMapper.updateByPrimaryKeySelective(session) == 0){
                return ResponseVo.errorByMsg(CodeMsg.SESSION_EDIT_ERROR);
            }
        }
        return ResponseVo.success(true);
    }
}
