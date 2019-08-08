package com.jjq.controller;

import com.jjq.bean.AdminChat;
import com.jjq.bean.User;
import com.jjq.service.ChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/chat")
public class ChatController
{
    @Autowired
    ChatService chatService;

    /**
     * 获取未读信息总数
     * @param id 用户ID
     * @return 该用户未读信息
     */
    @RequestMapping("/getUnreadChatCount")
    @ResponseBody
    public Map<String, Object> getUnreadChatCount(Integer id)
    {
        Map<String, Object> map = new HashMap<>();
        map.put("unreadChatCount", chatService.selectAllUnreadChatCount(id));
        return map;
    }

    /**
     * @return 跳转到用户聊天界面
     */
    @RequestMapping("/userChat")
    public String userChat(Model model)
    {
        return "main/userChat";
    }

    /**
     * @param adminId 聊天的管理员的ID
     * @return 用户与管理员的聊天界面
     */
    @RequestMapping("/adminChatUser")
    public String adminChatUser(Model model, HttpSession session, Integer adminId)
    {
        User user = (User) session.getAttribute("user");
        model.addAttribute("chatList", chatService.selectAllAdminChatByUserAndAdminId(user.getId(), adminId, 0));
        return "main/adminChatUser";
    }

    /**
     * ajax请求新的聊天内容
     * @param userId 用户ID
     * @param adminId 管理员ID
     * @param chatId 以查找过的最后一条聊天记录的ID
     * @return 新的聊天记录
     */
    @RequestMapping("/newAdminChat")
    @ResponseBody
    public List<AdminChat> getNewAdminChat(Integer userId, Integer adminId, Integer chatId)
    {
        return chatService.selectAllAdminChatByUserAndAdminId(userId, adminId, chatId);
    }

    /**
     * ajax插入新的管理员聊天
     * @param userId 用户ID
     * @param adminId 管理员ID
     * @param content 聊天内容
     */
    @RequestMapping("/insertNewAdminChat")
    @ResponseBody
    public void insertNewAdminChatUser(Integer userId, Integer adminId, String content)
    {
        chatService.insertNewAdminChatByUser(userId, adminId, content);
    }
}
