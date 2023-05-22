package devster.semi.service;

import org.apache.ibatis.javassist.compiler.ast.StringL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Random;

@Service
public class MailService implements MailServiceInter {

    @Autowired
    JavaMailSender javaMailSender;

    private String ePass;

    @Override
    public MimeMessage createMessage(String to) throws MessagingException, UnsupportedEncodingException {
        System.out.println("메일받을 사용자 : " + to);
        System.out.println("인증번호 : " + ePass);

        MimeMessage message = javaMailSender.createMimeMessage();

        message.addRecipients(Message.RecipientType.TO, to); //메일 받을 사용자
        message.setSubject("[Devster] 이메일 인증번호가 도착하였습니다.");

        String msg = "";
        msg += "<h1>[Devster] 이메일 인증번호는 아래와 같습니다 : <h1>";
        msg += "<div><h1 style='background-color:#8007AD; color:white; width:100%'>" + ePass + "</h1></div>";

        message.setText(msg, "utf-8", "html");
        message.setFrom(new InternetAddress("devster@naver.com", "Dev-ster"));

        return message;
    }

    @Override
    public String createKey() {
        //숫자로 바꿀지 고민

//        int min = 48; //아스키
//        int max = 122; // 아스키 z
//        int StringLength = 6; //코드길이 6
//        Random random = new Random();
//        String key = random.ints(min, max + 1).filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97)).limit(StringLength)
//                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();
//
//        return key;
        int min = 0;
        int max = 9;
        int StringLength = 6;
        Random random = new Random();
        StringBuilder key = new StringBuilder(StringLength);

        for (int i = 0; i < StringLength; i++) {
            int randomnum = min + random.nextInt(max - min + 1);
            key.append(randomnum);
        }
        return key.toString();
    }

    @Override
    public String sendSimpleMessage(String to) throws Exception {

        ePass = createKey(); //인증코드 생성
        MimeMessage message = createMessage(to); // "to"로 메일보내기

        try {
            javaMailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalAccessException();
        }

        return ePass;
    }
}
