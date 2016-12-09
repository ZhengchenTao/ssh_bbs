package com.tao.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tao.dao.BaseDAO;
import com.tao.model.Users;
import com.tao.service.UsersService;

@Transactional
// 启用事务机制
@Service("UsersService")
public class UsersServiceImpl implements UsersService {
	@Resource
	private BaseDAO<Users> baseDAO;

	@Override
	public void saveUsers(Users users) {
		baseDAO.save(users);
	}

	@Override
	public void updateUsers(Users users) {
		baseDAO.update(users);
	}

	@Override
	public Users findUsersById(int id) {
		return baseDAO.get(Users.class, id);
	}

	@Override
	public void deleteUsers(Users users) {
		baseDAO.delete(users);
	}

	@Override
	public List<Users> findAllList() {
		return baseDAO.find("from Users");
	}

	@Override
	public List<Users> findByPage(int page, int rows) {
		return baseDAO.findByPage(Users.class, page, rows);
	}

	@Override
	public int getCount() {
		return baseDAO.getCount(Users.class);
	}

	@Override
	public Users Login(Users users) {
		return baseDAO.find(Users.class, users);
	}

	@Override
	public Users find(Users users) {
		return baseDAO.find(Users.class, users);
	}
}
