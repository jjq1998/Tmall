package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;

/**
 * 管理员聊天记录
 */

@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class AdminChat
{
    /** 聊天记录ID */
    private int id;
    /** 参与聊天的用户 */
    private User user;
    /** 参与聊天的管理员 */
    private Admin admin;
    /** 聊天内容 */
    private String content;
    /** 聊天记录时间 */
    private Timestamp time;
    /** 聊天记录状态 */
    private String state;
    /** 谁发的消息 */
    private String sender;
}
