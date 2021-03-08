package com.dalbit.payment.controller.rest;

import com.dalbit.exception.GlobalException;
import com.dalbit.payment.dao.Pay_CancelDao;
import com.dalbit.payment.service.Pay_CancelService;
import com.dalbit.payment.vo.*;
import com.dalbit.util.GsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;

@Slf4j
@RestController
@RequestMapping("/rest/payment/pay/cancel")
public class Pay_CancelRestController {

    @Autowired
    Pay_CancelService payCancelService;

    @Autowired
    Pay_CancelDao payCancelDao;

    @Autowired
    GsonUtil gsonUtil;

    /**
     *  신용카드 결제 취소
     */
    @PostMapping("card")
    public String payCancelCard(Pay_CancelCardVo payCancelCardVo) throws GlobalException {

        String result = payCancelService.payCancelCard(payCancelCardVo);
        return result;
    }

    /**
     *  휴대폰 결제 취소
     */
    @PostMapping("phone")
    public String payCancelPhone(Pay_CancelPhoneVo payCancelPhoneVo) throws GlobalException {

        String result = payCancelService.payCancelPhone(payCancelPhoneVo);
        return result;
    }


    /**
     *  페이레터 결제 취소
     */
    @PostMapping("payletter")
    public String payletterCancel(Pay_CancelPayletterVo payCancelPayletterVo, HttpServletRequest request) throws GlobalException {

        String result = payCancelService.payletterCancel(payCancelPayletterVo, request);
        return result;
    }


    /**
     *  문화상품권 결제 취소
     */
    @PostMapping("gm")
    public String payCancelGm(Pay_CancelGiftVo payCancelGiftVo) throws GlobalException {

        String result = payCancelService.payCancelGm(payCancelGiftVo);
        return result;
    }


    /**
     *  게임문화상품권 결제 취소
     */
    @PostMapping("gg")
    public String payCancelGg(Pay_CancelGiftVo payCancelGiftVo) throws GlobalException {

        String result = payCancelService.payCancelGg(payCancelGiftVo);
        return result;
    }


    /**
     *  도서문화상품권 결제 취소
     */
    @PostMapping("gc")
    public String payCancelGc(Pay_CancelGiftVo payCancelGiftVo) throws GlobalException {

        String result = payCancelService.payCancelGc(payCancelGiftVo);
        return result;
    }


    /**
     *  해피머니상품권 결제 취소
     */
    @PostMapping("hm")
    public String payCancelHm(Pay_CancelGiftVo payCancelGiftVo) throws GlobalException {

        String result = payCancelService.payCancelHm(payCancelGiftVo);
        return result;
    }


    /**
     * 카카오페이(머니) 결제 취소
     */
    @PostMapping("kakaoMoney")
    public String payCancelKakaoMoney(Pay_CancelKakaoPayVo payCancelKakaoPayVo) throws GlobalException {
        String result = payCancelService.payCancelKakaoMoney(payCancelKakaoPayVo);
        return result;
    }

    /**
     * 간편결제(계좌) 결제 취소
     */
    @PostMapping("simple")
    public String payCancelSimple(Pay_CancelSimplePayVo payCancelSimplePayVo) throws GlobalException, NoSuchPaddingException, InvalidKeyException, UnsupportedEncodingException, IllegalBlockSizeException, BadPaddingException, NoSuchAlgorithmException, InvalidAlgorithmParameterException, ParseException {
        String result = payCancelService.payCancelSimple(payCancelSimplePayVo);
        return result;
    }


}
