package com.yjq.programmer.exception;


import com.yjq.programmer.bean.CodeMsg;
import com.yjq.programmer.util.CommonUtil;
import com.yjq.programmer.vo.ResponseVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

/**
 * @author WZX
 * @create 2023-03-24 8:58
 */

/**
 * 运行时触发异常捕获
 */
@ControllerAdvice
public class ExceptionsHandler {

    private  final Logger logger = LoggerFactory.getLogger(ExceptionsHandler.class);

    @ExceptionHandler(RuntimeException.class)
    @ResponseBody
    public ResponseVo<Boolean> handle(RuntimeException e) {
        e.printStackTrace();
        if(!CommonUtil.isEmpty(e.getMessage())) {
            logger.info("异常信息={}", e.getMessage());
            if ("生成订单失败，请稍后重试！".equals(e.getMessage())) {
                return ResponseVo.errorByMsg(CodeMsg.ORDER_ADD_ERROR);
            }
            if ("订单信息删除失败，请联系管理员！".equals(e.getMessage())) {
                return ResponseVo.errorByMsg(CodeMsg.ORDER_DELETE_ERROR);
            }
            if ("评分失败，请联系管理员！".equals(e.getMessage())) {
                return ResponseVo.errorByMsg(CodeMsg.RATE_ADD_ERROR);
            }
        }
        return ResponseVo.errorByMsg(CodeMsg.SYSTEM_ERROR);
    }

    @ExceptionHandler(MaxUploadSizeExceededException.class)
    @ResponseBody
    public ResponseVo<Boolean> handle(MaxUploadSizeExceededException e) {
        e.printStackTrace();
        return ResponseVo.errorByMsg(CodeMsg.PHOTO_SURPASS_MAX_SIZE);
    }
}
