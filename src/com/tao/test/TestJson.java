package com.tao.test;

import net.sf.json.JSONObject;

import org.apache.struts2.json.JSONWriter;
import org.junit.Test;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.tao.model.Users;

public class TestJson {

	public void testGson() {
		Users u = new Users();
		u.setUsername("abc");
		u.setPassword("123");
		Gson gson = new Gson();
		
		System.out.println(gson.toJson(u).toString());
	}

	public void testJsonObject() {
		JsonObject j = new JsonObject();
		j.addProperty("state", 2);
		j.addProperty("message", "成功");
		j.toString();
		System.out.println(j);
	}

	
	public void testJson() {
		Users u = new Users();
		u.setUsername("abc");
		u.setPassword("123");
		JsonObject j = new JsonObject();
		j.getAsJsonObject();
		System.out.println(j);
	}

}
