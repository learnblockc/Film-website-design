package com.yjq.programmer.controller.admin;

import com.yjq.programmer.domain.Movie;
import com.yjq.programmer.domain.Page;
import com.yjq.programmer.service.IMovieService;
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
 * @create 2023-03-19 16:57
 */
@Controller("AdminMovieController")
@RequestMapping("/admin/movie")
public class MovieController {

    @Resource
    private IMovieService movieService;

    /**
     * 电影列表页面
     * @param model
     * @return
     */
    @RequestMapping(value="/index",method = RequestMethod.GET)
    public ModelAndView index(ModelAndView model){
        model.addObject("firstMenu", "movie");
        model.addObject("secondMenu", "movie-index");
        model.addObject("Page", movieService.getPage(new Page(), "").getData());
        model.setViewName("admin/movie/index");
        return model;
    }

    /**
     * 电影列表数据获取
     * @param name
     * @param page
     * @return
     */
    @RequestMapping(value="/list",method = RequestMethod.POST)
    @ResponseBody
    public List<Movie> list(String name, Page page){
        return movieService.list(name, page).getData();
    }

    /**
     * 封装分页数据
     * @return
     */
    @RequestMapping(value="/page",method = RequestMethod.POST)
    @ResponseBody
    public Page page(Page page, String name){
        return movieService.getPage(page, name).getData();
    }

    /**
     * 保存电影信息
     * @param movie
     * @return
     */
    @RequestMapping(value="/save",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> save(Movie movie){
        return movieService.save(movie);
    }

    /**
     * 删除电影信息
     * @param id
     * @return
     */
    @RequestMapping(value="/delete",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> delete(String id){
        return movieService.delete(id);
    }


}
