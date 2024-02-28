package com.yjq.programmer.controller.admin;

import com.yjq.programmer.domain.Comment;
import com.yjq.programmer.domain.Page;
import com.yjq.programmer.service.ICommentService;
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
 * @create 2023-03-25 11:13
 */
@Controller("AdminCommentController")
@RequestMapping("/admin/comment")
public class CommentController {

    @Resource
    private ICommentService commentService;

    /**
     * 评论列表页面
     * @param model
     * @return
     */
    @RequestMapping(value="/index",method = RequestMethod.GET)
    public ModelAndView index(ModelAndView model){
        model.addObject("firstMenu", "comment");
        model.addObject("secondMenu", "comment-index");
        model.addObject("Page", commentService.getPage(new Page(), "").getData());
        model.setViewName("admin/comment/index");
        return model;
    }

    /**
     * 评论列表数据获取
     * @param name
     * @param page
     * @return
     */
    @RequestMapping(value="/list",method = RequestMethod.POST)
    @ResponseBody
    public List<Comment> list(String name, Page page){
        return commentService.list(name, page).getData();
    }

    /**
     * 封装分页数据
     * @return
     */
    @RequestMapping(value="/page",method = RequestMethod.POST)
    @ResponseBody
    public Page page(Page page, String name){
        return commentService.getPage(page, name).getData();
    }

    /**
     * 删除评论信息
     * @param id
     * @return
     */
    @RequestMapping(value="/delete",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> delete(String id){
        return commentService.delete(id);
    }

}
