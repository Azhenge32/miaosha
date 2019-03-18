package com.azhen.miaosha.dao;

import com.azhen.miaosha.domain.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface UserDao {
    @Select("select * from user where id = #{id}")
    User getById(@Param("id") int id);

    @Select("select * from user")
    List<User> getAll();
}
