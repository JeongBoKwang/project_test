package com.example.spring.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.spring.demo.vo.Article;

@Controller
public class UsrHomeController {
	@RequestMapping("/usr/home/getArticle")
	@ResponseBody
	public Article getArticle() {
		Article article = new Article(1, "제목1", "내용1");

		return article;
	}

	@RequestMapping("/usr/home/getArticles")
	@ResponseBody
	public List<Article> getArticles() {
		Article article1 = new Article(1, "제목1", "내용1");
		Article article2 = new Article(2, "제목2", "내용2");

		List<Article> list = new ArrayList<>();
		list.add(article1);
		list.add(article2);
		return list;
	}
}

