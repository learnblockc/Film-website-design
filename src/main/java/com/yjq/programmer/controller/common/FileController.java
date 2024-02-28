package com.yjq.programmer.controller.common;

import com.yjq.programmer.bean.CodeMsg;
import com.yjq.programmer.constant.RuntimeConstant;
import com.yjq.programmer.util.CommonUtil;
import com.yjq.programmer.vo.ResponseVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;

/**
 * @author WZX
 * @create 2023-02-24 8:58
 */
@Controller("FileController")
@RequestMapping("/common/file")
public class FileController {

    private Logger logger = LoggerFactory.getLogger(FileController.class);

    @Autowired
    private ResourceLoader resourceLoader;

    /**
     * 上传图片统一处理
     * @param photo
     * @param request
     * @return
     */
    @RequestMapping(value="/upload_photo",method= RequestMethod.POST)
    @ResponseBody
    public ResponseVo<String> uploadPhoto(MultipartFile photo, HttpServletRequest request){
        if(photo == null){
            return ResponseVo.errorByMsg(CodeMsg.PHOTO_EMPTY);
        }
        //检查上传文件大小 不能超过1MB
        if(photo.getSize() > 1 * 1024* 1024) {
            return ResponseVo.errorByMsg(CodeMsg.PHOTO_SURPASS_MAX_SIZE);
        }
        //获取文件后缀
        String suffix = photo.getOriginalFilename().substring(photo.getOriginalFilename().lastIndexOf(".")+1,photo.getOriginalFilename().length());
        if(!CommonUtil.isPhoto(suffix)){
            return ResponseVo.errorByMsg(CodeMsg.PHOTO_FORMAT_NOT_CORRECT);
        }
        String path = request.getContextPath();
        String savePath = RuntimeConstant.BASE_UPLOAD_PHOTO_PATH + CommonUtil.getFormatterDate(new Date(), "yyyyMMdd") + "\\";
        File savePathFile = new File(savePath);
        if(!savePathFile.exists()){
            //若不存在改目录，则创建目录
            savePathFile.mkdir();
        }
        String filename = new Date().getTime()+"."+suffix;
        logger.info("保存图片的路径:{}",savePath + filename);
        try {
            //将文件保存至指定目录
            photo.transferTo(new File(savePath + filename));
        }catch (Exception e) {
            e.printStackTrace();
            return ResponseVo.errorByMsg(CodeMsg.SAVE_FILE_EXCEPTION);
        }
        String filepath = "../resources/upload/" + CommonUtil.getFormatterDate(new Date(), "yyyyMMdd") + "/" + filename;
        return ResponseVo.successByMsg(filepath, "图片上传成功！");
    }

    /**
     * 系统统一的图片查看方法
     * @param filename
     * @return
     */
    @RequestMapping(value="/view_photo")
    @ResponseBody
    public ResponseEntity<?> viewPhoto(@RequestParam(name="filename",required=true)String filename){
        String uploadPhotoPath = RuntimeConstant.BASE_UPLOAD_PHOTO_PATH;
        String fileDate = CommonUtil.getFileDate(filename); //取得文件路径中的日期部分
        logger.info("文件路径中日期部分：{}",fileDate);
        filename = "\\" + filename.substring(filename.lastIndexOf("/") + 1); //取得文件名
        Resource resource = resourceLoader.getResource("file:" + uploadPhotoPath + fileDate + filename);
        logger.info("查看图片路径:{}",uploadPhotoPath + fileDate + filename);
        try {
            return ResponseEntity.ok(resource);
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }
}
