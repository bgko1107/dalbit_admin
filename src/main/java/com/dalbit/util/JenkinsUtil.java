package com.dalbit.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.HashMap;

@Slf4j
@Component
public class JenkinsUtil {

    @Value("${jenkins.url}")
    private String JENKINS_URL;

    @Value("${jenkins.job.image.name}")
    private String JENKINS_JOB_IMAGE_NAME;

    @Value("${jenkins.user.name}")
    private String JENKINS_USER_NAME;

    @Value("${jenkins.rest.api.key}")
    private String JENKINS_REST_API_KEY;

    public HashMap imageBuild(){

        HashMap map = new HashMap();
        boolean isSuccess = false;

        try {
            //http://devm.dalbitlive.com:8180/jenkins/job/dalbit_sync_IMAGE.dalbitlive.com/buildWithParameters
            URL url = new URL(JENKINS_URL + "/job/" + JENKINS_JOB_IMAGE_NAME + "/buildWithParameters");
            String user = JENKINS_USER_NAME;
            String pass = JENKINS_REST_API_KEY;
            String authStr = user + ":" + pass;
            String encoding = Base64.getEncoder().encodeToString(authStr.getBytes("utf-8"));

            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            connection.setRequestProperty("Authorization", "Basic " + encoding);

            //parameter 세팅부분.. 젠킨스에서 [yes] 입력하는 부분 처리
            String urlParams = "Are_You_Sure=yes";
            byte[] postData = urlParams.getBytes("utf-8");
            try (DataOutputStream wr = new DataOutputStream(connection.getOutputStream())) {
                wr.write(postData);
            }

            InputStream content = connection.getInputStream();
            BufferedReader in = new BufferedReader(new InputStreamReader(content));
            String line;
            while ((line = in.readLine()) != null) {
                System.out.println(line);
            }

            isSuccess = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        map.put("result", isSuccess);

        return map;
    }
}
