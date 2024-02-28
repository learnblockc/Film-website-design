package com.yjq.programmer.service.impl;

import com.github.pagehelper.PageHelper;
import com.yjq.programmer.bean.CodeMsg;
import com.yjq.programmer.dao.*;
import com.yjq.programmer.domain.*;
import com.yjq.programmer.service.IMovieService;
import com.yjq.programmer.util.CommonUtil;
import com.yjq.programmer.util.UuidUtil;
import com.yjq.programmer.util.ValidateEntityUtil;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
@Service
@Transactional
public class MovieServiceImpl implements IMovieService {

    @Resource
    private MovieMapper movieMapper;

    @Resource
    private CommentMapper commentMapper;

    @Resource
    private ActorMapper actorMapper;

    @Resource
    private SessionMapper sessionMapper;

    @Resource
    private RateMapper rateMapper;

    /**
     * 封装分页数据
     * @param page
     * @param name
     * @return
     */
    @Override
    public ResponseVo<Page> getPage(Page page, String name) {
        MovieExample movieExample = new MovieExample();
        movieExample.createCriteria().andNameLike('%'+name+'%');
        page.setTotalCount(movieMapper.countByExample(movieExample));
        return ResponseVo.success(page);
    }

    /**
     * 获取电影列表数据
     * @param name
     * @param page
     * @return
     */
    @Override
    public ResponseVo<List<Movie>> list(String name, Page page) {
        MovieExample movieExample = new MovieExample();
        if(!CommonUtil.isEmpty(name)){
            // 进行了搜索
            movieExample.createCriteria().andNameLike('%' + name + '%');
        }
        PageHelper.startPage(page.getPage(), page.getRows());
        List<Movie> movieList = movieMapper.selectByExample(movieExample);
        return ResponseVo.success(movieList);
    }

    /**
     * 获取电影的总数
     * @return
     */
    @Override
    public ResponseVo<Integer> getTotal() {
        return ResponseVo.success(movieMapper.countByExample(new MovieExample()));
    }

    /**
     * 根据评分获取前三个电影数据
     * @return
     */
    @Override
    public ResponseVo<List<Movie>> getMovieByRate() {
        MovieExample movieExample = new MovieExample();
        movieExample.setOrderByClause("rate desc");
        PageHelper.startPage(1, 3);
        List<Movie> movieList = movieMapper.selectByExample(movieExample);
        return ResponseVo.success(movieList);
    }

    /**
     * 保存电影信息
     * @param movie
     * @return
     */
    @Override
    public ResponseVo<Boolean> save(Movie movie) {
        if(movie == null){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 进行统一表单验证
        CodeMsg validate = ValidateEntityUtil.validate(movie);
        if (!validate.getCode().equals(CodeMsg.SUCCESS.getCode())) {
            return ResponseVo.errorByMsg(validate);
        }
        if(CommonUtil.isEmpty(movie.getId())){
            // 添加操作
            // 判断电影名称是否存在
            if(isMovieNameExist(movie, "")){
                return ResponseVo.errorByMsg(CodeMsg.MOVIE_NAME_EXIST);
            }
            movie.setId(UuidUtil.getShortUuid());
            if(movieMapper.insertSelective(movie) == 0){
                return ResponseVo.errorByMsg(CodeMsg.MOVIE_ADD_ERROR);
            }
        }else {
            // 修改操作
            // 判断电影名称是否存在
            if(isMovieNameExist(movie, movie.getId())){
                return ResponseVo.errorByMsg(CodeMsg.MOVIE_NAME_EXIST);
            }
            if(movieMapper.updateByPrimaryKeySelective(movie) == 0){
                return ResponseVo.errorByMsg(CodeMsg.MOVIE_EDIT_ERROR);
            }
        }
        return ResponseVo.success(true);
    }

    /**
     * 删除电影信息
     * @param id
     * @return
     */
    @Override
    public ResponseVo<Boolean> delete(String id) {
        if(CommonUtil.isEmpty(id)){
            return ResponseVo.errorByMsg(CodeMsg.DATA_ERROR);
        }
        // 删除评论信息
        CommentExample commentExample = new CommentExample();
        commentExample.createCriteria().andMovieIdEqualTo(id);
        commentMapper.deleteByExample(commentExample);
        // 删除演职人员信息
        ActorExample actorExample = new ActorExample();
        actorExample.createCriteria().andMovieIdEqualTo(id);
        actorMapper.deleteByExample(actorExample);
        // 删除场次信息
        SessionExample sessionExample = new SessionExample();
        sessionExample.createCriteria().andMovieIdEqualTo(id);
        sessionMapper.deleteByExample(sessionExample);
        // 删除评分信息
        RateExample rateExample = new RateExample();
        rateExample.createCriteria().andMovieIdEqualTo(id);
        rateMapper.deleteByExample(rateExample);
        // 删除电影信息
        if(movieMapper.deleteByPrimaryKey(id) == 0){
            return ResponseVo.errorByMsg(CodeMsg.MOVIE_DELETE_ERROR);
        }
        return ResponseVo.success(true);
    }

    /**
     * 根据电影id获取电影信息
     * @param id
     * @return
     */
    @Override
    public ResponseVo<Movie> findById(String id) {
        if(CommonUtil.isEmpty(id)){
            return ResponseVo.success(new Movie());
        }
        Movie movie = movieMapper.selectByPrimaryKey(id);
        return ResponseVo.success(movie);
    }

    /**
     * 根据搜索条件获取电影列表
     * @param movieListSearch
     * @param page
     * @return
     */
    @Override
    public ResponseVo<List<Movie>> getMovieListBySearch(MovieListSearch movieListSearch, Page page) {
        MovieExample movieExample = new MovieExample();
        MovieExample.Criteria criteria = movieExample.createCriteria();
        if(!CommonUtil.isEmpty(movieListSearch.getName())){
            criteria.andNameLike("%" + movieListSearch.getName() + "%");
        }
        if(!"0".equals(movieListSearch.getType())){
            criteria.andTypeEqualTo(movieListSearch.getType());
        }
        if(!"0".equals(movieListSearch.getArea())){
            criteria.andAreaEqualTo(movieListSearch.getArea());
        }
        if(!"0".equals(movieListSearch.getTime())){
            switch (movieListSearch.getTime()){
                case "1":
                    criteria.andCreateTimeBetween(
                            CommonUtil.getFormatterDate("2023-01-01 00:00:00", "yyyy-MM-dd HH:mm:ss"),
                            CommonUtil.getFormatterDate("2023-12-31 23:59:59", "yyyy-MM-dd HH:mm:ss")
                    );
                    break;
                case "2":
                    criteria.andCreateTimeBetween(
                            CommonUtil.getFormatterDate("2022-01-01 00:00:00", "yyyy-MM-dd HH:mm:ss"),
                            CommonUtil.getFormatterDate("2022-12-31 23:59:59", "yyyy-MM-dd HH:mm:ss")
                    );
                    break;
                case "3":
                    criteria.andCreateTimeBetween(
                            CommonUtil.getFormatterDate("2021-01-01 00:00:00", "yyyy-MM-dd HH:mm:ss"),
                            CommonUtil.getFormatterDate("2021-12-31 23:59:59", "yyyy-MM-dd HH:mm:ss")
                    );
                    break;
                default:
                    break;
            }
        }
        if(!"0".equals(movieListSearch.getSort())){
            switch (movieListSearch.getSort()){
                case "1":
                    movieExample.setOrderByClause("create_time desc");
                    break;
                case "2":
                    movieExample.setOrderByClause("rate desc");
                    break;
                default:
                    break;
            }
        }
        PageHelper.startPage(page.getPage(), page.getRows());
        List<Movie> movieList = movieMapper.selectByExample(movieExample);
        return ResponseVo.success(movieList);
    }

    /**
     * 根据搜索条件获取分页数据
     * @param page
     * @param movieListSearch
     * @return
     */
    @Override
    public ResponseVo<Page> getPageBySearch(Page page, MovieListSearch movieListSearch) {
        int total = movieMapper.countByExample(new MovieExample());
        page.setRows(total);
        page.setTotalCount(getMovieListBySearch(movieListSearch, page).getData().size());
        page.setRows(15);
        return ResponseVo.success(page);
    }

    /**
     * 判断电影名称是否重复
     * @param movie
     * @param id
     * @return
     */
    public Boolean isMovieNameExist(Movie movie, String id) {
        MovieExample movieExample = new MovieExample();
        movieExample.createCriteria().andNameEqualTo(movie.getName());
        List<Movie> selectedMovieList = movieMapper.selectByExample(movieExample);
        if(selectedMovieList != null && selectedMovieList.size() > 0) {
            if(selectedMovieList.size() > 1){
                return true; //出现重名
            }
            if(!selectedMovieList.get(0).getId().equals(id)) {
                return true; //出现重名
            }
        }
        return false;//没有重名
    }
}
