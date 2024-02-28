package com.yjq.programmer.enums;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
public enum MovieAreaEnum {

    CHINA("1","中国大陆"),

    AMERICA("2","美国"),

    KOREA("3","韩国"),

    JAPAN("4","日本"),

    HONG_KONG("5","中国香港"),

    GERMANY("6","德国"),

    INDIA("7","印度"),

    ENGLAND("8","英国"),

    FRANCE("9","法国"),

    RUSSIA("10","俄罗斯"),

    ITALY("11","意大利"),

    ;

    String code;

    String desc;

    MovieAreaEnum(String code, String desc) {
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
