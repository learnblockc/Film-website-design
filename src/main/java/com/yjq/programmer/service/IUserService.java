package com.yjq.programmer.service;

import com.yjq.programmer.domain.Page;
import com.yjq.programmer.domain.User;
import com.yjq.programmer.vo.ResponseVo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
public interface IUserService {

    // 封装分页数据
    ResponseVo<Page> getPage(Page page, String name);

    // 获取用户列表数据
    ResponseVo<List<User>> list(String name, Page page);

    // 保存用户信息
    ResponseVo<Boolean> save(User user);

    // 获取用户的总数
    ResponseVo<Integer> getTotal();

    // 删除用户信息
    ResponseVo<Boolean> delete(String id);

    // 前台用户登录操作处理
    ResponseVo<Boolean> homeLogin(User user, HttpServletRequest request);

    // 后台用户登录操作处理
    ResponseVo<Boolean> adminLogin(User user, HttpServletRequest request);

    // 用户注册操作处理
    ResponseVo<Boolean> register(User user, HttpServletRequest request);

    // 用户修改个人信息操作处理
    ResponseVo<Boolean> saveUserInfo(User user, HttpServletRequest request);

}
