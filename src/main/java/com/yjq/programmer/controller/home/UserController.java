package com.yjq.programmer.controller.home;

import com.yjq.programmer.constant.RuntimeConstant;
import com.yjq.programmer.domain.User;
import com.yjq.programmer.service.IOrderService;
import com.yjq.programmer.service.IUserService;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * @author WZX
 * @create 2023-03-20 8:58
 */
@Controller("HomeUserController")
@RequestMapping("/home/user")
public class UserController {

    @Resource
    private IUserService userService;

    @Resource
    private IOrderService orderService;

    /**
     * 用户登录/注册页面
     * @param model
     * @return
     */
    @RequestMapping(value="/login",method = RequestMethod.GET)
    public ModelAndView login(ModelAndView model){
        model.setViewName("home/user/login");
        return model;
    }

    /**
     * 用户登录操作处理
     * @param user
     * @param request
     * @return
     */
    @RequestMapping(value="/login",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> login(User user, HttpServletRequest request){
        return userService.homeLogin(user, request);
    }

    /**
     * 用户注册操作处理
     * @param user
     * @param request
     * @return
     */
    @RequestMapping(value="/register",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> register(User user, HttpServletRequest request){
        return userService.register(user, request);
    }


    /**
     * 用户个人中心页面
     * @param model
     * @return
     */
    @RequestMapping(value="/center",method = RequestMethod.GET)
    public ModelAndView center(ModelAndView model, HttpServletRequest request){
        User user = (User) request.getSession().getAttribute(RuntimeConstant.HOME_USER);
        model.addObject("orderList", orderService.getByUserId(user.getId()).getData());
        model.setViewName("home/user/center");
        return model;
    }

    /**
     * 退出登录操作处理
     * @param request
     * @return
     */
    @RequestMapping(value="/logout",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> logout(HttpServletRequest request){
        request.getSession().setAttribute(RuntimeConstant.HOME_USER, null);
        return ResponseVo.successByMsg(true, "退出登录成功！");
    }

    /**
     * 用户修改个人信息操作处理
     * @param user
     * @param request
     * @return
     */
    @RequestMapping(value="/save_info",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> saveUserInfo(User user, HttpServletRequest request){
        return userService.saveUserInfo(user, request);
    }
}
