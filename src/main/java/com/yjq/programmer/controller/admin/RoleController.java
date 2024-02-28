package com.yjq.programmer.controller.admin;

import com.yjq.programmer.domain.Page;
import com.yjq.programmer.domain.Role;
import com.yjq.programmer.service.IRoleService;
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
 * @create 2023-03-19 15:14
 */
@Controller("AdminRoleController")
@RequestMapping("/admin/role")
public class RoleController {

    @Resource
    private IRoleService roleService;

    /**
     * 角色列表页面
     * @param model
     * @return
     */
    @RequestMapping(value="/index",method = RequestMethod.GET)
    public ModelAndView index(ModelAndView model){
        model.addObject("firstMenu", "role");
        model.addObject("secondMenu", "role-index");
        model.addObject("Page", roleService.getPage(new Page(), "").getData());
        model.setViewName("admin/role/index");
        return model;
    }

    /**
     * 角色列表数据获取
     * @param name
     * @param page
     * @return
     */
    @RequestMapping(value="/list",method = RequestMethod.POST)
    @ResponseBody
    public List<Role> list(String name, Page page){
        return roleService.list(name, page).getData();
    }

    /**
     * 封装分页数据
     * @return
     */
    @RequestMapping(value="/page",method = RequestMethod.POST)
    @ResponseBody
    public Page page(Page page, String name){
        return roleService.getPage(page, name).getData();
    }

    /**
     * 保存角色信息
     * @param role
     * @return
     */
    @RequestMapping(value="/save",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> save(Role role){
        return roleService.save(role);
    }

    /**
     * 删除角色信息
     * @param id
     * @return
     */
    @RequestMapping(value="/delete",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> delete(String id){
        return roleService.delete(id);
    }
}
