package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

/**
 * 用户搜索表
 */

@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Search
{
    /** 搜索ID */
    private int id;
    /** 用户ID */
    private int userId;
    /** 搜索内容 */
    private String content;
}
