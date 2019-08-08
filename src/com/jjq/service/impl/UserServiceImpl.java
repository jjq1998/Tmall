package com.jjq.service.impl;

import com.jjq.bean.User;
import com.jjq.mapper.UserMapper;
import com.jjq.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService
{
    @Autowired
    UserMapper userMapper;

    @Override
    public void insertUser(User user)
    {
        userMapper.insertUser(user);
    }

    @Override
    public void updatePassword(User user)
    {
        userMapper.updatePassword(user);
    }

    @Override
    public void updateUserType(Integer userId)
    {
        userMapper.updateUserType(userId);
    }

    @Override
    public User selectUserByNameAndPassword(User user)
    {
        return userMapper.selectUserByNameAndPassword(user);
    }

    @Override
    public boolean selectUserByName(String name)
    {
        return userMapper.selectUserByName(name);
    }
}
