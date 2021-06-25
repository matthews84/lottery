package com.longzhi.lottery.service.impl;

import com.longzhi.lottery.domain.User;
import com.longzhi.lottery.mapper.UserMapper;
import java.util.List;

import com.longzhi.lottery.service.IUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class UserService implements IUserService {
    @Resource
    private UserMapper userMapper;

    public User findUserById(Integer id) {
        return userMapper.selectByPrimaryKey(id);
    }
    public User userLogin(User user) {
        // TODO Auto-generated method stub
        List<User> users = userMapper.selectByExample(user);
        for(User u:users){
            if(u.getUsername().equals(user.getUsername())){
                if(u.getPassword().equals(user.getPassword())){
                    return u;
                }
            }
        }
        return user;
    }

}
