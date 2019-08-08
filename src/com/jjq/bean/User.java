package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

/**
 * 用户
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Repository
public class User
{
    /** 用户ID */
    private int id;
    /** 用户名 */
    private String name;
    /** 用户密码 */
    private String password;
    /** 用户类型 */
    private String type;
    /** 用户级别 */
    private int level;
}
