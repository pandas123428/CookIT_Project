package com.cookit.order.vo;

import java.util.List;

import org.springframework.stereotype.Component;

@Component("OrderVO")
public class OrderVO {
	private String each_order_id;
	private int order_id;
	private int product_id;
	private int quantity;
	private int order_price;
	
	private String product_name; 
	private String product_image; 
	private int product_price; 
	
	private String user_id;
	private String order_date;
	private String order_state;
	private String payment;
	private int delivery_price;
	private int t_order_price;
	private int cash_point;
	private int use_point;
	private int other_discount_price;
	private int t_discount_price;
	private int f_t_order_price;
	
	
	
	private int delivery_id;
	private String phone_num;
	private String receiver_name;
	private String desired_delivery_date;
	private String delivery_method;
	private String road_address;
	private String namuji_address;
	private String zipcode;
	private String delivery_request;
	
	private List<OrderVO> each_orderList; // 하위 객체 리스트 추가
	
	public OrderVO() {
		
	}
	
	public OrderVO(int order_id, int product_id, int quantity, String product_image, String product_name) {
		this.order_id = order_id;
		this.product_id = product_id;
		this.quantity = quantity;
		this.product_image = product_image;
		this.product_name = product_name;
	}
	
	public OrderVO(int order_id, String user_id, String order_date, int order_price, String payment) {
		this.order_id = order_id;
		this.user_id = user_id;
		this.order_date = order_date;
		this.order_price = order_price;
		this.payment = payment;
	}
	
	public OrderVO(int order_id, int delivery_id, String phone_num, String reciver_name, String desired_delivery_date,
				   String delivery_method, String road_address, String namuji_address, String zipcode, String delivery_request) {
		this.order_id =order_id;
		this.delivery_id = delivery_id;
		this.phone_num = phone_num;
		this.receiver_name = reciver_name;
		this.desired_delivery_date = desired_delivery_date;
		this.delivery_method = delivery_method;
		this.road_address = road_address;
		this.namuji_address = namuji_address;
		this.zipcode = zipcode;
		this.delivery_request = delivery_request;
	}
	
	
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getOrder_state() {
		return order_state;
	}
	public void setOrder_state(String order_state) {
		this.order_state = order_state;
	}
	public int getOrder_price() {
		return order_price;
	}
	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public int getDelivery_id() {
		return delivery_id;
	}
	public void setDelivery_id(int delivery_id) {
		this.delivery_id = delivery_id;
	}
	public String getPhone_num() {
		return phone_num;
	}
	public void setPhone_num(String phone_num) {
		this.phone_num = phone_num;
	}
	public String getReceiver_name() {
		return receiver_name;
	}
	public void setReceiver_name(String reciver_name) {
		this.receiver_name = reciver_name;
	}
	public String getDesired_delivery_date() {
		return desired_delivery_date;
	}
	public void setDesired_delivery_date(String desired_delivery_date) {
		this.desired_delivery_date = desired_delivery_date;
	}
	public String getDelivery_method() {
		return delivery_method;
	}
	public void setDelivery_method(String delivery_method) {
		this.delivery_method = delivery_method;
	}
	public String getRoad_address() {
		return road_address;
	}
	public void setRoad_address(String road_address) {
		this.road_address = road_address;
	}
	public String getNamuji_address() {
		return namuji_address;
	}
	public void setNamuji_address(String namuji_address) {
		this.namuji_address = namuji_address;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getDelivery_request() {
		return delivery_request;
	}
	public void setDelivery_request(String delivery_request) {
		this.delivery_request = delivery_request;
	}
	public String getProduct_image() {
		return product_image;
	}
	public void setProduct_image(String product_image) {
		this.product_image = product_image;
	}
	
	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	
	public int getT_order_price() {
		return t_order_price;
	}

	public void setT_order_price(int t_order_price) {
		this.t_order_price = t_order_price;
	}

	public int getCash_point() {
		return cash_point;
	}

	public void setCash_point(int cash_point) {
		this.cash_point = cash_point;
	}

	public int getUse_point() {
		return use_point;
	}

	public void setUse_point(int use_point) {
		this.use_point = use_point;
	}

	public String getEach_order_id() {
		return each_order_id;
	}

	public void setEach_order_id(String each_order_id) {
		this.each_order_id = each_order_id;
	}

	public int getDelivery_price() {
		return delivery_price;
	}

	public void setDelivery_price(int delivery_price) {
		this.delivery_price = delivery_price;
	}

	public int getOther_discount_price() {
		return other_discount_price;
	}

	public void setOther_discount_price(int other_discount_price) {
		this.other_discount_price = other_discount_price;
	}

	public int getT_discount_price() {
		return t_discount_price;
	}

	public void setT_discount_price(int t_discount_price) {
		this.t_discount_price = t_discount_price;
	}

	public int getF_t_order_price() {
		return f_t_order_price;
	}

	public void setF_t_order_price(int f_t_order_price) {
		this.f_t_order_price = f_t_order_price;
	}

	public List<OrderVO> getEach_orderList() {
		return each_orderList;
	}

	public void setEach_orderList(List<OrderVO> each_orderList) {
		this.each_orderList = each_orderList;
	}	
	
	
	
}
