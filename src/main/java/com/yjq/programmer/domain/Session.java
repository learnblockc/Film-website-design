package com.yjq.programmer.domain;

import com.yjq.programmer.annotation.ValidateEntity;

import java.math.BigDecimal;
import java.util.Date;

public class Session {
    private String id;

    @ValidateEntity(required=true,errorRequiredMsg="场次所属电影院不能为空！")
    private String cinemaId;

    private Cinema cinema;

    @ValidateEntity(required=true,errorRequiredMsg="场次所属电影不能为空！")
    private String movieId;

    private Movie movie;

    @ValidateEntity(required=true,errorRequiredMsg="放映时间不能为空！")
    private Date time;

    @ValidateEntity(required=true,requiredMaxLength=true,requiredMinLength=true,maxLength=8,minLength=1,errorRequiredMsg="语言版本不能为空！",errorMaxLengthMsg="语言版本长度不能大于8！",errorMinLengthMsg="语言版本不能为空！")
    private String language;

    @ValidateEntity(required=true,requiredMaxLength=true,requiredMinLength=true,maxLength=8,minLength=1,errorRequiredMsg="放映厅不能为空！",errorMaxLengthMsg="放映厅长度不能大于8！",errorMinLengthMsg="放映厅不能为空！")
    private String hall;

    @ValidateEntity(required=true,requiredMinValue=true,requiredMaxValue=true,minValue= 0.01, maxValue=999999.99,errorRequiredMsg="票价不能为空！",errorMaxValueMsg="票价不能大于999999.99元！",errorMinValueMsg="票价不能小于0.01元！")
    private BigDecimal price;

    @ValidateEntity(required=true,requiredMinValue=true,requiredMaxValue=true,minValue= 1, maxValue=12,errorRequiredMsg="座位行数不能为空！",errorMaxValueMsg="座位行数不能大于12行！",errorMinValueMsg="座位行数不能小于1行！")
    private Integer row;

    @ValidateEntity(required=true,requiredMinValue=true,requiredMaxValue=true,minValue= 1, maxValue=12,errorRequiredMsg="座位列数不能为空！",errorMaxValueMsg="座位列数不能大于12列！",errorMinValueMsg="座位列数不能小于1列！")
    private Integer col;

    private Integer totalSeat;

    private Integer orderSeat;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public String getHall() {
        return hall;
    }

    public void setHall(String hall) {
        this.hall = hall;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
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

    public Integer getTotalSeat() {
        return totalSeat;
    }

    public void setTotalSeat(Integer totalSeat) {
        this.totalSeat = totalSeat;
    }

    public Integer getOrderSeat() {
        return orderSeat;
    }

    public void setOrderSeat(Integer orderSeat) {
        this.orderSeat = orderSeat;
    }

    public Cinema getCinema() {
        return cinema;
    }

    public void setCinema(Cinema cinema) {
        this.cinema = cinema;
    }

    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", cinemaId=").append(cinemaId);
        sb.append(", movieId=").append(movieId);
        sb.append(", time=").append(time);
        sb.append(", language=").append(language);
        sb.append(", hall=").append(hall);
        sb.append(", price=").append(price);
        sb.append(", row=").append(row);
        sb.append(", col=").append(col);
        sb.append(", totalSeat=").append(totalSeat);
        sb.append(", orderSeat=").append(orderSeat);
        sb.append(", movie=").append(movie);
        sb.append(", cinema=").append(cinema);
        sb.append("]");
        return sb.toString();
    }

}
