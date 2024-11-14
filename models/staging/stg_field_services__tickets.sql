SELECT
    ticket_id,
    customer_id,
    equipment_id,
    technician_id,
    service_date,
    service_type,
    CAST(time_on_site AS NUMERIC) as time_on_site_minutes,
    parts_used,
    service_notes,
    status,
    -- Add calculated fields
    CASE 
        WHEN time_on_site > 120 THEN 'Extended'
        ELSE 'Standard'
    END as visit_duration_category
FROM {{ ref('raw_service_tickets') }}