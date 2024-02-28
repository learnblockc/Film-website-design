package com.yjq.programmer.controller.home;

import com.yjq.programmer.service.ICinemaService;
import com.yjq.programmer.service.IMovieService;
import com.yjq.programmer.service.ISessionService;
import com.yjq.programmer.util.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
@Controller("HomeCinemaController")
@RequestMapping("/home/cinema")
public class CinemaController {

    @Resource
    private ICinemaService cinemaService;

    @Resource
    private IMovieService movieService;

    @Resource
    private ISessionService sessionService;

    /**
     * 电影院详情页面
     * @param model
     * @param cinemaId
     * @param movieId
     * @param time
     * @return
     */
    @RequestMapping(value="/detail",method = RequestMethod.GET)
    public ModelAndView detail(ModelAndView model, String cinemaId, String movieId, String time){
        model.addObject("cinema", cinemaService.findById(cinemaId).getData());
        model.addObject("movie", movieService.findById(movieId).getData());
        model.addObject("sessionList", sessionService.findByDateAndMovieId(time, movieId).getData());
        if(CommonUtil.isEmpty(time)){
            model.addObject("time", 0);
        } else {
            model.addObject("time", time);
        }
        model.setViewName("home/cinema/detail");
        return model;
    }
}
