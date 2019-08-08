package com.jjq.service;

import com.jjq.bean.AdminChat;

import java.util.List;

public interface ChatService
{
    /**
     * 根据用户ID查询所有该用户收到的未读聊天数量
     * @param id 用户ID
     * @return 该用户收到的所有未读聊天的数量
     */
    Integer selectAllUnreadChatCount(Integer id);

    /**
     * 根据用户和管理员ID查询已查询聊天ID后的所有聊天
     * @param userId 用户ID
     * @param adminId 管理员ID
     * @param chatId 已查询的最后一条聊天的 ID
     * @return 返回符合条件的聊天内容
     */
    List<AdminChat> selectAllAdminChatByUserAndAdminId(Integer userId, Integer adminId, Integer chatId);

    /**
     * 根据用户ID查询收到管理员信息的最后一条
     * @param userId 用户ID
     * @return 该条聊天
     */
    List<AdminChat> selectAdminChatByUserId(Integer userId);

    /**
     * 根据管理员ID查询收到的用户聊天的最后一条
     * @param adminId 管理员ID
     * @return 该条信息
     */
    List<AdminChat> selectAdminChatByAdminId(Integer adminId);

    /**
     * 插入用户发送的聊天
     * @param userId 用户ID
     * @param adminId 管理员ID
     * @param content 内容
     */
    void insertNewAdminChatByUser(Integer userId, Integer adminId, String content);

    /**
     * 插入管理员送的聊天
     * @param userId 用户ID
     * @param adminId 管理员ID
     * @param content 内容
     */
    void insertNewAdminChatByAdmin(Integer userId, Integer adminId, String content);

    /**
     * 更新用户发给管理员的消息为已读
     * @param userId 用户ID
     * @param adminId 管理员ID
     */
    void updateAdminChatReadByAdmin(Integer userId, Integer adminId);

    /**
     * 更新管理员发给用户的消息为已读
     * @param userId 用户ID
     * @param adminId 管理员ID
     */
    void updateAdminChatReadByUser(Integer userId, Integer adminId);
}
