package com.jjq.mapper;

import com.jjq.bean.User;

public interface UserMapper
{
    void insertUser(User user);

    void updatePassword(User user);

    void updateUserType(Integer userId);

    User selectUserByNameAndPassword(User user);

    boolean selectUserByName(String name);
}
