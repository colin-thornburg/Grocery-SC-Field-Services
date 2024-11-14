SELECT
    technician_id,
    service_date,
    COUNT(DISTINCT ticket_id) as tickets_handled,
    SUM(time_on_site_minutes) as total_time_minutes,
    COUNT(DISTINCT customer_id) as customers_served,
    -- Calculate efficiency metrics
    SUM(time_on_site_minutes) / COUNT(DISTINCT ticket_id) as avg_time_per_ticket,
    COUNT(CASE WHEN status = 'Completed' THEN 1 END) as completed_tickets,
    COUNT(CASE WHEN parts_used != 'None' THEN 1 END) as tickets_with_parts
FROM {{ ref('stg_field_services__tickets') }}
GROUP BY 
    technician_id,
    service_date