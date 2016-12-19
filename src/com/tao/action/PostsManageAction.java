package com.tao.action;

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
import com.tao.model.Users;
import com.tao.service.ForumsService;
import com.tao.service.PostsService;
import com.tao.service.RepliesService;
import com.tao.service.UsersService;

@Controller
@ParentPackage("json-default")
@Namespace(value = "/admin")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "error") })
public class PostsManageAction extends BaseAction {
	@Resource
	private PostsService postsService;
	@Resource
	private ForumsService forumsService;
	@Resource
	private UsersService usersService;
	@Resource
	private RepliesService repliesService;
	private Posts posts;
	private int page = 1;
	private int rows = 9;

	@Action(value = "postsIndex", results = { @Result(name = "success", location = "/admin/postsIndex.jsp") })
	public String index() {
		int count = postsService.getCount();
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
		List<Posts> postslist = postsService.findByPage(page, rows);
		List<Forums> forumslist = forumsService.findAllList();
		List<Users> uslist = usersService.findAllList();
		Map<Integer, Integer> replist = new HashMap();
		for (int i = 0; i < postslist.size(); i++) {
			int pid = postslist.get(i).getId();
			int recount = repliesService.findByPosts(pid).size();
			replist.put(pid, recount);
		}
		ac.put("replist", replist);
		ac.put("uslist", uslist);
		ac.put("folist", forumslist);
		ac.put("list", postslist);
		ac.put("page", page);
		ac.put("cpage", cpage);
		return SUCCESS;
	}

	@Action(value = "postsDelete", results = { @Result(type = "json") })
	public void delete() {
		System.out.println(posts.getId());
		repliesService.deleteRepliesByPosts(posts.getId());
		postsService.deletePosts(posts);
		this.write("success", "删除成功");
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
}
