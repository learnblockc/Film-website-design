package com.yjq.programmer.enums;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
public enum ActorTypeEnum {

    DIRECTOR("1","导演"),

    ACTOR("2","演员")

    ;

    String code;

    String desc;

    ActorTypeEnum(String code, String desc) {
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
