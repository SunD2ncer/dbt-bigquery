TIMESTAMP_TRUNC(input_timestamp, HOUR)
+ MAKE_INTERVAL(
    minute => 30 * DIV(EXTRACT(MINUTE FROM input_timestamp), 30)
)