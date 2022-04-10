package com.sist.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.sist.dao.ProductlistDAO;
import com.sist.vo.ApartmentVO;
@RestController
public class ProductlistRestController {

	@Autowired
	private ProductlistDAO dao;
	
	@RequestMapping(value="product/apartmentlist_vue.do",produces="text/plain;charset=utf-8")
	public String apartment_find(String fd,int page)
	{
		String result="";
		try
  	  {

  		 int curpage=page;
 		System.out.println(curpage);
  		 int rowSize=20;
  		 int start=(rowSize*curpage)-(rowSize-1);
  		 int end=rowSize*curpage;
  		 System.out.println("fd= "+fd);
  		 Map map=new HashMap();
  		 map.put("start", start);
  		 map.put("end", end);
  		 map.put("fd", fd);
  		 List<ApartmentVO> list=dao.apartmentFindData(map);
  		 int totalpage=dao.apartmentFindTotalpage(fd);
  		 Gson gson = new Gson();
//  		 result=gson.toJson(list);
  		 
  		final int BLOCK=10;
 		int startPage=((curpage-1)/BLOCK*BLOCK)+1;
 		int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
  		 JSONArray arr=new JSONArray();
  		 int i=0;
  		 for(ApartmentVO vo:list)
  		 {
  			 JSONObject obj=new JSONObject();//VO가 가지고 있는 데이터 첨부
  			 obj.put("no", vo.getNo()); //{"no":1}
  			 obj.put("address", vo.getAddress());
  			 obj.put("road_name", vo.getRoad_name());
  			 obj.put("name", vo.getName());
  			 obj.put("price", vo.getPrice());
  			 obj.put("construction_date", vo.getConstruction_date());
  			 obj.put("area_size", vo.getArea_size());
  			 obj.put("contract_date", vo.getContract_date());
  			 if(i==0)
  			 {
  				 obj.put("curpage", curpage);
  				 obj.put("totalpage", totalpage);
  				 obj.put("startPage",startPage);
  				 obj.put("endPage",endPage);
  			 }
  			 arr.add(obj);
  			 i++;
  		 }
  		 result=gson.toJson(arr);
  		 System.out.println(startPage);
  		 System.out.println(endPage);
  	  }catch(Exception ex){
  		  ex.printStackTrace();
  	  }
  	  return result;		
	}
	
	
}
