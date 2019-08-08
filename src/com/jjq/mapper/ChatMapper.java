package com.jjq.mapper;

import com.jjq.bean.AdminChat;

import java.util.List;

public interface ChatMapper
{
    Integer selectAllUnreadChatCount(Integer id);

    List<AdminChat> selectAllAdminChatByUserAndAdminId(Integer userId, Integer adminId, Integer chatId);

    List<AdminChat> selectAdminChatByUserId(Integer userId);

    List<AdminChat> selectAdminChatByAdminId(Integer adminId);

    void insertNewAdminChatByUser(Integer userId, Integer adminId, String content);

    void insertNewAdminChatByAdmin(Integer userId, Integer adminId, String content);

    void updateAdminChatReadByAdmin(Integer userId, Integer adminId);

    void updateAdminChatReadByUser(Integer userId, Integer adminId);
}
