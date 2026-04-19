USE bostonability;

UPDATE report r
JOIN accessibility_report ar ON r.report_id = ar.report_id
SET r.user_id = ar.user_id
WHERE r.user_id IS NULL;

UPDATE accessibility_report ar
JOIN report r ON ar.report_id = r.report_id
SET ar.report_date = DATE(r.report_date)
WHERE ar.report_date IS NULL;
