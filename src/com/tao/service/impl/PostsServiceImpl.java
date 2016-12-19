package com.tao.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tao.dao.BaseDAO;
import com.tao.model.Posts;
import com.tao.service.PostsService;

;

@Transactional
// 启用事务机制
@Service("PostsService")
public class PostsServiceImpl implements PostsService {
	@Resource
	private BaseDAO<Posts> baseDAO;

	@Override
	public void savePosts(Posts posts) {
		baseDAO.save(posts);
	}

	@Override
	public void updatePosts(Posts posts) {
		baseDAO.update(posts);
	}

	@Override
	public Posts findById(int id) {
		return baseDAO.get(Posts.class, id);
	}

	@Override
	public void deletePosts(Posts posts) {
		baseDAO.delete(posts);
	}

	@Override
	public List<Posts> findAllList() {
		return baseDAO.find("from Posts");
	}

	@Override
	public List<Posts> findByPage(int page, int rows) {
		return baseDAO.findByPageDesc(Posts.class, page, rows);
	}

	@Override
	public List<Posts> findByPage(int page, int rows, int forumsId) {
		Posts p = new Posts();
		p.setForums_id(forumsId);
		return baseDAO.findByPageDesc(Posts.class, page, rows, p);
	}

	@Override
	public int getCount() {
		return baseDAO.getCount(Posts.class);
	}

	@Override
	public int getCount(int forumsId) {
		Posts p = new Posts();
		p.setForums_id(forumsId);
		return baseDAO.getCount(Posts.class, p);
	}

	@Override
	public Posts find(Posts posts) {
		return baseDAO.find(Posts.class, posts);
	}

	@Override
	public List<Posts> findByForums(int forumsId) {
		return baseDAO.find("from Posts where forums_id=" + forumsId);
	}

	@Override
	public void clickPost(int id) {
		Posts po = this.findById(id);
		int clickNum = po.getClickNum();
		clickNum++;
		po.setClickNum(clickNum);
		baseDAO.saveOrUpdate(po);
	}
}
