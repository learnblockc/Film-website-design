package com.yjq.programmer.service.impl;

import com.github.pagehelper.PageHelper;
import com.yjq.programmer.bean.CodeMsg;
import com.yjq.programmer.constant.RuntimeConstant;
import com.yjq.programmer.dao.*;
import com.yjq.programmer.domain.*;
import com.yjq.programmer.enums.RoleEnum;
import com.yjq.programmer.service.*;
import com.yjq.programmer.util.CommonUtil;
import com.yjq.programmer.util.UuidUtil;
import com.yjq.programmer.util.ValidateEntityUtil;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
@Service
@Transactional
public class UserServiceImpl implements IUserService {

    @Resource
    private UserMapper userMapper;

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private CommentMapper commentMapper;

    @Resource
    private IOrderService orderService;

    @Resource
    private OrderMapper orderMapper;

    @Resource
    private IRateService rateService;

    @Resource
    private RateMapper rateMapper;

    /**
     * 封装分页数据
     * @param page
     * @param name
     * @return
     */
    @Override
    public ResponseVo<Page> getPage(Page page, String name) {
        UserExample userExample = new UserExample();
        userExample.createCriteria().andUsernameLike('%'+name+'%');
        page.setTotalCount(userMapper.countByExample(userExample));
        return ResponseVo.success(page);
    }

    /**
     * 获取用户列表数据
     * @param name
     * @param page
     * @return
     */
    @Override
    public ResponseVo<List<User>> list(String name, Page page) {
        UserExample userExample = new UserExample();
        if(!CommonUtil.isEmpty(name)){
            // 进行了搜索
            userExample.createCriteria().andUsernameLike('%' + name + '%');
        }
        PageHelper.startPage(page.getPage(), page.getRows());
        List<User> userList = userMapper.selectByExample(userExample);
        for(User u : userList){
            Role role = roleMapper.selectByPrimaryKey(u.getRoleId());
            u.setRole(role);
        }
        return ResponseVo.success(userList);
    }

    /**
     * 保存用户信息
     * @param user
     * @return
     */
    @Override
    public ResponseVo<Boolean> save(User user) {
        if(user == null){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 进行统一表单验证
        CodeMsg validate = ValidateEntityUtil.validate(user);
        if (!validate.getCode().equals(CodeMsg.SUCCESS.getCode())) {
            return ResponseVo.errorByMsg(validate);
        }
        if(CommonUtil.isEmpty(user.getId())){
            // 添加操作
            // 判断用户昵称是否存在
            if(isUsernameExist(user, "")){
                return ResponseVo.errorByMsg(CodeMsg.USERNAME_EXIST);
            }
            user.setId(UuidUtil.getShortUuid());
            user.setLoginTime(new Date());
            if(userMapper.insertSelective(user) == 0){
                return ResponseVo.errorByMsg(CodeMsg.USER_ADD_ERROR);
            }
        }else {
            // 修改操作
            // 判断用户昵称是否存在
            if(isUsernameExist(user, user.getId())){
                return ResponseVo.errorByMsg(CodeMsg.USERNAME_EXIST);
            }
            if(userMapper.updateByPrimaryKeySelective(user) == 0){
                return ResponseVo.errorByMsg(CodeMsg.USER_EDIT_ERROR);
            }
        }
        return ResponseVo.success(true);
    }

    /**
     * 获取用户的总数
     * @return
     */
    @Override
    public ResponseVo<Integer> getTotal() {
        return ResponseVo.success(userMapper.countByExample(new UserExample()));
    }

    /**
     * 删除用户信息
     * @param id
     * @return
     */
    @Override
    public ResponseVo<Boolean> delete(String id) {
        if(CommonUtil.isEmpty(id)){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 删除评论信息
        CommentExample commentExample = new CommentExample();
        commentExample.createCriteria().andUserIdEqualTo(id);
        commentMapper.deleteByExample(commentExample);
        // 删除订单信息
        OrderExample orderExample = new OrderExample();
        orderExample.createCriteria().andUserIdEqualTo(id);
        List<Order> orderList = orderMapper.selectByExample(orderExample);
        for(Order order : orderList){
            orderService.delete(order.getId());
        }
        // 删除评分信息
        RateExample rateExample = new RateExample();
        rateExample.createCriteria().andUserIdEqualTo(id);
        rateMapper.deleteByExample(rateExample);
        rateService.sumRateAndCount();
        // 删除用户信息
        if(userMapper.deleteByPrimaryKey(id) == 0){
            return ResponseVo.errorByMsg(CodeMsg.USER_DELETE_ERROR);
        }
        return ResponseVo.success(true);
    }

    /**
     * 前台用户登录操作处理
     * @param user
     * @param request
     * @return
     */
    @Override
    public ResponseVo<Boolean> homeLogin(User user, HttpServletRequest request) {
        if(user == null){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        if(CommonUtil.isEmpty(user.getUsername())){
            return ResponseVo.errorByMsg(CodeMsg.USERNAME_EMPTY);
        }
        if(CommonUtil.isEmpty(user.getPassword())){
            return ResponseVo.errorByMsg(CodeMsg.PASSWORD_EMPTY);
        }
        // 验证验证码输入是否正确
        String correctCaptcha = (String) request.getSession().getAttribute("home_login");
        if(CommonUtil.isEmpty(correctCaptcha)){
            return ResponseVo.errorByMsg(CodeMsg.CAPTCHA_EXPIRED);
        }
        if(!(correctCaptcha.toLowerCase()).equals(user.getCaptcha().toLowerCase())){
            return ResponseVo.errorByMsg(CodeMsg.CAPTCHA_ERROR);
        }
        // 验证用户昵称和密码是否正确
        UserExample userExample = new UserExample();
        userExample.createCriteria().andUsernameEqualTo(user.getUsername()).andPasswordEqualTo(user.getPassword());
        List<User> userList = userMapper.selectByExample(userExample);
        if(userList == null || userList.size() != 1){
            return ResponseVo.errorByMsg(CodeMsg.USERNAME_PASSWORD_ERROR);
        }
        User loginUser = userList.get(0);
        loginUser.setLoginTime(new Date());
        userMapper.updateByPrimaryKeySelective(loginUser);
        request.getSession().setAttribute(RuntimeConstant.HOME_USER, loginUser);
        return ResponseVo.successByMsg(true, "登录成功！");
    }

    /**
     * 后台用户登录
     * @param user
     * @param request
     * @return
     */
    @Override
    public ResponseVo<Boolean> adminLogin(User user, HttpServletRequest request) {
        if(user == null){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        if(CommonUtil.isEmpty(user.getUsername())){
            return ResponseVo.errorByMsg(CodeMsg.USERNAME_EMPTY);
        }
        if(CommonUtil.isEmpty(user.getPassword())){
            return ResponseVo.errorByMsg(CodeMsg.PASSWORD_EMPTY);
        }
        // 验证验证码输入是否正确
        String correctCaptcha = (String) request.getSession().getAttribute("admin_login");
        if(CommonUtil.isEmpty(correctCaptcha)){
            return ResponseVo.errorByMsg(CodeMsg.CAPTCHA_EXPIRED);
        }
        if(!(correctCaptcha.toLowerCase()).equals(user.getCaptcha().toLowerCase())){
            return ResponseVo.errorByMsg(CodeMsg.CAPTCHA_ERROR);
        }
        // 验证用户昵称和密码是否正确
        UserExample userExample = new UserExample();
        userExample.createCriteria().andUsernameEqualTo(user.getUsername())
                .andPasswordEqualTo(user.getPassword())
                .andRoleIdEqualTo(RoleEnum.ADMIN.getCode());
        List<User> userList = userMapper.selectByExample(userExample);
        if(userList == null || userList.size() != 1){
            return ResponseVo.errorByMsg(CodeMsg.USERNAME_PASSWORD_ERROR);
        }
        User loginUser = userList.get(0);
        loginUser.setLoginTime(new Date());
        userMapper.updateByPrimaryKeySelective(loginUser);
        request.getSession().setAttribute(RuntimeConstant.ADMIN_USER, loginUser);
        return ResponseVo.successByMsg(true, "登录成功！");
    }

    /**
     * 用户注册操作处理
     * @param user
     * @param request
     * @return
     */
    @Override
    public ResponseVo<Boolean> register(User user, HttpServletRequest request) {
        if(user == null){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        if(CommonUtil.isEmpty(user.getUsername())){
            return ResponseVo.errorByMsg(CodeMsg.USERNAME_EMPTY);
        }
        if(CommonUtil.isEmpty(user.getPassword())){
            return ResponseVo.errorByMsg(CodeMsg.PASSWORD_EMPTY);
        }
        if(CommonUtil.isEmpty(user.getRePassword())){
            return ResponseVo.errorByMsg(CodeMsg.REPASSWORD_EMPTY);
        }
        if(CommonUtil.isEmpty(user.getPhone()) || user.getPhone().length() != 11){
            return ResponseVo.errorByMsg(CodeMsg.USER_PHONE_ERROR);
        }
        if(!user.getPassword().equals(user.getRePassword())){
            return ResponseVo.errorByMsg(CodeMsg.REPASSWORD_ERROR);
        }
        // 验证验证码输入是否正确
        String correctCaptcha = (String) request.getSession().getAttribute("home_register");
        if(CommonUtil.isEmpty(correctCaptcha)){
            return ResponseVo.errorByMsg(CodeMsg.CAPTCHA_EXPIRED);
        }
        if(!(correctCaptcha.toLowerCase()).equals(user.getCaptcha().toLowerCase())){
            return ResponseVo.errorByMsg(CodeMsg.CAPTCHA_ERROR);
        }
        // 判断用户昵称是否重复
        if(isUsernameExist(user, "")){
            return ResponseVo.errorByMsg(CodeMsg.USERNAME_EXIST);
        }
        user.setId(UuidUtil.getShortUuid());
        user.setLoginTime(new Date());
        user.setRoleId(RoleEnum.USER.getCode());
        if(userMapper.insertSelective(user) == 0){
            return ResponseVo.errorByMsg(CodeMsg.USER_REGISTER_ERROR);
        }
        return ResponseVo.successByMsg(true, "注册成功，快去登录体验吧！");
    }

    /**
     * 用户修改个人信息操作处理
     * @param user
     * @return
     */
    @Override
    public ResponseVo<Boolean> saveUserInfo(User user, HttpServletRequest request) {
        if(user == null){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        if(userMapper.updateByPrimaryKeySelective(user) == 0){
            return ResponseVo.errorByMsg(CodeMsg.SAVE_USER_INFO_ERROR);
        }
        User newUser = userMapper.selectByPrimaryKey(user.getId());
        request.getSession().setAttribute(RuntimeConstant.HOME_USER, newUser);
        return ResponseVo.successByMsg(true, "保存用户个人信息成功！");
    }


    /**
     * 判断用户昵称是否重复
     * @param user
     * @param id
     * @return
     */
    public Boolean isUsernameExist(User user, String id) {
        UserExample userExample = new UserExample();
        userExample.createCriteria().andUsernameEqualTo(user.getUsername());
        List<User> selectedUserList = userMapper.selectByExample(userExample);
        if(selectedUserList != null && selectedUserList.size() > 0) {
            if(selectedUserList.size() > 1){
                return true; //出现重名
            }
            if(!selectedUserList.get(0).getId().equals(id)) {
                return true; //出现重名
            }
        }
        return false;//没有重名
    }
}
