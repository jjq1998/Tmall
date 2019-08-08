package com.jjq.service.impl;

import com.jjq.bean.Search;
import com.jjq.mapper.SearchMapper;
import com.jjq.service.SearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SearchServiceImpl implements SearchService
{
    @Autowired
    SearchMapper searchMapper;

    @Override
    public List<Search> selectAllSearchByUserId(Integer userId)
    {
        return searchMapper.selectAllSearchByUserId(userId);
    }
}
