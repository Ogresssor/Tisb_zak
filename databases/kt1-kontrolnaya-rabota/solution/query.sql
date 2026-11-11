SELECT tm.name AS transport_type, r.number AS route_number,
 r.name AS route_name,
 CASE rv.direction WHEN 0 THEN 'прямое' ELSE 'обратное' END AS direction,
 vs.stop_order, st.name AS stop_name, vs.arrival_offset_min
FROM variant_stop vs
JOIN route_variant rv ON rv.variant_id = vs.variant_id
JOIN route r ON r.route_id = rv.route_id
JOIN transport_mode tm ON tm.mode_id = r.mode_id
JOIN stop st ON st.stop_id = vs.stop_id
ORDER BY tm.name, r.number, rv.direction, vs.stop_order;
