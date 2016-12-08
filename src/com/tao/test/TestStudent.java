package com.tao.test;

import static org.junit.Assert.*;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class TestStudent {

	@Test
	public void test() {
		ApplicationContext context=new ClassPathXmlApplicationContext();
	}

}
