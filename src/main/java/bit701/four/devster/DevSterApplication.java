package bit701.four.devster;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan({"devster.semi.*","naver.cloud"})
@MapperScan({"devster.semi.mapper"})
public class DevSterApplication {
    public static void main(String[] args) {
        SpringApplication.run(DevSterApplication.class, args);
    }
}
