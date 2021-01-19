package com.dalbit.member.vo.procedure;

import com.dalbit.common.vo.BaseVo;
import com.google.gson.Gson;
import lombok.Getter;
import lombok.Setter;
import org.json.JSONException;
import org.json.JSONObject;

@Getter
@Setter
public class P_MemberEditorVo extends BaseVo {
    private String  mem_no;
    private String  reset_profileImage;
    private String  profileImage;
    private String	phoneNum;
    private String	nickName;
    private String	name;
    private String  birthDate;
    private String	memSex;
    private String	passwdReset;
    private String	photoUrl;
    private String  sendNoti;
    private String  notiContents;
    private String  notiMemo;
    private String  notiSms;
    private String  socialId;
    private String  before_socialId;
    private String  editContents;
    private String  beforProfileImage;
    private String  beforNickName;
    private int type;
    private String memState;
    private String profileMsg;

    // 방송방 숨김상태
    private String room_no;
    private int hide;
    private String title;

    // 달 별 추가 Cnt
    private int beforDalCnt;
    private int afterDalCnt;
    private int addDalCnt;
    private int minusDalCnt;
    private int beforByeolCnt;
    private int afterByeolCnt;
    private int addByeolCnt;
    private String use_contents;
    private String pointEditStroy;

    private int dalSlct;
    private int dalType;
    private String useContents;
    private String addContents;


    private P_MemberInfoOutputVo beforeMemberData;

    public void setBeforeMemberData(String beforeMemberData){
        try {
            new JSONObject(beforeMemberData);

            this.beforeMemberData = new Gson().fromJson(beforeMemberData, P_MemberInfoOutputVo.class);

        } catch (JSONException ex) {
            this.beforeMemberData = null;
        }
    }
}

