package com.yjq.programmer.controller.admin;

import com.yjq.programmer.domain.Page;
import com.yjq.programmer.domain.Session;
import com.yjq.programmer.service.ICinemaService;
import com.yjq.programmer.service.IMovieService;
import com.yjq.programmer.service.ISessionService;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author WZX
 * @create 2023-03-20 11:28
 */
@Controller("AdminSessionController")
@RequestMapping("/admin/session")
public class SessionController {

    @Resource
    private ISessionService sessionService;

    @Resource
    private IMovieService movieService;

    @Resource
    private ICinemaService cinemaService;

    /**
     * 场次列表页面
     * @param model
     * @return
     */
    @RequestMapping(value="/index",method = RequestMethod.GET)
    public ModelAndView index(ModelAndView model){
        model.addObject("firstMenu", "session");
        model.addObject("secondMenu", "session-index");
        model.addObject("Page", sessionService.getPage(new Page(), "").getData());
        model.addObject("cinemaList", cinemaService.list("", new Page(1, cinemaService.getTotal().getData())).getData());
        model.addObject("movieList", movieService.list("", new Page(1, movieService.getTotal().getData())).getData());
        model.setViewName("admin/session/index");
        return model;
    }

    /**
     * 场次列表数据获取
     * @param name
     * @param page
     * @return
     */
    @RequestMapping(value="/list",method = RequestMethod.POST)
    @ResponseBody
    public List<Session> list(String name, Page page){
        return sessionService.list(name, page).getData();
    }

    /**
     * 封装分页数据
     * @return
     */
    @RequestMapping(value="/page",method = RequestMethod.POST)
    @ResponseBody
    public Page page(Page page, String name){
        return sessionService.getPage(page, name).getData();
    }

    /**
     * 保存场次信息
     * @param session
     * @return
     */
    @RequestMapping(value="/save",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> save(Session session){
        return sessionService.save(session);
    }

    /**
     * 删除场次信息
     * @param id
     * @return
     */
    @RequestMapping(value="/delete",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> delete(String id){
        return sessionService.delete(id);
    }
}
