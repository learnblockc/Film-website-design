package com.yjq.programmer.enums;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
public enum RoleEnum {

    USER("tWalUpvk","普通用户"),

    ADMIN("mY69h4is","管理员"),

    ;

    String code;

    String desc;

    RoleEnum(String code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
