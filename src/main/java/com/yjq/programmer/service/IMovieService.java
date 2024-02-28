package com.yjq.programmer.service;

import com.yjq.programmer.domain.Movie;
import com.yjq.programmer.domain.MovieListSearch;
import com.yjq.programmer.domain.Page;
import com.yjq.programmer.vo.ResponseVo;

import java.util.List;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */
public interface IMovieService {

    // 封装分页数据
    ResponseVo<Page> getPage(Page page, String name);

    // 获取电影列表数据
    ResponseVo<List<Movie>> list(String name, Page page);

    // 获取电影的总数
    ResponseVo<Integer> getTotal();

    // 根据评分获取前三个电影数据
    ResponseVo<List<Movie>> getMovieByRate();

    // 保存电影信息
    ResponseVo<Boolean> save(Movie movie);

    // 删除电影信息
    ResponseVo<Boolean> delete(String id);

    // 根据电影id获取电影信息
    ResponseVo<Movie> findById(String id);

    // 根据搜索条件获取电影列表
    ResponseVo<List<Movie>> getMovieListBySearch(MovieListSearch movieListSearch, Page page);

    // 根据搜索条件获取分页数据
    ResponseVo<Page> getPageBySearch(Page page, MovieListSearch movieListSearch);
}
