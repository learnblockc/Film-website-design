package com.yjq.programmer.controller.home;

import com.yjq.programmer.domain.Session;
import com.yjq.programmer.service.ICinemaService;
import com.yjq.programmer.service.IMovieService;
import com.yjq.programmer.service.ISessionService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * @author WZX
 * @create 2023-03-21 8:58
 */
@Controller("HomeSessionController")
@RequestMapping("/home/session")
public class SessionController {

    @Resource
    private ISessionService sessionService;

    @Resource
    private ICinemaService cinemaService;

    @Resource
    private IMovieService movieService;

    /**
     * 电影场次挑选座位页面
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value="/seat",method = RequestMethod.GET)
    public ModelAndView seat(ModelAndView model, String id){
        Session session = sessionService.findById(id).getData() ;
        model.addObject("session", session);
        model.addObject("selectSeat", sessionService.findOrderItemById(id).getData());
        model.addObject("cinema", cinemaService.findById(session.getCinemaId()).getData());
        model.addObject("movie", movieService.findById(session.getMovieId()).getData());
        model.setViewName("home/session/seat");
        return model;
    }
}
