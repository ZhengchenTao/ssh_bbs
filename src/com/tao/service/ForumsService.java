package com.tao.service;

import java.util.List;

import com.tao.model.Forums;
import com.tao.model.Users;

public interface ForumsService {

	public void saveForums(Forums forums);

	public void updateForums(Forums forums);

	public Forums findForumsById(int id);

	public void deleteForums(Forums forums);

	public List<Forums> findAllList();

	public List<Forums> findByPage(int page, int rows);

	public int getCount();

	public Forums find(Forums forums);
}
