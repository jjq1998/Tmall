package com.jjq.service.impl;

import com.jjq.bean.AdminChat;
import com.jjq.mapper.ChatMapper;
import com.jjq.service.ChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChatServiceImpl implements ChatService
{
    @Autowired
    ChatMapper chatMapper;

    @Override
    public Integer selectAllUnreadChatCount(Integer id)
    {
        return chatMapper.selectAllUnreadChatCount(id);
    }

    @Override
    public List<AdminChat> selectAllAdminChatByUserAndAdminId(Integer userId, Integer adminId, Integer chatId)
    {
        return chatMapper.selectAllAdminChatByUserAndAdminId(userId, adminId, chatId);
    }

    @Override
    public List<AdminChat> selectAdminChatByUserId(Integer userId)
    {
        return chatMapper.selectAdminChatByUserId(userId);
    }

    @Override
    public List<AdminChat> selectAdminChatByAdminId(Integer adminId)
    {
        return chatMapper.selectAdminChatByAdminId(adminId);
    }

    @Override
    public void insertNewAdminChatByUser(Integer userId, Integer adminId, String content)
    {
        chatMapper.insertNewAdminChatByUser(userId, adminId, content);
    }

    @Override
    public void insertNewAdminChatByAdmin(Integer userId, Integer adminId, String content)
    {
        chatMapper.insertNewAdminChatByAdmin(userId, adminId, content);
    }

    @Override
    public void updateAdminChatReadByAdmin(Integer userId, Integer adminId)
    {
        chatMapper.updateAdminChatReadByAdmin(userId, adminId);
    }

    @Override
    public void updateAdminChatReadByUser(Integer userId, Integer adminId)
    {
        chatMapper.updateAdminChatReadByUser(userId, adminId);
    }
}
