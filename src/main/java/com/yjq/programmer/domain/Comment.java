package com.yjq.programmer.domain;

import com.yjq.programmer.annotation.ValidateEntity;

import java.util.Date;

public class Comment {
    private String id;

    @ValidateEntity(required=true,requiredMaxLength=true,requiredMinLength=true,maxLength=256,minLength=1,errorRequiredMsg="评论不能为空！",errorMaxLengthMsg="评论长度不能大于256！",errorMinLengthMsg="评论不能为空！")
    private String content;

    @ValidateEntity(required=true,errorRequiredMsg="评论所属用户不能为空！")
    private String userId;

    private User user;

    @ValidateEntity(required=true,errorRequiredMsg="评论所属电影不能为空！")
    private String movieId;

    private Movie movie;

    private Date createTime;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getMovieId() {
        return movieId;
    }

    public void setMovieId(String movieId) {
        this.movieId = movieId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", content=").append(content);
        sb.append(", userId=").append(userId);
        sb.append(", movieId=").append(movieId);
        sb.append(", createTime=").append(createTime);
        sb.append(", movie=").append(movie);
        sb.append(", user=").append(user);
        sb.append("]");
        return sb.toString();
    }
}
