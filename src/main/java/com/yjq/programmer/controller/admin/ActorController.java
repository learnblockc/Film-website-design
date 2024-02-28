package com.yjq.programmer.controller.admin;

import com.yjq.programmer.domain.Actor;
import com.yjq.programmer.service.IActorService;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author WZX
 * @create 2023-03-20 9:51
 */
@Controller("AdminActorController")
@RequestMapping("/admin/actor")
public class ActorController {

    @Resource
    private IActorService actorService;

    /**
     * 根据电影id获取演职人员列表数据
     * @param id
     * @return
     */
    @RequestMapping(value="/list",method = RequestMethod.POST)
    @ResponseBody
    public List<Actor> list(String id){
        return actorService.getByMovieId(id).getData();
    }

    /**
     * 保存演职人员信息
     * @param actor
     * @return
     */
    @RequestMapping(value="/save",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> save(Actor actor){
        return actorService.save(actor);
    }

    /**
     * 删除演职人员信息
     * @param id
     * @return
     */
    @RequestMapping(value="/delete",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> delete(String id){
        return actorService.delete(id);
    }
}
