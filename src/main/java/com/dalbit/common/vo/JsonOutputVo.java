package com.dalbit.common.vo;

import com.dalbit.common.code.ErrorStatus;
import com.dalbit.common.code.Status;
import com.dalbit.util.DalbitUtil;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;

/**
 * JSON output을 위한 VO
 */
@Getter
@Setter
public class JsonOutputVo {

    public JsonOutputVo(){}

    public JsonOutputVo(Status status){
        setStatus(status);
        setTimestamp(DalbitUtil.getTimeStamp());
    }

    public JsonOutputVo(Status status, Object data){
        setStatus(status);
        setData(data);
        setTimestamp(DalbitUtil.getTimeStamp());
    }

    public JsonOutputVo(Status status, Object data, ArrayList validationMessageDetail){
        setStatus(status);
        setData(data);
        setTimestamp(DalbitUtil.getTimeStamp());

        setValidationMessageDetail(validationMessageDetail);
    }

    public JsonOutputVo(Status status, Object data, PagingVo pagingVo){
        setStatus(status);
        setData(data);
        setTimestamp(DalbitUtil.getTimeStamp());

        setPagingVo(pagingVo);
    }

    public JsonOutputVo(Status status, Object data, PagingVo pagingVo, Object summary){
        setStatus(status);
        setData(data);
        setTimestamp(DalbitUtil.getTimeStamp());

        setPagingVo(pagingVo);
        setSummary(summary);
    }

    public JsonOutputVo(ErrorStatus errorStatus){
        setErrorStatus(errorStatus);
        setTimestamp(DalbitUtil.getTimeStamp());
    }

    public JsonOutputVo(ErrorStatus errorStatus, Object data){
        setErrorStatus(errorStatus);
        setData(data);
        setTimestamp(DalbitUtil.getTimeStamp());
    }

    private String result;

    private String code;
    private String messageKey;
    private String message;

    private Object data = "";

    private PagingVo pagingVo;
    private Object summary;

    private String timestamp;

    private ArrayList validationMessageDetail = new ArrayList<String>();

    public void setStatus(Status status){
        setCode(status.getMessageCode());
        setMessageKey(status.getMessageKey());
        setResult(status.getResult());
    }

    public void setErrorStatus(ErrorStatus errorStatus){
        setCode(errorStatus.getErrorCode());
        setMessageKey(errorStatus.getMessageKey());
        setResult(errorStatus.getResult());
    }

}
