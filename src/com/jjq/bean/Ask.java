package com.jjq.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Repository;

/**
 * 申请
 */

@Repository
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Ask
{
    /** 申请ID */
    private int id;
    /** 申请的店铺 */
    private Shop shop;
    /** 申请的用户 */
    private User user;
    /** 申请的种类 */
    private String type;
    /** 申请材料 */
    private String content;
    /** 申请状态 */
    private String state;
    /** 审批人 */
    private String admin;
    /** 申请的品牌名 */
    private String brandName;
    /** 申请的品牌所属分类 */
    private String brandType;
    /** 申请的品牌图标 */
    private String brandImage;
}
