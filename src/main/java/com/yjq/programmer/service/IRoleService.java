package com.yjq.programmer.service;

import com.yjq.programmer.domain.Page;
import com.yjq.programmer.domain.Role;
import com.yjq.programmer.vo.ResponseVo;

import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
public interface IRoleService {

    // 封装分页数据
    ResponseVo<Page> getPage(Page page, String name);

    // 获取角色列表数据
    ResponseVo<List<Role>> list(String name, Page page);

    // 获取所有角色数据
    ResponseVo<List<Role>> all();

    // 保存角色信息
    ResponseVo<Boolean> save(Role role);

    // 删除角色信息
    ResponseVo<Boolean> delete(String id);
}
