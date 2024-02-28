package com.yjq.programmer.enums;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
public enum  OrderStateEnum {

    FINISH(1,"已完成"),

    CANCEL(2,"已取消"),

    NO_PAY(3,"未支付")

            ;

    Integer code;

    String desc;

    OrderStateEnum(Integer code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
