package com.yjq.programmer.controller.home;

import com.yjq.programmer.constant.RuntimeConstant;
import com.yjq.programmer.domain.Comment;
import com.yjq.programmer.domain.User;
import com.yjq.programmer.service.ICommentService;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
@Controller("HomeCommentController")
@RequestMapping("/home/comment")
public class CommentController {

    @Resource
    private ICommentService commentService;

    /**
     * 发布评论操作处理
     * @param comment
     * @param request
     * @return
     */
    @RequestMapping(value="/add",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> addComment(Comment comment, HttpServletRequest request){
        User user = (User) request.getSession().getAttribute(RuntimeConstant.HOME_USER);
        comment.setUserId(user.getId());
        return commentService.addComment(comment);
    }


}
