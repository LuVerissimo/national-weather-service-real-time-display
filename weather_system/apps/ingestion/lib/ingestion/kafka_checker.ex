defmodule Ingestion.KafkaChecker do
  @moduledoc """
  Checks Kafka connection by reusing BroadwayKafka :brod_client.
  """

  @broadway_client Ingestion.WeatherPipeline.Broadway.Producer_0.Client
  @topic "weather_alerts"

  # Ingestion.KafkaChecker.check()
  def check do
    case :brod.get_partitions_count(@broadway_client, @topic) do
      {:ok, count} ->
        IO.puts("Kafka topic #{@topic} has #{count} partitions. Conn is healthy")
        :ok

      {:error, reason} ->
        IO.puts("Failed Kafka Check: #{inspect(reason)}")
        {:error, reason}

      :ok ->
        IO.puts("Check Success")
      other ->
        IO.puts("Unexpected item in the bagging area: #{inspect(other)}")
        {:error, other}
    end
  end
end
