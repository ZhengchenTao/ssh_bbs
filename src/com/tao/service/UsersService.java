package com.tao.service;

import java.util.List;

import com.tao.model.Users;

public interface UsersService {

	public void saveUsers(Users users);

	public void updateUsers(Users users);

	public Users findUsersById(int id);

	public void deleteUsers(Users users);

	public List<Users> findAllList();

	public List<Users> findByPage(int page, int rows);

	public int getCount();

	public Users Login(Users users);

	public Users find(Users users);

}
