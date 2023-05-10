package devster.semi.service;

import java.util.HashMap;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class SmsService {
    public void certified(String phonenum,int randomnum) {
        String api_key="NCSO0UIJK1HNMHTV";
        String api_secret="Q6ZY54CAJZAUG73CR8YMHM1FHQIQ1F5Z";
        //net.nurigo
        Message coolsms=new Message(api_key, api_secret);

        HashMap<String, String> map=new HashMap<>();
        map.put("to", phonenum); //수신전화
        map.put("from","01025734177"); //발신전화

        map.put("type","SMS");
        map.put("text", "[Dev-ster] 인증번호 "+"["+randomnum+"]"+"를 입력해주세요.");
        map.put("app_version", "test app 1.2");

        JSONObject obj;
        try {
            obj = (JSONObject) coolsms.send(map);
            System.out.println(obj.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }
    }
}
