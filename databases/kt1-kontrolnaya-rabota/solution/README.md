# Контрольная работа «Городской транспорт»

Выполнено проектирование реляционной БД городских транспортных маршрутов.

**Инфологическая модель:** вид транспорта (1:N) маршрут (1:N) вариант маршрута (1:N) запись остановки; остановка (1:N) запись остановки. Между вариантами и остановками — M:N, разрешённая таблицей `variant_stop`.

**PK / FK:**
- transport_mode: PK mode_id.
- route: PK route_id; FK mode_id → transport_mode.mode_id.
- stop: PK stop_id.
- route_variant: PK variant_id; FK route_id → route.route_id.
- variant_stop: PK (variant_id, stop_order); FK variant_id → route_variant.variant_id; FK stop_id → stop.stop_id.

В базе четыре вида транспорта, четыре маршрута, восемь направлений, шесть остановок, 22 записи остановок. Для повторения: выполнить `schema.sql`, затем `data.sql`, затем `query.sql` в SQLite; включить поддержку FK командой `PRAGMA foreign_keys = ON;`.

Готовый документ с подробным описанием и диаграммой можно поместить в эту же папку в формате DOCX.
