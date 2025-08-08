# National Weather Service Real Time Display
System to ingest weather data from the National Weather Service, process it, and display it in real-time. 


***Core Technologies:*** 
```yml
Language & Library
-------------------------------------------------------------
> Elixir: functional language for scalable, maintainable apps.

> PhoenixLiveView: A framework for interactive user interfaces.

> Commanded: Library for building CQRS/ES applications.

> Broadway: Library for building concurrent / multi-stage data ingestion and processing pipelines.

> Oban: Background job processing library.

-------------------------------------------------------------
> Postgres: DB for the event store and read models.

> Redis: Caching / fast data-access needs.

> Kafka: Streaming platform for publishing / subscribing events.

> Prometheus / Grafana: For monitoring and visualizing application metrics.

gRPC / REST: For creating robust and flexible APIs.
