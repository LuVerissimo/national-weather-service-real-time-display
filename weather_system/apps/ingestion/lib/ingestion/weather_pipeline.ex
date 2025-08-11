defmodule Ingestion.WeatherPipeline do
  use Broadway

  alias Broadway.Message

  def start_link(_opts) do
    Broadway.start_link(
      __MODULE__,
      producer: [
        module: {
          BroadwayKafka.Producer,
          [
            hosts: [localhost: 9092],
            group_id: "weather_ingestion",
            topics: ["weather_alerts"]
          ]
        }
      ],
      processors: [
        default: []
      ],
      batchers: [
        default: [
          batch_size: 10,
          batch_timeout: 2000
        ]
      ]
    )
  end

  def handle_message(_, %Message{data: data} = message, _) do
    # TODO populate topic w/locations to check
    location = Jason.decode!(data)

    with {:ok, weather_data} <- fetch_weather_for(location) do
      message |> Message.put_data(weather_data)
    else
      _ -> message |> Message.failed("Failed to fetch weather data")
    end
  end

  def handle_batch(_, messages, _, _) do
    # TODO Dispatch Commands Here
    for message <- messages do
      IO.inspect(message.data)
    end

    messages
  end

  # Weather API w/Finch
  defp fetch_weather_for(location) do
    # TODO Step 1 gather grid endpoints
    # TODO Step 2

    base_url = "https://api.weather.gov/points/#{location["lat"]},#{location["lon"]}"

    with {:ok, response} <- Finch.build(:get, base_url) |> Finch.request(Ingestion.Finch),
         {:ok, body} <- Jason.decode(response.body) do
      forecast_url = body["properties"]["forecast"]

      with {:ok, forecast_response} <-
             Finch.build(:get, forecast_url) |> Finch.request(Ingestion.Finch),
           {:ok, forecast_body} <- Jason.decode(forecast_response.body) do
        {:ok, forecast_body}
      end
    else
      _ -> {:error, "API request failed"}
    end
  end
end
