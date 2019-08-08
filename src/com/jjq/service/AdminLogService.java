package com.jjq.service;

import com.jjq.bean.AdminLog;

import java.util.List;

public interface AdminLogService
{
    /**
     * 分页查询所有管理员操作日志
     * @param page 当前页数
     * @return 该页所有的操作日志
     */
    List<AdminLog> selectAllAdminLog(Integer page);

    /**
     * 插入管理员日志
     * @param adminLog 管理员日志
     */
    void insertAdminLog(AdminLog adminLog);

    /**
     * 查询所有管理员日志数目
     * @return 管理员日志数目
     */
    Integer selectAllAdminLogCount();
}
