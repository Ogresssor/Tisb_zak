PRAGMA foreign_keys = ON;
CREATE TABLE transport_mode (
 mode_id INTEGER PRIMARY KEY,
 name TEXT NOT NULL UNIQUE
);
CREATE TABLE route (
 route_id INTEGER PRIMARY KEY,
 mode_id INTEGER NOT NULL REFERENCES transport_mode(mode_id),
 number TEXT NOT NULL,
 name TEXT NOT NULL,
 UNIQUE(mode_id, number)
);
CREATE TABLE stop (
 stop_id INTEGER PRIMARY KEY,
 name TEXT NOT NULL,
 latitude REAL NOT NULL CHECK(latitude BETWEEN -90 AND 90),
 longitude REAL NOT NULL CHECK(longitude BETWEEN -180 AND 180),
 UNIQUE(name, latitude, longitude)
);
CREATE TABLE route_variant (
 variant_id INTEGER PRIMARY KEY,
 route_id INTEGER NOT NULL REFERENCES route(route_id) ON DELETE CASCADE,
 direction INTEGER NOT NULL CHECK(direction IN (0, 1)),
 variant_name TEXT NOT NULL DEFAULT 'основной',
 UNIQUE(route_id, direction, variant_name)
);
CREATE TABLE variant_stop (
 variant_id INTEGER NOT NULL REFERENCES route_variant(variant_id) ON DELETE CASCADE,
 stop_order INTEGER NOT NULL CHECK(stop_order > 0),
 stop_id INTEGER NOT NULL REFERENCES stop(stop_id),
 arrival_offset_min INTEGER NOT NULL CHECK(arrival_offset_min >= 0),
 PRIMARY KEY(variant_id, stop_order)
);
CREATE INDEX idx_variant_stop_stop ON variant_stop(stop_id);
CREATE INDEX idx_route_mode ON route(mode_id);
