package com.tao.service;

import java.util.List;

import com.tao.model.Replies;

public interface RepliesService {

	public void saveReplies(Replies replies);

	public void updateReplies(Replies replies);

	public Replies findById(int id);

	public void deleteReplies(Replies replies);

	public List<Replies> findAllList();

	public List<Replies> findByPosts(int postsId);

	public List<Replies> findByPage(int page, int rows);

	public int getCount();

	public Replies find(Replies replies);

	public int getCount(int postsId);

	public List<Replies> findByPage(int page, int rows, int postsId);
}
