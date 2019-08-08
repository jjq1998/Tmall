package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 商品分类（具体类别）
 */

@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class GoodsType
{
    /** ID */
    private int id;
    /** 分类名称 */
    private String name;
    /** 所属二级分类名称 */
    private String categoryName;
}
