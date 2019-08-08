package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;

/**
 * 管理员日志
 */

@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class AdminLog
{
    /** 日志ID */
    private int id;
    /** 操作 */
    private String action;
    /** 时间 */
    private Timestamp time;
    /** 操作的管理员 */
    private Admin admin;
}
