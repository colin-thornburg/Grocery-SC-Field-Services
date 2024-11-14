SELECT
    sm.service_date,
    COUNT(DISTINCT sm.technician_id) as active_technicians,
    SUM(sm.tickets_handled) as total_tickets,
    SUM(sm.completed_tickets) as total_completed,
    CAST(SUM(sm.completed_tickets) / NULLIF(SUM(sm.tickets_handled), 0) * 100 AS NUMERIC) as completion_rate,
    CAST(SUM(sm.total_time_minutes) / NULLIF(SUM(sm.tickets_handled), 0) AS NUMERIC) as avg_ticket_duration,
    -- Productivity metrics
    SUM(sm.tickets_with_parts) as tickets_requiring_parts,
    COUNT(DISTINCT st.customer_id) as unique_customers_served
FROM {{ ref('int_service_metrics') }} sm
LEFT JOIN {{ ref('stg_field_services__tickets') }} st 
    ON sm.technician_id = st.technician_id 
    AND sm.service_date = st.service_date
GROUP BY sm.service_date