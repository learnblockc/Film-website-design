package com.yjq.programmer.domain;

import org.springframework.stereotype.Component;

/**
 * @author 杨杨吖
 * @QQ 823208782
 * @WX yjqi12345678
 * @create 2020-09-25 20:53
 */

/**
 * 分页基本信息
 */
@Component
public class Page {

    private Integer page = 1; //当前页码

    private Integer rows = 5; //每页显示数量

    private Integer offset; //对应数据库中的偏移量

    private Integer totalPage;  //总页数

    private Integer totalCount;  //总记录数

    public Page(){

    }

    public Page(Integer page, Integer rows) {
        this.page = page;
        this.rows = rows;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getRows() {
        return rows;
    }

    public void setRows(int rows) {
        this.rows = rows;
    }

    public int getOffset() {
        this.offset = (page - 1) * rows;
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = offset;
    }

    public int getTotalPage() {
        return (totalCount-1)/rows+1;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

}
