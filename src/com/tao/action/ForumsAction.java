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
import com.opensymphony.xwork2.ActionSupport;
import com.tao.model.Forums;
import com.tao.service.ForumsService;

@Controller
@ParentPackage("struts-default")
@Namespace(value = "/forums")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "error") })
public class ForumsAction extends ActionSupport {
	@Resource
	private ForumsService forumsService;
	private Forums forums;

	@Action(value = "index", results = { @Result(name = "success", location = "/forums/forumsIndex.jsp") })
	public String index() {
		List<Forums> list = forumsService.findAllList();
		ActionContext ac = ActionContext.getContext();
		ac.put("list", list);
		return SUCCESS;
	}

	public Forums getForums() {
		return forums;
	}

	public void setForums(Forums forums) {
		this.forums = forums;
	}
}
