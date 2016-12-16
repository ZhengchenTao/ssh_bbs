package com.tao.action;

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
public class AdminAction extends BaseAction {
	@Resource
	private UsersService usersService;

	private Users users;

	@Action(value = "index", results = { @Result(name = "success", location = "/admin/index.jsp") })
	public String index() {
		return SUCCESS;
	}

	@Action(value = "login", results = { @Result(name = "success", location = "/admin/login.jsp") })
	public String login() {
		return SUCCESS;
	}

	@Action(value = "doLogin", results = { @Result(type = "json") })
	public void doLogin() {
		users.setRole(1);
		users = usersService.Login(users);
		if (users != null) {
			ActionContext ac = ActionContext.getContext();
			ac.getSession().put("adminid", users.getId());
			ac.getSession().put("admin", users.getUsername());
			this.write("success", "");
		} else {
			this.write("error", "用户名不正确或没有权限");
		}
	}

	public Users getUsers() {
		return users;
	}

	public void setUsers(Users users) {
		this.users = users;
	}

}
