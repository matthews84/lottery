package com.longzhi.lottery.service;

import com.longzhi.lottery.domain.User;

public interface IUserService {
    User userLogin(User user);
    User findUserById(Integer id);
}
