package com.yjq.programmer.service.impl;

import com.github.pagehelper.PageHelper;
import com.yjq.programmer.bean.CodeMsg;
import com.yjq.programmer.dao.RoleMapper;
import com.yjq.programmer.dao.UserMapper;
import com.yjq.programmer.domain.*;
import com.yjq.programmer.service.IRoleService;
import com.yjq.programmer.service.IUserService;
import com.yjq.programmer.util.CommonUtil;
import com.yjq.programmer.util.UuidUtil;
import com.yjq.programmer.util.ValidateEntityUtil;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
@Service
@Transactional
public class RoleServiceImpl implements IRoleService {

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private IUserService userService;

    @Resource
    private UserMapper userMapper;

    /**
     * 封装分页数据
     * @param page
     * @param name
     * @return
     */
    @Override
    public ResponseVo<Page> getPage(Page page, String name) {
        RoleExample roleExample = new RoleExample();
        roleExample.createCriteria().andNameLike('%'+name+'%');
        page.setTotalCount(roleMapper.countByExample(roleExample));
        return ResponseVo.success(page);
    }

    /**
     * 获取角色列表数据
     * @param name
     * @param page
     * @return
     */
    @Override
    public ResponseVo<List<Role>> list(String name, Page page) {
        RoleExample roleExample = new RoleExample();
        if(!CommonUtil.isEmpty(name)){
            // 进行了搜索
            roleExample.createCriteria().andNameLike('%' + name + '%');
        }
        PageHelper.startPage(page.getPage(), page.getRows());
        List<Role> userList = roleMapper.selectByExample(roleExample);
        return ResponseVo.success(userList);
    }

    /**
     * 获取所有角色数据
     * @return
     */
    @Override
    public ResponseVo<List<Role>> all() {
        return ResponseVo.success(roleMapper.selectByExample(new RoleExample()));
    }

    /**
     * 保存角色信息
     * @param role
     * @return
     */
    @Override
    public ResponseVo<Boolean> save(Role role) {
        if(role == null){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 进行统一表单验证
        CodeMsg validate = ValidateEntityUtil.validate(role);
        if (!validate.getCode().equals(CodeMsg.SUCCESS.getCode())) {
            return ResponseVo.errorByMsg(validate);
        }
        if(CommonUtil.isEmpty(role.getId())){
            // 添加操作
            // 判断角色名称是否存在
            if(isRoleNameExist(role, "")){
                return ResponseVo.errorByMsg(CodeMsg.ROLE_NAME_EXIST);
            }
            role.setId(UuidUtil.getShortUuid());
            if(roleMapper.insertSelective(role) == 0){
                return ResponseVo.errorByMsg(CodeMsg.ROLE_ADD_ERROR);
            }
        }else {
            // 修改操作
            // 判断角色名称是否存在
            if(isRoleNameExist(role, role.getId())){
                return ResponseVo.errorByMsg(CodeMsg.ROLE_NAME_EXIST);
            }
            if(roleMapper.updateByPrimaryKeySelective(role) == 0){
                return ResponseVo.errorByMsg(CodeMsg.ROLE_EDIT_ERROR);
            }
        }
        return ResponseVo.success(true);
    }

    /**
     * 删除角色信息
     * @param id
     * @return
     */
    @Override
    public ResponseVo<Boolean> delete(String id) {
        if(CommonUtil.isEmpty(id)){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 删除角色对应的用户信息
        UserExample userExample = new UserExample();
        userExample.createCriteria().andRoleIdEqualTo(id);
        List<User> userList = userMapper.selectByExample(userExample);
        for(User user : userList){
            userService.delete(user.getId());
        }
        // 删除角色信息
        if(roleMapper.deleteByPrimaryKey(id) == 0){
            return ResponseVo.errorByMsg(CodeMsg.ROLE_DELETE_ERROR);
        }
        return ResponseVo.success(true);
    }

    /**
     * 判断角色名称是否重复
     * @param role
     * @param id
     * @return
     */
    public Boolean isRoleNameExist(Role role, String id) {
        RoleExample roleExample = new RoleExample();
        roleExample.createCriteria().andNameEqualTo(role.getName());
        List<Role> selectedRoleList = roleMapper.selectByExample(roleExample);
        if(selectedRoleList != null && selectedRoleList.size() > 0) {
            if(selectedRoleList.size() > 1){
                return true; //出现重名
            }
            if(!selectedRoleList.get(0).getId().equals(id)) {
                return true; //出现重名
            }
        }
        return false;//没有重名
    }
}
