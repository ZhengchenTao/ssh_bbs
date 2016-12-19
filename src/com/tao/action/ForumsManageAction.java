package com.tao.action;

import java.util.List;

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
import com.tao.service.ForumsService;
import com.tao.service.PostsService;

@Controller
@ParentPackage("json-default")
@Namespace(value = "/admin")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "error") })
public class ForumsManageAction extends BaseAction {
	@Resource
	private ForumsService forumsService;
	@Resource
	private PostsService postsService;
	private Forums forums;
	private int page = 1;
	private int rows = 9;

	@Action(value = "forumsIndex", results = { @Result(name = "success", location = "/admin/forumsIndex.jsp") })
	public String index() {
		int count = forumsService.getCount();
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
		List<Forums> forumsList = forumsService.findByPage(page, rows);
		ActionContext ac = ActionContext.getContext();
		ac.put("list", forumsList);
		ac.put("page", page);
		ac.put("cpage", cpage);
		return SUCCESS;
	}

	@Action(value = "forumsUpdate", results = { @Result(type = "json") })
	public void update() {
		forumsService.updateForums(forums);
		this.write("success", "修改成功");
	}

	@Action(value = "forumsDelete", results = { @Result(type = "json") })
	public void delete() {
		postsService.deletePostsByForums(forums.getId());
		forumsService.deleteForums(forums);
		this.write("success", "删除成功");
	}

	@Action(value = "forumsAdd", results = { @Result(type = "json") })
	public void add() {
		forumsService.saveForums(forums);
		this.write("success", "添加成功");
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

	public Forums getForums() {
		return forums;
	}

	public void setForums(Forums forums) {
		this.forums = forums;
	}
}
