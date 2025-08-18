# Web

***Our Phoenix application for the LiveView UI, API endpoints, and user-facing components.*** 

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

----------------
### Endpoints:
----------------
Generate UUID --> station_id = Ecto.UUID.generate()

REST
``` 
GET "/observations/:station_id"

Terminal Example
curl http://localhost:4000/api/observations/2d92f26e-1221-4400-91f8-54fbe4d2f505

```
GRPC with Postman
``` 
grpcurl -plaintext \
  -d '{"station_id": "YOUR_STATION_ID"}' \
  localhost:50051 \
  weather.WeatherService/GetObservation
``` 


## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
