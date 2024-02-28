package com.yjq.programmer.domain;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class Order {
    private String id;

    private String tradeNo;

    private Date createTime;

    private String userId;

    private User user;

    private String cinemaId;

    private String movieId;

    private Integer state;

    private String movieName;

    private Date sessionTime;

    private String cinemaName;

    private BigDecimal totalPrice;

    private String sessionHall;

    private String sessionId;

    private String moviePhoto;

    private List<OrderItem> orderItemList;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTradeNo() {
        return tradeNo;
    }

    public void setTradeNo(String tradeNo) {
        this.tradeNo = tradeNo;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCinemaId() {
        return cinemaId;
    }

    public void setCinemaId(String cinemaId) {
        this.cinemaId = cinemaId;
    }

    public String getMovieId() {
        return movieId;
    }

    public void setMovieId(String movieId) {
        this.movieId = movieId;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public Date getSessionTime() {
        return sessionTime;
    }

    public void setSessionTime(Date sessionTime) {
        this.sessionTime = sessionTime;
    }

    public String getCinemaName() {
        return cinemaName;
    }

    public void setCinemaName(String cinemaName) {
        this.cinemaName = cinemaName;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getSessionHall() {
        return sessionHall;
    }

    public void setSessionHall(String sessionHall) {
        this.sessionHall = sessionHall;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public String getMoviePhoto() {
        return moviePhoto;
    }

    public void setMoviePhoto(String moviePhoto) {
        this.moviePhoto = moviePhoto;
    }

    public List<OrderItem> getOrderItemList() {
        return orderItemList;
    }

    public void setOrderItemList(List<OrderItem> orderItemList) {
        this.orderItemList = orderItemList;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", tradeNo=").append(tradeNo);
        sb.append(", createTime=").append(createTime);
        sb.append(", userId=").append(userId);
        sb.append(", cinemaId=").append(cinemaId);
        sb.append(", movieId=").append(movieId);
        sb.append(", state=").append(state);
        sb.append(", movieName=").append(movieName);
        sb.append(", sessionTime=").append(sessionTime);
        sb.append(", cinemaName=").append(cinemaName);
        sb.append(", totalPrice=").append(totalPrice);
        sb.append(", sessionHall=").append(sessionHall);
        sb.append(", sessionId=").append(sessionId);
        sb.append(", moviePhoto=").append(moviePhoto);
        sb.append(", orderItemList=").append(orderItemList);
        sb.append(", user=").append(user);
        sb.append("]");
        return sb.toString();
    }
}
