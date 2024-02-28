package com.yjq.programmer.controller.admin;

import com.yjq.programmer.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * @author WZX
 * @create 2023-03-17 8:17
 */
@Controller("AdminSystemController")
@RequestMapping("/admin/system")
public class SystemController {

    @Resource
    private IRoleService roleService;

    @Resource
    private IUserService userService;

    @Resource
    private IMovieService movieService;

    @Resource
    private ISessionService sessionService;

    @Resource
    private IOrderService orderService;

    @Resource
    private ICinemaService cinemaService;

    @Resource
    private ICommentService commentService;

    /**
     * 系统首页页面
     * @param model
     * @return
     */
    @RequestMapping(value="/index",method = RequestMethod.GET)
    public ModelAndView index(ModelAndView model){
        model.addObject("firstMenu", "system");
        model.addObject("roleList", roleService.all().getData());
        model.addObject("userTotal", userService.getTotal().getData());
        model.addObject("cinemaTotal", cinemaService.getTotal().getData());
        model.addObject("movieTotal", movieService.getTotal().getData());
        model.addObject("commentTotal", commentService.getTotal().getData());
        model.addObject("orderTotal", orderService.getTotal().getData());
        model.addObject("sessionTotal", sessionService.getTotal().getData());
        model.setViewName("admin/system/index");
        return model;
    }
}
