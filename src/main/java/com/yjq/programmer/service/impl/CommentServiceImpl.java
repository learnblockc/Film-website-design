package com.yjq.programmer.service.impl;

import com.github.pagehelper.PageHelper;
import com.yjq.programmer.bean.CodeMsg;
import com.yjq.programmer.dao.CommentMapper;
import com.yjq.programmer.dao.MovieMapper;
import com.yjq.programmer.dao.UserMapper;
import com.yjq.programmer.domain.*;
import com.yjq.programmer.service.ICommentService;
import com.yjq.programmer.util.CommonUtil;
import com.yjq.programmer.util.UuidUtil;
import com.yjq.programmer.util.ValidateEntityUtil;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
@Service
@Transactional
public class CommentServiceImpl implements ICommentService {

    @Resource
    private CommentMapper commentMapper;

    @Resource
    private UserMapper userMapper;

    @Resource
    private MovieMapper movieMapper;

    /**
     * 封装分页数据
     * @param page
     * @param name
     * @return
     */
    @Override
    public ResponseVo<Page> getPage(Page page, String name) {
        CommentExample commentExample = new CommentExample();
        commentExample.createCriteria().andContentLike('%'+name+'%');
        page.setTotalCount(commentMapper.countByExample(commentExample));
        return ResponseVo.success(page);
    }

    /**
     * 获取评论列表数据
     * @param name
     * @param page
     * @return
     */
    @Override
    public ResponseVo<List<Comment>> list(String name, Page page) {
        CommentExample commentExample = new CommentExample();
        if(!CommonUtil.isEmpty(name)){
            // 进行了搜索
            commentExample.createCriteria().andContentLike('%' + name + '%');
        }
        PageHelper.startPage(page.getPage(), page.getRows());
        List<Comment> commentList = commentMapper.selectByExample(commentExample);
        for(Comment comment : commentList){
            User user = userMapper.selectByPrimaryKey(comment.getUserId());
            comment.setUser(user);
            Movie movie = movieMapper.selectByPrimaryKey(comment.getMovieId());
            comment.setMovie(movie);
        }
        return ResponseVo.success(commentList);
    }

    /**
     * 删除评论信息
     * @param id
     * @return
     */
    @Override
    public ResponseVo<Boolean> delete(String id) {
        if(CommonUtil.isEmpty(id)){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        if(commentMapper.deleteByPrimaryKey(id) == 0){
            return ResponseVo.errorByMsg(CodeMsg.COMMENT_DELETE_ERROR);
        }
        return ResponseVo.success(true);
    }

    /**
     * 发表评论操作处理
     * @param comment
     * @return
     */
    @Override
    public ResponseVo<Boolean> addComment(Comment comment) {
        if(comment == null){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 进行统一表单验证
        CodeMsg validate = ValidateEntityUtil.validate(comment);
        if (!validate.getCode().equals(CodeMsg.SUCCESS.getCode())) {
            return ResponseVo.errorByMsg(validate);
        }
        comment.setId(UuidUtil.getShortUuid());
        comment.setCreateTime(new Date());
        if(commentMapper.insertSelective(comment) == 0){
            return ResponseVo.errorByMsg(CodeMsg.COMMENT_ADD_ERROR);
        }
        return ResponseVo.successByMsg(true, "发表评论成功！");
    }

    /**
     * 根据电影id获取所有评论
     * @param movieId
     * @return
     */
    @Override
    public ResponseVo<List<Comment>> getByMovieId(String movieId) {
        CommentExample commentExample = new CommentExample();
        commentExample.createCriteria().andMovieIdEqualTo(movieId);
        commentExample.setOrderByClause("create_time desc");
        List<Comment> commentList = commentMapper.selectByExample(commentExample);
        for(Comment comment : commentList){
            User user = userMapper.selectByPrimaryKey(comment.getUserId());
            comment.setUser(user);
            Movie movie = movieMapper.selectByPrimaryKey(comment.getMovieId());
            comment.setMovie(movie);
        }
        return ResponseVo.success(commentList);
    }

    /**
     * 获取评论的总数
     * @return
     */
    @Override
    public ResponseVo<Integer> getTotal() {
        return ResponseVo.success(commentMapper.countByExample(new CommentExample()));
    }
}
