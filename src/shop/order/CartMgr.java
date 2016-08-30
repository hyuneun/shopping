package shop.order;

import java.util.Hashtable;import org.apache.catalina.util.Introspection;

import shop.product.OrderBean;

public class CartMgr {
	private Hashtable  hCart = new Hashtable<>();
	
	public void addCart(OrderBean obean){
		String product_no = obean.getProduct_no();
		int quantity = Integer.parseInt(obean.getQuantify());
		
		if(quantity > 0){
			//동일 상품 주문여부확인
			if(hCart.containsKey(product_no)){
				//System.out.println("gggg");
				OrderBean temp = (OrderBean)hCart.get(product_no);
				quantity += Integer.parseInt(temp.getQuantify());
				temp.setQuantify(Integer.toString(quantity));
				hCart.put(product_no, temp);
				//System.out.println(quantity);
			}else{//새상품
				//System.out.println("1");
				hCart.put(product_no, obean);
			}
			
			
		}
	}
	
	public Hashtable getCartList(){
		return hCart;
	}
	
	public void updateCart(OrderBean obean){
		String product_no = obean.getProduct_no();
		hCart.put(product_no, obean);
		
	}
	
	public void deleteCart(OrderBean obean){
		String product_no = obean.getProduct_no();
		hCart.remove(product_no);
	}
}
