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
import com.tao.model.Users;
import com.tao.service.UsersService;

@Controller
@ParentPackage("json-default")
@Namespace(value = "/admin")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "error") })
public class UsersManage extends BaseAction {
	@Resource
	private UsersService usersService;
	private Users users;
	private int page = 1;
	private int rows = 9;

	@Action(value = "usersIndex", results = { @Result(name = "success", location = "/admin/usersIndex.jsp") })
	public String index() {
		int count = usersService.getCount();
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
		List<Users> usersList = usersService.findByPage(page, rows);
		ActionContext ac = ActionContext.getContext();
		ac.put("userslist", usersList);
		ac.put("page", page);
		ac.put("cpage", cpage);
		return SUCCESS;
	}
	@Action(value = "usersUpdate", results = { @Result(type = "json") })
	public void update() {
		usersService.updateUsers(users);
		this.write("success","修改成功");
	}
	@Action(value = "usersDelete", results = { @Result(type = "json") })
	public void delete() {
		usersService.deleteUsers(users);
		this.write("success","删除成功");
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
	public Users getUsers() {
		return users;
	}

	public void setUsers(Users users) {
		this.users = users;
	}
}
