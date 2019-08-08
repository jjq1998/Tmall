package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;

/**
 * 用户聊天记录
 */

@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class UserChat
{
    /** 聊天记录ID */
    private int id;
    /** 发送方用户 */
    private User sendUser;
    /** 接收方用户 */
    private User receiveUser;
    /** 聊天记录内容 */
    private String content;
    /** 聊天记录时间 */
    private Timestamp time;
    /** 聊天记录状态 */
    private String state;
}
