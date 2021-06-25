package com.longzhi.lottery.mapper;

import com.longzhi.lottery.domain.User;

import java.util.List;

public interface UserMapper {
    User selectByPrimaryKey(Integer id);
    List<User> selectByExample(User user);
}
