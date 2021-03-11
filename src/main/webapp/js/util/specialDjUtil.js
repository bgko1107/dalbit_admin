/**
 * 공통 자바스크립트 유틸
 */
var specialDjUtil = {};

specialDjUtil.getConditionData = function(code, value){
    if(common.isEmpty(code) || common.isEmpty(value)){
        return '';
    }

    var result;

    if(code == 1){
        result = '{{value}}시간';
        
    }else if(code == 2){
        result = '{{value}}회';
        
    }else if(code == 3){
        result = '{{value}}번';

    }else if(code == 4){
        result = '{{value}}레벨';

    }else if(code == 5){
        result = '{{value}}명';

    }else if(code == 6){
        result = '{{value}}명';

    }else if(code == 7){
        result = '{{value}}별';

    }else if(code == 8){
            result = '{{value}}시간';

    }else if(code == 9){
        result = '{{value}}일';

    }else if(code == 10){
        result = '{{value}}명';

    }else{
        result = value;
    }

    return common.replace(result, '{{value}}', common.addComma(value));

}

specialDjUtil.conditionCheck = function(code, data, value){

}