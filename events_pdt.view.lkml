view: clean_events {
  derived_table: {
    sql:
      SELECT *
      FROM events
      WHERE EVENT_TYPE NOT IN ('test', 'staff') ;;
    sql_trigger_value: SELECT CURRENT_DATE() ;;
  }
}

view: events_summary {
  derived_table: {
    sql:
      SELECT
        EVENT_TYPE,
        created_at::date as date,
        COUNT(*) AS num_events
      FROM
        ${clean_events.SQL_TABLE_NAME} AS clean_events
      GROUP BY
        1,
        2 ;;
    sql_trigger_value: SELECT MAX(id) FROM ${clean_events.SQL_TABLE_NAME} ;;
  }
}
