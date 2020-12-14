package com.dalbit.sample.dao;

import com.dalbit.sample.vo.ErrorVo;
import com.dalbit.sample.vo.SampleVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface SampleDao {

    @Transactional(readOnly = true)
    int getCount();

    @Transactional(readOnly = true)
    List<SampleVo> getList();

    int insertSample(SampleVo sampleVo);

    @Transactional(readOnly = true)
    List<ErrorVo> getLogErrorData(ErrorVo errorVo);

    @Transactional(readOnly = true)
    int getLogErrorDataCnt(ErrorVo errorVo);

    void joinEventReset(String memNo);
}
