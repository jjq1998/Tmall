package com.jjq.service.impl;

import com.jjq.bean.AdminLog;
import com.jjq.mapper.AdminLogMapper;
import com.jjq.service.AdminLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminLogServiceImpl implements AdminLogService
{
    @Autowired
    AdminLogMapper adminLogMapper;

    @Override
    public List<AdminLog> selectAllAdminLog(Integer page)
    {
        return adminLogMapper.selectAllAdminLog(page);
    }

    @Override
    public void insertAdminLog(AdminLog adminLog)
    {
        adminLogMapper.insertAdminLog(adminLog);
    }

    @Override
    public Integer selectAllAdminLogCount()
    {
        return adminLogMapper.selectAllAdminLogCount();
    }
}
