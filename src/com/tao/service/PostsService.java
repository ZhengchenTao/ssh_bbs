package com.tao.service;

import java.util.List;

import com.tao.model.Posts;
import com.tao.model.Users;

public interface PostsService {

	public void savePosts(Posts posts);

	public void updatePosts(Posts posts);

	public Posts findById(int id);

	public void deletePosts(Posts posts);

	public List<Posts> findAllList();

	public List<Posts> findByForums(int forumsId);

	public List<Posts> findByPage(int page, int rows);

	public int getCount();

	public Posts find(Posts posts);

	public int getCount(int forumsId);

	public List<Posts> findByPage(int page, int rows, int forumsId);
}
