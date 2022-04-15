package com.sist.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sist.dao.ProductDAO;
import com.sist.vo.ApartmentVO;
import com.sist.vo.OfficetelVO;
import com.sist.vo.VillaVO;

@Controller
public class ProductController {
	@Autowired
	private ProductDAO dao;
	
	//아파트
	@GetMapping("product/apartmentDetail.do")
	public String apartmetDetail(int no,Model model,HttpServletResponse res)
	{
		Cookie cookie = new Cookie("a"+no, String.valueOf(no));
		cookie.setMaxAge(60*60*24);
		cookie.setPath("/");
		res.addCookie(cookie);
		
		ApartmentVO vo=dao.apartmentDetailData(no);
		
		// 거래금액 억단위 변경
		int price=vo.getPrice();
		int p1=price/10000;
		int p2=price-p1*10000;
		
		// 면적 유형 = 제곱미터 & 평수 
		int area_size1=vo.getArea_size();
		int area_size2=(area_size1*3025)/10000;
		
		// 거래일자 YY/MM/DD 에서 YY년MM월DD일 변경
		Date contract_date=vo.getContract_date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
		String c_date=simpleDateFormat.format(contract_date);
		
		
		// 주소 연결
		String addr_B=vo.getAddress()+vo.getBunji();
		String addr_R=vo.getAddress()+vo.getRoad_name();
		
		// 월별 계약건수
		int ACount=dao.apartment_ACount(vo.getRoad_name());
		int BCount=dao.apartment_BCount(vo.getRoad_name());
		int CCount=dao.apartment_CCount(vo.getRoad_name());
		
		// 해당 매물 다른 계약 건수
		List<ApartmentVO> aSameList=dao.apartmentSameData(vo.getRoad_name());
		
		model.addAttribute("vo", vo);
		model.addAttribute("p1", p1);
		model.addAttribute("p2", p2);
		model.addAttribute("area_size1", area_size1);
		model.addAttribute("area_size2", area_size2);
		model.addAttribute("addr_B", addr_B);
		model.addAttribute("addr_R", addr_R);
		model.addAttribute("c_date", c_date);
		model.addAttribute("ACount", ACount);
		model.addAttribute("BCount", BCount);
		model.addAttribute("CCount", CCount);
		model.addAttribute("aSameList", aSameList);
		return "product/apartmentDetail";
	}
	
	//오피스텔
	@GetMapping("product/officetelDetail.do")
	public String officetelDetail(int no,Model model,HttpServletResponse res)
	{
		OfficetelVO vo=dao.officetelDetailData(no);
		Cookie cookie = new Cookie("o"+no, String.valueOf(no));
		cookie.setMaxAge(60*60*24);
		cookie.setPath("/");
		res.addCookie(cookie);
		
		// 거래금액 억단위 변경
		int price=vo.getPrice();
		int p1=price/10000;
		int p2=price-p1*10000;
		
		// 면적 유형 = 제곱미터 & 평수 
		int area_size1=vo.getArea_size();
		int area_size2=(area_size1*3025)/10000;
		
		// 거래일자 YY/MM/DD 에서 YY년MM월DD일 변경
		Date contract_date=vo.getContract_date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
		String c_date=simpleDateFormat.format(contract_date);
		
		
		// 주소 연결
		String addr_B=vo.getAddress()+vo.getBunji();
		String addr_R=vo.getAddress()+vo.getRoad_name();
		
		// 월별 계약건수
		int ACount=dao.officetel_ACount(vo.getRoad_name());
		int BCount=dao.officetel_BCount(vo.getRoad_name());
		int CCount=dao.officetel_CCount(vo.getRoad_name());
		
		// 해당 매물 다른 계약 건수
		List<OfficetelVO> oSameList=dao.officetelSameData(vo.getRoad_name());
		
		model.addAttribute("vo", vo);
		model.addAttribute("p1", p1);
		model.addAttribute("p2", p2);
		model.addAttribute("area_size1", area_size1);
		model.addAttribute("area_size2", area_size2);
		model.addAttribute("addr_B", addr_B);
		model.addAttribute("addr_R", addr_R);
		model.addAttribute("c_date", c_date);
		model.addAttribute("ACount", ACount);
		model.addAttribute("BCount", BCount);
		model.addAttribute("CCount", CCount);
		model.addAttribute("oSameList", oSameList);
		return "product/officetelDetail";
	}
	
	
	//빌라
		@GetMapping("product/villaDetail.do")
		public String villaDetail(int no,Model model,HttpServletResponse res)
		{
			VillaVO vo=dao.villaDetailData(no);
			Cookie cookie = new Cookie("v"+no, String.valueOf(no));
			cookie.setMaxAge(60*60*24);
			cookie.setPath("/");
			res.addCookie(cookie);
			
			// 거래금액 억단위 변경
			int price=vo.getPrice();
			int p1=price/10000;
			int p2=price-p1*10000;
			
			// 면적 유형 = 제곱미터 & 평수 
			int area_size1=vo.getArea_size();
			int area_size2=(area_size1*3025)/10000;
			
			int area_size3=vo.getLandarea_size();
			int area_size4=(area_size3*3025)/10000;
			
			// 거래일자 YY/MM/DD 에서 YY년MM월DD일 변경
			Date contract_date=vo.getContract_date();
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
			String c_date=simpleDateFormat.format(contract_date);
			
			
			// 주소 연결
			String addr_B=vo.getAddress()+vo.getBunji();
			String addr_R=vo.getAddress()+vo.getRoad_name();
			
			// 월별 계약건수
			int ACount=dao.villa_ACount(vo.getRoad_name());
			int BCount=dao.villa_BCount(vo.getRoad_name());
			int CCount=dao.villa_CCount(vo.getRoad_name());
			
			// 해당 매물 다른 계약 건수
			List<VillaVO> vSameList=dao.villaSameData(vo.getRoad_name());
			
			model.addAttribute("vo", vo);
			model.addAttribute("p1", p1);
			model.addAttribute("p2", p2);
			model.addAttribute("area_size1", area_size1);
			model.addAttribute("area_size2", area_size2);
			model.addAttribute("area_size3", area_size3);
			model.addAttribute("area_size4", area_size4);
			model.addAttribute("addr_B", addr_B);
			model.addAttribute("addr_R", addr_R);
			model.addAttribute("c_date", c_date);
			model.addAttribute("ACount", ACount);
			model.addAttribute("BCount", BCount);
			model.addAttribute("CCount", CCount);
			model.addAttribute("vSameList", vSameList);
			return "product/villaDetail";
		}

/*
		@RequestMapping("product/insertJjim.do")
		public String insertJiim (int no, int type,Model model,RedirectAttributes ra,HttpSession session) {
			String email=(String)session.getAttribute("username");
			System.out.println(email);
			Map map = new HashMap();
			String link="";
			ra.addAttribute("no", no);
			if(type==1) {
				map.put("type","ano");
				link="apartmentDetail";
				map.put("no",no);
				map.put("email",email);
				
			}else if (type==2) {
				map.put("type","ono");
				link="officetelDetail";
				map.put("no",no);
				map.put("email",email);
			}else {
				map.put("type","vno");
				link="villaDetail";
				map.put("no",no);
				map.put("email",email);
			}
			
			dao.insertMarkApart(map);
			
			return "redirect:../product/"+link+".do";
		}
*/
		
}
