package com.yjq.programmer.domain;

import com.yjq.programmer.annotation.ValidateEntity;

import java.util.Date;

public class Movie {
    private String id;

    @ValidateEntity(required=true,requiredMaxLength=true,requiredMinLength=true,maxLength=32,minLength=1,errorRequiredMsg="电影名称不能为空！",errorMaxLengthMsg="电影名称长度不能大于32！",errorMinLengthMsg="电影名称不能为空！")
    private String name;

    @ValidateEntity(required=true,errorRequiredMsg="电影类型不能为空！")
    private String type;

    @ValidateEntity(required=true,requiredMinValue=true,requiredMaxValue=true,minValue= 1, maxValue=999999,errorRequiredMsg="电影时长不能为空！",errorMaxValueMsg="电影时长不能大于999999分钟！",errorMinValueMsg="电影时长不能小于1分钟！")
    private Integer time;

    @ValidateEntity(required=true,errorRequiredMsg="电影源地不能为空！")
    private String area;

    @ValidateEntity(required=true,errorRequiredMsg="上映时间不能为空！")
    private Date createTime;

    private Integer rate;

    private Integer rateCount;

    @ValidateEntity(required=true,requiredMaxLength=true,requiredMinLength=true,maxLength=256,minLength=1,errorRequiredMsg="电影简介不能为空！",errorMaxLengthMsg="电影简介长度不能大于256！",errorMinLengthMsg="电影简介不能为空！")
    private String info;

    @ValidateEntity(requiredMaxLength=true,maxLength=256,errorMaxLengthMsg="电影海报长度不能大于256！")
    private String photo;

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

    public Integer getTime() {
        return time;
    }

    public void setTime(Integer time) {
        this.time = time;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getRate() {
        return rate;
    }

    public void setRate(Integer rate) {
        this.rate = rate;
    }

    public Integer getRateCount() {
        return rateCount;
    }

    public void setRateCount(Integer rateCount) {
        this.rateCount = rateCount;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
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
        sb.append(", time=").append(time);
        sb.append(", area=").append(area);
        sb.append(", createTime=").append(createTime);
        sb.append(", rate=").append(rate);
        sb.append(", rateCount=").append(rateCount);
        sb.append(", info=").append(info);
        sb.append(", photo=").append(photo);
        sb.append("]");
        return sb.toString();
    }
}
