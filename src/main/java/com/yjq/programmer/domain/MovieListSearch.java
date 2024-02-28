package com.yjq.programmer.domain;

/**
 * @authorWZX
 * @create 2023-03-24 11:16
 */
public class MovieListSearch {

    private String type = "0"; // 根据电影类型搜索

    private String name = ""; // 根据电影名称搜索

    private String area = "0"; // 根据电影源地搜索

    private String time = "0"; // 根据上映时间搜索

    private String sort = "0"; // 根据热门、时间、评分排序

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }
}
