package com.yjq.programmer.controller.home;

import com.yjq.programmer.domain.Page;
import com.yjq.programmer.service.IMovieService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * @author WZX
 * @create 2023-03-23 8:58
 */
@Controller("HomeSystemController")
@RequestMapping("/home/system")
public class SystemController {

    @Resource
    private IMovieService movieService;

    /**
     * 系统首页页面
     * @param model
     * @return
     */
    @RequestMapping(value="/index",method = RequestMethod.GET)
    public ModelAndView index(ModelAndView model){
        model.addObject("total", movieService.getTotal().getData());
        model.addObject("movieList", movieService.list("", new Page(1, 8)).getData());
        model.addObject("rateMovieList", movieService.getMovieByRate().getData());
        model.setViewName("home/system/index");
        return model;
    }

}
