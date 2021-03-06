package cn.digirun.component.order.model;

import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity(name = "t_order_return_detail")
@DynamicInsert
@DynamicUpdate
public class OrderReturnDetail {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@ManyToOne(fetch=FetchType.LAZY)
	private OrderReturn orderReturn;
	
	/**
	 * 价格
	 */
	private BigDecimal price;
	
	/**
	 * 商品ID
	 */
	private Integer itemId;
	
	/**
	 * 数量
	 */
	private Integer quantity;

	
	

	public OrderReturn getOrderReturn() {
		return orderReturn;
	}

	public void setOrderReturn(OrderReturn orderReturn) {
		this.orderReturn = orderReturn;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public Integer getItemId() {
		return itemId;
	}

	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	
	
	
}
