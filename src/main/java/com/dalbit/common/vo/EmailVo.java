package com.dalbit.common.vo;

import com.dalbit.util.DalbitUtil;
import lombok.Getter;
import lombok.Setter;
import lombok.SneakyThrows;
import lombok.ToString;

import java.io.UnsupportedEncodingException;

@Getter
@Setter
@ToString
public class EmailVo {

    public EmailVo(String title, String rcvMail, String msgCont) throws UnsupportedEncodingException {
        /*this.title = new String(title.getBytes("utf-8"), "euc-kr");
        this.rcvMemId = new String(rcvMail.getBytes("utf-8"), "euc-kr");
        this.rcvMail = new String(rcvMail.getBytes("utf-8"), "euc-kr");
        this.msgCont = new String(msgCont.getBytes("utf-8"), "euc-kr");*/

        this.title = title;
        this.rcvMemId = rcvMail;
        this.rcvMail = rcvMail;
        this.msgCont = msgCont;
    }

    private String title;       //제목
    private String rcvMemId;    //수신자 아이디
    private String rcvMail;     //수신자 메일주소
    private String sendMail = "help@dalbitlive.com";    //발신자
    private String msgCont;     //내용
    private String sendType = "1";    //발송구분 [코드표참고]
}
