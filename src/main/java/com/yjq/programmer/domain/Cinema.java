package com.yjq.programmer.domain;

import com.yjq.programmer.annotation.ValidateEntity;

public class Cinema {
    private String id;

    @ValidateEntity(required=true,requiredMaxLength=true,requiredMinLength=true,maxLength=32,minLength=1,errorRequiredMsg="电影院名称不能为空！",errorMaxLengthMsg="电影院名称长度不能大于32！",errorMinLengthMsg="电影院名称不能为空！")
    private String name;

    @ValidateEntity(required=true,requiredMaxLength=true,requiredMinLength=true,maxLength=128,minLength=1,errorRequiredMsg="电影院地址不能为空！",errorMaxLengthMsg="电影院地址长度不能大于128！",errorMinLengthMsg="电影院地址不能为空！")
    private String address;

    @ValidateEntity(required=true,requiredMaxLength=true,requiredMinLength=true,maxLength=32,minLength=1,errorRequiredMsg="电影院电话不能为空！",errorMaxLengthMsg="电影院电话长度不能大于32！",errorMinLengthMsg="电影院电话不能为空！")
    private String phone;

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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", name=").append(name);
        sb.append(", address=").append(address);
        sb.append(", phone=").append(phone);
        sb.append("]");
        return sb.toString();
    }
}
