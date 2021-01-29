package com.dalbit.content.dao;

import com.dalbit.content.vo.*;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface Con_PhotoEventDao {

    @Transactional(readOnly = true)
    int selectPhotoShotCnt(PhotoShotVo photoShotVo);
    @Transactional(readOnly = true)
    List<PhotoShotVo> selectPhotoShotList(PhotoShotVo photoShotVo);

    int deleteEventMember(PhotoShotVo photoShotVo);

    int deletePhotoShot(PhotoShotVo photoShotVo);

    int updatePhotoGood(PhotoShotVo photoShotVo);

    List<EventMemberVo> selectEventMemberList(EventMemberVo eventMemberVo);
    int selectEventMemberCnt(EventMemberVo eventMemberVo);

    List<PhotoShotVo> selectWebcamList(PhotoShotVo photoShotVo);
    int selectWebcamCnt(PhotoShotVo photoShotVo);

}
