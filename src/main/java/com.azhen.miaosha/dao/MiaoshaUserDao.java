package com.azhen.miaosha.dao;

import com.azhen.miaosha.domain.MiaoshaUser;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface MiaoshaUserDao {
	
	@Select("select * from miaosha_user where id = #{id}")
	MiaoshaUser getById(@Param("id") long id);

	@Select("select * from miaosha_user")
	List<MiaoshaUser> getAll();

	@Update("update miaosha_user set password = #{password} where id = #{id}")
	void update(MiaoshaUser toBeUpdate);
}
