package com.yjq.programmer.domain;

import com.yjq.programmer.annotation.ValidateEntity;

import java.util.Date;

public class Rate {
    private String id;

    @ValidateEntity(required=true,errorRequiredMsg="评分所属用户不能为空！")
    private String userId;

    @ValidateEntity(required=true,requiredMinValue=true,requiredMaxValue=true,maxValue=10,minValue=0,errorRequiredMsg="评分分数不能为空！",errorMaxValueMsg="评分分数不能大于10分",errorMinValueMsg="评分分数不能小于0分！")
    private Integer score;

    private Date createTime;

    @ValidateEntity(required=true,errorRequiredMsg="评分所属电影不能为空！")
    private String movieId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getMovieId() {
        return movieId;
    }

    public void setMovieId(String movieId) {
        this.movieId = movieId;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", userId=").append(userId);
        sb.append(", score=").append(score);
        sb.append(", createTime=").append(createTime);
        sb.append(", movieId=").append(movieId);
        sb.append("]");
        return sb.toString();
    }
}
