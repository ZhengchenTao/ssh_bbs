package com.tao.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ExceptionMapping;
import org.apache.struts2.convention.annotation.ExceptionMappings;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.tao.model.Forums;
import com.tao.model.Posts;
import com.tao.model.Replies;
import com.tao.model.Users;
import com.tao.service.ForumsService;
import com.tao.service.PostsService;
import com.tao.service.RepliesService;
import com.tao.service.UsersService;

@Controller
@ParentPackage("json-default")
@Namespace(value = "/posts")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "error") })
public class PostsAction extends BaseAction {
	@Resource
	private PostsService postsService;
	@Resource
	private ForumsService forumsService;
	@Resource
	private UsersService usersService;
	@Resource
	private RepliesService repliesService;
	private int page = 1;
	private int rows = 9;
	private int forumsId;
	private Posts posts;
	private Replies replies;

	private int postId;

	@Action(value = "index", results = { @Result(name = "success", location = "/posts/postsIndex.jsp") })
	public String index() {
		int count = postsService.getCount(forumsId);
		int cpage;
		if (count % rows == 0) {
			cpage = (count / rows);
		} else {
			cpage = (count / rows) + 1;
		}
		if (page < 1) {
			this.page = 1;
		} else if (page > cpage) {
			page = cpage;
		}
		ActionContext ac = ActionContext.getContext();
		List<Posts> postlist = postsService.findByPage(page, rows, forumsId);
		int pocount = postsService.getCount(forumsId);
		List<Forums> forumslist = forumsService.findAllList();
		Forums forums = forumsService.findById(forumsId);
		ac.put("pocount", pocount);
		ac.put("forums", forums);
		ac.put("folist", forumslist);
		ac.put("polist", postlist);
		ac.put("page", page);
		ac.put("cpage", cpage);
		return SUCCESS;
	}

	@Action(value = "addPost", results = {
			@Result(name = "success", location = "/posts/addPost.jsp"),
			@Result(name = "error", location = "/error.jsp") })
	public String addPost() {
		if (forumsService.findById(forumsId) == null) {
			return ERROR;
		}
		Forums f = forumsService.findById(forumsId);
		List<Forums> forumslist = forumsService.findAllList();
		ActionContext ac = ActionContext.getContext();
		ac.put("forums", f);
		ac.put("folist", forumslist);
		return SUCCESS;
	}

	@Action(value = "doAdd", results = { @Result(type = "json") })
	public void doAdd() {
		ActionContext ac = ActionContext.getContext();
		if (ac.getSession().get("username") == null) {
			this.write("error", "");
		} else {
			int uid = (int) ac.getSession().get("userid");
			posts.setUsers_id(uid);
			posts.setCreateTime(new Date());
			postsService.savePosts(posts);
			posts = postsService.find(posts);
			Map<String, String> map = new HashMap<String, String>();
			map.put("state", "success");
			map.put("pid", String.valueOf(posts.getId()));
			this.write(map);
		}
	}

	@Action(value = "checkPost", results = {
			@Result(name = "success", location = "/posts/checkPost.jsp"),
			@Result(name = "error", location = "/error.jsp") })
	public String checkPost() {
		if (postId == 0) {
			return ERROR;
		}
		Posts po = postsService.findById(postId);
		if (po != null) {
			postsService.clickPost(postId);
			po = postsService.findById(postId);
			Forums fo = forumsService.findById(po.getForums_id());
			Users us = usersService.findUsersById(po.getUsers_id());
			List<Replies> re = repliesService.findByPosts(po.getId());
			int reCount = repliesService.getCount(po.getId());
			ActionContext ac = ActionContext.getContext();
			ac.put("user", us);
			ac.put("forums", fo);
			ac.put("post", po);
			ac.put("replies", re);
			ac.put("reCount", reCount);
			return SUCCESS;
		} else {
			return ERROR;
		}
	}

	@Action(value = "addReply", results = { @Result(type = "json") })
	public void addReply() {
		ActionContext ac = ActionContext.getContext();
		if (ac.getSession().get("userid") == null) {
			this.write("error", "");
		} else {
			int uid = (int) ac.getSession().get("userid");
			replies.setUsers_id(uid);
			replies.setReplyTime(new Date());
			repliesService.saveReplies(replies);
			this.write("success", "");
		}
	}

	public int getForumsId() {
		return forumsId;
	}

	public void setForumsId(int forumsId) {
		this.forumsId = forumsId;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public Posts getPosts() {
		return posts;
	}

	public void setPosts(Posts posts) {
		this.posts = posts;
	}

	public int getPostId() {
		return postId;
	}

	public void setPostId(int postId) {
		this.postId = postId;
	}

	public Replies getReplies() {
		return replies;
	}

	public void setReplies(Replies replies) {
		this.replies = replies;
	}
}
