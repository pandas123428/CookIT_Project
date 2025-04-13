package com.cookit.cart.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.cookit.cart.dao.CartDAO;
import com.cookit.cart.vo.CartVO;
import com.cookit.product.vo.ProductVO;

@Service("cartService")
@Transactional(propagation=Propagation.REQUIRED)
public class CartServiceImpl  implements CartService{
	@Autowired
	private CartDAO cartDAO;
	
	public Map<String ,List> myCartList(CartVO cartVO) throws Exception{
		Map<String,List> cartMap=new HashMap<String,List>();
		List<CartVO> myCartList=cartDAO.selectCartList(cartVO);
		if(myCartList.size()==0){ //카트에 저장된 상품이없는 경우
			return null;
		}
		List<ProductVO> myProductList=cartDAO.selectProductList(myCartList);
		cartMap.put("myCartList", myCartList);
		cartMap.put("myProductList",myProductList);
		System.out.println("장바구니 리스트: " + myCartList);
		System.out.println("상품 리스트: " + myProductList);
		return cartMap;
	}
	
	public boolean findCartProduct(CartVO cartVO) throws Exception{
		 return cartDAO.selectCountInCart(cartVO);
		
	}	
	public void addProductInCart(CartVO cartVO) throws Exception{
		cartDAO.insertProductInCart(cartVO);
	}
	
	public boolean modifyCartQty(CartVO cartVO) throws Exception{
		boolean result=true;
		cartDAO.updateCartProductQty(cartVO);
		return result;
	}
	public void removeCartProduct(int cart_id) throws Exception{
		cartDAO.deleteCartProduct(cart_id);
	}
	
}
