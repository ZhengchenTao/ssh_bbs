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
import com.opensymphony.xwork2.ActionSupport;
import com.tao.model.Forums;
import com.tao.service.ForumsService;
import com.tao.service.PostsService;

@Controller
@ParentPackage("struts-default")
@Namespace(value = "/forums")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "error") })
public class ForumsAction extends ActionSupport {
	@Resource
	private ForumsService forumsService;
	@Resource
	private PostsService postsService;
	private Forums forums;

	@Action(value = "index", results = { @Result(name = "success", location = "/forums/forumsIndex.jsp") })
	public String index() {
		List<Forums> list = forumsService.findAllList();
		ActionContext ac = ActionContext.getContext();
		ac.put("list", list);
		Map<Integer, Integer> pocount = new HashMap();
		for (int i = 0; i < list.size(); i++) {
			int forumsId = list.get(i).getId();
			int count = postsService.getCount(forumsId);
			pocount.put(forumsId, count);
		}
		ac.put("count", pocount);
		return SUCCESS;
	}

	public Forums getForums() {
		return forums;
	}

	public void setForums(Forums forums) {
		this.forums = forums;
	}
}
