package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 商品总类（最大的分类）
 */

@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Type
{
    /** ID */
    private int id;
    /** 总类名称 */
    private String name;
    /** 所属基本分类 */
    private String basic;
}
