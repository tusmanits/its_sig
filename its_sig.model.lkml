connection: "its_warehouse"

include: "*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

named_value_format: big_money {
  value_format: "[>=1000000]$0.00,,\"M\";[>=1000]$0.00,\"K\";$0.00"
  }

explore: order_items {
  label: "(1) Orders, Items and Users"
  view_name: order_items

  join: users {
    relationship: many_to_one
    foreign_key: order_items.user_id
  }

}