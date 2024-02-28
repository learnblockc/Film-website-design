package com.yjq.programmer.controller.common;

import com.yjq.programmer.util.CaptchaUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author WZX
 * @create 2023-02-25 9:44
 */

/**
 * 验证码生成控制器
 */
@Controller("CaptchaController")
@RequestMapping("/common/captcha")
public class CaptchaController {
    private Logger log = LoggerFactory.getLogger(CaptchaController.class);

    /**
     * 通用验证码生成器
     * @param vcodeLength
     * @param fontSize
     * @param width
     * @param height
     * @param method
     * @param request
     * @param response
     */
    @RequestMapping(value="/generate_captcha",method = RequestMethod.GET)
    public void generateCaptcha(
            @RequestParam(name="vl",defaultValue="4")Integer vcodeLength,//vcodeLength,验证码长度
            @RequestParam(name="fs",defaultValue="21")Integer fontSize,//fontSize,验证码字体大小
            @RequestParam(name="w",defaultValue="98")Integer width,//width,图片宽度
            @RequestParam(name="h",defaultValue="33")Integer height,//height,图片高度
            @RequestParam(name="method")String method,//用来调用此方法的名称，以此名称为键，存入到session中
            HttpServletRequest request,
            HttpServletResponse response){
        CaptchaUtil captchaUtil = new CaptchaUtil(vcodeLength,fontSize,width,height);
        String generatorVCode = captchaUtil.generatorVCode(); //验证码的值
        //将生成的验证码放入session，以供放后面程序的验证使用
        request.getSession().setAttribute(method, generatorVCode);
        log.info("验证码成功生成，method=" + method + ",value=" + generatorVCode);
        try {
            ImageIO.write(captchaUtil.generatorRotateVCodeImage(generatorVCode, true), "gif", response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
