package com.jjq.service;

import com.jjq.bean.Admin;

import java.util.List;

public interface AdminService
{
    /**
     * 注册
     * 添加新管理员
     * @param admin 管理员
     */
    void insertAdmin(Admin admin);

    /**
     * 删除管理员
     * @param id 管理员ID
     */
    void deleteAdmin(int id);

    /**
     * 修改密码
     * 更改管理员密码
     * @param admin 管理员
     */
    void updateAdmin(Admin admin);

    /**
     * 登录
     * 根据管理员账户和密码查询管理员
     * @param name
     * @param password
     * @return
     */
    Admin selectAdminByNameAndPassword(String name, String password);

    /**
     * 分页查询所有管理员
     * @param page 当前页数
     * @return 该页所有管理员
     */
    List<Admin> selectAllAdmin(Integer page);

    /**
     * 查询所有管理员数目
     * @return 管理员数目
     */
    Integer selectAllAdminCount();

    /**
     * 注册时查重
     * 根据用户名查询管理员
     * @param name 管理员账户
     * @return 存在返回true 否则返回false
     */
    boolean selectAdminByName(String name);
}
