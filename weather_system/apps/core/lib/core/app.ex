defmodule Core.App do
  use Commanded.Application,
    otp_app: :core,
    # router: Core.Station.Router,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: Core.EventStore
    ],
    projections: [
      Core.Station.Projectors.ObservationProjector
    ]

    router(Core.Station.Router)
end
