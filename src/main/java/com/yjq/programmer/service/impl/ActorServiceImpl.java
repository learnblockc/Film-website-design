package com.yjq.programmer.service.impl;

import com.yjq.programmer.bean.CodeMsg;
import com.yjq.programmer.dao.ActorMapper;
import com.yjq.programmer.domain.Actor;
import com.yjq.programmer.domain.ActorExample;
import com.yjq.programmer.service.IActorService;
import com.yjq.programmer.util.CommonUtil;
import com.yjq.programmer.util.UuidUtil;
import com.yjq.programmer.util.ValidateEntityUtil;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
@Service
@Transactional
public class ActorServiceImpl implements IActorService {

    @Resource
    private ActorMapper actorMapper;

    /**
     * 根据电影id获取演职人员列表数据
     * @param id
     * @return
     */
    @Override
    public ResponseVo<List<Actor>> getByMovieId(String id) {
        ActorExample actorExample = new ActorExample();
        actorExample.createCriteria().andMovieIdEqualTo(id);
        return ResponseVo.success(actorMapper.selectByExample(actorExample));
    }

    /**
     * 保存演职人员信息
     * @param actor
     * @return
     */
    @Override
    public ResponseVo<Boolean> save(Actor actor) {
        if(actor == null){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 进行统一表单验证
        CodeMsg validate = ValidateEntityUtil.validate(actor);
        if (!validate.getCode().equals(CodeMsg.SUCCESS.getCode())) {
            return ResponseVo.errorByMsg(validate);
        }
        if(CommonUtil.isEmpty(actor.getId())){
            // 添加操作
            // 判断演职人员名称是否存在
            if(isActorNameExist(actor, "")){
                return ResponseVo.errorByMsg(CodeMsg.ACTOR_NAME_EXIST);
            }
            actor.setId(UuidUtil.getShortUuid());
            if(actorMapper.insertSelective(actor) == 0){
                return ResponseVo.errorByMsg(CodeMsg.ACTOR_ADD_ERROR);
            }
        }else {
            // 修改操作
            // 判断演职人员名称是否存在
            if(isActorNameExist(actor, actor.getId())){
                return ResponseVo.errorByMsg(CodeMsg.ACTOR_NAME_EXIST);
            }
            if(actorMapper.updateByPrimaryKeySelective(actor) == 0){
                return ResponseVo.errorByMsg(CodeMsg.ACTOR_EDIT_ERROR);
            }
        }
        return ResponseVo.success(true);
    }

    /**
     * 删除演职人员信息
     * @param id
     * @return
     */
    @Override
    public ResponseVo<Boolean> delete(String id) {
        if(CommonUtil.isEmpty(id)){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        if(actorMapper.deleteByPrimaryKey(id) == 0){
            return ResponseVo.errorByMsg(CodeMsg.ACTOR_DELETE_ERROR);
        }
        return ResponseVo.success(true);
    }

    /**
     * 判断演职人员名称是否重复
     * @param actor
     * @param id
     * @return
     */
    public Boolean isActorNameExist(Actor actor, String id) {
        ActorExample actorExample = new ActorExample();
        actorExample.createCriteria().andNameEqualTo(actor.getName());
        List<Actor> selectedActorList = actorMapper.selectByExample(actorExample);
        if(selectedActorList != null && selectedActorList.size() > 0) {
            if(selectedActorList.size() > 1){
                return true; //出现重名
            }
            if(!selectedActorList.get(0).getId().equals(id)) {
                return true; //出现重名
            }
        }
        return false;//没有重名
    }


}
