view: clean_events {
  derived_table: {
    sql:
      SELECT *
      FROM events
      WHERE type NOT IN ('test', 'staff') ;;
    sql_trigger_value: SELECT CURDATE() ;;
  }
}

view: events_summary {
  derived_table: {
    sql:
      SELECT
        type,
        date,
        COUNT(*) AS num_events
      FROM
        ${clean_events.SQL_TABLE_NAME} AS clean_events
      GROUP BY
        type,
        date ;;
    sql_trigger_value: SELECT MAX(id) FROM ${clean_events.SQL_TABLE_NAME} ;;
  }
}
