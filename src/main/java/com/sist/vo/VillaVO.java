package com.sist.vo;

import java.util.*;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VillaVO {
	private int no,area_size,landarea_size,price,floor,construction_year;
	private String address,bunji,name,road_name,deal_type,agent_seat;
	private Date construct_year,contract_date;
}
