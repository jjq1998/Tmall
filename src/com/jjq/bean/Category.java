package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 大概类别（中间）
 */
@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Category
{
    /** ID */
    private int id;
    /** 类别名 */
    private String name;
    /** 所属一级分类名称 */
    private String typeName;
}
