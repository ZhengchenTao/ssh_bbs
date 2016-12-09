package com.tao.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tao.dao.BaseDAO;
import com.tao.model.Forums;
import com.tao.service.ForumsService;;

@Transactional// 启用事务机制
@Service("ForumsService")
public class ForumsServiceImpl implements ForumsService {
	@Resource
	private BaseDAO<Forums> baseDAO;

	@Override
	public void saveForums(Forums forums) {
		baseDAO.save(forums);
	}

	@Override
	public void updateForums(Forums forums) {
		baseDAO.update(forums);
	}

	@Override
	public Forums findForumsById(int id) {
		return baseDAO.get(Forums.class, id);
	}

	@Override
	public void deleteForums(Forums forums) {
		baseDAO.delete(forums);
	}

	@Override
	public List<Forums> findAllList() {
		return baseDAO.find("from Forums");
	}

	@Override
	public List<Forums> findByPage(int page, int rows) {
		return baseDAO.findByPage(Forums.class, page, rows);
	}

	@Override
	public int getCount() {
		return baseDAO.getCount(Forums.class);
	}

	@Override
	public Forums find(Forums forums) {
		// TODO Auto-generated method stub
		return null;
	}

}
