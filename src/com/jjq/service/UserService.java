package com.jjq.service;

import com.jjq.bean.User;

public interface UserService
{
    /**
     * 注册
     * 添加用户
     * @param user 用户
     */
    void insertUser(User user);

    /**
     * 修改密码
     * 更改用户密码
     * @param user 用户
     */
    void updatePassword(User user);

    void updateUserType(Integer userId);

    /**
     * 登录
     * 根据用户名和密码查询用户
     * @param user 用户
     * @return 当前用户
     */
    User selectUserByNameAndPassword(User user);

    /**
     * 注册时查重
     * @param name 根据用户名查询用户
     * @return 存在返回true 否则返回false
     */
    boolean selectUserByName(String name);
}
