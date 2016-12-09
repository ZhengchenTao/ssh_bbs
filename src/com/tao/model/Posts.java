package com.tao.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "posts")
public class Posts implements java.io.Serializable {
	@Id
	@Column(name = "id")
	private int id;

	@Column(name = "frums_id")
	private int frums_id;

	@Column(name = "users_id")
	private int users_id;

	@Column(name = "title")
	private String title;

	@Column(name = "content")
	private String content;

	@Column(name = "createTime")
	private Date createTime;

	@Column(name = "clickNum")
	private int clickNum;

}
