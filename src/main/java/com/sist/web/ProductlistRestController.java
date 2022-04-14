package com.sist.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.sist.dao.ProductlistDAO;
import com.sist.vo.ApartmentVO;
import com.sist.vo.OfficetelVO;
import com.sist.vo.VillaVO;
@RestController
public class ProductlistRestController {

	@Autowired
	private ProductlistDAO dao;
	
	@PostMapping(value="product/apartmentlist_vue.do",produces="text/plain;charset=utf-8")
	public String apartment_find(@RequestBody String data)
	{
		String[] guList_1 = { "전체", "강서구", "양천구", "구로구", "마포구", "영등포구", "금천구",
			    "은평구", "서대문구", "동작구", "관악구", "종로구", "중구", "용산구", "서초구", "강북구",
			    "성북구", "도봉구", "동대문구", "성동구", "강남구", "노원구", "중랑구", "광진구", "송파구",
			    "강동구" };
		String result="";
		Gson gson = new Gson();
		Map<String,Object> map = gson.fromJson(data, Map.class);
		try{
		 double page = (double) map.get("page"); 
		 String fd = "";
		 String sort = (String)map.get("sort");
		 List checkOption = new ArrayList();
		 checkOption = (List)map.get("checkOption");
		 String gu = (String)map.get("gu");
		 
		 if(gu.startsWith("searchMap")) {
			 fd=guList_1[Integer.parseInt(gu.substring(gu.lastIndexOf("p")+1))];
		 }else {
			 fd=(String)map.get("fd");
		 }
  		 int curpage=(int)page;
  		 int rowSize=20;
  		 int start=(rowSize*curpage)-(rowSize-1);
  		 int end=rowSize*curpage;
  		 Map fmap=new HashMap();
  		 fmap.put("start", start);
  		 fmap.put("end", end);
  		 fmap.put("fd", fd);
  		 fmap.put("optArr",checkOption);
  		 fmap.put("sort",sort);
  		 List<ApartmentVO> list=dao.apartmentFindData(fmap);
  		 int totalCount = dao.apartmentFindTotalcount(fmap);
  		 int totalpage= (int)(Math.ceil(totalCount/20.0));
  		 
  		final int BLOCK=10;
 		int startPage=((curpage-1)/BLOCK*BLOCK)+1;
 		int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
 		if(endPage>totalpage)
 			endPage=totalpage;
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
  				 obj.put("sort",sort);
  			 }
  			 arr.add(obj);
  			 i++;
 		 }
  		 result=gson.toJson(arr);
  	  }catch(Exception ex){
  		  ex.printStackTrace();
  	  }
  	  return result;		
	}
	//오피스텔
	@PostMapping(value="product/officetellist_vue.do",produces="text/plain;charset=utf-8")
	public String officetel_find(@RequestBody String data)
	{
		String[] guList_1 = { "전체", "강서구", "양천구", "구로구", "마포구", "영등포구", "금천구",
				"은평구", "서대문구", "동작구", "관악구", "종로구", "중구", "용산구", "서초구", "강북구",
				"성북구", "도봉구", "동대문구", "성동구", "강남구", "노원구", "중랑구", "광진구", "송파구",
		"강동구" };
		String result="";
		Gson gson = new Gson();
		Map<String,Object> map = gson.fromJson(data, Map.class);
		try{
			double page = (double) map.get("page"); 
			String fd = "";
			String sort = (String)map.get("sort");
			List checkOption = new ArrayList();
			checkOption = (List)map.get("checkOption");
			String gu = (String)map.get("gu");
			
			if(gu.startsWith("searchMap")) {
				fd=guList_1[Integer.parseInt(gu.substring(gu.lastIndexOf("p")+1))];
			}else {
				fd=(String)map.get("fd");
			}
			int curpage=(int)page;
			int rowSize=20;
			int start=(rowSize*curpage)-(rowSize-1);
			int end=rowSize*curpage;
			Map fmap=new HashMap();
			fmap.put("start", start);
			fmap.put("end", end);
			fmap.put("fd", fd);
			fmap.put("optArr",checkOption);
			fmap.put("sort",sort);
			List<OfficetelVO> list=dao.officetelFindData(fmap);
			int totalCount = dao.officetelFindTotalcount(fmap);
			int totalpage= (int)(Math.ceil(totalCount/20.0));
			
			final int BLOCK=10;
			int startPage=((curpage-1)/BLOCK*BLOCK)+1;
			int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
			if(endPage>totalpage)
				endPage=totalpage;
			JSONArray arr=new JSONArray();
			int i=0;
			for(OfficetelVO vo:list)
			{
				JSONObject obj=new JSONObject();//VO가 가지고 있는 데이터 첨부
				obj.put("no", vo.getNo()); //{"no":1}
				obj.put("address", vo.getAddress());
				obj.put("road_name", vo.getRoad_name());
				obj.put("name", vo.getName());
				obj.put("price", vo.getPrice());
				obj.put("construction_year", vo.getConstruction_year());
				obj.put("area_size", vo.getArea_size());
				obj.put("contract_date", vo.getContract_date());
				if(i==0)
				{
					obj.put("curpage", curpage);
					obj.put("totalpage", totalpage);
					obj.put("startPage",startPage);
					obj.put("endPage",endPage);
					obj.put("sort",sort);
				}
				arr.add(obj);
				i++;
			}
			result=gson.toJson(arr);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return result;		
	}
	//오피스텔
	@PostMapping(value="product/villalist_vue.do",produces="text/plain;charset=utf-8")
	public String villa_find(@RequestBody String data)
	{
		String[] guList_1 = { "전체", "강서구", "양천구", "구로구", "마포구", "영등포구", "금천구",
				"은평구", "서대문구", "동작구", "관악구", "종로구", "중구", "용산구", "서초구", "강북구",
				"성북구", "도봉구", "동대문구", "성동구", "강남구", "노원구", "중랑구", "광진구", "송파구",
		"강동구" };
		String result="";
		Gson gson = new Gson();
		Map<String,Object> map = gson.fromJson(data, Map.class);
		try{
			double page = (double) map.get("page"); 
			String fd = "";
			String sort = (String)map.get("sort");
			List checkOption = new ArrayList();
			checkOption = (List)map.get("checkOption");
			String gu = (String)map.get("gu");
			
			if(gu.startsWith("searchMap")) {
				fd=guList_1[Integer.parseInt(gu.substring(gu.lastIndexOf("p")+1))];
			}else {
				fd=(String)map.get("fd");
			}
			int curpage=(int)page;
			int rowSize=20;
			int start=(rowSize*curpage)-(rowSize-1);
			int end=rowSize*curpage;
			Map fmap=new HashMap();
			fmap.put("start", start);
			fmap.put("end", end);
			fmap.put("fd", fd);
			fmap.put("optArr",checkOption);
			fmap.put("sort",sort);
			List<VillaVO> list=dao.villaFindData(fmap);
			int totalCount = dao.villaFindTotalcount(fmap);
			int totalpage= (int)(Math.ceil(totalCount/20.0));
			
			final int BLOCK=10;
			int startPage=((curpage-1)/BLOCK*BLOCK)+1;
			int endPage=((curpage-1)/BLOCK*BLOCK)+BLOCK;
			if(endPage>totalpage)
				endPage=totalpage;
			JSONArray arr=new JSONArray();
			int i=0;
			for(VillaVO vo:list)
			{
				JSONObject obj=new JSONObject();//VO가 가지고 있는 데이터 첨부
				obj.put("no", vo.getNo()); //{"no":1}
				obj.put("address", vo.getAddress());
				obj.put("road_name", vo.getRoad_name());
				obj.put("name", vo.getName());
				obj.put("price", vo.getPrice());
				obj.put("construction_year", vo.getConstruction_year());
				obj.put("area_size", vo.getArea_size());
				obj.put("contract_date", vo.getContract_date());
				if(i==0)
				{
					obj.put("curpage", curpage);
					obj.put("totalpage", totalpage);
					obj.put("startPage",startPage);
					obj.put("endPage",endPage);
					obj.put("sort",sort);
				}
				arr.add(obj);
				i++;
			}
			result=gson.toJson(arr);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return result;		
	}
	
	
}
