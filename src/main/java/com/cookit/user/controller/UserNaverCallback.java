package com.cookit.user.controller;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.cookit.user.service.UserService;
import com.cookit.user.vo.UserVO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/naverUser")
public class UserNaverCallback {

    private static final String CLIENT_ID = "8O_1bqGXuNneG4LZnXdZ";
    private static final String CLIENT_SECRET = "0Sy0ZAZ93h";

    @Autowired
    private UserService userService;

    @RequestMapping("/UserNaverCallback.do")
    public ModelAndView handleNaverCallback(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String code = request.getParameter("code");
        String state = request.getParameter("state");

        HttpSession session = request.getSession();
        String sessionState = (String) session.getAttribute("naverState");

        if (code == null || state == null || !state.equals(sessionState)) {
            mav.addObject("error", "🚨 네이버 로그인 인증 코드 또는 상태 값이 유효하지 않습니다.");
            mav.setViewName("errorPage");
            return mav;
        }

        try {
            String tokenUrl = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
                    + "&client_id=" + CLIENT_ID
                    + "&client_secret=" + CLIENT_SECRET
                    + "&code=" + code
                    + "&state=" + state;
            String accessToken = getAccessToken(tokenUrl);

            // 네이버 사용자 정보를 UserVO에 직접 저장
            UserVO userVO = getUserInfo(accessToken);

            // 세션에 UserVO 저장
            session.setAttribute("isLogOn", true);
            session.setAttribute("userInfo", userVO);

            insertOrUpdateUser(userVO);

            String redirectUrl = (String) session.getAttribute("redirectUrl");
            if (redirectUrl != null) {
                session.removeAttribute("redirectUrl");
                mav.setViewName("redirect:" + redirectUrl);
            } else {
                mav.setViewName("redirect:/main/main.do");
            }
        } catch (Exception e) {
            e.printStackTrace();
            mav.addObject("error", "네이버 로그인 중 오류 발생: " + e.getMessage());
            mav.setViewName("errorPage");
        }
        return mav;
    }

    private void insertOrUpdateUser(UserVO userVO) throws Exception {
        if (userService.isNaverUserExists(userVO.getUser_id())) {
            userService.updateNaverUser(userVO);
        } else {
            userService.insertNaverUser(userVO);
        }
    }

    private String getAccessToken(String apiUrl) throws IOException {
        URL url = new URL(apiUrl);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");

        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String response = br.readLine();
        br.close();

        Gson gson = new Gson();
        return gson.fromJson(response, JsonObject.class).get("access_token").getAsString();
    }

    private UserVO getUserInfo(String accessToken) throws IOException {
        String apiURL = "https://openapi.naver.com/v1/nid/me";
        URL url = new URL(apiURL);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Authorization", "Bearer " + accessToken);

        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String response = br.readLine();
        br.close();

        Gson gson = new Gson();
        JsonObject userInfo = gson.fromJson(response, JsonObject.class).getAsJsonObject("response");

        UserVO userVO = new UserVO();
        userVO.setUser_id(userInfo.has("id") ? userInfo.get("id").getAsString() : "");
        userVO.setUsername(userInfo.has("name") ? userInfo.get("name").getAsString() : "");
        String email = userInfo.has("email") ? userInfo.get("email").getAsString() : "unknown@example.com";
        if (email.contains("@")) {
            String[] emailParts = email.split("@");
            userVO.setEmail1(emailParts[0]);
            userVO.setEmail2(emailParts[1]);
        }
        userVO.setPhone_num(userInfo.has("mobile") ? userInfo.get("mobile").getAsString() : "");
        userVO.setRoadAddress("도로명 주소 기본값");
        userVO.setJibunAddress("지번 주소 기본값");
        userVO.setNamujiAddress("나머지 주소 기본값");
        userVO.setZipcode("우편번호 기본값");

        // 네이버의 gender 값 변환 ('M' -> 'male', 'F' -> 'female')
        String gender = userInfo.has("gender") ? userInfo.get("gender").getAsString() : "";
        if ("M".equalsIgnoreCase(gender)) {
            userVO.setGender("male");
        } else if ("F".equalsIgnoreCase(gender)) {
            userVO.setGender("female");
        } else {
            userVO.setGender("unknown");
        }
        userVO.setUser_type("Naver");
        return userVO;
    }
}
