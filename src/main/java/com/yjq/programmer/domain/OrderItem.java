package com.yjq.programmer.domain;

import java.math.BigDecimal;

public class OrderItem {
    private String id;

    private Integer row;

    private Integer col;

    private BigDecimal price;

    private String orderId;

    private String sessionId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Integer getRow() {
        return row;
    }

    public void setRow(Integer row) {
        this.row = row;
    }

    public Integer getCol() {
        return col;
    }

    public void setCol(Integer col) {
        this.col = col;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", row=").append(row);
        sb.append(", col=").append(col);
        sb.append(", price=").append(price);
        sb.append(", orderId=").append(orderId);
        sb.append(", sessionId=").append(sessionId);
        sb.append("]");
        return sb.toString();
    }
}