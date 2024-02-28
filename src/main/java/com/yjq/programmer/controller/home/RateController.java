package com.yjq.programmer.controller.home;

import com.yjq.programmer.constant.RuntimeConstant;
import com.yjq.programmer.domain.Rate;
import com.yjq.programmer.domain.User;
import com.yjq.programmer.service.IRateService;
import com.yjq.programmer.vo.ResponseVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * @author WZX
 * @create 2023-03-23 8:58
 */
@Controller("HomeRateController")
@RequestMapping("/home/rate")
public class RateController {

    @Resource
    private IRateService rateService;

    /**
     * 电影评分操作处理
     * @param rate
     * @param request
     * @return
     */
    @RequestMapping(value="/rate",method = RequestMethod.POST)
    @ResponseBody
    public ResponseVo<Boolean> rateMovie(Rate rate, HttpServletRequest request){
        User user = (User) request.getSession().getAttribute(RuntimeConstant.HOME_USER);
        rate.setUserId(user.getId());
        return rateService.rateMovie(rate);
    }
}
