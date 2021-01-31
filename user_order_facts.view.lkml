view: user_order_facts {
  derived_table: {
    explore_source: order_items {
      column: user_id {
        field: order_items.user_id
      }
      column: lifetime_number_of_orders {
        field: order_items.order_count
      }
      column: lifetime_customer_value {
        field: order_items.total_sale_price
      }
      derived_column: average_customer_order {
        sql:  lifetime_customer_value / lifetime_number_of_orders ;;
      }
    }
  }
  # Define the view's fields as desired
  dimension: user_id {
    hidden: yes
  }
  dimension: lifetime_number_of_orders {
    type: number
  }
  dimension: lifetime_customer_value {
    type: number
  }
  dimension: average_customer_order {
    type: number
  }
}
