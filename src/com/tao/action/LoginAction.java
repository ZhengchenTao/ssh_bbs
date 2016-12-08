package com.tao.action;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ExceptionMapping;
import org.apache.struts2.convention.annotation.ExceptionMappings;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.opensymphony.xwork2.ActionSupport;
import com.tao.model.Student;
import com.tao.service.StudentService;

@Controller
@ParentPackage("struts-default") 
@Namespace(value = "/loginAction")
@ExceptionMappings({ @ExceptionMapping(exception = "java.lange.RuntimeException", result = "error") })  
public class LoginAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	@Resource
	private StudentService studentService;

	@Action(value = "login" , results = { @Result(name = "success", location = "/success.jsp"),
				@Result(name = "failure", location = "/failure.jsp"),
				@Result(name = "error", location = "/login.jsp")})
	public String login() {
		
		Student  student = studentService.findStudentById("12312");// 为了测试结果，这里写死了
		
		if (student != null) {
			
			return SUCCESS;
		} else {
			return "failure";
		}

	}

	

}