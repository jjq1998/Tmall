package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Brand
{
    /** 品牌ID */
    private int id;
    /** 品牌名 */
    private String name;
    /** 品牌图标 */
    private String image;
    /** 所属分类 */
    private String typeName;
}
