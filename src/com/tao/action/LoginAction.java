package com.tao.action;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

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
@Namespace(value = "/login")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "error") })
public class LoginAction extends BaseAction {
	@Resource
	private UsersService usersService;
	private Users users;
	private boolean remember;

	@Action(value = "login", results = { @Result(type = "json") })
	public void login() {
		Users us = usersService.Login(users);
		ActionContext ac = ActionContext.getContext();
		HttpServletResponse response = (HttpServletResponse) ac
				.get(org.apache.struts2.StrutsStatics.HTTP_RESPONSE);
		if (us != null) {
			if (remember == true) {
				System.out.println(remember);
				Cookie unCookie = new Cookie("username", us.getUsername());
				Cookie pwCookie = new Cookie("password", us.getPassword());
				unCookie.setPath("/");
				pwCookie.setPath("/");
				unCookie.setMaxAge(60 * 60 * 24 * 30);
				pwCookie.setMaxAge(60 * 60 * 24 * 30);
				response.addCookie(unCookie);
				response.addCookie(pwCookie);
			}
			ac.getSession().put("userid", us.getId());
			ac.getSession().put("username", us.getUsername());
			this.write("success", "登录成功");
		} else {
			this.write("error", "登录失败 请检查用户名密码");
		}
	}

	@Action(value = "logout", results = { @Result(type = "json") })
	public void logout() {
		ActionContext ac = ActionContext.getContext();
		ac.getSession().remove("userid");
		ac.getSession().remove("username");
		this.write("success", "退出成功");
	}

	@Action(value = "register", results = { @Result(type = "json") })
	public void register() {
		Users us = new Users();
		us.setUsername(users.getUsername());
		us = usersService.find(us);
		if (us == null) {
			users.setRegtime(new Date());
			usersService.saveUsers(users);
			this.write("success", "注册成功");
		} else {
			this.write("error", "该用户名已经被注册");
		}
	}

	public Users getUsers() {
		return users;
	}

	public void setUsers(Users users) {
		this.users = users;
	}

	public boolean getRemember() {
		return remember;
	}

	public void setRemember(boolean remember) {
		this.remember = remember;
	}

}
