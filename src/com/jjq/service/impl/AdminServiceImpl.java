package com.jjq.service.impl;

import com.jjq.bean.Admin;
import com.jjq.mapper.AdminMapper;
import com.jjq.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService
{
    @Autowired
    AdminMapper adminMapper;

    @Override
    public void insertAdmin(Admin admin)
    {
        adminMapper.insertAdmin(admin);
    }

    @Override
    public void deleteAdmin(int id)
    {
        adminMapper.deleteAdmin(id);
    }

    @Override
    public void updateAdmin(Admin admin)
    {
        adminMapper.updateAdmin(admin);
    }

    @Override
    public Admin selectAdminByNameAndPassword(String name, String password)
    {
        return adminMapper.selectAdminByNameAndPassword(name, password);
    }

    @Override
    public List<Admin> selectAllAdmin(Integer page)
    {
        return adminMapper.selectAllAdmin(page);
    }

    @Override
    public Integer selectAllAdminCount()
    {
        return adminMapper.selectAllAdminCount();
    }

    @Override
    public boolean selectAdminByName(String name)
    {
        return adminMapper.selectAdminByName(name);
    }
}
