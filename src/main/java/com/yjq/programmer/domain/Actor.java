package com.yjq.programmer.domain;

import com.yjq.programmer.annotation.ValidateEntity;

public class Actor {
    private String id;

    @ValidateEntity(required=true,requiredMaxLength=true,requiredMinLength=true,maxLength=32,minLength=1,errorRequiredMsg="演职人员名称不能为空！",errorMaxLengthMsg="演职人员名称长度不能大于32！",errorMinLengthMsg="演职人员名称不能为空！")
    private String name;

    @ValidateEntity(required=true,errorRequiredMsg="演职人员类型不能为空！")
    private String type;

    @ValidateEntity(required=true,errorRequiredMsg="演职人员所属电影不能为空！")
    private String movieId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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
        sb.append(", name=").append(name);
        sb.append(", type=").append(type);
        sb.append(", movieId=").append(movieId);
        sb.append("]");
        return sb.toString();
    }
}
