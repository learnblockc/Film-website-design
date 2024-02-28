package com.yjq.programmer.enums;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
/**
 * 电影类型枚举类
 */
public enum MovieTypeEnum {

    LOVE("1","爱情"),

    MOVE("2","动作"),

    COMEDY("3","喜剧"),

    FEATURE("4","剧情"),

    WAR("5","战争"),

    THRILL("6","惊悚"),

    SCIENCE_FICTION("7","科幻"),

    SUSPENSE("8","悬疑"),

    CRIME("9","犯罪"),

    RISK("10","冒险"),

    FAMILY("11","家庭"),

    ANCIENT("12","古装"),

    CARTOON("13","动画")

    ;

    String code;

    String desc;

    MovieTypeEnum(String code, String desc) {
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
