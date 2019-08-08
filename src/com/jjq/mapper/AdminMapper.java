package com.jjq.mapper;

import com.jjq.bean.Admin;

import java.util.List;

public interface AdminMapper
{
    void insertAdmin(Admin admin);

    void deleteAdmin(int id);

    void updateAdmin(Admin admin);

    Admin selectAdminByNameAndPassword(String name, String password);

    List<Admin> selectAllAdmin(Integer page);

    Integer selectAllAdminCount();

    boolean selectAdminByName(String name);
}
