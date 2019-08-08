package com.jjq.service;

import com.jjq.bean.Search;

import java.util.List;

public interface SearchService
{
    /**
     * 查询该用户最近的十条搜索历史
     * @param userId 用户ID
     * @return 该用户最近十条搜索历史
     */
    List<Search> selectAllSearchByUserId(Integer userId);
}
