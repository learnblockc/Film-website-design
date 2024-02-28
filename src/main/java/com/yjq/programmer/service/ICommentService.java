package com.yjq.programmer.service;

import com.yjq.programmer.domain.Comment;
import com.yjq.programmer.domain.Page;
import com.yjq.programmer.vo.ResponseVo;

import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */

public interface ICommentService {

    // 封装分页数据
    ResponseVo<Page> getPage(Page page, String name);

    // 获取评论列表数据
    ResponseVo<List<Comment>> list(String name, Page page);

    // 删除评论信息
    ResponseVo<Boolean> delete(String id);

    // 发表评论操作处理
    ResponseVo<Boolean> addComment(Comment comment);

    // 根据电影id获取所有评论
    ResponseVo<List<Comment>> getByMovieId(String movieId);

    // 获取评分的总数
    ResponseVo<Integer> getTotal();
}
