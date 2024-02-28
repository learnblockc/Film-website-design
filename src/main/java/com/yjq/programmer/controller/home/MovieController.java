package com.yjq.programmer.controller.home;

import com.yjq.programmer.domain.MovieListSearch;
import com.yjq.programmer.domain.Page;
import com.yjq.programmer.service.IActorService;
import com.yjq.programmer.service.ICinemaService;
import com.yjq.programmer.service.ICommentService;
import com.yjq.programmer.service.IMovieService;
import com.yjq.programmer.util.CommonUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * @author WZX
 * @create 2023-02-24 8:58
 */
@Controller("HomeMovieController")
@RequestMapping("/home/movie")
public class MovieController {

    @Resource
    private IMovieService movieService;

    @Resource
    private ICinemaService cinemaService;

    @Resource
    private ICommentService commentService;

    @Resource
    private IActorService actorService;

    /**
     * 电影列表页面
     * @param model
     * @param movieListSearch
     * @param page
     * @return
     */
    @RequestMapping(value="/list",method = RequestMethod.GET)
    public ModelAndView list(ModelAndView model, MovieListSearch movieListSearch, Page page){
        page.setRows(15);
        model.addObject("movieListSearch", movieListSearch);
        model.addObject("page", movieService.getPageBySearch(page, movieListSearch).getData());
        model.addObject("movieList", movieService.getMovieListBySearch(movieListSearch, page).getData());
        model.setViewName("home/movie/list");
        return model;
    }

    /**
     * 电影详情页面
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value="/detail",method = RequestMethod.GET)
    public ModelAndView detail(ModelAndView model, String id){
        model.addObject("movie", movieService.findById(id).getData());
        model.addObject("commentList", commentService.getByMovieId(id).getData());
        model.addObject("actorList", actorService.getByMovieId(id).getData());
        model.setViewName("home/movie/detail");
        return model;
    }


    /**
     * 电影简介页面
     * @param model
     * @param id
     * @param time
     * @return
     */
    @RequestMapping(value="/info",method = RequestMethod.GET)
    public ModelAndView info(ModelAndView model, String id, String time){
        model.addObject("movie", movieService.findById(id).getData());
        model.addObject("cinemaList", cinemaService.findBySessionAndDate(time, id).getData());
        if(CommonUtil.isEmpty(time)){
            model.addObject("time", 0);
        } else {
            model.addObject("time", time);
        }
        model.setViewName("home/movie/info");
        return model;
    }
}
