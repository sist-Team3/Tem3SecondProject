package com.sist.vo;

import java.util.*;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ApartmentVO {
	private int no,area_size,price,floor,construction_date,type;
	private String address,bunji,name,road_name,deal_type,agent_seat;
	private Date contract_date;
}
