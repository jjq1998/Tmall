package com.jjq.mapper;

import com.jjq.bean.AdminLog;

import java.util.List;

public interface AdminLogMapper
{
    List<AdminLog> selectAllAdminLog(Integer page);

    void insertAdminLog(AdminLog adminLog);

    Integer selectAllAdminLogCount();
}
