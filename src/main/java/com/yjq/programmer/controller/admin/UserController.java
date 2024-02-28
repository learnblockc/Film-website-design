package com.yjq.programmer.controller.admin;

import com.yjq.programmer.constant.RuntimeConstant;
import com.yjq.programmer.domain.Page;
import com.yjq.programmer.domain.User;
import com.yjq.programmer.service.IRoleService;
import com.yjq.programmer.service.IUserService;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author WZX
 * @create 2023-03-16 19:05
 */
@Controller("AdminUserController")
@RequestMapping("/admin/user")
public class UserController {

    @Resource
    private IUserService userService;

    @Resource
    private IRoleService roleService;

    /**
     * 用户登录页面
     * @param model
     * @return
     */
    @RequestMapping(value="/login",method = RequestMethod.GET)
    public ModelAndView login(ModelAndView model){
        model.setViewName("admin/user/login");
        return model;
    }

    /**
     * 用户列表页面
     * @param model
     * @return
     */
    @RequestMapping(value="/index",method = RequestMethod.GET)
    public ModelAndView index(ModelAndView model){
        model.addObject("firstMenu", "user");
        model.addObject("secondMenu", "user-index");
        model.addObject("Page", userService.getPage(new Page(), "").getData());
        model.addObject("roleList", roleService.all().getData());
        model.setViewName("admin/user/index");
        return model;
    }

    /**
     * 用户列表数据获取
     * @param name
     * @param page
     * @return
     */
    @RequestMapping(value="/list",method = RequestMethod.POST)
    @ResponseBody
    public List<User> list(String name, Page page){
        return userService.list(name, page).getData();
    }

    /**
     * 封装分页数据
     * @return
     */
    @RequestMapping(value="/page",method = RequestMethod.POST)
    @ResponseBody
    public Page page(Page page, String name){
        return userService.getPage(page, name).getData();
    }

    /**
     * 保存用户信息
     * @param user
     * @return
     */
    @RequestMapping(value="/save",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> save(User user){
        return userService.save(user);
    }

    /**
     * 删除用户信息
     * @param id
     * @return
     */
    @RequestMapping(value="/delete",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> delete(String id){
        return userService.delete(id);
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
        return userService.adminLogin(user, request);
    }

    /**
     * 退出登录操作处理
     * @param request
     * @return
     */
    @RequestMapping(value="/logout",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> logout(HttpServletRequest request){
        request.getSession().setAttribute(RuntimeConstant.ADMIN_USER, null);
        return ResponseVo.successByMsg(true, "退出登录成功！");
    }
}
