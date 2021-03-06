view: repeat_purchase_facts {
  derived_table: {
    sql: SELECT
        order_items.order_id
        , COUNT(DISTINCT repeat_order_items.id) AS number_subsequent_orders
        , MIN(repeat_order_items.created_at) AS next_order_date
        , MIN(repeat_order_items.order_id) AS next_order_id
      FROM order_items
      LEFT JOIN order_items repeat_order_items
        ON order_items.user_id = repeat_order_items.user_id
        AND order_items.created_at < repeat_order_items.created_at
      GROUP BY 1
       ;;
    persist_for: "24 hours"
  }

  dimension: order_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: next_order_id {
    type: number
    hidden: yes
    sql: ${TABLE}.next_order_id ;;
  }

  dimension: less_than_40 {
    type:  yesno
    sql:  NOT ${less_than_30} AND ${number_subsequent_orders} <= 30 ;;
  }

  dimension: has_subsequent_order {
    type: yesno
    sql: ${next_order_id} > 0 ;;
  }

  dimension: less_than_10 {
    type:  yesno
    sql:  ${number_subsequent_orders} >= 1 AND ${number_subsequent_orders} <= 10 ;;
  }

  dimension: less_than_20 {
    type:  yesno
    sql:  NOT ${less_than_10} AND ${number_subsequent_orders} <= 20 ;;
  }

  dimension: less_than_30 {
    type:  yesno
    sql:  NOT ${less_than_20} AND ${number_subsequent_orders} <= 30 ;;
  }

  dimension: number_subsequent_orders {
    type: number
    sql: ${TABLE}.number_subsequent_orders ;;
  }

  dimension_group: next_order {
    type: time
    timeframes: [raw, date]
    hidden: yes
    sql: ${TABLE}.next_order_date ;;
  }
}
