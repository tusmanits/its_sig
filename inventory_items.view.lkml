view: inventory_items {
  sql_table_name: inventory_items ;;
  ## DIMENSIONS ##

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cost {
    type: number
    value_format_name: usd
    sql: ${TABLE}.cost ;;
  }

  dimension_group: created {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.created_at ;;
  }

  dimension: product_id {
    type: number
    hidden: yes
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: sold {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${TABLE}.sold_at ;;
  }

  dimension: is_sold {
    type: yesno
    sql: ${sold_raw} is not null ;;
  }

  dimension: days_in_inventory {
    description: "days between created and sold date"
    type: number
    sql: DATEDIFF('day', ${created_raw}, coalesce(${sold_raw},CURRENT_DATE)) ;;
  }

  dimension: days_in_inventory_tier {
    type: tier
    sql: ${days_in_inventory} ;;
    style: integer
    tiers: [0, 5, 10, 20, 40, 80, 160, 360]
  }

  dimension: days_since_arrival {
    description: "days since created - useful when filtering on sold yesno for items still in inventory"
    type: number
    sql: DATEDIFF('day', ${created_date}, CURRENT_DATE) ;;
  }

  dimension: days_since_arrival_tier {
    type: tier
    sql: ${days_since_arrival} ;;
    style: integer
    tiers: [0, 5, 10, 20, 40, 80, 160, 360]
  }

  dimension: product_distribution_center_id {
    hidden: yes
    sql: ${TABLE}.product_distribution_center_id ;;
  }
}
