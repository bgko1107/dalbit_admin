package com.dalbit.content.dao;

import com.dalbit.content.vo.SitebanVo;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface SitebanDao {

    @Transactional(readOnly = true)
    SitebanVo selectBanword(SitebanVo sitebanVo);

    int updateBanword(SitebanVo sitebanVo);

    @Transactional(readOnly = true)
    String excelBanword(SitebanVo sitebanVo);
}
