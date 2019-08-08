package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

/**
 * 管理员
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Repository
public class Admin
{
    /** 管理员ID */
    private int id;
    /** 管理员账户 */
    private String name;
    /** 管理员密码 */
    private String password;
    /** 管理员权限 */
    private String permission;
}
