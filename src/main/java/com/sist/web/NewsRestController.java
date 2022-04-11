package com.sist.web;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class NewsRestController {
	
	@GetMapping(value="news/data.do",produces = "text/plain;charset=utf-8")
	public String getNewsData(String fd) throws Exception {
		String client_Id = "Nl8bSCNGtMche3Q6TLT1";
		String client_Secret = "uVSF_3ROmh";
		String text = URLEncoder.encode(fd, "UTF-8");
		final String URL = "https://openapi.naver.com/v1/search/news?query="+text+"&display=20&start=1&sort=sim";
		URL url = new URL(URL);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("X-Naver-Client-Id", client_Id);
		con.setRequestProperty("X-Naver-Client-Secret", client_Secret);
		int responseCode = con.getResponseCode();
		BufferedReader br;
        if(responseCode==200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        } else {  // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        }
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            response.append(inputLine);
        }
        br.close();
		String result = response.toString();
		result= result.replaceAll("&quot;", "\\\\\"").replaceAll("</?b>","").replaceAll("<br>", "\n");
		
		JSONParser jpar= new JSONParser();
		JSONObject jobj= new JSONObject();
		JSONArray jarr=new JSONArray();
		
		jobj=(JSONObject) jpar.parse(result);
		jarr =(JSONArray) jobj.get("items");
		
		JSONArray resultArr= new JSONArray();
		for(int i=0;i<jarr.size();i++) {
			JSONObject obj= (JSONObject) jarr.get(i);
			Map map = new HashMap();
			String link= (String)obj.get("link");
			Document news = Jsoup.connect(link).get();
			Element newsImg= news.selectFirst(".end_photo_org img");
			if(newsImg!=null) {
				String imgLink= newsImg.attr("src");
				imgLink=imgLink.substring(0,imgLink.lastIndexOf("?"));
				System.out.println(imgLink);
				obj.put("img", imgLink);
				resultArr.add(obj);
			}else {
				resultArr.add(obj);
			}
		}
		return resultArr.toJSONString();
	}
}
