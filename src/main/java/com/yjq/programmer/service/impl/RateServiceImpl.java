package com.yjq.programmer.service.impl;

import com.yjq.programmer.bean.CodeMsg;
import com.yjq.programmer.dao.MovieMapper;
import com.yjq.programmer.dao.RateMapper;
import com.yjq.programmer.domain.Movie;
import com.yjq.programmer.domain.MovieExample;
import com.yjq.programmer.domain.Rate;
import com.yjq.programmer.domain.RateExample;
import com.yjq.programmer.service.IRateService;
import com.yjq.programmer.util.UuidUtil;
import com.yjq.programmer.util.ValidateEntityUtil;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
@Service
@Transactional
public class RateServiceImpl implements IRateService {

    @Resource
    private RateMapper rateMapper;

    @Resource
    private MovieMapper movieMapper;

    /**
     * 电影评分操作处理
     * @param rate
     * @return
     */
    @Override
    public ResponseVo<Boolean> rateMovie(Rate rate) {
        if(rate == null){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 进行统一表单验证
        CodeMsg validate = ValidateEntityUtil.validate(rate);
        if (!validate.getCode().equals(CodeMsg.SUCCESS.getCode())) {
            return ResponseVo.errorByMsg(validate);
        }
        Movie movie = movieMapper.selectByPrimaryKey(rate.getMovieId());
        // 判断此用户是否已经评过分了
        RateExample rateExample = new RateExample();
        rateExample.createCriteria().andMovieIdEqualTo(rate.getMovieId()).andUserIdEqualTo(rate.getUserId());
        List<Rate> rateList = rateMapper.selectByExample(rateExample);
        if(rateList != null && rateList.size() > 0){
            return ResponseVo.errorByMsg(CodeMsg.RATE_REPEAT);
        }
        rate.setId(UuidUtil.getShortUuid());
        rate.setCreateTime(new Date());
        if(rateMapper.insertSelective(rate) == 0){
            throw new RuntimeException("评分失败，请联系管理员！");
        }
        // 修改评分和已评分人数
        movie.setRate((movie.getRate() * movie.getRateCount() + rate.getScore()) / (movie.getRateCount() + 1));
        movie.setRateCount(movie.getRateCount() + 1);
        if(movieMapper.updateByPrimaryKeySelective(movie) == 0){
            throw new RuntimeException("评分失败，请联系管理员！");
        }
        return ResponseVo.successByMsg(true, "评分成功！");
    }

    /**
     * 重新核算所有电影的电影评分和评分人数
     * @return
     */
    @Override
    public ResponseVo<Boolean> sumRateAndCount() {
        List<Movie> movieList = movieMapper.selectByExample(new MovieExample());
        for(Movie movie : movieList){
            RateExample rateExample = new RateExample();
            rateExample.createCriteria().andMovieIdEqualTo(movie.getId());
            List<Rate> rateList = rateMapper.selectByExample(rateExample);
            movie.setRateCount(rateList.size());
            Integer totalRate = 0;
            for(Rate rate : rateList){
                totalRate = totalRate + rate.getScore();
            }
            if(rateList.size() == 0){
                movie.setRate(0);
            } else {
                movie.setRate(totalRate / rateList.size());
            }
            if(movieMapper.updateByPrimaryKeySelective(movie) == 0){
                return ResponseVo.errorByMsg(CodeMsg.MOVIE_EDIT_ERROR);
            }
        }
        return ResponseVo.success(true);
    }
}
