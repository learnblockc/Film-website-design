package com.yjq.programmer.controller.admin;

import com.yjq.programmer.domain.Cinema;
import com.yjq.programmer.domain.Page;
import com.yjq.programmer.service.ICinemaService;
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
 * @create 2023-03-17 13:47
 */
@Controller("AdminCinemaController")
@RequestMapping("/admin/cinema")
public class CinemaController {

    @Resource
    private ICinemaService cinemaService;

    /**
     * 电影院列表页面
     * @param model
     * @return
     */
    @RequestMapping(value="/index",method = RequestMethod.GET)
    public ModelAndView index(ModelAndView model){
        model.addObject("firstMenu", "cinema");
        model.addObject("secondMenu", "cinema-index");
        model.addObject("Page", cinemaService.getPage(new Page(), "").getData());
        model.setViewName("admin/cinema/index");
        return model;
    }

    /**
     * 电影院列表数据获取
     * @param name
     * @param page
     * @return
     */
    @RequestMapping(value="/list",method = RequestMethod.POST)
    @ResponseBody
    public List<Cinema> list(String name, Page page){
        return cinemaService.list(name, page).getData();
    }

    /**
     * 封装分页数据
     * @return
     */
    @RequestMapping(value="/page",method = RequestMethod.POST)
    @ResponseBody
    public Page page(Page page, String name){
        return cinemaService.getPage(page, name).getData();
    }

    /**
     * 保存电影院信息
     * @param cinema
     * @return
     */
    @RequestMapping(value="/save",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> save(Cinema cinema){
        return cinemaService.save(cinema);
    }

    /**
     * 删除电影院信息
     * @param id
     * @return
     */
    @RequestMapping(value="/delete",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> delete(String id){
        return cinemaService.delete(id);
    }

}
