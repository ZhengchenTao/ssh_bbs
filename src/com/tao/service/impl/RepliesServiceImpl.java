package com.tao.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tao.dao.BaseDAO;
import com.tao.model.Replies;
import com.tao.service.RepliesService;

@Transactional
// 启用事务机制
@Service("RepliesService")
public class RepliesServiceImpl implements RepliesService {
	@Resource
	private BaseDAO<Replies> baseDAO;

	@Override
	public void saveReplies(Replies replies) {
		baseDAO.save(replies);
	}

	@Override
	public void updateReplies(Replies replies) {
		baseDAO.update(replies);
	}

	@Override
	public Replies findById(int id) {
		return baseDAO.get(Replies.class, id);
	}

	@Override
	public void deleteReplies(Replies replies) {
		baseDAO.delete(replies);
	}

	@Override
	public void deleteRepliesByPosts(int postsId) {
		List<Replies> list = baseDAO.find("from Replies where post_id="
				+ postsId);
		for (Replies replies : list) {
			baseDAO.delete(replies);
		}
	}

	@Override
	public List<Replies> findAllList() {
		return baseDAO.find("from Replies");
	}

	@Override
	public List<Replies> findByPage(int page, int rows) {
		return baseDAO.findByPage(Replies.class, page, rows);
	}

	@Override
	public List<Replies> findByPage(int page, int rows, int postsId) {
		Replies r = new Replies();
		r.setPost_id(postsId);
		return baseDAO.findByPage(Replies.class, page, rows, r);
	}

	@Override
	public int getCount() {
		return baseDAO.getCount(Replies.class);
	}

	@Override
	public int getCount(int postsId) {
		Replies r = new Replies();
		r.setPost_id(postsId);
		return baseDAO.getCount(Replies.class, r);
	}

	@Override
	public Replies find(Replies replies) {
		return baseDAO.find(Replies.class, replies);
	}

	@Override
	public List<Replies> findByPosts(int postsId) {
		return baseDAO.find("from Replies where post_id=" + postsId);
	}

}
