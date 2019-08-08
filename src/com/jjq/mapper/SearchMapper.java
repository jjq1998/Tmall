package com.jjq.mapper;

import com.jjq.bean.Search;

import java.util.List;

public interface SearchMapper
{
    List<Search> selectAllSearchByUserId(Integer userId);
}
